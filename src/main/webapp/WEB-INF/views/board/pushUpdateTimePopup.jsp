<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javascript" src="/js/clipboard.js"></script>
<script type="text/javaScript">
$(document).ready(function(){
	goSearch();
});


// 업데이트 주기 정보조회
function goSearch() {
	$.ajax({
		url : "/admin/board/selectPushUpdateTime.do"
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var data = data.boardVO;
		$("#updatetime").val(data.updatetime);
	});
}

// 업데이트 주기 업데이트 
function updatePushupdatetime() {
	if (checkAlert()){
		$.ajax({
			url : "/admin/board/updatePushUpdateTime.do",
			type : "POST",
			data : getFormData($("#pushSearchForm")),
			dataType : "json",
			contentType: "application/json"
		}).done(function(data) {
			if (data.resultCode == "1001") {
				alert("변경내용이 저장되었습니다.");
				exitPopup();
			}
		});
	}
}

function checkAlert() {
	if (formValidationCheck(['updatetime'])){
		// 정규식 숫자만  입력되지 않도록한다.
		var pattern = /[0-9]/;
		var updatetime = $("#updatetime").val();
		
		if ( updatetime > 24 ) {
			alert("업데이트 주기는 24시간 기준으로 입력가능합니다.");
			return false;
		}
		
		for (var i=0; i<updatetime.length; i++ ) {
			if(updatetime.charAt(i) != "" && pattern.test(updatetime.charAt(i))==false) {
				alert("숫자만 입력하실 수 있습니다.");
				return false;
			}
		}
	}
	return true;
}


//미입력 항목 alert
function alertMessageSource(elId){
	switch (elId) {
	case 'updatetime': 
		alert("업데이트주기는 필수입력 항목입니다.");
		break;
	}
}

</script>


<!-- 내용-->
<body class="jui">
<div class="popup_inner w03"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px, -->
   <div class="p_header">
       <h1>업데이트 주기설정</h1>
       <a href="javascript:exitPopup()" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
   </div> 
   <div class="p_body">
      <div class="p_content">
	  <form id="pushSearchForm" name="pushSearchForm" method="POST" >     
       <!-- s: table wrap-->                                      
       <div class="table_wrap table_scroll">
           <table class="table simple table_list_type">
               <colgroup>
                         <col width="50%"/>
                         <col width="50%"/>
               </colgroup>
               <tbody>
                  <tr>
                       <td>Push Reg 주기</td>
                       <td><input type="text" name="updatetime" id="updatetime" /></td>
                  </tr>
               </tbody>
              
           </table>
		</div>
       <!-- e: table wrap-->
       </form>
      </div>
   </div>
</div>
<div class="btn_wrap02">
 	<a href="javascript:updatePushupdatetime();"><span class="btn large focus">저장</span></a>
 	<a href="javascript:exitPopup();"><span class="btn large">취소</span></a>
</div>
</body>

