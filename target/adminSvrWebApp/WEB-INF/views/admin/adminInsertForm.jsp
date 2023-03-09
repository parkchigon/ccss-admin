<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
var checkIdYn = false;
$(document).ready(function(){
	
	
	$("#eamilAddrPostText").hide();
	
	$("#emailAddrPost").change(function() { 
		var emailAddrPostValue = $("#emailAddrPost").val();
		if(emailAddrPostValue =='directly'){
			$("#eamilAddrPostText").empty();
			$("#eamilAddrPostText").show();
		}else{
			$("#eamilAddrPostText").empty();
			$("#eamilAddrPostText").hide();
		}
	});
	
	
});

function insertAdmin() {
	//Email Check
	var eamilAddrPostText = $("#eamilAddrPostText").val();
	var emailAddrPastValue = $("#emailAddrPost").val();
	var emailAddrPre = $("#emailAddrPre").val();
	var completeEmailAddr;
	var ipAddr = $("#ipAddr").val();
	
	//console.log("ipAddr:",ipAddr);
	
	if(emailAddrPastValue =='directly'){
		completeEmailAddr = emailAddrPre + "@" + eamilAddrPostText;
	}else{
		completeEmailAddr = emailAddrPre + "@" + emailAddrPastValue;
	}	
	$("#emailAddr").val(AES_Encode(completeEmailAddr));

	if(!checkIdYn) {
		alert("아이디 중복확인을 해주세요.");
		return ;
	}
	if (formValidationCheck(['mngrId', 'passWd', 'passWdRe', 'mngrNm', 'clphNo','emailAddr'])){
		if(!isTelNum($("#clphNo").val())){
			$("#clphNo").focus();
			return;
		}
		
		var adminPw = $("#passWd").val();
		var adminRePw = $("#passWdRe").val();
		
		 if(adminPw != adminRePw) {
			alert("비밀번호가 일치하지 않습니다.");
			return;
		}
		 
		$("#mngrIdEnc").val(AES_Encode($("#mngrId").val())); 
		$("#mngrNmEnc").val(AES_Encode($("#mngrNm").val())); 
		$("#clphNoEnc").val(AES_Encode($("#clphNo").val())); 
		
		console.log("0ipAddr.length:",ipAddr.length);
		//Ip check
		if( ipAddr != null  && ipAddr.length > 0){
			console.log("1ipAddr.length:",ipAddr.length);
			if(!checkIP(ipAddr)){
				alert("Ip 형식이 올바르지 않습니다.");
				$("#ipAddr").focus();
				return;
			}	
		}else{
			console.log("1ipAddr:",ipAddr);
		}
		if(!checkEmail(completeEmailAddr)){
			alert("이메일 주소 형식이 올바르지 않습니다.");
			$("#emailAddrPre").focus();
			return false;
		}
		
		if(checkPassword(adminPw)) {
			$("#passWdEnc").val(AES_Encode($("#passWd").val()));
			$("#passWdEncRe").val(AES_Encode($("#passWdRe").val()));
			
			$.ajax({
				url : "<c:url value='/admin/insertAdmin.do'/>"
				,data : $("#adminInsertForm").serialize()
				,dataType : 'json'
				,type : "POST"
			}).done(function(data) {
				var result = data.result;
				if(result == "Y") {
					alert("정상적으로 등록이 완료 되었습니다.");
					location.href = "<c:url value='/admin/adminListForm.do' />";
				
				} else if(result== "N") {
					alert(data.sayMessage);
				}else {
					alert("수정에 실패하였습니다.");
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


function checkPassword(password){
	
    var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9])(?=.*[0-9]).{8,15}$/;
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

   
	if(/(\w)\1\1/.test(password)) {
        alert("비밀번호에 같은 문자를 3번 이상 사용하실 수 없습니다.");
        return false;
    }
    var id = $.trim($("#mngrId").val());
   
    if(password.indexOf(id) > -1) {
        alert("아이디가 포함된 비밀번호는 사용하실 수 없습니다.");
        return false;
    }
    
    var ctn = $.trim($("#clphNo").val());  
    if(password.indexOf(ctn) > -1) {
        alert("전화번호가 포함된 비밀번호는 사용하실 수 없습니다.");
        return false;
    }
    return true;
}


//미입력 항목 alert
function alertMessageSource(elId){
	console.log(elId);
	alert("입력되지 않은 항목이 있습니다.");
}

// 중복확인
function checkAdminId() {
	if(isEmpty($("#mngrId").val())) {
		alert("운영자 ID를 입력해주세요.");
		$("#mngrId").focus();
		return;
	}
	
	$.ajax({
		url : "<c:url value='/admin/checkAdminId.do' />"
		,data : {mngrId : $("#mngrId").val()}
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var result = data.result;
		if(result == 'Y') {
			alert("사용 가능한 아이디입니다.");
			$("#mngrId").attr("readonly", true);
			checkIdYn = true;
		} else if(result == 'N') {
			alert("이미 존재하는 아이디입니다.");
		} else {
			alert("아이디 중복확인에 실패하였습니다.");
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


function checkIP(strIP) {
	 var expIp = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
	 return expIp.test(strIP);
}

function checkEmail(strEmail) {
	 var expEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	 return expEmail.test(strEmail);
}

function notAvailableSpecialChar(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9-_.]/g,""));
	}); 
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="adminInsertForm" name="adminInsertForm" method="POST" action="<c:url value='/admin/insertAdmin.do' />" >
		<input type="hidden" id="emailAddr" name="emailAddr" />
			
		<!--[Fortify] Cross-Site Scripting: Reflected -->
		<input type="hidden" id="regId" name="regId" value ="<c:out value='${USER_INFO.mngrId}'/>"/>
		<input type="hidden" id="updId" name="updId" value ="<c:out value='${USER_INFO.mngrId}'/>"/>
				
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
								<input onkeydown="notAvailableSpecialChar(this)" autocomplete="off" type="text" id="mngrId" class="input w03"/>
								<input  type="hidden" id="mngrIdEnc" name="mngrId" class="input w03"/>
								<a href="javascript:checkAdminId();"><span class="btn">중복 확인</span></a>
							</div>
						</td>
					</tr>
					<tr>
						<th>운영자 이름<span class="imp">*</span></th>
						<td>
							<input onkeydown="notAvailableSpecialChar(this)" autocomplete="off" type="text" id="mngrNm"class="input w01"/>
							<input  type="hidden" id="mngrNmEnc" name="mngrNm" class="input w01"/>
						</td>
						<th>전화 번호<span class="imp">*</span></th>
						<td class="last">
							<input autocomplete="off" type="text" id="clphNo"  class="input w01"/>
							<input type="hidden" id="clphNoEnc" name="clphNo" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th>비밀번호<span class="imp">*</span></th>
						<td>
							<input autocomplete="off" type="password" id="passWd" class="input w01"/>
							<input type="hidden" id="passWdEnc" name="passWd" class="input w01"/>
						</td>
						<th>비밀번호 확인<span class="imp">*</span></th>
						<td class="last">
							<input autocomplete="off" type="password" id="passWdRe" class="input w01"/>
							<input type="hidden" id="passWdEncRe" name="passWdRe" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th>운영자 권한<span class="imp">*</span></th>
						<td class="last">
							<c:if test="${roleInfo ne null }">
							
							<select id="mngrLevel" name="mngrLevel" class="select w01" style="width:130px;">
								<c:forEach items="${roleInfo.list}" var="list" varStatus="status">
									<c:if test="${list.useYn eq 'Y' }">
										<c:if test="${list.mngrGrpId.toUpperCase() ne 'TOP' }">
											<c:choose>
												<c:when test="${status.index == 0}">
														<option value="${list.mngrGrpId}" selected="selected">${list.grpNm}</option>
												</c:when>
												<c:otherwise>
													<option value="${list.mngrGrpId}">${list.grpNm}</option>
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
						<th>아이피<span class="imp"></span></th>
						<td>
							<input type="text" id="ipAddr" name ="ipAddr" value=""  class="input w01"/>
						</td>
						<th>계정상태<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" name="accountStatus" id="accountStatus" class="" checked="checked" value="1" /> <label for="useY">활성화</label>&nbsp;&nbsp;
							<input type="radio" name="accountStatus" id="accountStatus" class="" value="3" /> <label for="useN">비활성화</label>
							<input type="radio" name="accountStatus" id="accountStatus" class="" value="2" /> <label for="useN">계정잠김</label>
							<input type="radio" name="accountStatus" id="accountStatus" class="" value="4" /> <label for="useN">비밀번호잠김</label>
						</td>
					</tr>
					<tr>
						<th>이메일<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" id="emailAddrPre" class="input w01"  style="width: 150px;"/>@
							<select  id="emailAddrPost" name="emailAddrPost" class="select w01"style="width: 130px;">
									<option value="" selected="selected">선택▼</option>
									<option value="lguplus.co.kr">lguplus.co.kr</option>
									<option value="nate.com">nate.com</option>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gamil.com">gamil.com</option>
									<option value="directly">직접입력</option>
							</select>
							<input type="text" autocomplete="off" id="eamilAddrPostText" name="eamilAddrPostText" class="input w01" style="width: 150px;"/>
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
