<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input:radio[name='useYn']:radio[value='${boardVO.useYn}']").attr("checked",true);
	$("input:radio[name='contentsType']:radio[value='${boardVO.contentsType}']").attr("checked",true);
	
	$("input").attr("disabled",true);
	if('${boardVO.fileInfoVO.filePath}' != "") {
		$("#imgPreview").css("display", "block");
		$("#imgPreview").attr('src', '${boardVO.fileInfoVO.filePath}');	
	} 
});

function bannerEditForm() {
	var boardId = $("input[name=boardId]").val();
	location.href="<c:url value='/board/bannerEditForm.do?boardId='/>"+boardId;
}


</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="bannerDetailForm" name="bannerDetailForm">
		<input type="hidden" name="boardMstId" value="${boardMstVO.boardMstId}" />
		<input type="hidden" name="boardId" value="${boardVO.boardId}" />
		<div class="main_top">
			<h2>배너상세</h2>
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
						<th>제목 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<c:out value="${boardVO.title}" />
						</td>
					</tr>
					<tr>
						<th>링크유형<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" name="contentsType" id="contentsTypeT" checked="checked" value="NOTICE" /> <label for="contentsTypeT">공지시항</label>&nbsp;&nbsp;
							<input type="radio" name="contentsType" id="contentsTypeI" value="OUTERLINK" /> <label for="contentsTypeI">외부링크</label>
						</td>
					</tr>
					<tr>
						<th>배너링크<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<c:out value="${boardVO.opt5}" />
						</td>
					</tr>
					<tr>
						<th>게시여부<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" name="useYn" id="useY" checked="checked" value="Y" /> <label for="useY">사용</label>&nbsp;&nbsp;
							<input type="radio" name="useYn" id="useN" value="N" /> <label for="useN">미사용</label>
						</td>
					</tr>
					<tr>
						<th>이미지 <span class="imp"></span></th>
						<td colspan="3" class="last">
							<c:out value="${boardVO.fileInfoVO.originFileName}" />
							<ul class="list_file">
								<li class="ltr">
									<span class="imp">*</span> 이미지는 jpg/png만 등록 가능 <br/>
									<span class="imp">*</span> 이미지 사이즈 1020X290px(최대 5MB)<br/>
									<img id="imgPreview" width="1020" height="290" style="display: none;">
								</li>
							</ul>
						</td>
					</tr>
					<tr>
						<th><div class="tit_search">게시일시</div></th>
						<td colspan="3" class="last">
							<fmt:parseDate value="${boardVO.postDate}" var='postDate' pattern="yyyy-mm-dd"/>
							<fmt:formatDate value="${postDate}" pattern="yyyy-mm-dd"/>
				            &nbsp;
							<c:out value="${boardVO.postHour}" />
							 &nbsp;시 
							<c:out value="${boardVO.postMinute}" />
							&nbsp;분 
							<c:if test="${not empty boardVO.bannerEndDate }">
							~
							<fmt:parseDate value="${boardVO.bannerEndDate}" var='bannerEndDate' pattern="yyyy-mm-dd"/>
							<fmt:formatDate value="${bannerEndDate}" pattern="yyyy-mm-dd"/>
				            &nbsp;
							<c:out value="${boardVO.bannerEndHour}" />
							 &nbsp;시 
							<c:out value="${boardVO.bannerEndMinute}" />
							&nbsp;분 
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:bannerEditForm();"><span class="btn large focus">수정</span></a>
			<a href="javascript:history.back();"><span class="btn large">목록</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
