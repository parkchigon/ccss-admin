<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input:radio[name='useYn']:radio[value='${noticeVO.useYn}']").attr("checked",true);
	$("input").attr("disabled",true);
});

function noticeEditForm() {
	var noticeId = $("#noticeId").val();
	location.href="/admin/notice/noticeEditForm.do?noticeId="+noticeId;
}


</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="termsDetailForm" name="termsDetailForm">
	<input type="hidden" id="noticeId" name="noticeId" value="${noticeVO.noticeId}" />
		<div class="main_top">
			<h2>Notice 상세</h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">기본정보</div>
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
							<c:out value="${noticeVO.title}" />
						</td>
					</tr>
					<tr>
						<th>사용여부 <span class="imp">*</span></th>
						<td class="last">
							<input type="radio" name="useYn" id="useY" checked="checked" value="Y" /> <label for="useY">사용</label>&nbsp;&nbsp;
							<input type="radio" name="useYn" id="useN" value="N" /> <label for="useN">미사용</label>
						</td>
					</tr>
					<tr>
						<th>링크(URL) <span class="imp">*</span></th>
						<td class="last">
							<c:out value="${noticeVO.linkUrl}" />
						</td>
					</tr>
					<tr>
						<th>내용 <span class="imp">*</span></th>
						<td class="last">
							<c:out value="${noticeVO.content}" />
						</td>
					</tr>
					
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:noticeEditForm();"><span class="btn large focus">수정</span></a>
			<a href="javascript:history.back();"><span class="btn large">목록</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
