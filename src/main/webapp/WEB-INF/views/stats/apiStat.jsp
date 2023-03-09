<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
var apiCodeMap = new Map();

$(document).ready(function(){

	
	
	//Start 시간 설정
	var startDate = "${startDate}";
	if(startDate !=null && startDate != ""){
		$('#startDate').val(startDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
		replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
	}else{
		$('#startDate').val(dateAdd(new Date().toISOString().slice(0,10),0,"d"));
	}
	//End 시간 설정
	var endDate = "${endDate}";
	if(endDate !=null && endDate != ""){
		$('#endDate').val(endDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
	}else{
		$('#endDate').val(dateAdd(new Date().toISOString().slice(0,10),+1,"d"));
	}	
	
	//datePicker설정
	datePicker({
		datePickerGroupId: "datepicker1_group",
		datePickerId: "datepicker1",
		defaultDt : $('#startDate').val()
	});
	datePicker({
		datePickerGroupId: "datepicker2_group",
		datePickerId: "datepicker2",
		defaultDt : $('#endDate').val()
	});
	
	selectGrpCodeSet();
	//goSearch(1);		
});


//API_NM 정보 조회
function selectGrpCodeSet(){
	selectGrpCodeList("API_NM","apiNm");
	selectGrpCodeList("APP_TYPE","reqAppType");
	selectGrpCodeList("DEVICE_TYPE","deviceType");
	selectDeviceModelList("deviceModelNm");
}


function selectGrpCodeList(grpCodeNm,grpCodeListAreaId){
	$.ajax({
		url : "<c:url value='/system/code/selectDtlCodeList.do' />",
		type : "POST",
		data : {
			"grpCdNm" : grpCodeNm
		},
		dataType : "json"
	}).done(function (data) {
		
		
		var list = data.resultList;
		var html ="<option value='ALL' selected='selected'>전체</option>";
		for (var i = 0; i < list.length ; i++) {	
			if(grpCodeNm =='API_NM'){
				apiCodeMap.put(list[i].cdVal,list[i].dtlCdNm);
				html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
			}else{
			 html += "<option value="+list[i].dtlCdNm+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
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


function selectDeviceModelList(grpCodeListAreaId){
	$.ajax({
		url : "<c:url value='/stat/selectDeviceModelList.do' />",
		type : "POST",
		data : {
		},
		dataType : "json"
	}).done(function (data) {
		
		var list = data.resultList;
		var html ="<option value='ALL' selected='selected'>전체</option>";
		for (var i = 0; i < list.length ; i++) {	
			 html += "<option value="+list[i].deviceModelId+">"+ list[i].deviceModelNm +"</option>";
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

// 검색 조건 초기화
function resetSearch(){
	$('#startDate').val(dateAdd(new Date().toISOString().slice(0,10),0,"d"));
	$('#endDate').val(dateAdd(new Date().toISOString().slice(0,10),+1,"d"));
	
	$("#reqCtn").val("");
	$("#membId").val("");
	
	$("#deviceModelNm").val("ALL").prop("selected", true);
	$("#apiNm").val("ALL").prop("selected", true);
	$("#resultStatus").val("ALL").prop("selected", true);
	
	var html="";
	html += "	<tr><th colspan='12'></td></tr>";
	
	$("#paging").empty();

	$("#apiStatList").empty();
	$("#apiStatList").append(html);
	
	$("#totCnt").text("0");
	
}

//엑셀 다운로드
function downLoadExcel(){
	$('#apiStatSearchForm').attr("action", "<c:url value='/stat/selectApiStatListExcel.do'/>");
	$('#apiStatSearchForm').submit();
}

//시작일, 종료일 체크
function checkStartEndDate(start, end, spliter, msg){
	
	//공백 체크
	if(start.trim() == "" || start.trim() == null){
		alert("시작 날짜를 선택해주세요.");
		return false;
	}
	if(end.trim() == "" || end.trim() == null){
		alert("종료 날짜를 선택해주세요.");
		return false;
	}
	 
	var startDateArr = start.split(spliter);
	var endDateArr  = end.split(spliter);
	//var sDate = new Date(startDateArr[0], startDateArr[1], startDateArr[2]).valueOf();
	//var eDate = new Date(endDateArr[0], endDateArr[1], endDateArr[2]).valueOf();
	
	console.log("start:",start);
	console.log("end:",end);
	var sDate = start.replace(/-/g,"")+"00";
	var eDate = end.replace(/-/g,"")+"00";
	
	if( sDate > eDate )
	{
		alert(msg);
		return false;
	}else{
		
		var betweenDay = calDateRange(start,end);
		
		if(betweenDay >=31 ){
			alert("노출기간은  최대 30일 이상 지정 하실 수 없습니다.");
			return false;
		}else{
			return true;
		}
	}
}


// 리스트 조회
function goSearch(page) {
	//CTN Validation Check
	//var reqCtn = $("#reqCtn").val();	
	
	/* if (reqCtn != "") {
		var rgEx = /[01](0|1|6|7|8|9)[-](\d{4}|\d{3})[-]\d{4}$/g;
		var strValue = reqCtn;
		var chkFlg = rgEx.test(strValue);
		if (!chkFlg) {
			alert("올바른 단말 번호가 아닙니다.");
			$("#reqCtn").focus();
			return false;
		}
	}  */
	//$("#reqCtn").val(reqCtn.replace(/-/gi, ""));
	
	var validCheck = false;
	validCheck = checkStartEndDate($('#startDate').val(), $('#endDate').val(),"-" , " 시작일, 종료일이 잘못되었습니다.");
	
	if(!validCheck){
		return false;
	}
	
	
	$("#page").val(page);
	$.ajax({
		url : "<c:url value='/stat/selectApiStatList.do'/>",
		data : $('#apiStatSearchForm').serialize(),
		dataType : 'json',
		type : "POST"
	}).done(function(data) {

		var html = '';
		var list = data.resultList;
		

		var totalResult = data.totalCount;

		if (list.length == 0) {

			html += "	<tr><th colspan='13'>조회된 결과가 없습니다.</td></tr>";
		} else {
			//Use Version Top Area
			for (var i = 0; i < list.length; i++) {
				html += "<tr>";
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td>" + replaceNullValue(list[i].membId) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].membNo) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].reqAppType) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].reqCtn) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].deviceType) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].sessionId) + "</td>";
				/* html += "	<td>" + list[i].apiNm + "</td>"; */
				var apiNm = apiCodeMap.get(list[i].apiNm);
				//console.log("apiNm",apiNm);
				//console.log("apiNm",if(apiNm));
				if(!apiNm){
					apiNm = list[i].apiNm;
				}
				html += "	<td>" + apiNm + "</td>";
				/* html += "	<td>" + list[i].apiDesc + "</td>"; */
				html += "	<td>" + replaceNullValue(list[i].resultStatus) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].processDt) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].elapsedTime) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].wasInfo) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].deviceModelNm) + "</td>";
				html += "</tr>";
			}
		}

			$("#paging").empty();
			$("#paging").append(data.paging);

			$("#apiStatList").empty();
			$("#apiStatList").append(html);

			$("#totCnt").text(totalResult);
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
	}

function replaceNullValue(txt){
	//console.log('txt',txt);
	if(txt =='null' || txt == null){
		return 'Unknown';
	}
	return txt;
}
function isNumber(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	}); 
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
	<form id="apiStatSearchForm" name="apiStatSearchForm">
	<input type="hidden" id="page" name="page" />
		<div class="main_top">
			<h2> 서비스 통계 > API 이력 조회 </h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">API 검색 조건</div>
			</div>
			<div class="rtl">
				<div class="table_info01">* 선택입력</div>
			</div>
		</div>
		<!-- e: table top-->
			
		<!-- s: search table wrap-->
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
						<th class="last" >기간<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<div id="datepicker1_group" class="group">
								<fmt:parseDate value="${apiStatVO.startDate}" var='startDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 120px;" id="startDate" name="startDate" value="<fmt:formatDate value="${startDate}" pattern="yyyy-mm-dd"/>" readonly />
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
							 ~ 
							<div id="datepicker2_group" class="group">
								<fmt:parseDate value="${apiStatVO.startDate}" var='endDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 120px;" id="endDate" name="endDate" value="<fmt:formatDate value="${endDate}" pattern="yyyy-mm-dd"/>" readonly />
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
						<th class="last" >CTN <span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="reqCtn" name="reqCtn" class="input w01"/>
						</td>
						<th class="last" >MEMB ID<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="membId" name="membId" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th class="last" >MEMB NO<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="membNo" name="membNo" class="input w01"/>
						</td>
						<th class="last" >Device Model<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="deviceModelNm" name="deviceModelNm" class="select w01"style="width: 380px;">
								<option value="ALL" selected="selected">전체</option>	
							</select>
						</td>	
					</tr>					
					<!-- <tr>
						
						<th class="last" >MEMB NO <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="membNo" name="membNo" class="input w01"/>
						</td>
					</tr> -->
					<tr>
						<th class="last" >API 이름<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="apiNm" name="apiNm" class="select w01"style="width: 380px; text-align: center;">
								<option value="ALL" selected="selected">전체</option>
							</select>
						</td>
						<th class="last" >처리 결과<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="resultStatus" name="resultStatus" class="select w01"style="width: 380px;">
								<option value="ALL" selected="selected">전체</option>
								<option value="suc">성공</option>
								<option value="fail">실패</option>
							</select>
						</td>
				</tr>
				
				<tr>
					<th class="last" >Device Type<span class="imp">*</span></th>
					<td colspan="1" class="last">
						<select id="deviceType" name="deviceType" onchange="showSub(this.options[this.selectedIndex].value);" class="select w01"style="width: 380px; text-align: center;">
							<option value="ALL" selected="selected">전체</option>							
						</select>
					</td>
					<th class="last" >Request App 타입<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="reqAppType" name="reqAppType" class="select w01"style="width: 380px;">
								<option value="ALL" selected="selected">전체</option>	
							</select>
						</td>					
				</tr>
				</tbody>
			</table>
			<div class="thead_wrap cboth">
				<div class="rtl">
					<a href="javascript:goSearch(1);"><span class="btn btn_w01"> 조회</span></a>&nbsp;
				</div>
				<div class="rtl">
					<a href="javascript:resetSearch();"><span class="btn btn_w01"> 초기화</span></a>&nbsp;
				</div>
			</div>
			<br><br>
			<div class="thead_wrap cboth">
				<div class="ltr">
					<div class="tit_table">API 이력 리스트</div>
				</div>
				<div class="rtl">
					<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
				</div>
		</div>
	<!-- e: search table wrap-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="5%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="7%"/>
				<col width="12%"/>
				<col width="5%"/>
				<col width="8%"/>
				<col width="*"/>
			</colgroup>
			<thead>
					<tr>
						<th colspan="1" scope="colgroup">No</th>
						<th colspan="1" scope="colgroup">MEMB ID</th>
						<th colspan="1" scope="colgroup">MEMB NO</th>
						<th colspan="1" scope="colgroup">APP<br>Type</th>
						<th colspan="1" scope="colgroup">CTN</th>
						<th colspan="1" scope="colgroup">Device<br>Type</th>
						<th colspan="1" scope="colgroup">세션 ID</th>
						<th colspan="1" scope="colgroup">API 이름</th>
						<th colspan="1" scope="colgroup">결과 코드</th>
						<th colspan="1" scope="colgroup">요청 시간</th>
						<th colspan="1" scope="colgroup">처리<br>시간<br></th>
						<th colspan="1" scope="colgroup">서버</th>
						<th colspan="1" scope="colgroup">Device<br>Model</th>
					</tr>
			</thead>
			<tbody id="apiStatList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:downLoadExcel();">결과 다운로드</a></span>
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>
