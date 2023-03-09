<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function getKeywordList() {
	var query = $("#keywordQuery").val().trim();
	$.ajax({
		url : "/admin/business/selectKeywordListAjax.do",
		type : "POST",
		data : {
			categoryKeywordName : query,
			useYn : "Y"
		}
	}).done(function(data) {
		console.log(data);
		var resultCode = data.resultCode;
		
		if(resultCode == "1001") {
			var list = data.resultData.keywordList;
			var html = '';
			var currentKeywords = $("#categoryKeyword").val();
			if(list.length > 0) {
				for(var i=0; i<list.length; i++) {
					html += '<tr>';
					html += '	<td>';
					
					

					//키워드 입력칸에 적혀 있는 키워드
					if(currentKeywords.indexOf(list[i].categoryKeywordName) > -1) {
						if(list[i].categoryName == null || list[i].categoryName == 'null' || list[i].categoryName == '') {
							html += '<input id="'+list[i].seqCategoryKeyword+'" type="checkbox" class="input" checked="checked" keyword="'+list[i].categoryKeywordName+'"/>';
						} else {
							//이미 카테고리 지정된 키워드						
							html += '	<input id="'+list[i].seqCategoryKeyword+'" type="checkbox" class="input" checked="checked" keyword="'+list[i].categoryKeywordName+'" disabled="disabled"/>';
						}
					} else {
						if(list[i].categoryName == null || list[i].categoryName == 'null' || list[i].categoryName == '') {
							html += '<input id="'+list[i].seqCategoryKeyword+'" type="checkbox" class="input" keyword="'+list[i].categoryKeywordName+'"/>';
						} else {
							html += '<input id="'+list[i].seqCategoryKeyword+'" type="checkbox" class="input" keyword="'+list[i].categoryKeywordName+'" disabled="disabled"/>';
						}
					}
					html += '	</td>';
					html += '	<td>'+list[i].seqCategoryKeyword+'</td>';
					html += '	<td>'+list[i].categoryKeywordName+'</td>';
					if(list[i].categoryName == null || list[i].categoryName == 'null' || list[i].categoryName == '') {
						html += '	<td>-</td>';
					} else {
						html += '	<td>'+list[i].categoryName+'</td>';
					}
					html += '</tr>';
				}
			} else {
				html += '<tr>';
				html += '	<td colspan="4">검색 결과가 없습니다.</td>';
				html += '</tr>';
			}
			
			$("#keywordList").empty();
			$("#keywordList").append(html);
		} else {
			alert(data.resultMsg);
		}
	});
}

function keywordSave() {
	var checkedList = $("#keywordList").find("input[type='checkbox']:checked");
	var checkedString = "";
	var checkedSeqString = "";

	checkedList.each(function () {
		checkedString += $(this).attr("keyword") + ",";
		checkedSeqString += $(this).attr("id") + ",";
		
		console.log($(this).attr("id"));
		console.log($(this).attr("keyword"));
	});
	console.log(checkedSeqString);
	$("#categoryKeyword").val(checkedString.substring(0, checkedString.length-1));
	$("#seqCategoryKeywords").val(checkedSeqString.substring(0, checkedSeqString.length-1));
	
	closeLayerPopup($('#keywordSearchPopup'));
	
}

</script>
<!-- s: popup -->
<div class="popup_container" id="keywordSearchPopup" style="display: none;">
	<div class="popup_inner w01"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px,-->
		<div class="p_header">
			<h1>키워드 검색</h1>
			<a href="javascript:closeLayerPopup($('#keywordSearchPopup'));" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 
		<div class="p_body">
			<div class="p_content">

				<!-- s: table top-->
				<div class="thead_wrap cboth">
					<div class="ltr">
						해당 업종에 맞는 키워드를 등록해주세요.
					</div>
				</div>
				<!-- e: table top-->
				
				<!-- s: table wrap-->
				<div class="table_wrap">
					<table class="table_search_type">
						<colgroup>
							<col width="15%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
							<tr>
								<th><div class="tit_search">검색어</div></th>
								<td>
									<div class="input_wrap">
										<input id="keywordQuery" type="text" class="input w01" onkeydown="if(event.keyCode==13) {getKeywordList(); return false;}"/>
										<span onclick="getKeywordList();" class="btn focus" style="width:90px;"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- e: table wrap-->
				
				<!-- s: table wrap-->				
				<div class="table_wrap table_scroll">
					<table class="table simple table_list_type">
						<colgroup>
							<col width="10%"/>
							<col width="30%"/>
							<col width="30%"/>
							<col width="30%"/>
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" name="" id=""/></th>
								<th>코드</th>
								<th>키워드</th>
								<th class="last">카테고리</th>
							</tr>
						</thead>
						<tbody id="keywordList">
							<tr>
								<td colspan="4">키워드를 검색해주세요</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- e: table wrap-->
			
				<!-- s: btn -->
				<div class="btn_wrap02">
					<span class="btn large focus" onclick="keywordSave();">저장</span>
					<span class="btn large" onclick="closeLayerPopup($('#keywordSearchPopup'));">취소</span>
				</div>
				<!-- e: btn -->
			</div>
		</div>
	</div>
</div>
<!-- e: popup -->
