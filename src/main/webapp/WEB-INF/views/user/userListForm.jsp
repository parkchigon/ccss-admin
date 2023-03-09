<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
var feeTypeMap = new Map();
feeTypeMap.put("ALL","전체");

var userDataMap = new Map();

$(document).ready(function(){
	//Start 시간 설정
	var startDate = "${startDate}";
	if(startDate !=null && startDate != ""){
		$('#startDate').val(startDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
	}else{
		$('#startDate').val(dateAdd(new Date().toISOString().slice(0,10),-29,"D"));
		
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
	
	
	var deviceCtn = "${deviceCtn}";
	if(deviceCtn !=null && deviceCtn != ""){
		$("#deviceCtn").val(deviceCtn);
	}
	var productNm = "${productNm}";
	if(productNm !=null && productNm != ""){
		$("#productNm").val(productNm).prop("selected", true);
	}
	var newRejoinYn = "${newRejoinYn}";
	if(newRejoinYn !=null && newRejoinYn != ""){
		$("#newRejoinYn").val(newRejoinYn).prop("selected", true);
	}
	var useStatus = "${useStatus}";	
	if(useStatus !=null && useStatus != ""){
		$("#useStatus").val(useStatus).prop("selected", true);
	}
	
	//상품정보 조회 및 Set
	selectGrpCodeList("PRODUCT_NM","feeType","cdVal");
	
	//goSearch(1);
	
});

function selectGrpCodeList(grpCodeNm,grpCodeListAreaId,codeViceType){
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
			
			if(grpCodeNm=='PRODUCT_NM'){
				feeTypeMap.put(list[i].cdVal,list[i].codeDesc);
			}
				
			if(codeViceType =='cdVal'){
				html += "<option value="+list[i].cdVal+">"+ list[i].codeDesc + "</option>";
			}else if(codeViceType =='dtlCdNm'){
				html += "<option value="+list[i].dtlCdNm+">"+ list[i].dtlCdNm + "</option>";
			}else{
				
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


// 검색 조건 초기화
function resetSearch(){
	$('#startDate').val(dateAdd(new Date().toISOString().slice(0,10),-29,"D"));
	$('#endDate').val(dateAdd(new Date().toISOString().slice(0,10),+1,"d"));
	
	$("#deviceCtn").val("");
	$("#membNo").val("");
	$("#membId").val("");
	
	$("#productNm").val("ALL").prop("selected", true);
	$("#newRejoinYn").val("ALL").prop("selected", true);
	$("#useStatus").val("ALL").prop("selected", true);
	//$("#devicePushConStatus").val("ALL").prop("selected", true);
	
}

//엑셀 다운로드
function downLoadExcel(){
	$('#userSearchForm').attr("action", "<c:url value='/user/selectUserListExcel.do'/>");
	$('#userSearchForm').attr("method","post");
	$('#userSearchForm').submit();
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
	}
	else{
		
		var betweenDay = calDateRange(start,end);
		//console.log("betweenDay:",betweenDay)
		if(betweenDay >=31 ){
			alert("노출기간은  최대 30일 이상 지정 하실 수 없습니다.");
			return false;
		}else{
			return true;
		}
		
		
		/* var betweenDay = (new Date(endDateArr[0], endDateArr[1], endDateArr[2]).getTime() -  new Date(startDateArr[0], startDateArr[1], startDateArr[2]).getTime()) / 1000 / 60 / 60 / 24;
		
		if(betweenDay > 31){
			alert("검색기간은  최대 31일 이상 지정 하실 수 없습니다.");
			return false;
		}else{
			return true;
		}  */
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

//상세 조회
function detailUserInfo(membId){
	$.ajax({
		url : "<c:url value='/user/selectDetailUserInfo.do' />",
		type : "POST",
		data : {
			"membId" : membId
		},
		dataType : "json"
	}).done(function (data) {
		//console.log(data.userVO);
		var userVO = data.userVO;
		
		$("#puseYn").val(userVO.useYn);
		$("#pmembNo").val(userVO.membNo);
		$("#pmembId").val(userVO.membId);
		
		
		//$("#pmembCtn").val(userVO.membCtn);
		//if(userVO.membCtn)
		$("#pmembCtn").val(AES_Decode(userVO.membCtn)); 
		
		$("#pjoinDt").val(userVO.joinDt);
		$("#platestLoginDt").val(userVO.latestLoginDt);
		$("#ploginFailCnt").val(userVO.loginFailCnt);
		$("#pproductNm").val(userVO.productNm);
		$("#pproductExplain").val(feeTypeMap.get(userVO.productExplain));
		
		$("#puseStatus").val(userVO.useStatus);
		$("#pnewRejoinYn").val(userVO.newRejoinYn);
		$("#ptransToken").val(userVO.transToken);
		$("#ppayResvYn").val(userVO.payResvYn);
		$("#ppayResvDt").val(userVO.payResvDt);
		$("#pmarketType").val(userVO.marketType);
		
		$(".dimmed").show();
		$("#userInfoPopup").show();
		
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


// 리스트 조회
function goSearch(page) {
	//CTN Validation Check
	var deviceCtn = $("#deviceCtn").val();	
	
	/* if (deviceCtn != "") {
		var rgEx = /[01](0|1|6|7|8|9)[-](\d{4}|\d{3})[-]\d{4}$/g;
		var strValue = deviceCtn;
		var chkFlg = rgEx.test(strValue);
		if (!chkFlg) {
			alert("올바른 단말 번호가 아닙니다.");
			$("#deviceCtn").focus();
			return false;
		}
	} */
	$("#deviceCtn").val(deviceCtn.replace(/-/gi, ""));
	
	var validCheck = false;
	validCheck = checkStartEndDate($('#startDate').val(), $('#endDate').val(),"-" , " 시작일, 종료일이 잘못되었습니다.");
	
	if(!validCheck){
		return false;
	}
	
	
	$("#page").val(page);
	$.ajax({
		url : "<c:url value='/user/selectUserList.do'/>",
		data : $('#userSearchForm').serialize(),
		dataType : 'json',
		type : "POST"
	}).done(function(data) {
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		
		if(list.length == 0){
			html += "	<th colspan='12' scope='colgroup'>조회된 결과가 없습니다.</th>";
		}else{
			//Use Version Top Area
			for (var i = 0; i < list.length; i++) {
				html += "<tr>";
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td>" + list[i].useYn + "</td>";
				html += "	<td>" + list[i].membNo + "</td>";
				
				html +="<td><a href=javascript:detailUserInfo("+"'"+list[i].membId+"'"+")><font color=blue>"+list[i].membId+"</a></td>";
				//html += "	<td>" + detailUserInfo(list[i].membId) + "</td>";
				html += "	<td>" + list[i].joinDt + "</td>";
				html += "	<td>" + list[i].latestLoginDt + "</td>";
				html += "	<td>" + list[i].productNm + "</td>";
				
				var feeType = feeTypeMap.get(list[i].productExplain);
				html += "	<td>" + feeType + "</td>";
				//html += "	<td>" + list[i].productExplain + "</td>";
				html += "	<td>" + list[i].deviceCtn + "</td>";
				
				if(list[i].useStatus == "정상"){
					html += "<td><font color='red'>" + list[i].useStatus + "</td>";
				}else{
					html += "<td>" + list[i].useStatus + "</td>";
				}
				if(list[i].devicePushConStatus == "Y"){
					html += "<td><font color='red'>연결</td>";
				}else{
					html += "<td>비연결</td>";
				}
				html += "	<td>" + list[i].newRejoinYn + "</td>";
				html += "</tr>";
			}
		}
		
		$("#paging").empty();
		$("#paging").append(data.paging);

		$("#userList").empty();
		$("#userList").append(html);

		$("#totCnt").text(totalResult);
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

function isNumber(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	}); 
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="userSearchForm" name="userSearchForm">
		<input type="hidden" id="page" name="page" />
		<div class="main_top">
			<h2> 사용자 관리 > 사용자 조회 </h2>
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
					<col width="24%"/>
					<col width="16%"/>
					<col width="24%"/>
					<col width="16%"/>
					<col width="24%"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="last" >기간<span class="imp">*</span></th>
						<td colspan="5" class="last">
							<div id="datepicker1_group" class="group">
								<fmt:parseDate value="${userVO.startDate}" var='startDate' pattern="yyyymmdd"/>
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
								<fmt:parseDate value="${userVO.startDate}" var='endDate' pattern="yyyymmdd"/>
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
						<th class="last" >CTN<span class="imp">*</span></th>
						<td colspan="5" class="last">
							<!-- <input type="text" placeholder="형식(000-0000-0000)" autocomplete="off" id="deviceCtn" name="deviceCtn" class="input w01"/> -->
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="deviceCtn" name="deviceCtn" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th class="last" >MEMB ID<span class="imp">*</span></th>
						<td colspan="5" class="last">
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="membId" name="membId" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th class="last" >MEMB NO(SubsNo)<span class="imp">*</span></th>
						<td colspan="5" class="last">
							<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="membNo" name="membNo" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th class="last" >가입 상품명 <span class="imp">*</span></th><!-- DB 상품 조회 -->
						<td colspan="1" class="last">
							<select id="feeType" name="feeType" class="select w01"style="width: 200px; text-align: center;">
								<option value="ALL" selected="selected">전체</option>
							</select>
						</td>
						<th class="last" >서비스 가입 <span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="newRejoinYn" name="newRejoinYn" class="select w01"style="width: 200px;">
								<option value="ALL" selected="selected">전체</option>
								<option value="N">신규가입</option>
								<option value="Y">재가입</option>
							</select>
						</td>
						<th class="last" >이용상태 <span class="imp">*</span></th>
						<td colspan="1" class="last">
							
							<select id="useStatus" name="useStatus" class="select w01"style="width: 200px;">
								<option value="ALL" selected="selected">전체</option>
								<option value="01">정상이용</option>
								<option value="02">일시정지</option>
								<option value="09">해지</option>
							</select>
						</td>
						<!-- <th class="last" >Push <span class="imp">*</span></th>
						<td colspan="1" class="last">
							
							<select id="devicePushConStatus" name="devicePushConStatus" class="select w01"style="width: 130px;">
								<option value="ALL" selected="selected">전체▼</option>
								<option value="Y">O</option>
								<option value="N">X</option>
							</select>
						</td> -->
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
			<div class="ltr">
				<div class="tit_table">사용자 리스트</div>
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
				<col width="5%"/>
				<col width="10%"/>
				<col width="13%"/>
				<col width="8%"/>
				<col width="12%"/>
				<col width="8%"/>
				<col width="12%"/>
				<col width="10%"/>
				<col width="7%"/>
				<col width="7%"/>
				<col width="7%"/>
			</colgroup>
			<thead>
					<tr>
						<th colspan="1" scope="colgroup">No</th>
						<th colspan="1" scope="colgroup">구분</th>
						<th colspan="1" scope="colgroup">MEMB NO</th>
						<th colspan="1" scope="colgroup">MEMB ID</th>
						<th colspan="1" scope="colgroup">가입일</th>
						<th colspan="1" scope="colgroup">최근 로그인</th>
						<th colspan="1" scope="colgroup">가입상품</th>
						<th colspan="1" scope="colgroup">가입상품명</th>
						<th colspan="1" scope="colgroup">CTN</th>
						<th colspan="1" scope="colgroup">이용<br>상태</th>
						<th colspan="1" scope="colgroup">Push <br>연결 상태</th>
						<th colspan="1" scope="colgroup">서비스<br>가입</th>
					</tr>
			</thead>
			<tbody id="userList">
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


<!--PreView Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="userInfoPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 600px">
			<div class="p_header">
				<h1>사용자 상세 정보</h1>
				<a href="javascript:$('#userInfoPopup').hide(); $('.dimmed').hide();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
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
												<th>구분<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="puseYn" name="puseYn" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>MEMB NO<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pmembNo" name="pmembNo" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>MEMB ID<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pmembId" name="pmembId" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>MEMB CTN<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pmembCtn" name="pmembCtn" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>가입일<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pjoinDt" name="pjoinDt" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>최근 로그인<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="platestLoginDt" name="platestLoginDt" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>로그인 실패 횟수<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="ploginFailCnt" name="ploginFailCnt" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>가입상품명<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pproductNm" name="pproductNm" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>가입 요금제<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pproductExplain" name="pproductExplain" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>이용상태<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="puseStatus" name="puseStatus" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>서비스 가입 <span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pnewRejoinYn" name="pnewRejoinYn" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>요금제 예약 여부<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="ppayResvYn" name="ppayResvYn" class="input w01" readonly/>
												</td>
											</tr>
											
											<tr>
												<th>요금제 예약 시간<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="ppayResvDt" name="ppayResvDt" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>마켓 타입<span class="imp">*</span></th>
												<td  colspan="3" class="last">
													<input type="text" autocomplete="off" id="pmarketType" name="pmarketType" class="input w01" readonly/>
												</td>
											</tr>
											
										</tbody>
									</table>
								</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:$('#userInfoPopup').hide(); $('.dimmed').hide();">확인</span>
					</div>
					<!-- e: btn -->

				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
