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
	
	goSearch(1);
});

function goSearch(page) {
    if(!checkDatePickerStartEnd()){
    	return;
    }
    
    $("#page").val(page);

    $.ajax({
		url : "/admin/stats/selectDailyUseUserReportListAjax.do",
		data : $("#dailyUseUserReportSearchForm").serialize(),
		dataType : "JSON",
		type : "POST"
	}).done(function(data) {
		console.log(data);
		var resultCode = data.resultCode;

		if(resultCode == "1001") {
			var html = '';
			var resultList = data.resultList;
			var totalCount = data.totalCount;
			
			if(resultList.length > 0) {
				for(var i=0; i<resultList.length; i++) {
					html += '<tr>';
					html += '	<td>' +resultList[i].statDate+ '</td>';
					html += '	<td>' +addComma(resultList[i].useUserCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].dailyUseUserCnt)+ '</td>';
					html += '</tr>';
				}
			} else {
				html += '<tr>';
				html += '	<td colspan="3"> 검색조건에 부합되는 데이터가 없습니다.</td>';
				html += '</tr>';				
			}
			
			
			$("#dailyUseUserReportList").empty();
			$("#dailyUseUserReportList").append(html);
			$("#totCnt").text(totalCount);
			$("#paging").empty();
			$("#paging").append(data.paging);
		}
	});
}

function downloadExcel() {
	$("#dailyUseUserReportSearchForm").attr("action", "/admin/stats/dailyUseUserReportListExcel.do");
	$("#dailyUseUserReportSearchForm").submit();
}
</script>


<!-- 내용-->
<div class="contents_wrap">
	<form id="dailyUseUserReportSearchForm" name="dailyUseUserReportSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>
			일별 이용자 리포트
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
				<col width="15%"/>
				<col width="*"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th>날짜</th>
					<th>데일리 이용자 수</th>
					<th>데일리 유니크 이용자 수</th>
				</tr>
			</thead>
			<tbody id="dailyUseUserReportList">
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