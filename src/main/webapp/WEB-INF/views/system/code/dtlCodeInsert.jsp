<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
var grpCdId;
$(document).ready(function(){
	//[Fortify] Cross-Site Scripting: Reflected
	grpCdId ="<c:out value='${codeVO.grpCdId}'/>";
});


//미입력 항목 alert
function alertMessageSource(elId){
	alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
}


function dtlCodeInsert() {
	
	var url = "<c:url value='/system/code/insertNewDtlCode.do' />";
	var checkParamArr = ['useYn', 'cdVal','codeDesc', 'dtlCdNm','grpCdNm'];
	
	if (formValidationCheck(checkParamArr)){
		$.ajax({
			url : url
			,data : $('#dtlCodeInsertForm').serialize()
			,dataType : 'json'
			,type : "POST"
		}).done(function(data) {
			var result = data.result;
			if(result == 'Y'){ 
				alert("상세 코드가 등록 되었습니다.");
				location.href="<c:url value='/system/code/groupCodeDetail.do?grpCdId="+grpCdId+"'/>";
			} else if(result == 'E'){
				alert("이미 해당 상세 코드 또는 코드 값이 있습니다.");
			}else{
				alert("상세 코드 등록에 실패하였습니다.");
			}
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
}

function historyBack(){
	if(confirm("저장 없이 목록으로 돌아가시 겠습니까?")) {
		history.back();
	}
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="dtlCodeInsertForm" name="dtlCodeInsertForm">
		<!-- [Fortify] Cross-Site Scripting: Reflected -->
		<input type="hidden" id="grpCdId" name="grpCdId" value="<c:out value='${codeVO.grpCdId}'/>" />
		<div class="main_top">
			<h2> 시스템 관리 > 공통 코드 관리 > 상세 코드 등록</h2>
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
						<th> 그룹 코드명 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<!-- [Fortify] Cross-Site Scripting: Reflected -->
							<input type="text" autocomplete="off" id="grpCdNm" name="grpCdNm"  value ="<c:out value='${codeVO.grpCdNm}'/>" class="input w01" readonly/>
						</td>
					</tr>
					<tr>
						<th> 상세 코드명 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="dtlCdNm" name="dtlCdNm"  class="input w01" />
						</td>
					</tr>
					<tr>
						<th> 상세 코드 설명 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="codeDesc" name="codeDesc"  class="input w01" />
						</td>
					</tr>
					<tr>
						<th> 코드값 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="cdVal" name="cdVal" maxlength="4" class="input w01" />
						</td>
					</tr>
					<tr>
						<th>사용 여부<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  type="radio" name="useYn" id="useYn" class="" value="Y"  checked="checked"/> <label for="useYn">사용</label>&nbsp;&nbsp;
							<input  type="radio" name="useYn" id="useYn" class="" value="N" /> <label for="useYn">미사용</label>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<a href="javascript:dtlCodeInsert();">
				<span class="btn large focus">저장</span>
			</a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
