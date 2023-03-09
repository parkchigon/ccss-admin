<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>

function updateOnOff() {
	$.ajax({
		url : "/admin/notice/updateNoticeShowYn.do",
		type : "POST",
		data : $("#frm").serialize(),
		datyType : "JSON"
	}).success(function(data){
		if(data.resultCode = "1001") {
			alert("Notice On/Off 설정이 정상 처리되었습니다.");
			closeLayerPopup($('#noticeOnOffPopup'));
			goSearch(1);
		} else {
			alert("Notice On/Off 설정중 오류가 발생하였습니다.\n잠시 후 다시 시도해 주세요.");	
			closeLayerPopup($('#noticeOnOffPopup'));
		}
	}).error(function(dat){
		alert("Notice On/Off 설정중 오류가 발생하였습니다.\n잠시 후 다시 시도해 주세요.");	
		closeLayerPopup($('#noticeOnOffPopup'));
	});
}
function toggleOnOff(onOff){
	var html = '';
   	html += "<div id='button_1' class='group'>";
	if(onOff) {
       	html += "<a href='javascript:toggleOnOff(true);' class='btn large active' style='background: blue; color: white; font-weight: bold;' value='true'>On</a>";
       	html += "<a href='javascript:toggleOnOff(false);' class='btn large' value='false'>Off</a>";
       	$("#noticeShowYn").val("Y");
	} else {
       	html += "<a href='javascript:toggleOnOff(true);' class='btn large' value='true'>On</a>";
       	html += "<a href='javascript:toggleOnOff(false);' class='btn large active' style='background: red; color: white; font-weight: bold;' value='false'>Off</a>";
       	$("#noticeShowYn").val("N");
	}
	html += "</div>";
	$("#onOffButton").empty();
	$("#onOffButton").append(html);
}
</script>
<form id="frm" method="post">
	<input type="hidden" id="currnetNoticeShowYn">
	<input type="hidden" id="noticeShowYn" name="noticeShowYn">
</form>

<!-- s: popup -->
<div class="popup_container" id="noticeOnOffPopup" style="display: none;">
	<div class="popup_inner w02">
		<div class="p_header">
			<h1>Notice ON/OFF 설정</h1>
			<a href="javascript:closeLayerPopup($('#noticeOnOffPopup'));" class="btn_close"><span class="hidden_obj">닫기</span></a>
		</div> 
		<div class="p_body">
			<div class="p_content">
				<div class="pop_info">&middot; Notice ON/OFF 설정하기</div>
				
				<div class="radio_group" id="onOffButton">
					<div id="button_1" class="group">
						<a href="javascript:toggleOnOff(true);" class="btn large active" style="background: blue; color: white; font-weight: bold;">On</a>
						<a href="javascript:toggleOnOff(false);" class="btn large">Off</a>
					</div>
				</div>
				<!-- s: btn -->
				<div class="btn_wrap02">
					<a href="javascript:updateOnOff();"><span class="btn large focus">적용</span></a>
					<span onclick="closeLayerPopup($('#noticeOnOffPopup'));"class="btn large" id="btn_exitPopup">취소</span>
				</div>
				<!-- e: btn -->
			</div>
		</div>
	</div>
</div>
<!-- e: popup -->