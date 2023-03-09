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
		}else if($(this).val() == "DAY"){
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
	
	$("#page").val(page);
	
	$.ajax({
		url : "/admin/stats/selectUseStatListAjax.do",
		data : $("#useStatForm").serialize(),
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
			html += '	<td>'+addComma(accCount.homeButtonCnt)+'</td>';
			html += '	<td>'+addComma(accCount.noticeBannerCnt)+'</td>';
			html += '	<td>'+addComma(accCount.ktSerachListCnt)+'</td>';
			html += '	<td>'+addComma(Number(accCount.lguKeywordListCnt)+Number(accCount.lguCategoryListCnt)+Number(accCount.lguDeliveryfoodListCnt))+'</td>';
			html += '	<td>'+addComma(accCount.ktSerachDetailCnt)+'</td>';
			html += '	<td>'+addComma(Number(accCount.lguKeywordDetailCnt)+Number(accCount.lguCategoryDetailCnt)+Number(accCount.lguDeliveryfoodDetailCnt))+'</td>';
			html += '	<td>'+addComma(accCount.ktCallCnt)+'</td>';
			html += '	<td>'+addComma(Number(accCount.lguKeywordCallListCnt)+Number(accCount.lguCategoryCallListCnt)+Number(accCount.lguDeliveryfoodCallListCnt))+'</td>';
			html += '	<td>'+addComma(Number(accCount.lguKeywordCallDetailCnt)+Number(accCount.lguCategoryCallDetailCnt)+Number(accCount.lguDeliveryfoodCallDetailCnt))+'</td>';
			html += '</tr>';
			
			var searchAccumulateCount = data.searchAccumulateCount;
			
			html += '<tr class="imp">';
			html += '	<td>검색기간(누적)</td>';
			html += '	<td>'+addComma(searchAccumulateCount.homeButtonCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.noticeBannerCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.ktSerachListCnt)+'</td>';
			html += '	<td>'+addComma(Number(searchAccumulateCount.lguKeywordListCnt)+Number(searchAccumulateCount.lguCategoryListCnt)+Number(searchAccumulateCount.lguDeliveryfoodListCnt))+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.ktSerachDetailCnt)+'</td>';
			html += '	<td>'+addComma(Number(searchAccumulateCount.lguKeywordDetailCnt)+Number(searchAccumulateCount.lguCategoryDetailCnt)+Number(searchAccumulateCount.lguDeliveryfoodDetailCnt))+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.ktCallCnt)+'</td>';
			html += '	<td>'+addComma(Number(searchAccumulateCount.lguKeywordCallListCnt)+Number(searchAccumulateCount.lguCategoryCallListCnt)+Number(searchAccumulateCount.lguDeliveryfoodCallListCnt))+'</td>';
			html += '	<td>'+addComma(Number(searchAccumulateCount.lguKeywordCallDetailCnt)+Number(searchAccumulateCount.lguCategoryCallDetailCnt)+Number(searchAccumulateCount.lguDeliveryfoodCallDetailCnt))+'</td>';
			html += '</tr>';
			
			if(resultList.length > 0) {
				for(var i=0; i<resultList.length; i++) {
					html += '<tr>';
					html += '	<td>' +resultList[i].statDate+ '</td>';
					html += '	<td>'+addComma(resultList[i].homeButtonCnt)+'</td>';
					html += '	<td>'+addComma(resultList[i].noticeBannerCnt)+'</td>';
					html += '	<td>'+addComma(resultList[i].ktSerachListCnt)+'</td>';
					html += '	<td>'+addComma(Number(resultList[i].lguKeywordListCnt)+Number(resultList[i].lguCategoryListCnt)+Number(resultList[i].lguDeliveryfoodListCnt))+'</td>';
					html += '	<td>'+addComma(resultList[i].ktSerachDetailCnt)+'</td>';
					html += '	<td>'+addComma(Number(resultList[i].lguKeywordDetailCnt)+Number(resultList[i].lguCategoryDetailCnt)+Number(resultList[i].lguDeliveryfoodDetailCnt))+'</td>';
					html += '	<td>'+addComma(resultList[i].ktCallCnt)+'</td>';
					html += '	<td>'+addComma(Number(resultList[i].lguKeywordCallListCnt)+Number(resultList[i].lguCategoryCallListCnt)+Number(resultList[i].lguDeliveryfoodCallListCnt))+'</td>';
					html += '	<td>'+addComma(Number(resultList[i].lguKeywordCallDetailCnt)+Number(resultList[i].lguCategoryCallDetailCnt)+Number(resultList[i].lguDeliveryfoodCallDetailCnt))+'</td>';
					html += '</tr>';
				}
			} else {
					html += '<tr>';
					html += '	<td colspan="10"> 검색조건에 부합되는 데이터가 없습니다.</td>';
					html += '</tr>';
			}
			
			$("#useStatList").empty();
			$("#useStatList").append(html);
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
	$("#useStatForm").attr("action", "/admin/stats/selectUseStatListExcel.do");
	$("#useStatForm").submit();
}
function goDetailPopup() {
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	var searchDateDiv = $("#searchDateDiv").val();
	if(searchDateDiv == "TIME"){
		startDate = startDate + $("#startHour").val();
		endDate = endDate + $("#endHour").val();
	}
	
	var popUrl = "/admin/stats/useStatListPopupView.do?startDate="+startDate+"&endDate="+endDate+"&searchDateDiv="+searchDateDiv;
	var popOption = "width=1900, height=700, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
	window.open(popUrl,"previewObj",popOption);
	
}

</script>

<!-- 내용-->
<div class="contents_wrap">
	<form id="useStatForm" name="useStatForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>
			 홈페이지 이용현황
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
							<option value="DAY" >일별</option>
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
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="*%"/>
			</colgroup>
			<thead>
				<tr>
					<th rowspan="3">날짜</th>
					<th colspan="2">진입</th>
					<th colspan="2">상호 목록 조회</th>
					<th colspan="2">상호 상세정보 조회</th>
					<th colspan="3">통화호출</th>
					
				</tr>
				<tr>
					<th rowspan="2">홈버튼</th>
					<th rowspan="2">Notice배너</th>
					<th rowspan="2">검색(KT)</th>
					<th rowspan="2"><a href="#" onclick="goDetailPopup();" style="text-decoration: underline;" >생활번호(U+)</a></th>
					<th rowspan="2">검색(KT)</th>
					<th rowspan="2"><a href="#" onclick="goDetailPopup();" style="text-decoration: underline;">생활번호(U+)</a></th>
					<th rowspan="2">검색(KT)</th>
					<th colspan="2"><a href="#" onclick="goDetailPopup();" style="text-decoration: underline;">생활번호(U+)</a></th>
				</tr>
				<tr>
					<th>리스트</th>
					<th>상세</th>
				</tr>
			</thead>
			<tbody id="useStatList">
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