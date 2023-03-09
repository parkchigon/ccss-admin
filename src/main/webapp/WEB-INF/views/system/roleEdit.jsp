<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script>
$(document).ready(function() {
	
	
	var roleId = '${roleId}';
	//console.log('roldId', roleId);
	var useYn = '${Role.useYn}';
	var f = document.frm;
	f.action = "<c:url value='/system/role/editRoleAjax.do'/>";
	
	if(useYn == "Y"){
		$("input:radio[name='useYn']:radio[value='Y']").attr("checked",true);
	}else if(useYn == "" || useYn == "undefined" || useYn =="null"){
		$("input:radio[name='useYn']:radio[value='Y']").attr("checked",true);
	}else{
		$("input:radio[name='useYn']:radio[value='N']").attr("checked",true);
	}
	
	if (roleId == "undefined" || roleId =="null"){
		$("#modButton").hide();
		$("#delButton").hide();
	}else{
		$("#regButton").hide();
	}
	
	$("#regButton").click(function(){
		f.roleId.value = '';
		f.submit();
	});
	$("#modButton").click(function(){
		f.roleId.value = '${roleId}'
		f.submit();
	});
	$("#delButton").click(function(){
		if(confirm("선택 하신 권한 그룹을 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {
		f.action = "<c:url value='/system/role/deleteRoleAjax.do'/>";
		f.roleId.value = '${roleId}'
		f.submit();
		}
	});
	$("#cnButton").click(function(){
		location.href="/admin/system/role/listView.do";
	});
	
	
});
function notAvailableSpecialChar(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9-_.]/g,""));
	}); 
}

</script>

<!-- 내용-->
<div class="contents_wrap">
	<form:form commandName="role" name="frm" id="frm" method="post">
	<form:hidden path="roleId"/>
		<div class="main_top">
			<h2>권한 그룹 관리</h2>
		</div>
		
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
						<th>권한명 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" onkeydown="notAvailableSpecialChar(this)" id="grpNm" name="grpNm" class="input w01" value="<c:out value="${Role.grpNm}" />" />
						</td>
					</tr>
<%-- 					<tr>
						<th>정렬순서 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" id="orderNo" name="orderNo" class="input w01" value="<c:out value="${Role.orderNo}" />" />
						</td>
					</tr> --%>
					<tr>
						<th>설명 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" id="grpExplan" name="grpExplan" class="input w01" value="<c:out value="${Role.grpExplan}" />" />
						</td>
					</tr>
					<tr>
						<th>사용여부 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" name="useYn" id="valueY" class="" checked="checked" value="Y" /> <label for="useY">사용</label>&nbsp;&nbsp;
							<input type="radio" name="useYn" id="valueN" class="" value="N" /> <label for="useN">미사용</label>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->

	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<span id="regButton" class="btn large focus">등록</span>
			<span id="modButton"class="btn large focus">수정</span>
			<span id="cnButton" class="btn large">취소</span>
			<span id="delButton" class="btn large">삭제</span>
		</div>
		<!-- e: 버튼-->
	</form:form>
</div>