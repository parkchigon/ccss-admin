<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {
	setTextLengthLimit("#termsTitle", 60);
	
});

function insertNewTerms() {
	var termsTitle = $.trim($("#termsTitle").val());
	
	if(isEmpty(termsTitle)) {
		alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
		return;
	}
	
	$.ajax({
		url : "/admin/servicemng/insertNewTerms.do",
		type : "POST",
		data : $("#frm").serialize(),
		dataType : "json"
	}).done(function(data) {
		console.log(data);
		closeLayerPopup($("#termsRegPopup"));
		goSearch(1);
	});
}
</script>
<!-- s: popup -->
<div class="popup_container" id="termsRegPopup" style="display: none;">
	<div class="popup_inner w01"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px,-->
		<div class="p_header">
			<h1>약관 등록</h1>
			<a href="javascript:closeLayerPopup($('#termsRegPopup'));" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 
		<div class="p_body">
			<div class="p_content">

				<!-- s: table top-->
				<div class="thead_wrap cboth">
					<div class="ltr">
						새롭게 추가할 약관을 등록해주세요.
					</div>
					<div class="rtl"><span class="imp">*</span>필수입력</div>
				</div>
				<!-- e: table top-->
				
				<!-- s: table wrap-->
				<div class="table_wrap">
				<form id="frm">
					<table class="table simple table_write_type">
						<colgroup>
							<col width="20%"/>
							<col width="80%"/>
						</colgroup>
						<tbody>
							<tr>
								<th>약관명 <span class="imp">*</span></th>
								<td class="last">
									<span class="modify" id="keyword"></span>
									<input id="termsTitle" name="termsTitle" type="text" class="input w01 insert" onkeydown="if(event.keyCode==13) {insertNewTerms(); return false;}"/>
								</td>
							</tr>
							<tr>
								<th>활용 동의 구분 <span class="imp">*</span></th>
								<td class="last">
									<input type="radio" name="requiredYn" id="requiredY" value="Y" class="" checked="checked"/> <label for="requiredY">필수 동의</label>&nbsp;&nbsp;
									<input type="radio" name="requiredYn" id="requiredN" value="N" class="" /> <label for="requiredN">선택 동의</label>
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				</div>
			
				<!-- s: btn -->
				<div class="btn_wrap02">
					<span class="btn large focus" onclick="insertNewTerms();">등록</span>
					<span class="btn large" onclick="closeLayerPopup($('#termsRegPopup'));" >취소</span>
				</div>
				<!-- e: btn -->
			</div>
		</div>
	</div>
</div>
<!-- e: popup -->
