<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javascript" src="<c:url value="/resources/common/ckeditor/ckeditor.js" />"></script>
<script type="text/javaScript">
var serviceCategoryMap = new Map();
var notiImportanceMap = new Map();
var serviceExposureMap = new Map();
var notiContTypeMap = new Map();
var notiTypeMap = new Map();

$(document).ready(function(){
	
	$("#pushStartDtArea").hide();
	$("#pushEndDtArea").hide();
	
	selectGrpCodeList("NOTI_IMPORTANCE","notiImportanceArea");
	//selectGrpCodeList("SERVICE_CATEGORY","serviceCategoryArea");	
	selectGrpCodeList("SERVICE_EXPOSURE","serviceExposureArea");
	selectGrpCodeList("CARD_NOTI_CONT_TYPE","cardNotiContType");	
	selectGrpCodeList("NOTI_TYPE","notiType");
	
	// F/W버전이 'ALL'일 경우 버전입력 안됨
	var firmVerAll = "${noticeVO.firmVer}";
	if (firmVerAll.toUpperCase() == "ALL") {
		$("input:checkbox[name=firmVerAll]").attr("checked",true);
		$('#firmVer').prop('readonly', 'true');
	}
	
	//상태
	var exposureYn = "${noticeVO.exposureYn}";
	$('input:radio[name=exposureYn]:input[value=' + exposureYn + ']').attr("checked", true);
	//서비스분류
	//var serviceCategory = "${noticeVO.serviceCategory}";
	//$('input:radio[name=serviceCategory]:input[value=' + serviceCategoryMap.get(serviceCategory) + ']').attr("checked", true);
	
	//본문 타입
	var contType = "${noticeVO.contType}";
	$('input:radio[name=contType]:input[value=' + notiContTypeMap.get(contType) + ']').attr("checked", true);
	

	//푸시알림
	var pushYn = "${noticeVO.pushYn}";
	$('input:radio[name=pushYn]:input[value=' + pushYn + ']').attr("checked", true);

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
					html += "<input  checked type='radio' name='serviceCategory' id='serviceCategory'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='serviceCategory'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
				}else{
					html += "<input  type='radio' name='serviceCategory' id='serviceCategory'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='serviceCategory'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
				}
			}else if(grpCodeNm =='CARD_NOTI_CONT_TYPE'){
				notiContTypeMap.put(list[i].cdVal,list[i].dtlCdNm);
				if( i == 0){
					html += "<input disabled checked type='radio' name='contType' id='contType'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='contType'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
				}else{
					html += "<input disabled type='radio' name='contType' id='contType'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='contType'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
				}
			}else if(grpCodeNm =='SERVICE_EXPOSURE'){
				serviceExposureMap.put(list[i].dtlCdNm,list[i].cdVal);
			}else if(grpCodeNm =='NOTI_IMPORTANCE'){
				notiImportanceMap.put(list[i].dtlCdNm,list[i].cdVal);
			}else if(grpCodeNm =='NOTI_TYPE'){
				notiTypeMap.put(list[i].dtlCdNm,list[i].cdVal);
			}else{
				//nothing
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


function editNoticeCardImg(){
	var url = "<c:url value='/card/insertNoticeCardImg.do' />";

	var formData = new FormData(); 
	formData.append("uploadfile", $("input[name=uploadfile]")[0].files[0]);
	
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
			$("#notiCont").val(resultDate);
			$("#urlImageSrc").attr("src",resultDate);
			$('#remove').click();
			alert("이벤트 카드 이미지가 등록 되었습니다.");
		}else{
			alert("이벤트 카드 이미지 등록에 실패하였습니다.");
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


function updateCardNotice() {
	
	if(confirm("해당 카드덱 공지사항을 수정 하시겠습니까?")) {
		
		//var notiId = "${noticeVO.notiId}";
		var url="<c:url value='/card/updateCardNotice.do'/>";

		var notiType =notiTypeMap.get("카드덱");
		$("#notiType").val(notiType);
		
		var serviceExposure =serviceExposureMap.get("디바이스");
		$("#serviceExposure").val(serviceExposure);
		
		var notiImportance =notiImportanceMap.get("일반");
		$("#notiImportance").val(notiImportance);
		
		//var serviceCategory =  $(":input:radio[name=serviceCategory]:checked").val();
		//$("#serviceCategory").val(serviceCategory);
		
		var contType =  $(":input:radio[name=contType]:checked").val();
		if(contType == "HTML"){
			var notiCont =  CKEDITOR.instances.notiCont.getData();
			$("#notiCont").val(safeTagToHtmlTag(notiCont));
		}else{

			//if(!regFlag){
			//	alert("공지사항 카드 이미지 업로드가 되지 않았습니다.")
			//	return false;
			//}
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
				,data : $('#cardNoticeEditForm').serialize()
				,dataType : 'json'
				,type : "POST"
			}).done(function(data) {
				var result = data.result;
				if(result == 'Y'){ 
					alert("카드덱 공지사항이 수정 되었습니다.");
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
}

function historyBack(){
		//history.back();
	location.href="<c:url value='/card/cardNoticeList.do'/>";
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
//미입력 항목 alert
function alertMessageSource(elId){
	console.log("elId",elId);
	alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="cardNoticeEditForm" name="cardNoticeEditForm">
	<input type="hidden" id="notiId" name="notiId" value="${noticeVO.notiId}" />
	<input type="hidden" id="pushStartDt" name="pushStartDt"  />
	<input type="hidden" id="pushEndDt" name="pushEndDt" />
	<input type="hidden" id="notiStartDt" name="notiStartDt"  />
	<input type="hidden" id="notiEndDt" name="notiEndDt" />
	<input type="hidden" id="notiImportance" name="notiImportance" />
	<input type="hidden" id="serviceExposure" name="serviceExposure" />
	
	<input type="hidden" id="notiType" name=notiType />
		<div class="main_top">
			<h2>카드덱 관리> 카드덱 공지 사항 관리 > 카드덱 공지사항 상세 수정</h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">기본정보</div>
			</div>
		</div>
		<!-- e: table top-->
			
		<!-- s: table wrap-->
		<div class="table_wrap">
			<table id ="notiDetailTable" class="table simple table_write_type">
				<colgroup>
					<col width="16%"/>
					<col width="34%"/>
					<col width="16%"/>
					<col width="34%"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="last" >제목 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="notiTitle" name = "notiTitle" value="${noticeVO.notiTitle}" class="input w01" />
						</td>
					</tr>
					<tr>
						<th class="last" >F/W 버전 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input id="firmVerAll" name="firmVerAll" type="checkbox" /> 전체
							<input type="text" autocomplete="off" id="firmVer" name = "firmVer" value="${noticeVO.firmVer}" class="input w01" style="position:relative;top:0px;left:40px;width:500px" />
						</td>
					</tr>
					<tr>
						<th class="last" >상태<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input   type="radio" name="exposureYn" id="exposureYn" class="" value="Y" /> <label for="exposureYn">사용</label>
							<input   type="radio" name="exposureYn" id="exposureYn" class="" value="N" /> <label for="exposureYn">미사용</label>
						</td>
					</tr>
					<tr>
						<th class="last" >서비스 분류</th>
						<td id="serviceCategoryArea" colspan="3" class="last">
							<input type="hidden"  maxlength="80"  autocomplete="off" id="serviceCategory" name="serviceCategory" value="AM" />
							AM (After 마켓 서비스)
						</td>
					</tr>
					<tr>
						<th class="last" >본문 타입<span class="imp">*</span></th>
						<td id="cardNotiContType" colspan="3" class="last">
							
						</td>
					</tr>
					<tr>
						<th class="last" >푸시 알림<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  type="radio" name="pushYn" id="pushYn" class="" value="Y" /> <label for="pushYn">사용</label>&nbsp;&nbsp;
							<input  type="radio" name="pushYn" id="pushYn" class="" value="N" /> <label for="pushYn">미사용</label>
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
					<c:choose>
						<c:when test="${noticeVO.contType eq 'HTML'}">
						<tr>
						<th class="last" >내용 <span class="imp">*</span></th>
							<td colspan="3" class="last">
								<textarea id="notiCont" name="notiCont" class="input textareabox" style="height:400px"><c:out value="${noticeVO.notiCont}" /></textarea>
								<script>
									CKEDITOR.editorConfig = function( config ) {
										config.enterMode = CKEDITOR.ENTER_BR // pressing the ENTER Key puts the <br/> tag
										config.shiftEnterMode = CKEDITOR.ENTER_P; //pressing the SHIFT + ENTER Keys puts the <p> tag
									};
	  							
									CKEDITOR.replace( 'notiCont' ,
									{
										enterMode:'2'
									});
								</script>
							</td>
						</tr>
						</c:when>
						<c:otherwise>
							<tr> 
								<th class="last">URL <span class="imp">*</span></th>
								<td colspan="3" class="last">
									<input type="text"  autocomplete="off" id="notiCont"  name="notiCont" value="${noticeVO.notiCont}"  class="input w01" readOnly/>
								</td>
							</tr>
							<tr>
								<th class="last" >URL 이미지 <span class="imp">*</span></th>
								<td colspan="3" class="last">
									<img id="urlImageSrc" src="${noticeVO.notiCont}" style='display: inline;'>
								</td>
							</tr>
							
							
							<tr> 
								<th class="last">변경 Card Notice(Image) <span class="imp">*</span></th>
								<td colspan="3" class="last">
								<p>
								<br/>
									<form id= "cardNoticeEditImgForm" name="cardNoticeEditImgForm"  enctype="multipart/form-data" >
										<input type="file" name="uploadfile" id="uploadfile" accept="image/gif, image/jpeg, image/png"/>
									</form>
								</p>
								<div id="image_preview">
									<a id="remove" href="#"><span class="btn small">제거</span></a>
									<a href="javascript:editNoticeCardImg();">
										<span class="btn small focus">카드 이미지 수정</span>
									</a>
									<br/>
									<img src="#" />
								</div>
								</td>
							</tr>
							<script>
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
										
										$('#eventCardUrl').val('');
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
							</script>
							</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<a href="javascript:updateCardNotice();"><span class="btn large focus">저장</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
