<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javaScript">

$(document).ready(function(){
	// 데이터 피커 생성
	compareDatePicker({
		startDatePickerGroupId: "datepicker1_group",
		startDatePickerId: "datepicker1",
		endDatePickerGroupId: "datepicker2_group",
		endDatePickerId: "datepicker2",
	});
	
	
	$("#batchCode").val(getUrlParameter("batchCode"));
	goSearch(1);
});

//리스트 조회
function goSearch(page) {
	$("#page").val(page);

	$.ajax({
		url : "/admin/manage/selectBatchStatusRecordListAjax.do",
		type : "POST",
		data : $("#manualBatchForm").serialize(),
		dataType : "JSON"
	}).success(function (data) {
		console.log(data);
		var resultCode = data.resultCode;
		if(resultCode == "1001") {
			var html = '';
			var resultList = data.resultList;
			var totalCount = data.totalCount;

			
			if(resultList.length > 0) {
				for(var i=0; i<resultList.length; i++) {
					html += '<tr>';
					html += '	<td>'+resultList[i].rnum+'</td>';
					html += '	<td>'+resultList[i].dataRangeCompareDate+'</td>';
					html += '	<td>'+resultList[i].batchEndDate+'</td>';
					if(resultList[i].batchProgressStatusCode == '00000') {
						if(resultList[i].batchResultStatus == '0') {
							html += '<td>자동 배치 성공</td>';
							html += '<td>-</td>';
						} else if(resultList[i].batchResultStatus == '1') {
							html += '<td>수동 배치 성공</td>';
							html += '<td>-</td>';
						} else if(resultList[i].batchResultStatus == '9999') {
							html += '<td>자동 배치 실패</td>';
							html += '<td><span class="btn" onclick="startManualBatch(\''+resultList[i].seqBatchStatusRecord+'\')">수동배치</span></td>';
						} else if(resultList[i].batchResultStatus == '9998') {
							html += '<td>수동 배치 실패</td>';
							html += '<td><span class="btn" onclick="startManualBatch(\''+resultList[i].seqBatchStatusRecord+'\')">수동배치</span></td>';
						}	
					} else {
						html += '<td>'+resultList[i].batchProgressStatusCodeKr+'</td>';
						html += '<td>-</td>';
					}
					html += '</tr>';
				}
			} else {
					html += '<tr>';
					html += '	<td colspan="4"> 검색조건에 부합되는 데이터가 없습니다.</td>';
					html += '</tr>';
			}
			
			$("#totCnt").text(totalCount);
			$("#paging").empty();
			$("#paging").append(data.paging);
			$("#batchRocordList").empty();
			$("#batchRocordList").append(html);
		} else {
			
		}
	
	}).error(function (data) {
		alert("목록 조회중 오류가 발생하였습니다.");
	});
}

function startManualBatch(seq) {
	$.ajax({
		url : "/admin/manage/manualBatchStart.do",
		type : "POST",
		data : {
			seqBatchStatusRecord : seq
		},
		dataType : "JSON"
	}).success(function (data){
		alert("성공적으로 수동배치가 시작되었습니다.\n잠시후 다시 확인 해 주세요");
	}).error(function (data) {
		
	});
}
</script>

<body class="jui">
	<div class="popup_inner w03"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px, -->
		<div class="p_header">
			<h1><span id="batchTitleTop"></span> 배치 내역</h1>
			<a href="javascript:window.close();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 
		<div class="p_body">
			<div class="p_content">
			<form id="manualBatchForm">				
				<input type="hidden" id="page" name="page" />
				<input type="hidden" id="batchCode" name="batchCode" />
				<!-- s: table wrap-->
				<div class="table_wrap">
					<table class="table_search_type">
						<colgroup>
							<col width="15%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
							<tr>
								<th><div class="tit_search">작업완료기간</div></th>
								<td colspan="3">
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
													<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th><th>zz</th>
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
									<a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'MONTH', 1);"><span class="btn">1개월</span></a>
						            <a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'YEAR', 1);"><span class="btn">1년</span></a>
						            <a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'ALL', 1);"><span class="btn">전체</span></a>
								</td>
								<td>
									<a href="javascript:goSearch(1);"><span class="btn focus" style="width:90px;"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span></a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- e: table wrap-->
				<div class="thead_wrap cboth">
					<div class="ltr">
						<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
					</div>
					<div class="rtl">
						<select id="pageRowCount" name="pageRowCount" class="select w01" style="width:130px;" onchange="javascript:goSearch(1);">
							<option value="20" selected="selected">20개씩 보기</option>
							<option value="50" >50개씩 보기</option>
							<option value="100" >100개씩 보기</option>
						</select>
					</div>
				</div>
			</form>	
				<!-- s: table wrap-->				
				<div class="table_wrap table_scroll">
					<table class="table simple table_list_type">
						<colgroup>
							<col width="10%"/>
							<col width="20%"/>
							<col width="*"/>
							<col width="20%"/>
							<col width="20%"/>
						</colgroup>
						<thead>
							<tr>
								<th>No</th>
								<th>통계 일자</th>
								<th>작업완료일시</th>
								<th>배치결과</th>
								<th class="last">수동배치</th>
							</tr>
						</thead>
						<tbody id="batchRocordList">
						</tbody>
					</table>
				</div>
				<!-- e: table wrap-->
				<!-- s: 페이징 -->
				<div id="paging" class="paging">
					<a class="prev" disabled="">Previous</a><div class="list"><a class="page active" style="position: static;">1</a></div><a class="next" disabled="">Next</a>
				</div>
				<!-- e: 페이징 -->
			</div>
		</div>
	</div>
</body>

<script data-jui="#datepicker1" data-tpl="dates" type="text/template">
	<tr>
		<! for(var i = 0; i < dates.length; i++) { !>
		<td><!= dates[i] !></td>
		<! } !>
	</tr>
</script>

<script data-jui="#datepicker2" data-tpl="dates" type="text/template">
	<tr>
		<! for(var i = 0; i < dates.length; i++) { !>
		<td><!= dates[i] !></td>
		<! } !>
	</tr>
</script>