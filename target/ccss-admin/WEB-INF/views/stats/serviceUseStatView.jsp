<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script>
$(document).ready(function() {
	
	// 검색조건 일별 기본값 세팅
	getCurrentDateAfter('startDate', 'endDate', 'DAY', 30, 10);
	
	// 데이터 피커 생성
	compareDatePicker({
		startDatePickerGroupId: "datepicker1_group",
		startDatePickerId: "datepicker1",
		endDatePickerGroupId: "datepicker2_group",
		endDatePickerId: "datepicker2",
	});	
	
	// 검색조건 일,월,연 구분 selectbox
	$("#searchDateDiv").change(function(){
		if($(this).val() == "TIME"){
			setDatePicker(null, "yyyy-MM-dd", null, 2);
			getCurrentDateAfter('startDate', 'endDate', 'DAY', 30, 10);
			$("#startHour").show();
			$("#startHourText").show();
			$("#endHour").show();
			$("#endHourText").show();
		} else if($(this).val() == "DAY"){
			setDatePicker(null, "yyyy-MM-dd", null, 2);
			getCurrentDateAfter('startDate', 'endDate', 'DAY', 30, 10);
			$("#startHour").hide();
			$("#startHourText").hide();
			$("#endHour").hide();
			$("#endHourText").hide();
		} else if($(this).val() == "MONTH"){
			setDatePicker("monthly", "yyyy-MM", "yyyy년", 1);
			getCurrentDateAfter('startDate', 'endDate', 'MONTH', 12, 7);
			$("#startHour").hide();
			$("#startHourText").hide();
			$("#endHour").hide();
			$("#endHourText").hide();
		} else if($(this).val() == "YEAR"){
			setDatePicker("yearly", "yyyy", "연도", 0);
			getCurrentDateAfter('startDate', 'endDate', 'YEAR', 5, 4);
			$("#startHour").hide();
			$("#startHourText").hide();
			$("#endHour").hide();
			$("#endHourText").hide();
		};
	});
	
	goSearch(1);
});

function goSearch(page) {
    if(!checkDatePickerStartEnd()){
    	return;
    }
    
	$("#page").val(page);
	
	$.ajax({
		url : "/admin/stats/selectserviceUseListAjax.do",
		data : $("#serviceUseSearchForm").serialize(),
		dataType : "JSON",
		type : "POST"
	}).done(function(data) {
		console.log(data);
		var resultCode = data.resultCode;
		
		if(resultCode == "1001") {
			var html = '';
			var resultList = data.resultList;
			var totalCount = data.totalCount;
			var accCount = data.accumulateCount;
			
			html += '<tr class="imp">';
			html += '	<td>현재기준(누적)</td>';
			html += '	<td>'+addComma(accCount.accKtPoisearchAllCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accKtPoisearchOemCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accKtPoisearchPlusCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accKtThemeSearchCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accKtTopSearchCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accNoticeSearchCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accBrandDetailAllCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accBrandDetailKtOemCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accBrandDetailKtPlusCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accBrandDetailLguPlusCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accBrandCallAllCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accBrandCallKtCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accBrandSmsKtCnt)+'</td>';
			html += '	<td>'+addComma(accCount.accBrandCallLguPlusCnt)+'</td>';
			html += '</tr>';
			
			var searchAccumulateCount = data.searchAccumulateCount;
			html += '<tr class="imp">';
			html += '	<td>검색기준(누적)</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accKtPoisearchAllCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accKtPoisearchOemCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accKtPoisearchPlusCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accKtThemeSearchCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accKtTopSearchCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accNoticeSearchCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accBrandDetailAllCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accBrandDetailKtOemCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accBrandDetailKtPlusCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accBrandDetailLguPlusCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accBrandCallAllCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accBrandCallKtCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accBrandSmsKtCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accBrandCallLguPlusCnt)+'</td>';
			html += '</tr>';
			
			if(resultList.length > 0) {
				for(var i=0; i<resultList.length; i++) {
					html += '<tr>';
					html += '	<td>' +resultList[i].statDate+ '</td>';
					html += '	<td>' +addComma(resultList[i].ktPoisearchAllCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].ktPoisearchOemCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].ktPoisearchPlusCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].ktThemeSearchCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].ktTopSearchCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].noticeSearchCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].brandDetailAllCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].brandDetailKtOemCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].brandDetailKtPlusCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].brandDetailLguPlusCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].brandCallAllCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].brandCallKtCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].brandSmsKtCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].brandCallLguPlusCnt)+ '</td>';
					html += '</tr>';
				}
			} else {
					html += '<tr>';
					html += '	<td colspan="15"> 검색조건에 부합되는 데이터가 없습니다.</td>';
					html += '</tr>';
			}
			
			$("#serviceUseList").empty();
			$("#serviceUseList").append(html);
			$("#totCnt").text(totalCount);
			$("#paging").empty();
			$("#paging").append(data.paging);
		}
		
		
	}).error(function() {
		alert("목록 조회중 오류가 발생하였습니다.");
	});
	
	
}


function setDatePicker(typeFlag, formatFlag, titleFormatFlag, dateFlag){
	// 이전 데이트피커 초기화
	resetDatePickerDiv("datepicker1_group", "datepicker1", "startDate");
	// 데이터 피커 생성
	datePicker({
		datePickerGroupId: "datepicker1_group",
		datePickerId: "datepicker1",
		type: typeFlag,
		format: formatFlag,
		titleFormat : titleFormatFlag,
		nextFunction: function() {
			//alert("next");
		},
		prevFunction: function() {
            //alert("prev");
        }
	});
	resetDatePickerDiv("datepicker2_group", "datepicker2", "endDate");
	datePicker({
		datePickerGroupId: "datepicker2_group",
		datePickerId: "datepicker2",
		type: typeFlag,
		format: formatFlag,
		titleFormat : titleFormatFlag,
		nextFunction: function() {
			//alert("next");
		},
		prevFunction: function() {
            //alert("prev");
        }
	});
}

function resetDatePickerDiv(datePickerDivId, datePickerId, InputFlag){
	$("#" + datePickerDivId).empty();
	var html = '';
	html+='<input type="text" class="input" style="width: 157px;" id="' + InputFlag + '" name="' + InputFlag + '" maxlength="8" readonly="readonly" />';
	html+='<a class="btn btn-gray"><i class="icon-calendar"></i></a>';
	html+='<div id="' + datePickerId + '" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">';
	html+='<div class="head">';
	html+='<div class="prev">';
	html+='<i class="icon-chevron-left"></i>';
	html+='</div>';
	html+='<div class="title"></div>';
	html+='<div class="next">';
	html+='<i class="icon-chevron-right"></i>';
	html+='</div>';
	html+='</div>';
	html+='<table class="body">';
	html+='<tr>';
	html+='<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>';
	html+='</tr>';
	html+='</table>';
	html+='</div>';
	$("#" + datePickerDivId).append(html);
}

function downloadExcel() {
	$("#serviceUseSearchForm").attr("action", "/admin/stats/serviceUseListExcel.do");
	$("#serviceUseSearchForm").submit();
}
</script>

<!-- 내용-->
<div class="contents_wrap">
	<form id="serviceUseSearchForm" name="serviceUseSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>
			서비스 이용현황
		</h2>
		
	</div>
	
	<!-- s: 검색-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">기간</div></th>
					<td>
						<select id="searchDateDiv" name="searchDateDiv" class="select w01" style="width:130px;">
							<option value="TIME" selected="selected">시간별</option>
							<option value="DAY">일별</option>
							<option value="MONTH">월별</option>
						</select>
						<div id="datepicker1_group" class="group">
							<input type="text" class="input" style="width: 157px;" id="startDate" name="startDate" maxlength="8" readonly />
							<a class="btn btn-gray"><i class="icon-calendar"></i></a>
							<div id="datepicker1" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
								<div class="head">
									<div class="prev">
										<i class="icon-chevron-left"></i>
									</div>
									<div class="title"></div>
									<div class="next">
										<i class="icon-chevron-right"></i>
									</div>
								</div>
								<table class="body">
									<tr>
										<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
									</tr>
								</table>
							</div>
						</div>
						<select id="startHour" name="startHour" class="select w04">
							<c:forEach var="hours" begin="00" end="23">
								<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
								<option value="${hour}">${hour}</option>
							</c:forEach>
						</select>
						<span id="startHourText">시 ~</span>
						<div id="datepicker2_group" class="group">
							<input type="text" class="input" style="width: 157px;" id="endDate" name="endDate" maxlength="8" readonly />
							<a class="btn btn-gray"><i class="icon-calendar"></i></a>
							<div id="datepicker2" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
								<div class="head">
									<div class="prev">
										<i class="icon-chevron-left"></i>
									</div>
									<div class="title"></div>
									<div class="next">
										<i class="icon-chevron-right"></i>
									</div>
								</div>
								<table class="body">
									<tr>
										<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
									</tr>
								</table>
							</div>
						</div>
						<select id="endHour" name="endHour" class="select w04">
							<c:forEach var="hours" begin="00" end="23">
								<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
								<option value="${hour}" <c:if test="${hour eq 23}">selected="selected"</c:if>>${hour}</option>
							</c:forEach>
						</select>
						<span id="endHourText">시</span>
					</td>
					<td>
			            <a href="javascript:goSearch(1);"><span class="btn focus" style="width:90px;"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span></a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	<!-- e: 검색-->
	
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
		<div class="rtl">
			<span class="imp">* 전일 기준 데이터</span>
			<span class="btn" onclick="downloadExcel();"><img src="/admin/resources/common/images/icon_excel.png" alt=""> 엑셀 다운로드</span>
			<select id="pageRowCount" name="pageRowCount" class="select w01" style="width:130px;" onchange="javascript:goSearch(1);">
				<option value="20" selected="selected">20개씩 보기</option>
				<option value="50" >50개씩 보기</option>
				<option value="100" >100개씩 보기</option>
			</select>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="10%"/>

				<col width="8%"/>
				<col width="5%"/>
				<col width="7%"/>

				<col width="6%"/>
				<col width="6%"/>
				<col width="6%"/>
				
				<col width="*"/>
				<col width="*"/>
				<col width="*"/>
				<col width="*"/>
				
				<col width="*"/>
				<col width="*"/>
				<col width="*"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th rowspan="3">날짜</th>
					<th colspan="3">검색(KT)</th>
					<th rowspan="3">테마<br/>(theme)</th>
					<th rowspan="3">추천<br/>(top)</th>
					<th rowspan="3">Notice</th>
					<th colspan="4">상호 상세정보조회</th>
					<th colspan="4">통화호출</th>
				</tr>
				<tr>
					<th rowspan="2">ALL</th>
					<th rowspan="2">OEM</th>
					<th rowspan="2">홈페이지</th>
					<th rowspan="2">ALL</th>
					<th rowspan="2">OEM (KT)</th>
					<th rowspan="2">홈페이지<br/>(KT)</th>
					<th rowspan="2">홈페이지<br/>(U+)</th>
					<th rowspan="2">ALL</th>
					<th colspan="2">OEM</th>
					<th rowspan="2">홈페이지<br/>(U+)</th>
				</tr>
				<tr>
					<th>통화</th>
					<th>문자</th>
				</tr>
			</thead>
			<tbody id="serviceUseList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>