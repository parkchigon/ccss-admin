<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {
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
			console.log(accCount);
			html += '<tr class="imp">';
			html += '	<td>현재기준(누적)</td>';
			html += '	<td>' +accCount.lguKeywordListCnt+ '</td>';
			html += '	<td>' +accCount.lguCategoryListCnt+ '</td>';
			html += '	<td>' +accCount.lguDeliveryfoodListCnt+ '</td>';
			html += '	<td>' +accCount.lguKeywordDetailCnt+ '</td>';
			html += '	<td>' +accCount.lguCategoryDetailCnt+ '</td>';
			html += '	<td>' +accCount.lguDeliveryfoodDetailCnt+ '</td>';
			html += '	<td>' +accCount.lguKeywordCallListCnt+ '</td>';
			html += '	<td>' +accCount.lguKeywordCallDetailCnt+ '</td>';
			html += '	<td>' +accCount.lguCategoryCallListCnt+ '</td>';
			html += '	<td>' +accCount.lguCategoryCallDetailCnt+ '</td>';
			html += '	<td>' +accCount.lguDeliveryfoodCallListCnt+ '</td>';
			html += '	<td>' +accCount.lguDeliveryfoodCallDetailCnt+ '</td>';
			html += '</tr>';
			if(resultList.length > 0) {
				for(var i=0; i<resultList.length; i++) {
					html += '<tr>';
					html += '	<td>' +resultList[i].statDate+ '</td>';
					html += '	<td>' +resultList[i].lguKeywordListCnt+ '</td>';
					html += '	<td>' +resultList[i].lguCategoryListCnt+ '</td>';
					html += '	<td>' +resultList[i].lguDeliveryfoodListCnt+ '</td>';
					html += '	<td>' +resultList[i].lguKeywordDetailCnt+ '</td>';
					html += '	<td>' +resultList[i].lguCategoryDetailCnt+ '</td>';
					html += '	<td>' +resultList[i].lguDeliveryfoodDetailCnt+ '</td>';
					html += '	<td>' +resultList[i].lguKeywordCallListCnt+ '</td>';
					html += '	<td>' +resultList[i].lguKeywordCallDetailCnt+ '</td>';
					html += '	<td>' +resultList[i].lguCategoryCallListCnt+ '</td>';
					html += '	<td>' +resultList[i].lguCategoryCallDetailCnt+ '</td>';
					html += '	<td>' +resultList[i].lguDeliveryfoodCallListCnt+ '</td>';
					html += '	<td>' +resultList[i].lguDeliveryfoodCallDetailCnt+ '</td>';
					html += '</tr>';
				}
			} else {
					html += '<tr>';
					html += '	<td colspan="13"> 검색조건에 부합되는 데이터가 없습니다.</td>';
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

</script>

<body class="jui">
	<div class="popup_inner w03"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px, -->
		<div class="p_header">
             <h1>생활번호(U+) 상세</h1>
             <a href="javascript:exitPopup();" class="btn_close"><span class="hidden_obj">닫기</span></a>
         </div> 
		<div class="p_body">
			<!-- s: table wrap-->
			
	<form id="useStatForm" name="useStatForm" method="POST" >
		<input type="hidden" id="page" name="page" value="1" />
		<input type="hidden" id="startDate" name="startDate" value="${startDate} " />
		<input type="hidden" id="endDate" name="endDate" value="${endDate}" />
		<input type="hidden" id="searchDateDiv" name="searchDateDiv" value="${searchDateDiv}" />
		
		
	<!-- 내용-->
	<div class="notice_wrap">
		<div class="notice_list">
			<div class="main_top">
				<h2></h2>
				<div class="location_wrap">
				</div>
			</div>
			
			<!-- s: 검색-->
			
			<!-- s: table top-->
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
			<!-- e: table top-->
			<!-- s: table wrap-->
			<div class="table_wrap">
				<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
					<colgroup>
						<col width="8%"/>
						<col width="*"/>
						<col width="*"/>
						<col width="*"/>
						<col width="*"/>
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
							<th colspan="3">상호 목록 조회</th>
							<th colspan="3">상호 상세정보 조회</th>
							<th colspan="6">통화호출</th>
							
						</tr>
						<tr>
							<th rowspan="2">U+통합검색</th>
							<th rowspan="2">업종카테고리</th>
							<th rowspan="2">배달검색</th>
							<th rowspan="2">U+통합검색</th>
							<th rowspan="2">업종카테고리</th>
							<th rowspan="2">배달검색</th>
							<th colspan="2">U+통합검색</th>
							<th colspan="2">업종카테고리</th>
							<th colspan="2">배달검색</th>
						</tr>
						<tr>
							<th>리스트</th>
							<th>상세</th>
							<th>리스트</th>
							<th>상세</th>
							<th>리스트</th>
							<th>상세</th>
						</tr>
					</thead>
					<tbody id="useStatList">
					</tbody>
				</table>
			</div>
			<!-- e: table wrap-->
			<!-- e: 검색-->
			
			<!-- s: 페이징 -->

			<div id="paging" class="paging">
			</div>
			<!-- e: 페이징 -->
		
		</div>
	
	
</div>
<!-- e: 내용-->
</body>