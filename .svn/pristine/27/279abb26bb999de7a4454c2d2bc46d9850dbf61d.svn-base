<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {
	goSearch('1');
	checkboxClickEventHandler();
	compareDatePicker({
		startDatePickerGroupId: "datepicker2_group",
		startDatePickerId: "datepicker2",
		endDatePickerGroupId: "datepicker3_group",
		endDatePickerId: "datepicker3",
	});
	
});

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='keyword']").attr("checked", true);
			} else {
				$("input:checkbox[name='keyword']").attr("checked", false);
			}
		} else if($(this).attr("name") == 'keyword') {
			if($(this).is(":checked")) {
				if($("input:checkbox[name='keyword']").length == $("input:checkbox[name='keyword']:checked").length) {
					$("#allCheck").attr("checked", true);
				}
			} else {
				if($("input:checkbox[name='keyword']").length != $("input:checkbox[name='keyword']:checked").length) {
					$("#allCheck").attr("checked", false);
				}
			}
		}
	});
}


function goSearch(page) {
	
	$("#page").val(page);
	
	$.ajax({
		url : "/admin/keyword/selectListAjax.do",
		data : $("#keywordSearchForm").serialize(),
		dataType : "json",
		type : "POST"
	}).done(function(data) {
		console.log(data);
		var resultCode = data.resultCode;
		if(resultCode == "1001") {
			var list = data.resultData.keywordList;
			var html = '';			
			if(list.length > 0) {
				for(var i=0; i<list.length; i++) {
					html += '<tr>';
					html += '	<td><input type="checkbox" value="'+list[i].seqCategoryKeyword+'" name="keyword"></td>';
					html += '	<td>'+list[i].rnum+'</td>';
					html += '	<td>'+list[i].seqCategoryKeyword+'</td>';
					html += '	<td><a href="javascript:openKeywordModifyPopup(\''+list[i].seqCategoryKeyword+'\', \''+list[i].categoryKeywordName+'\', \''+list[i].useYn+'\', \''+list[i].businessCode+'\', \''+list[i].categoryCode+'\');" class="link">'+list[i].categoryKeywordName+'</a></td>';
					if(list[i].categoryName == null) {
						html += '<td>-</td>';
					} else {
						html += '<td>'+list[i].categoryName+'</td>';
					}
					if(list[i].useYn == 'Y') {
						html += '<td>사용</td>';
					} else {
						html += '<td>미사용</td>';
					}
					html += '	<td>'+list[i].insertDate+'</td>';
					html += '</tr>';
				}
			} else {
					html += '<tr>';
					html += '	<td colspan="7">검색 결과가 없습니다.</td>';
					html += '</tr>';
				
			}
			
			$("#totalPageNum").text(data.resultData.totalCount);
			$("#paging_1").empty();
			$("#paging_1").append(data.paging);
			$("#keywordList").empty();
			$("#keywordList").append(html);
		}
	});
}

function deleteKeywords(){
	var keyworkdSeqArray = $("input:checkbox[name='keyword']:checked").map(function(){return $(this).val();}).get();
	
	if(keyworkdSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	if(confirm("정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "/admin/keyword/deleteKeywordAjax.do",
			type : "POST",
			data : {
				seqCategoryKeywordArray : keyworkdSeqArray.toString()
			},
			dataType : "json"
		}).done(function (data) {
			var resultCode = data.resultCode;
			if(resultCode == "1001") {
				alert("키워드가 삭제 되었습니다.");
				location.reload(true);
			} else {
				alert("키워드 삭제 중 오류가 발생하였습니다.");				
			}
		
		}).error(function(data){
			alert("키워드 삭제 중 오류가 발생하였습니다.");				
		});
	}

}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="keywordSearchForm" name="keywordSearchForm" method="POST" >
		<input type="hidden" id="page" name="page" />
		

<div class="main_top">
		<h2>
			키워드 관리 
	        	<a href="javascript:openKeywordRegPopup();"><span class="rtl btn focus" style="width:80px;"><img src="/admin/resources/common/images/icon_add01.png" alt=""> 등록</span></a>
		</h2>
		
	</div>	
	<!-- s: 검색-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">등록기간</div></th>
					<td colspan="3">
						<div id="datepicker2_group" class="group">
							<input type="text" class="input" style="width: 157px;" id="startDate" name="startDate" maxlength="8" readonly />
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
						<div id="datepicker3_group" class="group">
							<input type="text" class="input" style="width: 157px;" id="endDate" name="endDate" maxlength="8" readonly />
							<a class="btn btn-gray"><i class="icon-calendar"></i></a>
							<div id="datepicker3" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
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
				</tr>
				<tr>
					<th><div class="tit_search">사용여부</div></th>
					<td colspan="3">
						<select class="select w02" name="useYn">
							<option value="A" selected="selected">전체</option>
							<option value="Y">사용</option>
							<option value="N">미사용</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><div class="tit_search">검색</div></th>
					<td colspan="3">
						<div class="input_wrap">
							<select class="select w02" name="searchKeywordType">
								<option value="KEYWORD_NAME" selected="selected">키워드명</option>
								<option value="CATEGORY_NAME">카테고리명</option>
							</select>						
							<input type="text" class="input w01" style="width: 85%" name="categoryKeywordName"/>
							<span class="btn focus" style="width:90px;" onclick="goSearch('1');"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span>
						</div>
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
			<a href="javascript:deleteKeywords();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count"><strong>Total : </strong><span id="totalPageNum"></span></span>
		</div>
		<div class="rtl">
			<select id="pageRowCount" name="pageRowCount" class="select w02" onchange="goSearch('1');">
				<option value="20" selected="selected">20개씩 보기</option>
				<option value="50">50개씩 보기</option>
				<option value="100">100개씩 보기</option>
			</select>	
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="5%"/>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck" id="allCheck" /></th>
					<th>No</th>
					<th>키워드코드</th>
					<th>키워드</th>
					<th>카테고리</th>
					<th>사용여부</th>
					<th class="last">등록일시</th>
				</tr>
			</thead>
			<tbody id="keywordList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging_1" class="paging">
	    <a href="#" class="prev">Previous</a>
	    <div class="list"></div>
	    <a href="#" class="next">Next</a>
	</div>
	<!-- e: 페이징 -->
	</form>
</div>
<!-- e: 내용-->
