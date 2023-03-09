<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
var checkIdYn = false;
$(document).ready(function(){
});

function insertAdmin() {
	
	if(!checkIdYn) {
		alert("아이디 중복확인을 해주세요.");
		return ;
	}
	if (formValidationCheck(['adminId', 'adminPw', 'adminRePw', 'adminName', 'adminMobileNum'])){
		if(!isTelNum($("#adminMobileNum").val())){
			$("#adminMobileNum").focus();
			return;
		}
		
		var adminPw = $("#adminPw").val();
		var adminRePw = $("#adminRePw").val();
		
		if(adminPw != adminRePw) {
			alert("비밀번호가 일치하지 않습니다.");
			return;
		}
		
		if(checkPassword(adminPw)) {
			$("#adminPwEnc").val(AES_Encode($("#adminPw").val()));
			$("#adminRePwEnc").val(AES_Encode($("#adminRePw").val()));
			$("#adminInsertForm").submit();
		}
	}
}


function checkPassword(password){
	
    var check = /^(?=.*[a-zA-Z])(?=.*[=+-_`~!@@#$%^&*|₩₩₩'₩";:₩/?])(?=.*[0-9]).{8,15}$/;
	if (!check.test(password)) {
		  alert("숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.");
		  return false;
	}

    var checkNumber = password.search(/[0-9]/g);
    var checkEnglish = password.search(/[a-z]/ig);
    var checkSc = password.search(/[=+-_`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
    
    if(checkNumber < 0 || checkEnglish < 0 || checkSc < 0) {
        alert("숫자,영문자,특수문자를 혼용하여야 합니다.");
        return false;
    }

    if(/(\w)\1\1\1/.test(password)) {
        alert("비밀번호에 같은 문자를 4번 이상 사용하실 수 없습니다.");
        return false;
    }
    
    var id = $.trim($("#adminId").val());
    if(password.search(id) > -1) {
        alert("아이디가 포함된 비밀번호는 사용하실 수 없습니다.");
        return false;
    }
    
    return true;
}


//미입력 항목 alert
function alertMessageSource(elId){
	alert("입력되지 않은 항목이 있습니다.");
}

// 중복확인
function checkAdminId() {
	if(isEmpty($("#adminId").val())) {
		alert("운영자 ID를 입력해주세요.");
		$("#adminId").focus();
		return;
	}
	
	$.ajax({
		url : "<c:url value='/admin/admin/checkAdminId.do' />"
		,data : {adminId : $("#adminId").val()}
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var result = data.result;
		if(result == 'Y') {
			alert("사용 가능한 아이디입니다.");
			$("#adminId").attr("readonly", true);
			checkIdYn = true;
		} else if(result == 'N') {
			alert("이미 존재하는 아이디입니다.");
		} else {
			alert("아이디 중복확인에 실패하였습니다.");
		}
	}).error(function(data) {
		alert("아이디 중복확인에 실패하였습니다.");
	});
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="adminInsertForm" name="adminInsertForm" method="POST" action="<c:url value='/admin/admin/insertAdmin.do' />" >
		<div class="main_top">
			<h2>운영자 등록</h2>
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
						<th>운영자 ID<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<div class="input_wrap">
								<input type="text" id="adminId" name="adminId" class="input w03"/>
								<a href="javascript:checkAdminId();"><span class="btn">중복 확인</span></a>
							</div>
						</td>
					</tr>
					<tr>
						<th>비밀번호<span class="imp">*</span></th>
						<td>
							<input type="password" id="adminPw" class="input w01"/>
							<input type="hidden" id="adminPwEnc" name="adminPw" class="input w01"/>
						</td>
						<th>비밀번호 확인<span class="imp">*</span></th>
						<td class="last">
							<input type="password" id="adminRePw" class="input w01"/>
							<input type="hidden" id="adminRePwEnc" name="adminRePw" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th>운영자 권한<span class="imp">*</span></th>
						<td class="last">
							<c:if test="${roleInfo ne null }">
							
							<select id="adminLevel" name="adminLevel" class="select w01" style="width:130px;">
								<c:forEach items="${roleInfo.list}" var="list" varStatus="status">
									<c:if test="${list.useYn eq 'Y' }">
										<c:if test="${list.roleId.toUpperCase() ne 'TOP' }">
											<c:choose>
												<c:when test="${status.index == 0}">
													<option value="${list.roleId}" selected="selected">${list.roleNm}</option>
												</c:when>
												<c:otherwise>
													<option value="${list.roleId}">${list.roleNm}</option>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:if>
								</c:forEach>
							</select>
							</c:if>
						</td>
						<th>사용여부<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" name="useYn" id="useY" class="" checked="checked" value="Y" /> <label for="useY">사용</label>&nbsp;&nbsp;
							<input type="radio" name="useYn" id="useN" class="" value="N" /> <label for="useN">미사용</label>
						</td>						
					</tr>
					<tr>
						<th>운영자 이름<span class="imp">*</span></th>
						<td>
							<input type="text" id="adminName" name="adminName" class="input w01"/>
						</td>
						<th>휴대폰 번호<span class="imp">*</span></th>
						<td class="last">
							<input type="text" id="adminMobileNum" name="adminMobileNum" class="input w01"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	

	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:insertAdmin();"><span class="btn large focus">등록</span></a>
			<a href="javascript:history.back();"><span class="btn large">취소</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
