<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input:radio[name='termsId']:radio[value='${termsVO.termsId}']").attr("checked",true);
	$("#termsContent").val(safeTagToHtmlTag($("#termsContent").val()));
	
	// 데이터 피커 생성
	datePicker({
		datePickerGroupId: "datepicker1_group",
		datePickerId: "datepicker1",
	});
	
	if(isEmpty($("#seqTerms").val())) { // 등록
		$("#postDate").val(getCurrentDate());	
	} else {	// 약관종류 수정 못함
		$("input:radio[name='termsId']").attr("disabled",true);
	}
	
});

// 약관 등록/수정
function termsEdit() {
	
	var url = "/admin/servicemng/updateTerms.do";
	var termsContent = $("#termsContent").val()
	var description = $("#description").val();
	var postDate = $("#postDate").val();
	
	
	if(termsContent == '' || termsContent == null) {
		alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
		return;
	}
	if(description == '' || description == null) {
		alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
		return;
	}
	if(postDate == '' || postDate == null) {
		alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
		return;
	}
	
	$.ajax({
		url : url
		,data : $('#termsEditForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var result = data.result;
		if(result == 'Y') {
			location.href="/admin/servicemng/termsList.do";
		} else {
			alert("수정에 실패하였습니다.");
		}
	}).error(function(data) {
		alert("수정에 실패하였습니다.");
	});
}

function openTermsHistPopup(termsId) {
	var url="/admin/servicemng/termsHistListPopup.do?termsId="+termsId+"&termsTitle=${termsVO.termsTitle}"; 
	commonPopup(url,'termsHistListPopup','width=1162,height=836,scrollbars=yes');
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="termsEditForm" name="termsEditForm">
	<input type="hidden" id="seqTerms" name="seqTerms" value="${termsVO.seqTerms}" />
	<input type="hidden" id="termsTitle" name="termsTitle" value="${termsVO.termsTitle}" />
		<div class="main_top">
			<h2>
			 약관   <c:if test="${not empty termsVO.seqTerms }">수정</c:if><c:if test="${empty termsVO.seqTerms }">등록</c:if></h2>
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
						<th>내용<br><br>
							<div class="btn_wrap01">
								<span class="btn" onclick="javascript:openTermsHistPopup('${termsVO.termsId}');">업데이트 내역보기</span>
							</div>
						</th>
						<td colspan="3" class="last">
							<textarea id="termsContent" name="termsContent" class="input textareabox" style="height:400px"><c:out value="${termsVO.termsContent}" /></textarea>
						</td>
					</tr>
					<tr>
						<th>비고 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<textarea id="description" name="description" class="input textareabox" style="height:50px"><c:out value="${termsVO.description}" /></textarea>
						</td>
					</tr>
					<tr>
						<th><div class="tit_search">게시일시</div></th>
						<td colspan="3" class="last">
							<div id="datepicker1_group" class="group">
								<fmt:parseDate value="${termsVO.postDate}" var='postDate' pattern="yyyymmdd"/>
				                <input type="text" class="input" style="width: 120px;" id="postDate" name="postDate" value="<fmt:formatDate value="${postDate}" pattern="yyyy-mm-dd"/>" readonly />
				                <a class="btn btn-gray"><i class="icon-calendar"></i></a>
				
				                <div id="datepicker1" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
				                    <div class="head">
				                        <div class="prev"><i class="icon-chevron-left"></i></div>
				                        <div class="title"></div>
				                        <div class="next"><i class="icon-chevron-right"></i></div>
				                    </div>
				                    <table class="body">
				                        <tr>
				                            <th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
				                        </tr>
				                    </table>
				                </div>
				            </div>
				            &nbsp;
							<select class="select w01" style="width: 100px;" id="postHour" name="postHour">
								<c:forEach var="hours" begin="00" end="23">
									<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
									<option value="${hour}" <c:if test="${empty termsVO.seqTerms and hour eq 12}">selected="selected"</c:if>
															 <c:if test="${!empty termsVO.seqTerms and hour eq termsVO.postHour}">selected="selected"</c:if> >${hour}</option>
								</c:forEach>
							</select>
							 &nbsp;시 &nbsp;
							<select class="select w01" style="width: 100px;" id="postMinute" name="postMinute">
								<c:forEach var="minutes" begin="00" end="59">
									<fmt:formatNumber var="minute" value="${minutes}" pattern="00" />
									<option value="${minute}" <c:if test="${empty termsVO.seqTerms and minute eq 00}">selected="selected"</c:if> 
																<c:if test="${!empty termsVO.seqTerms and minute eq termsVO.postMinute}">selected="selected"</c:if>>${minute}</option>
								</c:forEach>
							</select>
							&nbsp;분 &nbsp;
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:termsEdit();">
				<span class="btn large focus">
					<c:if test="${not empty termsVO.seqTerms }">수정</c:if>
					<c:if test="${empty termsVO.seqTerms }">등록</c:if>
				</span>
			</a>
			<a href="javascript:history.back();"><span class="btn large">취소</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
