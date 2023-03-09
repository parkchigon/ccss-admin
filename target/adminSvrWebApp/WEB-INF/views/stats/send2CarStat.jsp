<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
var serviceTypeMap = new Map();
var sendStatusMap = new Map();


$(document).ready(function(){

	selectGrpCodeList("SEND2CAR_SERVICE_TYPE","serviceType");
	selectGrpCodeList("SEND2CAR_SEND_STATUS","sendStatus");
	
	
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
		
		var html ="<option value='ALL' selected='selected'>전체</option>";
		
		for (var i = 0; i < list.length ; i++) {	
			if(grpCodeNm =='SEND2CAR_SERVICE_TYPE'){
				serviceTypeMap.put(list[i].cdVal,list[i].dtlCdNm);
				if(list[i].cdVal !='ALL'){
					html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
				}
			}else if(grpCodeNm =='SEND2CAR_SEND_STATUS'){
				sendStatusMap.put(list[i].dtlCdNm,list[i].dtlCdNm);
				 html += "<option value="+list[i].dtlCdNm+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
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
	})
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
	
	$("#membId").val("");
	$("#deviceCtn").val("");
	$("#mgrappCtn").val("");
	$("#mgrappLoginId").val("");
	$("#sendStatus").val("ALL").prop("selected", true);
	$("#serviceType").val("ALL").prop("selected", true);
	
	var html="";
	html += "	<tr><th colspan='10'></td></tr>";
	
	$("#paging").empty();
	$("#send2CarStatList").empty();
	$("#send2CarStatList").append(html);
	
	$("#totCnt").text("0");
	
}

//엑셀 다운로드
function downLoadExcel(){
	$('#send2CarStatSearchForm').attr("action", "<c:url value='/stat/selectSend2CarStatListExcel.do'/>");
	$('#send2CarStatSearchForm').submit();
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
	
	$("#page").val(page);
	
	var validCheck = false;
	
	validCheck = checkStartEndDate($('#startDate').val(), $('#endDate').val(),"-" , " 시작일, 종료일이 잘못되었습니다.");
	
	if(!validCheck){
		return false;
	}


	$.ajax({
		url : "<c:url value='/stat/selectSend2CarStatList.do'/>",
		data : $('#send2CarStatSearchForm').serialize(),
		dataType : 'json',
		type : "POST"
	}).done(function(data) {

		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;

		if (list.length == 0) {

			html += "	<tr><th colspan='10'>조회된 결과가 없습니다.</td></tr>";
		} else {
			//Use Version Top Area
			for (var i = 0; i < list.length; i++) {
				html += "<tr>";
				/* 	html += "	<td>" + list[i].rnum + "</td>"; */
				html +="<td title=send2CarId:"+list[i].sendToCarId+"><a href=javascript:detailSend2CarInfo("+"'"+list[i].sendToCarId+"'"+")><font color=blue>"+list[i].rnum+"</a></td>";
				html += "	<td>" + replaceNullValue(list[i].membId) + "</td>";
				//html += "	<td>" + replaceNullValue(list[i].mgrappId) + "</td>";
				/* html += "	<td>" + replaceNullValue(list[i].mgrappLoginId) + "</td>"; */
				html += "	<td>" + replaceNullValue(list[i].mgrappCtn) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].deviceCtn) + "</td>";
				//	html +="<td><a href=javascript:detailSend2CarInfo("+"'"+list[i].sendToCarId+"'"+")><font color=blue>"+list[i].sendToCarId+"</a></td>";
				//html += "	<td>" + replaceNullValue(list[i].scheduleId) + "</td>";
				var serviceType = serviceTypeMap.get(list[i].serviceType);
				if(!serviceType){
					serviceType = list[i].serviceType;
				}
				html += "	<td>" +serviceType + "</td>";
				
				var sendStatus = sendStatusMap.get(list[i].sendStatus);
				if(!sendStatus){
					sendStatus = list[i].sendStatus;
				}
				html += "	<td>" + sendStatus + "</td>";
				html += "	<td>" + replaceNullValue(list[i].targetNm) + "</td>";
			/* 	html += "	<td>" + replaceNullValue(list[i].targetAddress) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].targetLonx) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].targetLaty) + "</td>"; */
				
				var useYn = list[i].useYn;
				if(useYn == "Y"){
					html += " <td>" + "사용" + "</td>";
				}else{
					html += " <td>" + "미사용" + "</td>";
				}
			/* 	html += "	<td>" + replaceNullValue(list[i].arrivHopeTime) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].estTime) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].rsvType) + "</td>"; */
				html += "	<td>" + replaceNullValue(list[i].regDt) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].hostNm) + "</td>";
			}
		}

		$("#paging").empty();
		$("#paging").append(data.paging);

		$("#send2CarStatList").empty();
		$("#send2CarStatList").append(html);

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

//상세 조회
function detailSend2CarInfo(sendToCarId){
	$.ajax({
		url : "<c:url value='/stat/selectSend2CarDetailInfo.do' />",
		type : "POST",
		data : {
			"sendToCarId" : sendToCarId
		},
		dataType : "json"
	}).done(function (data) {
		
		var send2CarStatVO = data.send2CarStatVO;
		
		$("#psendToCarId").val(send2CarStatVO.sendToCarId);
		$("#pmembId").val(send2CarStatVO.membId);
		/* $("#pmgrappLoginId").val(send2CarStatVO.mgrappLoginId); */
		$("#pmgrappCtn").val(send2CarStatVO.mgrappCtn);
		
		$("#pdeviceCtn").val(send2CarStatVO.deviceCtn);
		$("#pscheuleId").val(send2CarStatVO.scheuleId);
		
		var serviceType = send2CarStatVO.serviceType
		$("#pseviceType").val(serviceTypeMap.get(serviceType));
		
		$("#psendStaus").val(send2CarStatVO.sendStaus);
		
		$("#ptargetNm").val(send2CarStatVO.targetNm);
		$("#ptargetAddress").val(send2CarStatVO.targetAddress);
		$("#ptargetLonx").val(send2CarStatVO.targetLonx);
		$("#ptargetLaty").val(send2CarStatVO.targetLaty);
		
		var useYn = send2CarStatVO.useYn;
		
		if(useYn =="Y" ){
			$("#puseYn").val("사용");
		}else{
			$("#puseYn").val("미사용");
		}
		
		$("#parrivHopeTime").val(send2CarStatVO.arrivHopeTime);
		$("#pestTime").val(send2CarStatVO.estTime);
		$("#prsvType").val(send2CarStatVO.rsvType);
		$("#pregDt").val(send2CarStatVO.regDt);
		$("#phostNm").val(send2CarStatVO.hostNm);
		
		$(".dimmed").show();
		$("#send2CarInfoPopup").show();
		
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
	<form id="send2CarStatSearchForm" name="send2CarStatSearchForm">
	<input type="hidden" id="page" name="page" />
		<div class="main_top">
			<h2> 서비스 통계 > Send2Car 이력 조회 </h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">Send2Car 검색 조건</div>
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
								<fmt:parseDate value="${send2CarStatVO.startDate}" var='startDate' pattern="yyyymmdd"/>
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
								<fmt:parseDate value="${send2CarStatVO.startDate}" var='endDate' pattern="yyyymmdd"/>
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
						<th class="last" >MEMB ID <span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="membId" name="membId" class="input w01"/>
						</td>
						<th class="last" >사용유무<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="useYn" name="useYn" class="select w01"style="width: 380px; text-align: center;">
								<option value="ALL" selected="selected">전체</option>
								<option value="Y">사용</option>
								<option value="N">미사용</option>
							</select>
						</td>
					</tr>
					<tr>
						<th class="last" >Device CTN <span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="deviceCtn" name="deviceCtn" class="input w01"/>
						</td>
						<th class="last" >Mgrapp Login Id<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<!-- <input type="text" onkeydown="isNumber(this)" autocomplete="off" id="mgrappLoginId" name="mgrappLoginId" class="input w01"/> -->
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="mgrappCtn" name="mgrappCtn" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th class="last" >서비스 타입<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="serviceType" name="serviceType" class="select w01"style="width: 380px; text-align: center;">
								<option value="ALL" selected="selected">전체</option>
							</select>
						</td>
						<th class="last" >Push 전송 상태<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="sendStatus" name="sendStatus" class="select w01"style="width: 380px;">
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
					<div class="tit_table">Send2Car 이력 리스트</div>
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
				<col width="11%"/>
				<!-- <col width="11%"/> -->
				<col width="8%"/>
				<col width="8%"/>
				<!--<col width="11%"/>
				 <col width="10%"/> -->
				<col width="6%"/>
				<col width="6%"/>
				<col width="12%"/>
				<!-- <col width="5%"/>
				<col width="5%"/>
				<col width="5%"/> -->
				<col width="4%"/>
				<!-- <col width="5%"/>
				<col width="5%"/>
				<col width="5%"/> -->
				<col width="11%"/>
				<col width="8%"/>
			</colgroup>
			<thead>
					<tr>
						<th colspan="1" scope="colgroup">No</th>
						<th colspan="1" scope="colgroup">Memb<br>Id</th>
						<!-- <th colspan="1" scope="colgroup">Mgrapp<br>Id</th> -->
						<th colspan="1" scope="colgroup">Mgrapp<br>LOGIN<br>ID</th>
						<th colspan="1" scope="colgroup">Device<br>Ctn</th>
						<!-- <th colspan="1" scope="colgroup">Send2Car<br>Id</th> 
						 <th colspan="1" scope="colgroup">Scheule<br>Id</th> -->
						<th colspan="1" scope="colgroup">Sevice<br>Type</th>
						<th colspan="1" scope="colgroup">Send<br>Staus</th>
						<th colspan="1" scope="colgroup">목적지명</th>
						<!-- <th colspan="1" scope="colgroup">목적지<br>주소</th>
						<th colspan="1" scope="colgroup">목적지<br>경도</th>
						<th colspan="1" scope="colgroup">목적지<br>위도</th> -->
						<th colspan="1" scope="colgroup">사용<br>유무</th>
						<!-- <th colspan="1" scope="colgroup">도착희망시간</th>
						<th colspan="1" scope="colgroup">예상소요시간</th> 
						<th colspan="1" scope="colgroup">예약형태</th>-->
						<th colspan="1" scope="colgroup">등록일</th>
						<th colspan="1" scope="colgroup">처리서버</th>
					</tr>
			</thead>
			<tbody id="send2CarStatList">
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

<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="send2CarInfoPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 600px">
			<div class="p_header">
				<h1>Send2Car 이력 상세 정보</h1>
				<a href="javascript:$('#send2CarInfoPopup').hide(); $('.dimmed').hide();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
							<div class="table_wrap">
									<table class="table simple table_write_type">
										<colgroup>
											<col width="25%"/>
											<col width="25%"/>
											<col width="16%"/>
											<col width="34%"/>
										</colgroup>
										<tbody>
											<tr>
												<th>Send2CarId<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="psendToCarId" name="psendToCarId" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>MembId<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pmembId" name="pmembId" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>MgrappLoginId(매니저앱 로그인 ID )<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<!-- <input type="text" autocomplete="off" id="pmgrappLoginId" name="pmgrappLoginId" class="input w01" readonly/> -->
													<input type="text" autocomplete="off" id="pmgrappCtn" name="pmgrappCtn" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>DeviceCtn<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pdeviceCtn" name="pdeviceCtn" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>ScheuleId(일정 ID)<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pscheuleId" name="pscheuleId" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>SeviceType(서비스 타입)<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pseviceType" name="pseviceType" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>SendStaus(Push 전송 상태)<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="psendStaus" name="psendStaus" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>목적지명<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="ptargetNm" name="ptargetNm" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>목적지 주소<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="ptargetAddress" name="ptargetAddress" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>목적지 경도<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="ptargetLonx" name="ptargetLonx" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>목적지 위도<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="ptargetLaty" name="ptargetLaty" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>사용 유무<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="puseYn" name="puseYn" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>도착 희망 시간<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="parrivHopeTime" name="parrivHopeTime" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>예상 소요 시간<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pestTime" name="pestTime" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>예약 형태<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="prsvType" name="prsvType" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>등록 시간<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pregDt" name="pregDt" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>처리 서버<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="phostNm" name="phostNm" class="input w01" readonly/>
												</td>
											</tr>
										</tbody>
										</tbody>
									</table>
								</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:$('##send2CarInfoPopup').hide(); $('.dimmed').hide();">확인</span>
					</div>
					<!-- e: btn -->

				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
