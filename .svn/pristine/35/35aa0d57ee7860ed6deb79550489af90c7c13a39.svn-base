<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input, textarea").attr("disabled",true);
});

function termsEditForm() {
	var seqTerms = $("input[name=seqTerms]").val();
	location.href="/admin/servicemng/termsEditForm.do?seqTerms="+seqTerms;
}


function openTermsHistPopup(termsId) {
	var url="/admin/servicemng/termsHistListPopup.do?termsId="+termsId+"&termsTitle=${termsVO.termsTitle}"; 
	commonPopup(url,'termsHistListPopup','width=1162,height=572,scrollbars=yes');
}

</script>
<body class="jui">
	<!-- 내용-->
	<div class="popup_inner w03"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px, -->
		<div class="p_header">
			<h1>${termsVO.termsTitle} 업데이트 내역</h1>
			<a href="javascript:window.close();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 	
	
		<div class="p_body">
			<div class="p_content">
				<form id="termsDetailForm" name="termsDetailForm">
				<input type="hidden" id="seqTerms" name="seqTerms" value="${termsVO.seqTerms}" />
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
									<th>약관명 <span class="imp">*</span></th>
									<td colspan="3" class="last">
										<c:out value="${termsVO.termsTitle}" />
									</td>
								</tr>
								<tr>
									<th>활용 동의 구분 <span class="imp">*</span></th>
									<td colspan="3" class="last">
										<c:if test="${termsVO.requiredYn eq 'Y' }">
										<input type="radio" name="requiredYn" id="requiredY" value="Y" checked="checked"/> <label for="requiredYn">필수 동의</label>&nbsp;&nbsp;
										<input type="radio" name="requiredYn" id="requiredN" value="N" /> <label for="requiredYn">선택 동의</label>&nbsp;&nbsp;
									</c:if>
									<c:if test="${termsVO.requiredYn eq 'N' }">
										<input type="radio" name="requiredYn" id="requiredY" value="Y" /> <label for="requiredYn">필수 동의</label>&nbsp;&nbsp;
										<input type="radio" name="requiredYn" id="requiredN" value="N" checked="checked" /> <label for="requiredYn">선택 동의</label>&nbsp;&nbsp;
									</c:if>
									</td>
								</tr>
								<tr>
									<th>사용여부 <span class="imp">*</span></th>
									<td colspan="3" class="last">
									<c:if test="${termsVO.useYn eq 'Y' }">
										<input type="radio" name="useYn" id="useY" value="Y" checked="checked"/> <label for="useYn">사용</label>&nbsp;&nbsp;
										<input type="radio" name="useYn" id="useN" value="N" /> <label for="useYn">미사용</label>&nbsp;&nbsp;
									</c:if>
									<c:if test="${termsVO.useYn eq 'N' }">
										<input type="radio" name="useYn" id="useY" value="Y" /> <label for="useYn">사용</label>&nbsp;&nbsp;
										<input type="radio" name="useYn" id="useN" value="N" checked="checked"/> <label for="useYn">미사용</label>&nbsp;&nbsp;
									</c:if>
									</td>
								</tr>
								<tr>
									<th>내용 <span class="imp">*</span>
									</th>
									<td colspan="3" class="last">
										<textarea id="termsContent" name="termsContent" class="input textareabox" style="height:400px"><c:out value="${termsVO.termsContent}" escapeXml="false"/></textarea>
									</td>
								</tr>
								<tr>
									<th>비고 <span class="imp">*</span></th>
									<td colspan="3" class="last">
										<textarea id="description" name="description" class="input textareabox" style="height:50px"><c:out value="${termsVO.description}" escapeXml="false"/></textarea>
									</td>
								</tr>
								<tr>
									<th><div class="tit_search">게시일시</div></th>
									<td colspan="3" class="last">
										<fmt:parseDate value="${termsVO.postDate}" var='postDate' pattern="yyyymmdd"/>
										<fmt:formatDate value="${postDate}" pattern="yyyy-mm-dd"/>
							            &nbsp;
										<c:out value="${termsVO.postHour}" />
										 &nbsp;시 
										<c:out value="${termsVO.postMinute}" />
										&nbsp;분 
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- e: table wrap-->
				
				
					<!-- s: 버튼-->
					<div class="btn_wrap02">
						<a href="javascript:history.back();"><span class="btn large">목록</span></a>
					</div>
					<!-- e: 버튼-->
				</form>
			</div>
		</div>
	</div>
</body>