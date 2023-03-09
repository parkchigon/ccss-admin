<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {
	getBusinessCateList();
	
	$("#businessList").on("change", function() {
		changeBusinessSelect($(this).val());
	})
});

function getBusinessCateList() {
	$.ajax({
		url : "/admin/business/cateListAjax.do",
	}).done(function (data) {
		var list = data.businessCateTreeList;

		var businessHtml = '';
		var categoryHtml = '';
		for(var i=0; i<list.length; i++) {
			if(list[i].businessCategoryDepth == 2) {
				businessHtml += '<option value="'+list[i].seqBusinessCategory+'" orderNo="'+list[i].orderNo+'">'+list[i].businessCategoryName+'</option>';
			} else if(list[i].businessCategoryDepth == 3) {
				categoryHtml += '<option value="'+list[i].seqBusinessCategory+'" orderNo="'+list[i].orderNo+'" parentSeqBusinessCategory="'+list[i].parentSeqBusinessCategory+'">'+list[i].businessCategoryName+'</option>';
			}
		}
		
		$("#businessList").append(businessHtml);
		$("#categoryList").append(categoryHtml);
		
	});
}

function editKeyword() {
	
	var seq = $("#seqCategoryKeyword").val();
	var keyword = $("#regKeyword").val().trim();
	
	if(keyword) {
		$.ajax({
			url : "/admin/keyword/editKeywordAjax.do",
			type : "POST",
			data : $("#frm").serialize(),
			dataType : "json"
		}).done(function (data) {
			console.log(data);	
			var resultCode = data.resultCode;
			if(resultCode == "1001") {
				//alert("키워드가 등록 되었습니다.");
				goSearch('1');
				closeLayerPopup($("#keywordEditPopup"));
			} else {
				alert("키워드가 등록 중 오류가 발생하였습니다.");				
			}
		});
	} else {
		alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
		return;
	}
	
}

function deleteKeyword(){
	if(confirm("정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {
		
		var seqArray = new Array();
		seqArray.push($("#seqCategoryKeyword").val());
		
		$.ajax({
			url : "/admin/keyword/deleteKeywordAjax.do",
			type : "POST",
			data : {
				seqCategoryKeywordArray : seqArray.toString()
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
function openKeywordModifyPopup(seq, keyword, useYn, businessCode, categoryCode) {
	changeBusinessSelect(businessCode, categoryCode);
	changeMode("modify");
	$("#keywordCode").text(seq);
	$("#seqCategoryKeyword").val(seq);
	$("#keyword").text(keyword)
	$("#regKeyword").val(keyword);
	$("input[name = 'useYn']").attr("checked", false);
	$("#use"+useYn).attr("checked", true);
	openLayerPopup($('#keywordEditPopup'));
}

function openKeywordRegPopup() {
	$("#regKeyword").val("");
	$("[name = 'seqCategoryKeyword'").val("");
	changeMode("insert");
	openLayerPopup($('#keywordEditPopup'));
}

function changeMode(mode) {
	$(".insert, .modify").hide();
	$("."+mode).show();
}

function changeBusinessSelect(businessCode, categoryCode) {
	
	var categoryOptions = $("#categoryList option");
	var businessOptions = $("#businessList option");
	$("#categoryList").empty();
	$("#categoryList").append(categoryOptions);
	$("#businessList").empty();
	$("#businessList").append(businessOptions);
	
	if(businessCode == null || businessCode == '' || businessCode == 'null') {
		var defaultSeq = $("#businessList option[orderNo = '1']").val();
		$("#businessList option[value = '"+defaultSeq+"']").attr("selected", "selected");
		$("#categoryList option").hide();
		$("#categoryList option[parentseqbusinesscategory = '"+defaultSeq+"']").show();
		$("#categoryList option[parentseqbusinesscategory = '"+defaultSeq+"'][orderNo = '1']").attr("selected", "selected");
	} else {
		$("#businessList option[value = '"+businessCode+"']").attr("selected", "selected");
		$("#categoryList option").hide();
		$("#categoryList option[parentseqbusinesscategory = '"+businessCode+"']").show();
		if(!categoryCode) {
			$("#categoryList option[parentseqbusinesscategory = '"+businessCode+"'][orderNo = '1']").attr("selected", "selected");
		} else {
			$("#categoryList option[parentseqbusinesscategory = '"+businessCode+"'][value = '"+categoryCode+"']").attr("selected", "selected");
		}
	}
	
}
</script>
<!-- s: popup -->
<div class="popup_container" id="keywordEditPopup" style="display: none;">
	<div class="popup_inner w01"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px,-->
		<div class="p_header">
			<h1>키워드 <span class="insert">등록</span><span class="modify">수정</span></h1>
			<a href="javascript:closeLayerPopup($('#keywordEditPopup'));" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 
		<div class="p_body">
			<div class="p_content">

				<!-- s: table top-->
				<div class="thead_wrap cboth">
					<div class="ltr">
						새롭게 추가할 키워드를 등록해주세요.
					</div>
					<div class="rtl"><span class="imp">*</span>필수입력</div>
				</div>
				<!-- e: table top-->
				
				<!-- s: table wrap-->
				<div class="table_wrap">
				<form id="frm">
					<table class="table simple table_write_type">
						<colgroup>
							<col width="16%"/>
							<col width="34%"/>
							<col width="16%"/>
							<col width="34%"/>
						</colgroup>
						<tbody>
							<tr class="modify">
								<th>키워드 코드</th>
								<td colspan="3" class="last">
									<span id="keywordCode"></span>
									<input type="hidden" id="seqCategoryKeyword" name="seqCategoryKeyword" value=""/>
								</td>
							</tr>
							<tr class="insert modify">
								<th>키워드 <span class="imp">*</span></th>
								<td colspan="3" class="last">
									<span class="modify" id="keyword"></span>
									<input id="regKeyword" name="categoryKeywordName" type="text" class="input w01 insert" onkeydown="if(event.keyCode==13) {editKeyword(); return false;}"/>
								</td>
							</tr>
							<tr>
								<th>사용여부 <span class="imp">*</span></th>
								<td colspan="3" class="last">
									<input type="radio" name="useYn" id="useY" value="Y" class="" checked="checked"/> <label for="useY">사용</label>&nbsp;&nbsp;
									<input type="radio" name="useYn" id="useN" value="N" class="" /> <label for="useN">미사용</label>
								</td>
							</tr>
							<tr class="modify">
								<th>업종</th>
								<td>
									<select class="select w01" id="businessList" name="businessCode">
									</select>
								</td>
								<th>카테고리</th>
								<td class="last">
									<select class="select w01" id="categoryList" name="categoryCode">
									</select>
								</td>
							</tr>

						</tbody>
					</table>
				</form>
				</div>
			
				<!-- s: btn -->
				<div class="btn_wrap02">
					<span class="btn large focus" onclick="editKeyword();"><span class="insert">등록</span><span class="modify">수정</span></span>
					<!-- <span class="btn large focus" onclick="deleteKeyword();"><span class="modify">삭제</span></span> -->
					<span class="btn large" onclick="closeLayerPopup($('#keywordEditPopup'));" >취소</span>
				</div>
				<!-- e: btn -->
			</div>
		</div>
	</div>
</div>
<!-- e: popup -->
