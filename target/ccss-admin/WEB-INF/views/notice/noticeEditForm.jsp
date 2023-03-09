<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input:radio[name='useYn']:radio[value='${noticeVO.useYn}']").attr("checked",true);
	$("#content").val(safeTagToHtmlTag($("#content").val()));
	
	if(isEmpty($("#noticeId").val())) { // 등록
		$("#postDate").val(getCurrentDate());	
	}
	
});

// 약관 등록/수정
function noticeEdit() {
	var url = "";
	if($("#content").val().length > 40){
		alert("내용을 40자이하로 작성해주세요.");
		return;
	}
	if('${noticeCount}' > 0 && $("input:radio[name='useYn']:checked").val() == "Y"){
		if(!confirm('사용 설정 시 기존 노출중인 내용은 \n자동으로 미사용 설정됩니다.')) {
			return;
		}
	}
	if(formValidationCheck(['title','content','linkUrl'])){
		$("#noticeEditForm").submit();
	}
}

//미입력 항목 alert
function alertMessageSource(elId){
	switch (elId) {
	case 'title': 
		alert("제목은 필수 항목입니다.");
		break;
	case 'content': 
		alert("내용은 필수 항목입니다.");
		break;
	case 'linkUrl': 
		alert("링크(URL)은 필수 항목입니다.");
		break;
		
	}
}


function radioUseYnCheck(){
	if("${noticeVO.useYn}" == "Y"){
		alert("최소 1개의 Notice를 노출해야합니다.");
		$("input:radio[name='useYn']:radio[value='${noticeVO.useYn}']").attr("checked",true);
	}
	
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="noticeEditForm" name="noticeEditForm" method="POST" action="/admin/notice/noticeEdit.do" >
	<input type="hidden" id="noticeId" name="noticeId" value="${noticeVO.noticeId}" />
		<div class="main_top">
			<h2>
			 Notice  <c:if test="${not empty noticeVO.noticeId }">수정</c:if><c:if test="${empty noticeVO.noticeId }">등록</c:if></h2>
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
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<th>제목 <span class="imp">*</span></th>
						<td class="last">
							<input type="text" id="title" name="title" class="input w01" value="<c:out value="${noticeVO.title}" />" />
						</td>
					</tr>
					<tr>
						<th>사용여부 <span class="imp">*</span></th>
						<td class="last">
							<input type="radio"  name="useYn" id="useY" class="" value="Y" /> <label for="useY">사용</label>&nbsp;&nbsp;
							<input type="radio"  name="useYn" id="useN" onclick="radioUseYnCheck();" class="" checked="checked" value="N" /> <label for="useN">미사용</label>
							*사용 설정 시 기존 노출중인 내용은 자동으로 미사용 설정됩니다.
						</td>
					</tr>
					<tr>
						<th>링크(URL) <span class="imp">*</span></th>
						<td  class="last">
							<input type="text" id="linkUrl" name="linkUrl" class="input w01" value="<c:out value="${noticeVO.linkUrl}" />" />
						</td>
					</tr>
					<tr>
						<th>내용 <span class="imp">*</span></th>
						<td  class="last">
							<input type="text" id="content" name="content" class="input w01" value="<c:out value="${noticeVO.content}" />" maxlength="20" />
							* 띄어쓰기 포함 20자 내외로 작성해 주세요.
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:noticeEdit();">
				<span class="btn large focus">
					<c:if test="${not empty noticeVO.noticeId }">수정</c:if>
					<c:if test="${empty noticeVO.noticeId }">등록</c:if>
				</span>
			</a>
			<a href="javascript:history.back();"><span class="btn large">취소</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
