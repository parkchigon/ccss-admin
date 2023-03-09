<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
var termsDivListMap = new Map();

$(document).ready(function(){
	selectTermsDivList();
	$("#termsCont").val(safeTagToHtmlTag($("#termsCont").val()));
});


function makeTermsDivArea(){
	$("#termsDivArea").empty();
	var termsDivAtreaHtml ="";
	var termsDivMapKeyList =termsDivListMap.keys();
	
	for(var i=0; i< termsDivListMap.size(); i++){
		termsDivAtreaHtml += "<input disabled type='radio' name='termsDiv' id='termsDiv'  value=" +"'"+ termsDivMapKeyList[i] +"'"+ "/> <label for='termsDiv'>" + termsDivListMap.get(termsDivMapKeyList[i]) + "</label>&nbsp;&nbsp;"; 
	}  
	
	$("#termsDivArea").append(termsDivAtreaHtml);
	
	$("input, textarea").attr("disabled",true);

	var termsDiv = "${termsVO.termsDiv}";
	var exposureYn = "${termsVO.exposureYn}";
	
	$('input:radio[name=termsDiv]:input[value=' + termsDiv + ']').attr("checked", true);
	$('input:radio[name=exposureYn]:input[value=' + exposureYn + ']').attr("checked", true);
	
	// Terms Type 선택시 제목 자동 생성. 
	 $("input[name=termsDiv]").change(function() {
		var radioValue = $(this).val();
		 $("#termsTitle").val(termsDivListMap.get(radioValue));
	});
	
}

function safeTagToHtmlTag(content) {
	var result = content.replace(/&gt;/gi, ">");
	result = result.replace(/&lt;/gi, "<");
	result = result.replace(/&quot;/gi, "\"");
    result = result.replace(/&amp;/gi, "&");
    result = result.replace(/&#039;/gi, "'");
    
    return result;
}
function selectTermsDivList(){
	$.ajax({
		url : "<c:url value='/system/code/selectDtlCodeListByGrpCodeNm.do' />",
		type : "POST",
		data : {
			"grpCdNm" : "TERMS_DIV"
		},
		dataType : "json"
	}).done(function (data) {
		var list = data.resultList;
		for (var i = 0; i < list.length ; i++) {		
			termsDivListMap.put(list[i].cdVal,list[i].codeDesc);
		}
		
		 makeTermsDivArea();
	}).error(function(request,status,error){
		//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		if(request.status == 401){
			alert("해당 권한이 없습니다.");
		}else if(request.status == 400){
			alert("비정상적인 요청입니다.");
		}else{
			console.log("서버 내부 오류 발생","code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			if(request.status ==200){
				location.href = "<c:url value='/login/loginView.do' />";
			}
		}
	});
}


function termsEditForm() {
	if(confirm("해당 약관 버전을 수정 하시겠습니까?")) {
		var termsNo = "${termsVO.termsNo}";
		location.href="<c:url value='/term/termsEditForm.do?termsNo="+termsNo+"'/>";
	}
}

function historyBack(){
		//history.back();
	location.href="<c:url value='/term/termsList.do'/>";
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="termsDetailForm" name="termsDetailForm">
	<input type="hidden" id="seqTerms" name="seqTerms" value="${termsVO.termsNo}" />
		<div class="main_top">
			<h2>전시관리 > 약관관리 > 약관 상세 정보</h2>
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
						<th>약관 구분 <span class="imp">*</span></th>
						<td id ="termsDivArea" colspan="3" class="last">
							<!-- <input disabled type="radio" name="termsDiv" id="termsDiv" class="" value="1" /> <label for="termsDiv">서비스 이용약관</label>&nbsp;&nbsp;
							<input disabled type="radio" name="termsDiv" id="termsDiv" class="" value="2" /> <label for="termsDiv">위치기반 서비스 이용약관</label>&nbsp;&nbsp;
							<input disabled type="radio" name="termsDiv" id="termsDiv" class="" value="3" /> <label for="termsDiv">개인정보 처리방침</label> -->
						</td>
					</tr>
					<tr>
						<th>상태<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input disabled type="radio" name="exposureYn" id="exposureYn" class="" value="Y" /> <label for="pexposureYn">사용</label>&nbsp;&nbsp;
							<input disabled type="radio" name="exposureYn" id="exposureYn" class="" value="N" /> <label for="pexposureYn">미사용</label>
						</td>
					</tr>
					<tr>
						<th>약관 게시 시작 일시<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="exposureStartDt" name="exposureStartDt" value ="${termsVO.exposureStartDt}" class="input w01" readOnly"/>
						</td>
					</tr>
					<tr>
						<th>약관 게시 종료 일시<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="exposureEndDt" name="exposureEndDt"  value ="${termsVO.exposureEndDt}" class="input w01" readOnly"/>
						</td>
					</tr>
					<tr>
						<th>등록자<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="regId" name="regId" value ="${termsVO.regId}" class="input w01" readOnly"/>
						</td>
					</tr>
					<tr>
						<th>등록일<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="regDt" name="regDt" value ="${termsVO.regDt}" class="input w01" readOnly"/>
						</td>
					</tr>
					<tr>
						<th>제목 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="termsTitle" name="termsTitle" value ="${termsVO.termsTitle}"  class="input w01" readOnly"/>
						</td>
					</tr>
					<tr>
						<th>버전 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="termsVer" name="termsVer" value ="${termsVO.termsVer}" class="input w01" readOnly/>
						</td>
					</tr>
					<tr>
						<th>내용 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<textarea id="termsCont" name="termsCont" class="input textareabox" style="height:400px" readOnly><c:out value="${termsVO.termsCont}" /></textarea>
						</td>
					</tr>
					<tr>
						<th>노출 순서 <span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" autocomplete="off" id="termsSortNum" name="termsSortNum" value ="${termsVO.termsSortNum}" class="input w01" readOnly"/>
						</td>
						<th>필수 여부 <span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" autocomplete="off" id="requiredYn" name="requiredYn" value ="${termsVO.requiredYn}" class="input w01" readOnly"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<a href="javascript:termsEditForm();"><span class="btn large focus">수정</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
