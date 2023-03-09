<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
});

// 공지사항 등록/수정
function fadeOutEdit() {
	
	if(isEmpty($("#ctn").val())){
		alert("휴대폰 번호는 필수항목입니다.");
		return;	
	}
	$.ajax({
		url : "/admin/manage/insertfadeOutUserAjax.do",
		data : $("#fadeOutEditForm").serialize(),
		method : "POST",
		success : function(response) {
			if(response.resultCode == "1001") {
				location.href = "/admin/manage/fadeOutUserList.do";
			}else if(response.resultCode == "0001") {	
				alert("등록된 회원이 존재합니다.");
			} else {
				alert("회원이 존재하지 않습니다.");
			}
		}
	}).error(function(data) {
		alert("회원이 존재하지 않습니다.")
	});

}


</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="fadeOutEditForm" name="fadeOutEditForm" method="POST">
		 <div class="main_top">
	        <h2 id="titleh2">FadeOut 유저 등록</h2>
			
	    </div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">기본정보</div>
			</div>
			<div class="rtl">
				<div class="table_info01">* 필수입력</div>
			</div>
		</div>
		<!-- e: table top-->
			
		<!-- s: table wrap-->
		<div class="table_wrap">
			<table class="table simple table_write_type">
				<colgroup>
					<col width="16%"/>
					<col width="34%"/>
					<col width="16%"/>
					<col width="34%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>휴대폰번호 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" id="ctn" name="ctn" class="input w01" value="" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:fadeOutEdit();">
				<span class="btn large focus">
					등록
				</span>
			</a>
			<a href="javascript:history.back();"><span class="btn large">취소</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
