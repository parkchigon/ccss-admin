<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input:radio[name='useYn']:radio[value='${boardVO.useYn}']").attr("checked",true);
	$("input:radio[name='fixYn']:radio[value='${boardVO.fixYn}']").attr("checked",true);
	$("input:radio[name='contentsType']:radio[value='${boardVO.contentsType}']").attr("checked",true);
	$("input, textarea").attr("disabled",true);
	$("input").attr("disabled",true);
	if('${boardVO.fileInfoVO.filePath}' != "") {
		$("#imgPreview").css("display", "block");
		$("#imgPreview").attr('src', '${boardVO.fileInfoVO.filePath}');	
	} 
	radioCheckContentsType();
});

function noticeEditForm() {
	var boardId = $("input[name=boardId]").val();
	location.href="<c:url value='/board/noticeEditForm.do?boardId='/>"+boardId;
}

function radioCheckContentsType(){
	if($("input:radio[name='contentsType']:checked").val() == "txt"){
		$("#trContent").show();
		$("#trImg").hide();
	}else if($("input:radio[name='contentsType']:checked").val() == "img"){
		$("#trContent").hide();
		$("#trImg").show();
	}else if($("input:radio[name='contentsType']:checked").val() == "txtimg"){
		$("#trContent").show();
		$("#trImg").show();
	}
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="noticeDetailForm" name="noticeDetailForm">
		<input type="hidden" name="boardMstId" value="${boardMstVO.boardMstId}" />
		<input type="hidden" name="boardId" value="${boardVO.boardId}" />
		<div class="main_top">
			<h2>공지사항</h2>
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
						<th>사용여부 <span class="imp">*</span></th>
						<td class="last">
							<input type="radio" name="useYn" id="useY" checked="checked" value="Y" /> <label for="useY">사용</label>&nbsp;&nbsp;
							<input type="radio" name="useYn" id="useN" value="N" /> <label for="useN">미사용</label>
						</td>
						<th>상단 고정 여부 <span class="imp">*</span></th>
						<td  class="last">
							<input type="radio" name="fixYn" id="fixYn" checked="checked" value="Y" /> <label for="useY">상단고정</label>&nbsp;&nbsp;
							<input type="radio" name="fixYn" id="fixYn" value="N" /> <label for="useN">고정안함</label>
						</td>
					</tr>
					<tr>
						<th>내용유형<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" name="contentsType" id="contentsType" checked="checked" value="txt" /> <label for="useY">TEXT</label>&nbsp;&nbsp;
							<input type="radio" name="contentsType" id="contentsType" value="img" /> <label for="useN">IMAGE</label>
							<input type="radio" name="contentsType" id="contentsType" value="txtimg" /> <label for="useN">TEXT+IMAGE</label>
						</td>
					</tr>
					<tr id="trContent">
						<th>내용<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<textarea id="content" name="content" class="input textareabox" style="height:400px"><c:out value="${boardVO.content}" escapeXml="false"/></textarea>
						</td>
					</tr>
					<tr id="trImg">
						<th>이미지 <span class="imp"></span></th>
						<td colspan="3" class="last">
							<input type="text" id="originFileName" name="originFileName" style="width: 400px;" class="input w04"  value="<c:out value="${boardVO.fileInfoVO.originFileName}" />" readonly>
							<ul class="list_file">
								<li class="ltr">
									<span class="imp">*</span> 이미지는 jpg/png만 등록 가능 <br/>
									<span class="imp">*</span> 가로 사이즈 938px(최대 5MB)<br/>
									<img id="imgPreview" width="938" style="display: none;">
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
