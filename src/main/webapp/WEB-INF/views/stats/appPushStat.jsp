<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
var msgStatusMap = new Map();

$(document).ready(function(){

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
	
	selectGrpCodeSet();
	
});

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

//그룹 코드 정보 조회
function selectGrpCodeSet(){
	selectGrpCodeList("SMS_MSG_STATUS","msgStatus");

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
			html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
			msgStatusMap.put(list[i].cdVal,list[i].codeDesc);
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
	
	$("#recvPhoneNo").val("");
	$("#msgId").val("");
	$("#msgStatus").val("ALL").prop("selected", true);
	
	var html="";
	html += "	<tr><th colspan='10'></th></tr>";
	
	$("#paging").empty();

	$("#appPushStatList").empty();
	$("#appPushStatList").append(html);
	$("#totCnt").text("0");
	
}

//엑셀 다운로드
function downLoadExcel(){
	$('#appPushStatSearchForm').attr("action", "<c:url value='/stat/selectAppPushStatListExcel.do'/>");
	$('#appPushStatSearchForm').submit();
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
	
	var validCheck = false;
	validCheck = checkStartEndDate($('#startDate').val(), $('#endDate').val(),"-" , " 시작일, 종료일이 잘못되었습니다.");
	
	if(!validCheck){
		return false;
	}
	
	
	$("#page").val(page);
	$.ajax({
		url : "<c:url value='/stat/selectAppPushStatList.do'/>",
		data : $('#appPushStatSearchForm').serialize(),
		dataType : 'json',
		type : "POST"
	}).done(function(data) {

		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		//console.log("msgStatusMap",msgStatusMap);
		if(list.length == 0){
			
			html += "	<tr><th colspan='10'>조회된 결과가 없습니다.</th></tr>";
		}else{
			for (var i = 0; i < list.length; i++) {
				html += "<tr>";
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td>" + list[i].msgId + "</td>";
				//console.log(list[i].msgStatus);
				var msgStatusDesc = msgStatusMap.get(list[i].msgStatus);
				html += "	<td>" + msgStatusDesc + "</td>";
				html += "	<td>" + list[i].msgTitle + "</td>";
				html += "	<td>" + list[i].msgCont + "</td>";
				/* html += "	<td>" + list[i].msgType + "</td>"; */
				html += "	<td>" + list[i].recvPhoneNo + "</td>";
				/* html += "	<td>" + list[i].sendType + "</td>"; */
				html += "	<td>" + list[i].sendDt + "</td>";
				/* html += "	<td>" + list[i].orgNo + "</td>"; */
				html += "	<td>" + list[i].sendTryCnt + "</td>";
				html += "	<td>" + list[i].regDt + "</td>";
				html += "	<td>" + list[i].wasInfo + "</td>";
				html += "</tr>";
			}
		}
		
		$("#paging").empty();
		$("#paging").append(data.paging);

		$("#appPushStatList").empty();
		$("#appPushStatList").append(html);

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
function isNumber(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	}); 
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="appPushStatSearchForm" name="appPushStatSearchForm">
	<input type="hidden" id="page" name="page" />
		<div class="main_top">
			<h2> 서비스 통계 > App Push 전송 이력 조회 </h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">검색 조건</div>
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
						<th class="last" >MSG ID<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="msgId" name="msgId" class="input w01"/>
						</td>
						<th class="last" >수신 번호 <span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="number" autocomplete="off" id="recvPhoneNo" name="recvPhoneNo" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th class="last" >처리 상태<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<select id="msgStatus" name="msgStatus" class="select w01"style="width: 380px; text-align: center;">
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
					<div class="tit_table">App Push 전송 이력 리스트</div>
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
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/> <!--제목  -->
				<col width="18%"/> <!--내용  -->
				<!-- <col width="5%"/> -->
				<col width="8%"/>
				<!-- <col width="5%"/> -->
				<col width="12%"/>
				<!-- <col width="12%"/> -->
				<col width="5%"/>
				<col width="12%"/>
				<col width="*%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>MSG ID</th>
					<th>처리<br>상태</th>
					<th>제목</th>
					<th>내용</th>
					<!-- <th>메세지타입</th> -->
					<th>수신자</th>
					<!-- <th>전송타입</th> -->
					<th>전송시간</th>
					<!-- <th>발신번호</th> -->
					<th>재전송<br>횟수</th>
					<th>등록일</th>
					<th>서버</th>
				<tr>
			</thead>
			<tbody id="appPushStatList">
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
