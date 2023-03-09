<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input").attr("disabled",true);
	if('${boardVO.fileInfoVO.filePath}' != "") {
		$("#imgPreview").css("display", "block");
		$("#imgPreview").attr('src', '${boardVO.fileInfoVO.filePath}');	
	} 
});

function appversionEditForm() {
	var boardId = $("input[name=boardId]").val();
	location.href="<c:url value='/board/appversionEditForm.do?boardId='/>"+boardId;
}
</script>
<div class="contents_wrap">
	<form id="appDetailForm" name="noticeDetailForm">
		<input type="hidden" name="boardMstId" value="${boardMstVO.boardMstId}" />
		<input type="hidden" name="boardId" value="${boardVO.boardId}" />
		<div class="main_top">
			<h2>버전 상세</h2>
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
					<col width="34%"/>
					<col width="16%"/>
					<col width="34%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>버전 <span class="imp">*</span></th>
						<td colspan="3" >
							${boardVO.title}
						</td>
					</tr>
					<tr>
						<th>파일명<span class="imp">*</span></th>
						<td colspan="3">
							<a href="${boardVO.fileInfoVO.filePath}" download>${boardVO.fileInfoVO.originFileName}</a>
						</td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3" class="last">
							<c:set var="content1"  value="${boardVO.content}" />
							<c:set var="content2"  value="${fn:replace( content1, newLineChar, '<br/>')}" />
							<c:out value="${content2}" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:appversionEditForm();"><span class="btn large focus">수정</span></a>
			<a href="javascript:history.back();"><span class="btn large">목록</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
