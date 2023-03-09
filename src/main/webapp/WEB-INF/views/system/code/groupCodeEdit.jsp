<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	var useYn = "${codeVO.useYn}";
	$('input:radio[name=useYn]:input[value=' + useYn + ']').attr("checked", true);
});


function groupCodeEdit() {
	if(confirm("해당 그룹 코드 정보를 수정 하시겠습니까?")) {
		var url = "<c:url value='/system/code/updateGroupCode.do' />";
		var checkParamArr = ['useYn', 'grpCdExplain', 'grpCdNm'];
		var grpCdNm =$("#grpCdNm").val();
		
		if (formValidationCheck(checkParamArr)){
			$.ajax({
				url : url
				,data : $('#groupCodeUpdateForm').serialize()
				,dataType : 'json'
				,type : "POST"
			}).done(function(data) {
				var result = data.result;
				if(result == 'Y'){ 
					alert("그룹 코드 정보가 수정 되었습니다.");
					location.href="<c:url value='/system/code/groupCodeDetail.do?grpCdId="+"${codeVO.grpCdId}"+"'/>";
				} else if(result == 'E'){
					alert("이미 " + grpCdNm + " 이름의 그룹 코드가 있습니다.");
				}else{
					alert("그룹 코드 수정에 실패하였습니다.");
				}
			}).error(function(request,status,error){
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
	}
}

function historyBack(){
	location.href="<c:url value='/system/code/groupCodeDetail.do?grpCdId="+${codeVO.grpCdId}+"'/>";
}

//미입력 항목 alert
function alertMessageSource(elId){
	alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="groupCodeUpdateForm" name="groupCodeUpdateForm">
	<input type="hidden" id="grpCdId" name="grpCdId" value="${codeVO.grpCdId}" />
		<div class="main_top">
			<h2>시스템 관리 > 코드 관리 > 그룹 코드 정보 수정</h2>
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
						<th>사용여부<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  type="radio" name="useYn" id="useYn" class="" value="Y" /> <label for="useYn">사용</label>&nbsp;&nbsp;
							<input  type="radio" name="useYn" id="useYn" class="" value="N" /> <label for="useYn">미사용</label>
						</td>
					</tr>
					<tr>
						<th>그룹 코드 명<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="grpCdNm" name="grpCdNm" value ="${codeVO.grpCdNm}" class="input w01" />
						</td>
					</tr>
					<tr>
						<th>그룹 코드 설명<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="grpCdExplain" name="grpCdExplain" value ="${codeVO.grpCdExplain}" class="input w01" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<a href="javascript:groupCodeEdit();"><span class="btn large focus">저장</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
