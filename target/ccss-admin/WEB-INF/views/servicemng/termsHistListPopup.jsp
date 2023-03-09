<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(document).ready(function(){
	// 데이터 피커 생성
	compareDatePicker({
		startDatePickerGroupId: "datepicker1_group",
		startDatePickerId: "datepicker1",
		endDatePickerGroupId: "datepicker2_group",
		endDatePickerId: "datepicker2",
	});
	
	$("#termsId").val(getUrlParameter("termsId"));
	$("#termsTitleTop").text(getUrlParameter("termsTitle"));
	goSearch("1");
	
});

function goSearch(page) {
	$("#page").val(page);
	$.ajax({
		url : "/admin/servicemng/termsHistListAjax.do"
		,data : $('#termsHistSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data){
		var list = data.resultList;
		var totalResult = data.totalCount;
		var html = '';
		if(list.length>0) {
			for(var i=0; i<list.length; i++) {
				html += '<tr>';
				html += '	<td>'+list[i].rnum+'</td>';
				html += '	<td><a href="javascript:termsHistDetail(\''+list[i].seqTermsHist+'\');" class="link">'+list[i].postDate+'</a></td>';
				if(list[i].description == "" || list[i].description == null) {
					html += '	<td><a href="javascript:termsHistDetail(\''+list[i].seqTermsHist+'\');" class="link">-</a></td>';
				} else {
					html += '	<td><a href="javascript:termsHistDetail(\''+list[i].seqTermsHist+'\');" class="link">'+list[i].description+'</a></td>';
				}
				html += '	<td>'+list[i].insertDate+'</td>';
				html += '</tr>';
			}
		} else {
			html += '<tr>';
			html += '	<td colspan="4">검색결과가 없습니다.</td>';
			html += '</tr>';
		}
		
		$("#termsHistList").empty();
		$("#termsHistList").append(html);
		$("#totCnt").text(totalResult);
	});
}

//상세 화면
function termsHistDetail(seqTermsHist) {
	location.href="/admin/servicemng/termsHistDetail.do?seqTermsHist="+seqTermsHist;
}

</script>

<body class="jui">
	<div class="popup_inner w03"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px, -->
		<div class="p_header">
			<h1><span id="termsTitleTop"></span> 업데이트 내역</h1>
			<a href="javascript:window.close();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 
		<div class="p_body">
			<div class="p_content">
			<form id="termsHistSearchForm">				
				<input type="hidden" id="page" name="page" />
				<input type="hidden" id="termsId" name="termsId" />
				<!-- s: table wrap-->
				<div class="table_wrap">
					<table class="table_search_type">
						<colgroup>
							<col width="15%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
							<tr>
								<th><div class="tit_search">기간</div></th>
								<td colspan="3">
									<select id="searchDateDiv" name="searchDateDiv" class="select w01" style="width:130px;">
										<option value="INSERT_DATE" selected="selected">등록일</option>
										<option value="POST_DATE">게시일</option>
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
						</colgroup>
						<thead>
							<tr>
								<th>No</th>
								<th>게시일시</th>
								<th>비고(편집 내용)</th>
								<th class="last">등록일시</th>
							</tr>
						</thead>
						<tbody id="termsHistList">
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