<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javascript" src="<c:url value="/resources/common/ckeditor/ckeditor.js" />"></script>  
<script type="text/javascript">
var serviceCategoryMap = new Map();
var notiTypeMap = new Map();
var notiContTypeMap = new Map();
var notiImportanceMap = new Map();
var serviceExposureMap = new Map();
var regFlag = false; 
$(document).ready(function(){
	
	selectGrpCodeList("NOTI_TYPE","notiType");
	//selectGrpCodeList("SERVICE_CATEGORY","serviceCategoryArea");	
	selectGrpCodeList("CARD_NOTI_CONT_TYPE","cardNotiContTypeArea");	
	selectGrpCodeList("SERVICE_EXPOSURE","serviceExposure");
	selectGrpCodeList("NOTI_IMPORTANCE","notiImportance");
	
	//Push 알림 시간 설정 영역 hide
	$("#pushStartDtArea").hide();
	$("#pushEndDtArea").hide();
	$("#ppushStartDtArea").hide();
	$("#ppushEndDtArea").hide();
	
	
	$("input[name=contType]").change(function() {
		var contTypeVal = $(this).val();
		if (contTypeVal == "HTML") {
			
			$("#cardTable").find("tr").last().remove();
			$("#cardTable").find("tr").last().remove();
			
			var html ="";
			html +="		<tr> ";
			html +="			<th class='last' >내용 <span class='imp'>*</span></th> ";
			html +="			<td colspan='3' class='last'> ";
			html +="				<textarea id='notiContEdit' name='notiContEdit' class='input textareabox' style='height:400px' ></textarea> ";
			html +="  	</td> ";
			html +="	</tr> ";
			
			$('#notiContEdit').remove();
			$("#tbodyArea").append(html);

			reloadCKEDITOR();
			
		}else{
			$("#cardTable").find("tr").last().remove();
			
			var html ="";
			html +="	<tr> ";
			html +="		<th class='last'>URL <span class='imp'>*</span></th>";
			html +="		<td colspan='3' class='last'>";
			html +="			<input type='text'  autocomplete='off' id='cardUrl' name='cardUrl'  class='input w01' readOnly/>";
			html +="		</td>";
			html +="	</tr>";
			html +="	<tr> ";
			html +="		<th class='last'>Card Notice(Image) <span class='imp'>*</span></th>";
			html +="		<td colspan='3' class='last'>";
			html +="		<p>";
			html +="		<br/>";
			html +="			<form id= 'cardNoticeInsertImgForm' name='cardNoticeInsertImgForm'  enctype='multipart/form-data' >";
			html +="				<input type='file' name='uploadfile' id='uploadfile' accept='image/gif, image/jpeg, image/png'/>";
			html +="			</form>";
			html +="		</p>";
			html +="		<div id='image_preview'>";
			html +="			<a id='remove' href='#'><span class='btn small'>제거</span></a>";
			html +="			<a href='javascript:insertNoticeCardImg();'>";
			html +="				<span class='btn small focus'>카드 이미지 등록</span>";
			html +="			</a>";
			html +="			<br/>";
			html +="			<img src='#' />";
			html +="		</div>";
			html +="		</td>";
			html +="	</tr>";
		
			$("#tbodyArea").append(html);
			
			$('#image_preview a').hide();
			$('#image_preview img').hide();
			
			$('#uploadfile').on('change', function() {
				$('#image_preview a').show();
				$('#image_preview img').show();
				ext = $(this).val().split('.').pop().toLowerCase(); //확장자
		
				//배열에 추출한 확장자가 존재하는지 체크
				if($.inArray(ext, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
					resetFormElement($(this)); //폼 초기화
					window.alert('이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)');
				} else {
				file = $('#uploadfile').prop("files")[0];
				 blobURL = window.URL.createObjectURL(file);
				$('#image_preview img').attr('src', blobURL);
				$('#image_preview').slideDown(); //업로드한 이미지 미리보기 
				$(this).slideUp(); //파일 양식 감춤
				}
			});
			
			/**
			onclick event handler for the delete button.
			It removes the image, clears and unhides the file input field.
			*/
			$('#remove').bind('click', function() {
				resetFormElement($('#uploadfile')); //전달한 양식 초기화
				$('#uploadfile').slideDown(); //파일 양식 보여줌
				$(this).parent().slideUp(); //미리 보기 영역 감춤
				
				$('#cardUrl').val('');
				return false; //기본 이벤트 막음
			});
	
	
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
			
		}
	});
	
	
	//Push 알림 시간 설정 영역 이벤트 설정.
	$("input[name=pushYn]").change(function() {
		var pushYnVal = $(this).val();
		if (pushYnVal == "Y") {
			if(confirm("푸시 알림을 사용 하시겠습니까?")) {
				$("#pushStartDtArea").show();
				$("#pushEndDtArea").show();
				$("#ppushStartDtArea").show();
				$("#ppushEndDtArea").show();	
			}else{
				return false;
			}
			
		} else {
			$("#pushStartDtArea").hide();
			$("#pushEndDtArea").hide();
			$("#ppushStartDtArea").hide();
			$("#ppushEndDtArea").hide();
			//Reset
			$("#spostDate").val("");
			$("#epostDate").val("");
			$("#pspostDate").val("");
			$("#pepostDate").val("");
			$("#pushStartDt").val("");
			$("#pushEndDt").val("");
			$("#ppushStartDt").val("");
			$("#ppushEndDt").val("");
		}
	});
	
	//F/W버전 전체 checkbox 이벤트
	$("input:checkbox[name=firmVerAll]").change(function() {	
		if($("input:checkbox[name=firmVerAll]").is(":checked")==true) {
			$("#firmVer").val("ALL");
			$('#firmVer').prop('readonly', 'true');
		} else {
			$("#firmVer").val("");
			$('#firmVer').removeAttr('readonly');
		}

	});
	
	//Start 시간 설정
	var notiSpostDate = "${notiSpostDate}";
	if(notiSpostDate !=null && notiSpostDate != ""){
		$('#notiSpostDate').val(startDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
		replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
	}else{
		$('#notiSpostDate').val(dateAdd(new Date().toISOString().slice(0,10),0,"d"));
	}
	//End 시간 설정
	var notiEpostDate = "${notiEpostDate}";
	if(notiEpostDate !=null && notiEpostDate != ""){
		$('#notiEpostDate').val(endDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
	}else{
		$('#notiEpostDate').val(dateAdd(new Date().toISOString().slice(0,10),+30,"d"));
	}	
	
	//datePicker설정
	datePicker({
		datePickerGroupId: "datepicker1_group",
		datePickerId: "datepicker1"
	
	});
	datePicker({
		datePickerGroupId: "datepicker2_group",
		datePickerId: "datepicker2"
	});
	
	
	// 데이터 피커 생성
	datePicker({
		datePickerGroupId: "datepicker3_group",
		datePickerId: "datepicker3",
		defaultDt : $('#notiSpostDate').val()
	});
	
	datePicker({
		datePickerGroupId: "datepicker4_group",
		datePickerId: "datepicker4",
		defaultDt : $('#notiEpostDate').val()
	});
	
});

function reloadCKEDITOR(){

	 if (CKEDITOR.instances['notiContEdit']) {
		console.log('instance exists');
		CKEDITOR.remove(CKEDITOR.instances['notiContEdit']);
		console.log('distroyed');
	}

	if(CKEDITOR) {
		console.log('0------');
		
		CKEDITOR.editorConfig = function( config ) {
			config.enterMode = CKEDITOR.ENTER_BR // pressing the ENTER Key puts the <br/> tag
			config.shiftEnterMode = CKEDITOR.ENTER_P; //pressing the SHIFT + ENTER Keys puts the <p> tag
		};
		
		CKEDITOR.replace('notiContEdit' ,
		{
					enterMode:'2'
		});
		
	
	}
};

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
		//var html ="<input type='radio' name='serviceCategory' id='serviceCategory'  value='ALL'/> <label for='serviceCategory'>전체</label>&nbsp;&nbsp;";
		var html ="";
		for (var i = 0; i < list.length ; i++) {	
			if(grpCodeNm =='SERVICE_CATEGORY'){
				serviceCategoryMap.put(list[i].cdVal,list[i].dtlCdNm);
				//html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
				
				if( i == 0){
					html += "<input checked type='radio' name='serviceCategory' id='serviceCategory'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='serviceCategory'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
				}else{
					html += "<input type='radio' name='serviceCategory' id='serviceCategory'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='serviceCategory'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
				}
			}else if(grpCodeNm =='CARD_NOTI_CONT_TYPE'){
				if( i == 0){
					html += "<input checked type='radio' name='contType' id='contType'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='contType'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
				}else{
					html += "<input type='radio' name='contType' id='contType'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='contType'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
				}
			}else if(grpCodeNm =='NOTI_TYPE'){
				notiTypeMap.put(list[i].dtlCdNm,list[i].cdVal);
			}else if(grpCodeNm =='SERVICE_EXPOSURE'){
				serviceExposureMap.put(list[i].dtlCdNm,list[i].cdVal);
			}else if(grpCodeNm =='NOTI_IMPORTANCE'){
				notiImportanceMap.put(list[i].dtlCdNm,list[i].cdVal);
			}else{
				///NOTI_IMPORTANCE
			}
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

	var exposureYn =  $(":input:radio[name=exposureYn]:checked").val();
	var serviceCategory =  $(":input:radio[name=serviceCategory]:checked").val();
	var pushYn = $(":input:radio[name=pushYn]:checked").val();
	
	//Date 형식 Set
	var spostDate =$("#spostDate").val();
	var spostHour = $("#spostHour").val();
	var spostMinute =$("#spostMinute").val();
	var epostDate = $("#epostDate").val();
	var epostHour =$("#epostHour").val();
	var epostMinute =$("#epostMinute").val();
	
	
	//공지 일정 Date 형식 Set
	var notiSpostDate =$("#notiSpostDate").val();
	var notiSpostHour = $("#notiSpostHour").val();
	var notiSpostMinute =$("#notiSpostMinute").val();
	var notiEpostDate = $("#notiEpostDate").val();
	var notiEpostHour =$("#notiEpostHour").val();
	var notiEpostMinute =$("#notiEpostMinute").val();
	
	var notiTitle =  $("#notiTitle").val();
	var firmVer =  $("#firmVer").val();
	
	$('input:radio[name=pexposureYn]:input[value=' + exposureYn + ']').attr("checked", true);
	$("#pserviceCategory").val(serviceCategoryMap.get(serviceCategory));
	
	$('input:radio[name=pcontType]:input[value=' + contType + ']').attr("checked", true);
	$('input:radio[name=ppushYn]:input[value=' + pushYn + ']').attr("checked", true);
	
	
	if(pushYn =='Y'){
		$("#ppushStartDt").val(spostDate + " "+spostHour + ":" + spostMinute +":00");
		$("#ppushEndDt").val(epostDate + " "+epostHour + ":" + epostMinute +":00");
	}
	
	$("#pnotiStartDt").val(notiSpostDate + " "+notiSpostHour + ":" + notiSpostMinute +":00");
	$("#pnotiEndDt").val(notiEpostDate + " "+notiEpostHour + ":" + notiEpostMinute +":00");
	
	$("#pnotiTitle").val(notiTitle);
	$("#pfirmVer").val(firmVer);
	
	var contType =  $(":input:radio[name=contType]:checked").val();
	
	if(contType == "HTML"){
		
		var html ="";
		html +="		<tr> ";
		html +="			<th class='last' >내용 <span class='imp'>*</span></th> ";
		html +="			<td colspan='3' class='last'> ";
		html +="				<textarea id='pnotiCont' name='pnotiCont' class='input textareabox' style='height:400px' ></textarea> ";
		html +="  	</td> ";
		html +="	</tr> ";
		
		$("#pcardTable").find("tr").last().remove();
		$("#preViewTbody").append(html);
		
		
		if (CKEDITOR.instances['notiCont']) {
				console.log('instance exists');
				CKEDITOR.remove(CKEDITOR.instances['notiCont']);
				console.log('distroyed');
			}

			CKEDITOR.editorConfig = function( config ) {
				config.enterMode = CKEDITOR.ENTER_BR // pressing the ENTER Key puts the <br/> tag
				config.shiftEnterMode = CKEDITOR.ENTER_P; //pressing the SHIFT + ENTER Keys puts the <p> tag
			};
			CKEDITOR.replace( 'pnotiCont' ,
			{
				enterMode:'2',
				toolbar: 'Custom', //makes all editors use this toolbar
				toolbarStartupExpanded : false,
				toolbarCanCollapse  : false,
				toolbar_Custom: [] //define an empty array or whatever buttons you want.
			});
			console.log("####");
			var notiCont =  CKEDITOR.instances.notiContEdit.getData();
			CKEDITOR.instances.pnotiCont.setData(notiCont);
	
	}else{
		
		$("#pcardTable").find("tr").last().remove();
		var html="";
		html+="	<tr> ";
		html+="		<th class='last'>URL <span class='imp'>*</span></th>";
		html+="		<td colspan='3' class='last'>";
		html+="			<input type='text'  autocomplete='off' id='pcardUrl' name='pcardUrl'  class='input w01' readonly/>";
		html+="		</td>";
		html+="	</tr>";
		html+="	<tr>";
		html+="		<th class='last' >카드 공지 사항 이미지<span class='imp'>*</span></th>";
		html+="		<td colspan='3' class='last'>";
		html+="			<div id='pimage_preview'>";
		html+="				<img src='#' />";
		html+="			</div>";
		html+="		</td>";
		html+="	</tr>";

		$("#preViewTbody").append(html);
		
		file = $('#uploadfile').prop("files")[0];
		 blobURL = window.URL.createObjectURL(file);
		$('#pimage_preview img').attr('src', blobURL);
		
		var cardUrl =  $("#cardUrl").val();
		$("#pcardUrl").val(cardUrl);
		
	}
	
	$(".dimmed").show();
	$("#cardNoticePreViewPopup").show();
}



function insertNoticeCardImg(){
	var url = "<c:url value='/card/insertNoticeCardImg.do' />";
	
	
	//console.log("TEST");
	//$('#eventCardInsertForm').attr('method','post').attr('action','/admin/card/insertEventCardImg.do').submit();
	/*  var frm = document.getElementById('eventCardInsertImgForm');
	frm.method = 'POST';
	frm.enctype = 'multipart/form-data';
	var fileData = new FormData(frm); */
	
	var formData = new FormData(); 
	formData.append("uploadfile", $("input[name=uploadfile]")[0].files[0]);
	
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
			$("#cardUrl").val(resultDate);
			alert("공지사항 카드 이미지가 등록 되었습니다.");
		}else if(result =='NOT_ALLOW_FILE_EXT'){
			alert("이미지 파일이 아닙니다! (gif, png, jpg, jpeg 만 업로드 가능)");
		}else{
			alert("공지사항 카드 이미지 등록에 실패하였습니다.");
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

//미입력 항목 alert
function alertMessageSource(elId){
	console.log("elId",elId);
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
	 
	if( start > end )
	{
		alert(msg);
		return false;
	}
	else{
		return true;
	}
}


//Notice 등록/수정
function cardNoticeInsert() {
	var url = "<c:url value='/card/insertCardNotice.do' />";
	
	var notiType =notiTypeMap.get("카드덱");
	$("#notiType").val(notiType);
	
	var serviceExposure =serviceExposureMap.get("DEVICE");
	$("#serviceExposure").val(serviceExposure);
	
	var notiImportance =notiImportanceMap.get("일반");
	$("#notiImportance").val(notiImportance);
	
	
	var contType =  $(":input:radio[name=contType]:checked").val();
	if(contType == "HTML"){
		var notiCont =  CKEDITOR.instances.notiContEdit.getData();
		$("#notiCont").val(safeTagToHtmlTag(notiCont));
	}else{
		var cardUrl = $("#cardUrl").val();
		
		$("#notiCont").val(cardUrl);
		
		if(!regFlag){
			alert("공지사항 카드 이미지 업로드가 되지 않았습니다.")
			return false;
		}
	}
	
	//Push 일정
	var spostDate =$("#spostDate").val();
	var spostHour = $("#spostHour").val();
	var spostMinute =$("#spostMinute").val();

	var epostDate = $("#epostDate").val();
	var epostHour =$("#epostHour").val();
	var epostMinute =$("#epostMinute").val();
	
	//공지 일정 Date 형식 Set
	var notiSpostDate =$("#notiSpostDate").val();
	var notiSpostHour = $("#notiSpostHour").val();
	var notiSpostMinute =$("#notiSpostMinute").val();
	
	var notiEpostDate = $("#notiEpostDate").val();
	var notiEpostHour =$("#notiEpostHour").val();
	var notiEpostMinute =$("#notiEpostMinute").val();
	
	var pushYn = $(":input:radio[name=pushYn]:checked").val();
	
	//var contType = $(":input:radio[name=contType]:checked").val();
	
	$("#pushStartDt").val(spostDate.replace(/-/gi, "") + spostHour + spostMinute +"00");
	$("#pushEndDt").val(epostDate.replace(/-/gi, "") + epostHour + epostMinute +"00");
	
	$("#notiStartDt").val(notiSpostDate.replace(/-/gi, "") + notiSpostHour + notiSpostMinute +"00");
	$("#notiEndDt").val(notiEpostDate.replace(/-/gi, "") + notiEpostHour + notiEpostMinute +"00");
	
	var validCheck = false;
	
	if(pushYn =='Y'){
		validCheck = checkStartEndDate($('#pushStartDt').val(), $('#pushEndDt').val(),  " 시작일, 종료일이 잘못되었습니다.");
	}
	
	validCheck = checkStartEndDate($('#notiStartDt').val(), $('#notiEndDt').val(),  " 시작일, 종료일이 잘못되었습니다.");
	
	if(!validCheck){
		return false;
	}
	
	var checkParamArr = ['exposureYn', 'serviceCategory', ,'pushYn', , 'notiTitle','notiCont','spostDate','spostHour','spostMinute','epostDate','epostHour','epostMinute'
	, 'notiSpostDate','notiSpostHour','notiSpostMinute','notiEpostDate','notiEpostHour','notiEpostMinute','firmVer'];
	
	if(pushYn !="Y"){
		checkParamArr = ['exposureYn', 'serviceCategory', ,'pushYn', , 'notiTitle','notiCont'
		             	, 'notiSpostDate','notiSpostHour','notiSpostMinute','notiEpostDate','notiEpostHour','notiEpostMinute','firmVer'];
	}
	
	if (formValidationCheck(checkParamArr)){
		$.ajax({
			url : url
			,data : $('#cardNoticeInsertForm').serialize()
			,dataType : 'json'
			,type : "POST"
		}).done(function(data) {
			var result = data.result;
			if(result == 'Y'){ 
				alert("신규 카드덱 공지사항이 등록 되었습니다.");
				location.href="<c:url value='/card/cardNoticeList.do' />";
			}else if(result == 'DFV'){
				alert("등록 실패 : 펌웨어 버전이 중복.");
			}else if(result == 'E'){
				alert("등록 실패 : 타이틀 중복");
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

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="cardNoticeInsertForm" name="cardNoticeInsertForm">
		<input type="hidden" id="pushStartDt" name="pushStartDt"  />
		<input type="hidden" id="pushEndDt" name="pushEndDt" />
		<input type="hidden" id="notiStartDt" name="notiStartDt"  />
		<input type="hidden" id="notiEndDt" name="notiEndDt" />
		
		<input type="hidden" id="notiCont" name="notiCont"  />
		<input type="hidden" id="notiType" name="notiType" />
		<input type="hidden" id="notiImportance" name="notiImportance" />
		<input type="hidden" id="serviceExposure" name="serviceExposure" />
		<input type="hidden" id="serviceCategory" name="serviceCategory" value="AM" />
		
		<div class="main_top">
			<h2>카드덱 관리> 카드덱 공지 사항 관리 > 카드덱 공지사항 등록</h2>
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
			<table id="cardTable"class="table simple table_write_type">
				<colgroup>
					<col width="16%"/>
					<col width="34%"/>
					<col width="16%"/>
					<col width="34%"/>
				</colgroup>
				<tbody id="tbodyArea">
					<tr>
						<th class="last">제목 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" onkeydown="notAvailableSpecialChar(this)" autocomplete="off" id="notiTitle" name="notiTitle" class="input w01" />
						</td>
					</tr>
					<tr>
						<th class="last">F/W 버전 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input id="firmVerAll" name="firmVerAll" type="checkbox" /> 전체
							<input type="text" onkeydown="notAvailableSpecialChar(this)" autocomplete="off" id="firmVer" name="firmVer" class="input w01" style="position:relative;top:0px;left:40px;width:500px"/>
						</td>
					</tr>
					<tr>
						<th class="last" >상태<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  checked="checked" type="radio" name="exposureYn" id="exposureYn" class="" value="Y" /> <label for="exposureYn">사용</label>&nbsp;&nbsp;
							<input  type="radio" name="exposureYn" id="exposureYn" class="" value="N" /> <label for="exposureYn">미사용</label>
						</td>
					</tr>
					<!-- <tr>
						<th class="last" >서비스 분류<span class="imp">*</span></th>
						<td id="serviceCategoryArea"colspan="3" class="last">
							
						</td>
					</tr> -->
					
					<tr>
						<th class="last">본문 타입<span class="imp">*</span></th>
						
						<td id="cardNotiContTypeArea" colspan="3" class="last">
							
						</td>
					</tr>
					
					<tr>
						<th class="last" >푸시 알림<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  type="radio" name="pushYn" id="pushYn" class="" value="Y" /> <label for="pushYn">사용</label>&nbsp;&nbsp;
							<input  checked="checked"  type="radio" name="pushYn" id="pushYn" class="" value="N" /> <label for="pushYn">미사용</label>
						</td>
					</tr>
					
					<tr id="pushStartDtArea">
						<th  class="last"><div class="tit_search">푸시 알림 시작 일시<span class="imp">*</span></div></th>
						<td colspan="3" class="last">
							<div id="datepicker1_group" class="group">
								<fmt:parseDate value="${noticeVO.spostDate}" var='spostDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 120px;" id="spostDate" name="spostDate" value="<fmt:formatDate value="${spostDate}" pattern="yyyy-mm-dd"/>" readonly />
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
							&nbsp;
							<select class="select w01" style="width: 100px;" id="spostHour" name="spostHour">
								<c:forEach var="hours" begin="00" end="23">
									<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
									<option value="${hour}" <c:if test="${empty noticeVO.notiId and hour eq 12}">selected="selected"</c:if>
															 <c:if test="${!empty noticeVO.notiId and hour eq noticeVO.spostHour}">selected="selected"</c:if> >${hour}</option>
								</c:forEach>
							</select>
							 &nbsp;시 &nbsp;
							<select class="select w01" style="width: 100px;" id="spostMinute" name="spostMinute">
								<c:forEach var="minutes" begin="00" end="59">
									<fmt:formatNumber var="minute" value="${minutes}" pattern="00" />
									<option value="${minute}" <c:if test="${empty noticeVO.notiId and minute eq 00}">selected="selected"</c:if> 
																<c:if test="${!empty noticeVO.notiId and minute eq appVO.spostMinute}">selected="selected"</c:if>>${minute}</option>
								</c:forEach>
							</select>
							&nbsp;분 &nbsp;
						</td>
					</tr>
					<tr id="pushEndDtArea">
						<th  class="last"><div class="tit_search">푸시 알림 종료 일시<span class="imp">*</span></div></th>
						<td colspan="3" class="last">
							<div id="datepicker2_group" class="group">
								<fmt:parseDate value="${noticeVO.epostDate}" var='epostDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 120px;" id="epostDate" name="epostDate" value="<fmt:formatDate value="${epostDate}" pattern="yyyy-mm-dd"/>" readonly />
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
							&nbsp;
							<select class="select w01" style="width: 100px;" id="epostHour" name="epostHour">
								<c:forEach var="hours" begin="00" end="23">
									<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
									<option value="${hour}" <c:if test="${empty noticeVO.notiId and hour eq 12}">selected="selected"</c:if>
															 <c:if test="${!empty noticeVO.notiId and hour eq appVO.epostHour}">selected="selected"</c:if> >${hour}</option>
								</c:forEach>
							</select>
							 &nbsp;시 &nbsp;
							<select class="select w01" style="width: 100px;" id="epostMinute" name="epostMinute">
								<c:forEach var="minutes" begin="00" end="59">
									<fmt:formatNumber var="minute" value="${minutes}" pattern="00" />
									<option value="${minute}" <c:if test="${empty noticeVO.notiId and minute eq 00}">selected="selected"</c:if> 
																<c:if test="${!empty noticeVO.notiId and minute eq appVO.epostMinute}">selected="selected"</c:if>>${minute}</option>
								</c:forEach>
							</select>
							&nbsp;분 &nbsp;
						</td>
					</tr>
					
					<tr id="notiStartDtArea">
						<th class="last"><div class="tit_search">공지 노출 일시<span class="imp">*</span></div></th>
						<td colspan="3" class="last">
							<div id="datepicker3_group" class="group">
								<fmt:parseDate value="${noticeVO.notiSpostDate}" var='notiSpostDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 120px;" id="notiSpostDate" name="notiSpostDate" value="<fmt:formatDate value="${notiSpostDate}" pattern="yyyy-mm-dd"/>" readonly />
								<a class="btn btn-gray"><i class="icon-calendar"></i></a>
				
								<div id="datepicker3" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
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
							&nbsp;
							<select class="select w01" style="width: 100px;" id="notiSpostHour" name="notiSpostHour">
								<c:forEach var="hours" begin="00" end="23">
									<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
									<option value="${hour}" <c:if test="${empty noticeVO.notiId and hour eq 12}">selected="selected"</c:if>
															 <c:if test="${!empty noticeVO.notiId and hour eq noticeVO.notiSpostHour}">selected="selected"</c:if> >${hour}</option>
								</c:forEach>
							</select>
							 &nbsp;시 &nbsp;
							<select class="select w01" style="width: 100px;" id="notiSpostMinute" name="notiSpostMinute">
								<c:forEach var="minutes" begin="00" end="59">
									<fmt:formatNumber var="minute" value="${minutes}" pattern="00" />
									<option value="${minute}" <c:if test="${empty noticeVO.notiId and minute eq 00}">selected="selected"</c:if> 
																<c:if test="${!empty noticeVO.notiId and minute eq noticeVO.notiSpostMinute}">selected="selected"</c:if>>${minute}</option>
								</c:forEach>
							</select>
							&nbsp;분 &nbsp;
						</td>
					</tr>
					
					<tr id="notiEndDtArea">
						<th  class="last"><div class="tit_search">공지 노출 종료 일시<span class="imp">*</span></div></th>
						<td colspan="3" class="last">
							<div id="datepicker4_group" class="group">
								<fmt:parseDate value="${noticeVO.notiEpostDate}" var='notiEpostDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 120px;" id="notiEpostDate" name="notiEpostDate" value="<fmt:formatDate value="${notiEpostDate}" pattern="yyyy-mm-dd"/>" readonly />
								<a class="btn btn-gray"><i class="icon-calendar"></i></a>
				
								<div id="datepicker4" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
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
							&nbsp;
							<select class="select w01" style="width: 100px;" id="notiEpostHour" name="notiEpostHour">
								<c:forEach var="hours" begin="00" end="23">
									<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
									<option value="${hour}" <c:if test="${empty noticeVO.notiId and hour eq 12}">selected="selected"</c:if>
															 <c:if test="${!empty noticeVO.notiId and hour eq noticeVO.notiEpostHour}">selected="selected"</c:if> >${hour}</option>
								</c:forEach>
							</select>
							 &nbsp;시 &nbsp;
							<select class="select w01" style="width: 100px;" id="notiEpostMinute" name="notiEpostMinute">
								<c:forEach var="minutes" begin="00" end="59">
									<fmt:formatNumber var="minute" value="${minutes}" pattern="00" />
									<option value="${minute}" <c:if test="${empty noticeVO.notiId and minute eq 00}">selected="selected"</c:if> 
																<c:if test="${!empty noticeVO.notiId and minute eq noticeVO.notiEpostMinute}">selected="selected"</c:if>>${minute}</option>
								</c:forEach>
							</select>
							&nbsp;분 &nbsp;
						</td>
					</tr>
					<tr>
						<th class="last">내용 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<textarea name="notiContEdit" id="notiContEdit" class="input textareabox" style="height:400px"></textarea>
							<script>
								// Replace the <textarea id="editor1"> with a CKEditor
								// instance, using default configuration.
								CKEDITOR.editorConfig = function( config ) {
									config.enterMode = CKEDITOR.ENTER_BR // pressing the ENTER Key puts the <br/> tag
									config.shiftEnterMode = CKEDITOR.ENTER_P; //pressing the SHIFT + ENTER Keys puts the <p> tag
								};
								CKEDITOR.replace( 'notiContEdit' ,
								{
									enterMode:'2'
								});
							</script>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<!-- <a href="javascript:preView();"><span class="btn large">미리보기</span></a> -->
			<a href="javascript:cardNoticeInsert();">
				<span class="btn large focus">저장</span>
			</a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>

<!--PreView Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="cardNoticePreViewPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 800px">
			<div class="p_header">
				<h1>미리보기</h1>
				<a href="javascript:$('#cardNoticePreViewPopup').hide(); $('.dimmed').hide();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
							<div class="table_wrap">
									<table id="pcardTable" class="table simple table_write_type">
										<colgroup>
											<col width="20%"/>
											<col width="30%"/>
											<col width="16%"/>
											<col width="34%"/>
										</colgroup>
										<tbody id = "preViewTbody">
											<tr>
												<th class="last" >제목 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pnotiTitle" name="pnotiTitle" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th class="last" >F/W 버전 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pfirmVer" name="pfirmVer" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th class="last" >본문 타입<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input  disabled type="radio" name="pcontType" id="pcontType" class="" value="Y" /> <label for="pcontType">사용</label>
													<input  disabled type="radio" name="pcontType" id="pcontType" class="" value="N" /> <label for="pcontType">미사용</label>
												</td>
											</tr>
											<tr>
												<th class="last" >상태<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input  disabled type="radio" name="pexposureYn" id="pexposureYn" class="" value="Y" /> <label for="pexposureYn">사용</label>
													<input  disabled type="radio" name="pexposureYn" id="pexposureYn" class="" value="N" /> <label for="pexposureYn">미사용</label>
												</td>
											</tr>
											<tr>
												<th class="last" >서비스 분류<span class="imp">*</span></th>
												<td colspan="3" class="last"> 
													<input type="text" autocomplete="off" id="pserviceCategory" name="pserviceCategory"  class="input w01" readOnly />
												</td>
											</tr>
											<tr>
												<th class="last" >푸시 알림<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input disabled type="radio" name="ppushYn" id="ppushYn" class="" value="Y" /> <label for="ppushYn">사용</label>&nbsp;&nbsp;
													<input  disabled type="radio" name="ppushYn" id="ppushYn" class="" value="N" /> <label for="ppushYn">미사용</label>
												</td>
											</tr>
											<tr id="pushStartDtArea">
												<th class="last" >푸시 알림 시작 일시<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="ppushStartDt" name="ppushStartDt" class="input w01" readonly/>
												</td>
											</tr>
											<tr id="pushEndDtArea">
												<th class="last" >푸시 알림 종료 일시<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="ppushEndDt" name="ppushEndDt" class="input w01" readonly/>
												</td>
											</tr>
											<tr id="notiStartDtArea">
												<th class="last" >공지 노출 일시<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pnotiStartDt" name="pnotiStartDt" class="input w01" readonly/>
												</td>
											</tr>
											<tr id="notiEndDtArea">
												<th class="last" >공지 노출 종료 일시<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pnotiEndDt" name="pnotiEndDt" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th class="last" >내용 <span class="imp">*</span></th>
												<td id = colspan="3" class="last">
													<textarea id="pnotiCont" name="pnotiCont" class="input textareabox" style="height:400px" readOnly></textarea>
													<script>
														// Replace the <textarea id="editor1"> with a CKEditor
														// instance, using default configuration.
														CKEDITOR.editorConfig = function( config ) {
															config.enterMode = CKEDITOR.ENTER_BR // pressing the ENTER Key puts the <br/> tag
															config.shiftEnterMode = CKEDITOR.ENTER_P; //pressing the SHIFT + ENTER Keys puts the <p> tag
														};
														CKEDITOR.replace( 'pnotiCont' ,
														{
															enterMode:'2',
															toolbar: 'Custom', //makes all editors use this toolbar
															toolbarStartupExpanded : false,
															toolbarCanCollapse  : false,
															toolbar_Custom: [] //define an empty array or whatever buttons you want.
														});
													</script>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:$('#cardNoticePreViewPopup').hide(); $('.dimmed').hide();">확인</span>
					</div>
					<!-- e: btn -->
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		CKEDITOR.disableAutoInline = true;
	</script>
	<!-- e: popup -->
