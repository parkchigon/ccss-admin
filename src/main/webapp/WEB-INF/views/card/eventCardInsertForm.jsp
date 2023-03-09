<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>


<script type="text/javascript" src="<c:url value="/resources/common/ckeditor/ckeditor.js" />"></script>  
<script type="text/javaScript">
var regFlag = false;
var serviceCategoryMap = new Map();

var serviceCardMap = new Map();
$(document).ready(function(){
	$('#image_preview a').hide();
	$('#image_preview img').hide();
	$('#image_preview_pm a').hide();
	$('#image_preview_pm img').hide();
	
	$("input:radio[name=cardType]").click(function(){
		var cardType = $(this).val();
		
		if (cardType=="02") {	// 프로모션일 경우
			$("#cardName").val("");
		    $("#cardId").val("");
	        $("#card_sel_view").hide();
	        $("#promotion_img_view").show();
	        $("#promotion_url").show();
		} else {
			$("#promotion_img_view").hide();
			$("#promotion_url").hide();
			$("#card_sel_view").show();
		}
		
	});
	
	//selectGrpCodeList("SERVICE_CATEGORY","serviceCategory");
	
	//Start 시간 설정
	var spostDate = "${spostDate}";
	if(spostDate !=null && spostDate != ""){
		$('#spostDate').val(startDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
		replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
	}else{
		$('#spostDate').val(dateAdd(new Date().toISOString().slice(0,10),0,"d"));
	}
	//End 시간 설정
	var epostDate = "${epostDate}";
	if(epostDate !=null && epostDate != ""){
		$('#epostDate').val(endDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
	}else{
		$('#epostDate').val(dateAdd(new Date().toISOString().slice(0,10),+7,"d"));
	}
	
	// 카테고리변경시, 서비스카드 초기화
	$('#serviceCategory').change(function(){
		$('#cardId').val("");
		$('#cardName').val("");
	});
	
	// 데이터 피커 생성
	datePicker({
		datePickerGroupId: "datepicker1_group",
		datePickerId: "datepicker1",
		defaultDt : $('#spostDate').val()
	});
	
	datePicker({
		datePickerGroupId: "datepicker2_group",
		datePickerId: "datepicker2",
		defaultDt : $('#epostDate').val()
	});

	/**
	onclick event handler for the delete button.
	It removes the image, clears and unhides the file input field.
	*/	
	$('#remove').bind('click', function() {
		resetFormElement($('#uploadfile')); //전달한 양식 초기화
		$('#uploadfile').slideDown(); //파일 양식 보여줌
		$(this).parent().slideUp(); //미리 보기 영역 감춤
		
		$('#eventCardUrl').val('');
		return false; //기본 이벤트 막음
	});
	
	$('#remove_pm').bind('click', function() {
		resetFormElement($('#uploadfile_pm')); //전달한 양식 초기화
		$('#uploadfile_pm').slideDown(); //파일 양식 보여줌
		$(this).parent().slideUp(); //미리 보기 영역 감춤
		
		$('#eventCardUrlPm').val('');
		return false; //기본 이벤트 막음
	});	
	
});


function selectGrpCodeList(grpCodeNm,grpCodeListAreaId){
	$.ajax({
		url : "<c:url value='/system/code/selectDtlCodeList.do' />",
		type : "POST",
		data : {
			"grpCdNm" : grpCodeNm
		},
		async: false,
		dataType : "json"
	}).done(function (data) {
		var list = data.resultList;
		
		var html ="";
	
		if(grpCodeNm =='SERVICE_CATEGORY'){
			html ="";
			
			for(var i=0; i< list.length; i++){
				
				if(list[i].cdVal !="ALL"){
					if( i == 0){
						serviceCategoryMap.put(list[i].cdVal,list[i].dtlCdNm);
						html += "<option checked value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";	
					}else{
						serviceCategoryMap.put(list[i].cdVal,list[i].dtlCdNm);
						html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";	
					}
				}
			}
		}else{
			
		}
		
		$("#"+ grpCodeListAreaId).empty();
		$("#"+ grpCodeListAreaId).append(html);
		
	}).error(function(request,status,error){
		//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		if(request.status == 401){
			alert("해당 권한이 없습니다.");
		}else if(request.status == 400){
			alert("비정상적인 요청입니다.");
		}else{
			console.log("서버 내부 오류 발생","code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			if(request.status ==200){
				location.href = "<c:url value='/login/loginView.do' />";
			}
		}
	});
}

//미리보기 팝업 화면 셋팅
function  preView(){
	
	file = $('#uploadfile').prop("files")[0];
	 blobURL = window.URL.createObjectURL(file);
	$('#pimage_preview img').attr('src', blobURL);
	
	var eventCardUrl =  $("#eventCardUrl").val();
	$("#peventCardUrl").val(eventCardUrl);
	
	var serviceCategory =  $("#serviceCategory").val();
	$("#pserviceCategory").val(serviceCategory);
	
	
	var exposureYn =  $(":input:radio[name=exposureYn]:checked").val();
	$('input:radio[name=pexposureYn]:input[value=' + exposureYn + ']').attr("checked", true);
	var fixYn =  $(":input:radio[name=fixYn]:checked").val();
	$('input:radio[name=pfixYn]:input[value=' + fixYn + ']').attr("checked", true);
	

	//카드번호
	var cardSortNum =  $(":input:radio[name=cardSortNum]:checked").val();
	$('input:radio[name=pcardSortNum]:input[value=' + cardSortNum + ']').attr("checked", true);
	
	
	if (fixYn == "Y") {
		$("#pcardNumArea").show();
	} else {
		$("#pcardNumArea").hide();
	}
	
	

	$(".dimmed").show();
	$("#cardPreViewPopup").show();
}

function closeCardListPopup(){
	$('#cardListPopup').hide(); 
	$('.dimmed').hide();
}

function eventCardInputCheck(obj){
	// check all clear
	$("input:checkbox[name='cardCheckBox']").attr("checked", false);
	// click check
	obj.checked = true;
	//$("input:checkbox[id='"+obj.id+"']").attr("checked", true);	
}

function cardSelect() {
	var chkBox = document.getElementsByName("cardCheckBox");
	
	for(var i = 0; i < chkBox.length; i++){
		if(chkBox[i].checked) {
			$('#cardId').val(chkBox[i].value);
			$('#cardName').val(chkBox[i].id);
			
			break;
		}
	}
	
	closeCardListPopup();
}

function goSearch(page){

	// 모든카드 체크를 제거한다.
	$("input:checkbox[name='cardCheckBox']").attr("checked", false);

	var serviceCategory =  $("#serviceCategory").val();
	
	$("#page").val(page);
	$.ajax({
		url :"<c:url value='/card/selectCardList.do'/>"
		,data : {
			"pageRowCount" : "15",
			"page" : page,
			"serviceCategory" : serviceCategory,
			"fixYn" : "N"
		}
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		
		if (list.length == 0) {

			html += "	<tr><th colspan='3'>조회된 결과가 없습니다.</td></tr>";
		} else {
			for (var i = 0; i < list.length ; i++) {
				
				html += "<tr>";
				html += "	<td class='rowhighlight'>" + list[i].rnum + "</td>";
				html += "	<td class='rowhighlight'>" + list[i].cardNm + "</td>";  //제목
				html += "   <td class='rowhighlight'><input type='checkbox' onClick='eventCardInputCheck(this)' value='"+list[i].cardId+"'"+" id='"+list[i].cardNm+"'" +" name='cardCheckBox'></td>";
				html +="</tr>";

			}
		}
		
		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#cardList").empty();
		$("#cardList").append(html);
		
	}).error(
			function(request, status, error) {
				if (request.status == 401) {
					alert("해당 권한이 없습니다.");
				} else {
					console.log("서버 내부 오류 발생", "code:" + request.status
							+ "\n" + "message:" + request.responseText
							+ "\n" + "error:" + error);
					if(request.status ==200){
						location.href = "<c:url value='/login/loginView.do' />";
					}
				}
	});
	
	$('#cardListPopup').show(); 
	$('.dimmed').show();
}

//미입력 항목 alert
function alertMessageSource(elId){
	alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
}

function insertEventCardImg(imgId){
	var url = "<c:url value='/card/insertEventCardImg.do' />";
	
	
	//console.log("TEST");
	//$('#eventCardInsertForm').attr('method','post').attr('action','/admin/card/insertEventCardImg.do').submit();
	/*  var frm = document.getElementById('eventCardInsertImgForm');
	frm.method = 'POST';
	frm.enctype = 'multipart/form-data';
	var fileData = new FormData(frm); */
	
	var formData = new FormData(); 
	var imgName = "";
	if (imgId=="event") {
		formData.append("uploadfile", $("input[name=uploadfile]")[0].files[0]);
		imgName = "이벤트";
	} else if (imgId=="promotion") {
		formData.append("uploadfile", $("input[name=uploadfile_pm]")[0].files[0]);
		imgName = "프로모션";
	}
	
	//var fileData = new FormData($("#uploadfile")[0]);
	
	
	 $.ajax({
		url : url
		,data : formData
		,enctype: 'multipart/form-data'
		,dataType : 'json'
		,processData: false 	// Important!
		,contentType: false
		,cache: false
		,type : "POST"
	}).done(function(data) {
		var result = data.result;
		var resultDate = data.resultDate;
		if(result == 'Y'){ 
			regFlag = true;
			if (imgId=="event") {
				$("#eventCardUrl").val(resultDate);
			} else if (imgId=="promotion") {
				$("#eventCardUrlPm").val(resultDate);
			}
			alert(imgName + " 카드 이미지가 등록 되었습니다.");
		}else if(result =='NOT_ALLOW_FILE_EXT'){
			alert("이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)");
		}else{
			alert(imgName + " 카드 이미지 등록에 실패하였습니다.");
		}
	}).error(function(request,status,error){
		//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		if(request.status == 401){
			alert("해당 권한이 없습니다.");
		}else if(request.status == 400){
			alert("비정상적인 요청입니다.");
		}else{
			console.log("서버 내부 오류 발생","code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			if(request.status ==200){
				location.href = "<c:url value='/login/loginView.do' />";
			}
		}
	}); 
}


function eventCardInsert() {

	if(regFlag){
		var url = "<c:url value='/card/insertEventCard.do' />";
		
		var spostDate =$("#spostDate").val();
		var epostDate = $("#epostDate").val();
		
		$("#exposureStartDt").val(spostDate.replace(/-/gi, ""));
		$("#exposureEndDt").val(epostDate.replace(/-/gi, ""));
		
		var validCheck = false;
		validCheck = checkStartEndDate($('#spostDate').val(), $('#epostDate').val(),  " 시작일, 종료일이 잘못되었습니다.");
		
		if(!validCheck){
			return false;
		}

		var checkParamArr = ['eventCardUrl','exposureStartDt','exposureEndDt'];

		if (formValidationCheck(checkParamArr)){

			// 이벤트서비스유형 Validation
 			/* var isTypeChk = false;
	        var arrType = document.getElementsByName("cardType");
	        for(var i=0;i<arrType.length;i++){
	            if(arrType[i].checked == true) {
	            	isTypeChk = true;
	                break;
	            }
	        } */
	        
	        if($("input:radio[name=cardType]:checked").val() == null){
	            alert("이벤트카드 유형은 필수선택항목입니다.");
	            return false;
	        } 
	        else if ($("input:radio[name=cardType]:checked").val()=="00" || $("input:radio[name=cardType]:checked").val()=="01") {
        		if ($("#cardId").val() == "") {
        			alert("서비스카드를 선택하시기 바랍니다.");
        			return false;
        		}
	        }
	        else if ($("input:radio[name=cardType]:checked").val()=="02") {
	        	$("#cardName").val("");
	        	$("#cardId").val("");
	        	
	        	var idVal = $('#eventCardUrlPm').val();
	        	if(idVal== null || idVal == ""){
	        		alert ("프로모션 이미지를 선 등록 하셔야 합니다.");
	        		return false;
	        	}
	        }
	        
	        
	    	$("#eventCardType").val($("input[name='cardType']:checked").val());
	    	
			$.ajax({
				url : url
				,data : $('#eventCardInsertForm').serialize()
				,dataType : 'json'
				,type : "POST"
			}).done(function(data) {
				var result = data.result;
				if(result == 'Y'){ 
					alert("신규 이벤트 카드가 등록 되었습니다.");
					location.href="<c:url value='/card/eventCardList.do' />";
				}else{
					alert("신규 서비스 카드 등록에 실패하였습니다.");
				}
			}).error(function(request,status,error){
				//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				if(request.status == 401){
					alert("해당 권한이 없습니다.");
				}else if(request.status == 400){
					alert("비정상적인 요청입니다.");
				}else{
					console.log("서버 내부 오류 발생","code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					if(request.status ==200){
						location.href = "<c:url value='/login/loginView.do' />";
					}
				}
			});
		}
	}else{
		alert("이벤트 카드 이미지를 선 등록 하셔야 합니다.");
	}
	
}

function historyBack(){
	if(confirm("저장 없이 목록으로 돌아가시 겠습니까?")) {
		history.back();
	}
}
function dateAdd(sDate, v, t) {
	var yy = parseInt(sDate.substr(0, 4), 10);
	var mm = parseInt(sDate.substr(5, 2), 10);
	var dd = parseInt(sDate.substr(8), 10);
	var d;
	if(t == "d"){
		d = new Date(yy, mm - 1, dd + v);
	}else if(t == "m"){
		d = new Date(yy, mm - 1 + v, dd);
	}else if(t == "y"){
		d = new Date(yy + v, mm - 1, dd);
	}else{
		d = new Date(yy, mm - 1, dd + v);
	}

	yy = d.getFullYear();
	mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
	dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;

	return '' + yy + '-' +  mm  + '-' + dd;
}

function notAvailableSpecialChar(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9-_.]/g,""));
	}); 
}
function isVersion(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9_.]/g,""));
	}); 
}
function isURL(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^a-zA-Z0-9/&=:;%~.?+-_]/g,""));
	}); 
}

//미입력 항목 alert
function alertMessageSource(elId){
	alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
}

//시작일, 종료일 체크
function checkStartEndDate(start, end, msg){
	
	
	//공백 체크
	if(start.trim() == "" || start.trim() == null){
		alert("시작 날짜를 선택해주세요.");
		return false;
	}
	if(end.trim() == "" || end.trim() == null){
		alert("종료 날짜를 선택해주세요.");
		return false;
	}
	
	var betweenDay = calDateRange(start,end);
	
	if(betweenDay >=8 ){
		alert("노출기간은  최대 7일 이상 지정 하실 수 없습니다.");
		return false;
	}
	 
	if( start > end )
	{
		alert(msg);
		return false;
	}
	else{
		return true;
	}
}

function calDateRange(val1, val2)
{
	var FORMAT = "-";
	// FORMAT을 포함한 길이 체크
	if (val1.length != 10 || val2.length != 10)
		return null;

	// FORMAT이 있는지 체크
	if (val1.indexOf(FORMAT) < 0 || val2.indexOf(FORMAT) < 0)
		return null;

	// 년도, 월, 일로 분리
	var start_dt = val1.split(FORMAT);
	var end_dt = val2.split(FORMAT);

	// 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
	// Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
	start_dt[1] = (Number(start_dt[1]) - 1) + "";
	end_dt[1] = (Number(end_dt[1]) - 1) + "";

	var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2]);
	var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2]);

	return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60 / 24;
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="eventCardInsertForm" name="eventCardInsertForm" >
		<!-- AM만 이벤트 등록  -->
	    <input type="hidden" id="serviceCategory" name="serviceCategory" value="AM" />
		<input type="hidden" id="exposureStartDt" name="exposureStartDt" />
		<input type="hidden" id="exposureEndDt" name="exposureEndDt" />
		<input type="hidden" id="eventCardType" name="eventCardType" />
		<div class="main_top">
			<h2> 카드덱관리 > 이벤트 카드 관리 > 이벤트 카드 등록</h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">기본정보</div>
			</div>
			<div class="rtl">
				<div class="table_info01">* 필수입력</div>
			</div>
		</div>
		<!-- e: table top-->
			
		<!-- s: table wrap-->
		<div class="table_wrap">
			<table class="table simple table_write_type">
				<colgroup>
					<col width="16%"/>
					<col width="34%"/>
					<col width="16%"/>
					<col width="34%"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="last">이벤트카드 유형 <span class="imp">*</span></th>
						<td colspan="3" class="last">
						    <span style="margin-right:15px">등록할 이벤트 카드의 종류를 선택해 주세요.</span>
							<input type="radio" name="cardType" value="00"> 신규서비스
							<input type="radio" style="margin-left:15px" name="cardType" value="01"> 기존서비스
							<input type="radio" style="margin-left:15px" name="cardType" value="02"> 프로모션
						</td>
					</tr>
					<!-- <tr>
						<th class="last" >서비스 카테고리 <span class="imp">*</span></th>
						<td id=""colspan="3" class="last">
							<select id="serviceCategory" name="serviceCategory" class="select w01"style="width: 380px;">
									
							</select>
						</td>
					</tr> -->
					<tr>
						<th  class="last"><div class="tit_search">노출 시작 일시<span class="imp">*</span></div></th>
						<td colspan="1" class="last">
							<div id="datepicker1_group" class="group">
								<fmt:parseDate value="${eventCardVO.spostDate}" var='spostDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 200px;" id="spostDate" name="spostDate" value="<fmt:formatDate value="${spostDate}" pattern="yyyy-mm-dd"/>" readonly />
								<a class="btn btn-gray"><i class="icon-calendar"></i></a>
				
								<div id="datepicker1" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
								<div class="head">
									<div class="prev"><i class="icon-chevron-left"></i></div>
									<div class="title"></div>
										<div class="next"><i class="icon-chevron-right"></i></div>
				 					</div>
									<table class="body">
									<tr>
									<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
										</tr>
									</table>
								</div>
							</div>
						</td>
						<th  class="last"><div class="tit_search">노출 종료 일시<span class="imp">*</span></div></th>
						<td colspan="1" class="last">
							<div id="datepicker2_group" class="group">
								<fmt:parseDate value="${eventCardVO.epostDate}" var='epostDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 200px;" id="epostDate" name="epostDate" value="<fmt:formatDate value="${epostDate}" pattern="yyyy-mm-dd"/>" readonly />
								<a class="btn btn-gray"><i class="icon-calendar"></i></a>
				
								<div id="datepicker2" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
								<div class="head">
									<div class="prev"><i class="icon-chevron-left"></i></div>
									<div class="title"></div>
										<div class="next"><i class="icon-chevron-right"></i></div>
				 					</div>
									<table class="body">
									<tr>
									<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
										</tr>
									</table>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th class="last">URL <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text"  autocomplete="off" id="eventCardUrl" name="eventCardUrl"  class="input w01" readOnly/>
						</td>
					</tr>
					<tr>
						<th class="last">Event Card(Image) <span class="imp">*</span></th>
						<td colspan="3" class="last">
							
						<!-- <form id ="uploadfileForm" enctype="multipart/form-data">  -->
						<p>
						<br/>
							<form id= "eventCardInsertImgForm" name="eventCardInsertImgForm"  enctype="multipart/form-data" >
								<input type="file" name="uploadfile" id="uploadfile" onchange="loadImageFile();"  accept="image/gif, image/jpeg, image/png"/>
							</form>
						</p>
						<!-- </form> -->
						
						<div id="image_preview">
							
							<a id="remove" href="#"><span class="btn small">제거</span></a>
							<a href="javascript:insertEventCardImg('event');">
								<span class="btn small focus">카드 이미지 등록</span>
							</a>
							<br/>
							<div id="imagePreview"></div>
							
							<!-- <div id="imagePreview"></div>
							<form id= "eventCardInsertImgForm22" name="eventCardInsertImgForm22"  enctype="multipart/form-data" >
								<input type="file" name="uploadfile22" id="uploadfile22"  onchange="loadImageFile();" accept="image/gif, image/jpeg, image/png"/>
							</form> -->
							
						</div>
						</td>
					</tr>
					<tr id="promotion_url"  style="display:none">
						<th class="last">프로모션 URL <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text"  autocomplete="off" id="eventCardUrlPm" name="eventCardUrlPm"  class="input w01" readOnly/>
						</td>
					</tr>
					<tr id="promotion_img_view" style="display:none">
						<th class="last">프로모션 이미지(Image) <span class="imp">*</span></th>
						<td colspan="3" class="last">
							
						<!-- <form id ="uploadfileForm" enctype="multipart/form-data">  -->
						<p>
						<br/>
							<form id= "eventCardInsertImgForm_pm" name="eventCardInsertImgForm_pm"  enctype="multipart/form-data" >
								<input type="file" name="uploadfile_pm" id="uploadfile_pm" onchange="loadImageFile_pm();" accept="image/gif, image/jpeg, image/png"/>
							</form>
						</p>
						<!-- </form> -->
						<div id="image_preview_pm">
							
							<a id="remove_pm" href="#"><span class="btn small">제거</span></a>
							<a href="javascript:insertEventCardImg('promotion');">
								<span class="btn small focus">카드 이미지 등록</span>
							</a>
							<br/>
							<div id="imagePreview_pm"></div>
							
						</div>
						</td>
					</tr>
					<tr id="card_sel_view" style="display:none">
						<th class="last">서비스카드 선택 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text"  autocomplete="off" id="cardName" name="cardName"  class="input w01" style="width: 300px;" readonly/>
							<input type="hidden" name="cardId" id="cardId"/>
							<span class="btn btn_w01"><a href="javascript:goSearch(1);">불러오기</a></span>
						</td>
					</tr>


	
					<script type="text/javascript">

				    var loadImageFile = (function () {  	
				        if (window.FileReader) {
				            var oPreviewImg = null, oFReader = new window.FileReader(),
				                rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;

				            oFReader.onload = function (oFREvent) {
				            	
					             $('#image_preview a').show();
					             $('#imagePreview').show();
					             $('#image_preview').slideDown(); //업로드한 이미지 미리보기 
				            	
				                if (!oPreviewImg) {
				                    var newPreview = document.getElementById("imagePreview");	// 보여줄 화면
				                    oPreviewImg = new Image();
				                    oPreviewImg.style.width = "160px";
				                    oPreviewImg.style.height ="120px";
				                    newPreview.appendChild(oPreviewImg);
				                }
				                oPreviewImg.src = oFREvent.target.result;
				            };

				            return function () {
				                var aFiles = document.getElementById("uploadfile").files;		// 파일 입력 폼
				                if (aFiles.length === 0) { return; }
				                if (!rFilter.test(aFiles[0].type)) { alert("jpg나 gif, png 만 업로드가 가능합니다."); return; }
				                oFReader.readAsDataURL(aFiles[0]);
				            }

				        }
				        if (navigator.appName === "Microsoft Internet Explorer") {
				            return function () {
				                document.getElementById("imagePreview").filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src 
				                	= document.getElementById("uploadfile").value;

				            }
				        }
				    })();
				 
				    var loadImageFile_pm = (function () {  	
				        if (window.FileReader) {
				            var oPreviewImg = null, oFReader = new window.FileReader(),
				                rFilter = /^(?:image\/bmp|image\/cis\-cod|image\/gif|image\/ief|image\/jpeg|image\/jpeg|image\/jpeg|image\/pipeg|image\/png|image\/svg\+xml|image\/tiff|image\/x\-cmu\-raster|image\/x\-cmx|image\/x\-icon|image\/x\-portable\-anymap|image\/x\-portable\-bitmap|image\/x\-portable\-graymap|image\/x\-portable\-pixmap|image\/x\-rgb|image\/x\-xbitmap|image\/x\-xpixmap|image\/x\-xwindowdump)$/i;

				            oFReader.onload = function (oFREvent) {
				            	
					             $('#image_preview_pm a').show();
					             $('#imagePreview_pm').show();
					             $('#image_preview_pm').slideDown(); //업로드한 이미지 미리보기 
				            	
				                if (!oPreviewImg) {
				                    var newPreview = document.getElementById("imagePreview_pm");	// 보여줄 화면
				                    oPreviewImg = new Image();
				                    oPreviewImg.style.width = "160px";
				                    oPreviewImg.style.height ="120px";
				                    newPreview.appendChild(oPreviewImg);
				                }
				                oPreviewImg.src = oFREvent.target.result;
				            };

				            return function () {
				                var aFiles = document.getElementById("uploadfile_pm").files;		// 파일 입력 폼
				                if (aFiles.length === 0) { return; }
				                if (!rFilter.test(aFiles[0].type)) { alert("jpg나 gif, png 만 업로드가 가능합니다."); return; }
				                oFReader.readAsDataURL(aFiles[0]);
				            }

				        }
				        if (navigator.appName === "Microsoft Internet Explorer") {
				            return function () {
				                document.getElementById("imagePreview_pm").filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src 
				                	= document.getElementById("uploadfile_pm").value;

				            }
				        }
				    })();
				    			
					/* $('#uploadfile1').on('change', function() {
						$('#image_preview a').show();
						//$('#image_preview img').show();
						ext = $(this).val().split('.').pop().toLowerCase(); //확장자
						
						//배열에 추출한 확장자가 존재하는지 체크
						if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
							resetFormElement($(this)); //폼 초기화
							window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
						} else {
							file = $('#uploadfile').prop("files")[0];
							blobURL = window.URL.createObjectURL(file);
							$('#image_preview img').attr('src', blobURL);
							$('#image_preview img').show();
							$('#image_preview').slideDown(); //업로드한 이미지 미리보기 
							$(this).slideUp(); //파일 양식 감춤
						}
					});
					
					$('#uploadfile_pm').on('change', function() {
						$('#image_preview_pm a').show();
						$('#image_preview_pm img').show();
						ext = $(this).val().split('.').pop().toLowerCase(); //확장자
				
						//배열에 추출한 확장자가 존재하는지 체크
						if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
							resetFormElement($(this)); //폼 초기화
							window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
						} else {
							file = $('#uploadfile_pm').prop("files")[0];
							 blobURL = window.URL.createObjectURL(file);
							$('#image_preview_pm img').attr('src', blobURL);
							$('#image_preview_pm').slideDown(); //업로드한 이미지 미리보기 
							$(this).slideUp(); //파일 양식 감춤
						}
					}); */
		
				/** 
				* 폼요소 초기화 
				* Reset form element
				* 
				* @param e jQuery object
				*/
				function resetFormElement(e) {
					e.wrap('<form>').closest('form').get(0).reset(); 
					//리셋하려는 폼양식 요소를 폼(<form>) 으로 감싸고 (wrap()) , 
					//요소를 감싸고 있는 가장 가까운 폼( closest('form')) 에서 Dom요소를 반환받고 ( get(0) ),
					//DOM에서 제공하는 초기화 메서드 reset()을 호출
					e.unwrap(); //감싼 <form> 태그를 제거
				}
					</script>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<!-- <a href="javascript:preView();"><span class="btn large">미리보기</span></a> -->
			<a href="javascript:eventCardInsert();">
				<span class="btn large focus">저장</span>
			</a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>

<!--명령어 수정 Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="cardListPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 400px; top: -150px;">
			<div class="p_header">
				<h1>카드목록</h1>
				<a href="javascript:closeCardListPopup();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
							<div class="table_wrap">
								<table class="table simple table_write_type">
									<colgroup>
										<col width="15%"/>
										<col width="70%"/>
										<col width="15%"/>
									</colgroup>
									<thead>
										<tr>
											<th>No</th>
											<th>카드명</th>
											<th class="last">선택</th>
										</tr>
									</thead>
									<tbody id="cardList">
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- s: 페이징 -->
					<div id="paging" class="paging">
					</div>
					<!-- e: 페이징 -->
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:cardSelect();">확인</span>
						<span class="btn large focus" onclick="javascript:closeCardListPopup();">취소</span>
					</div>
					<!-- e: btn -->
				</div>
			</div>

		</div>

	</div>	
	