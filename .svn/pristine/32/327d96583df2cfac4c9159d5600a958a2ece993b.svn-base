<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
	var agent = navigator.userAgent.toLowerCase();
	var time2;
	var authExprYn = false;
	var refreshIntervalId;

	$(document).ready(function(){
		if (agent.indexOf("chrome") == -1) {
			alert("커넥티드카 Admin Web Page는 크롬 브라우저에 최적화 되어 있습니다");
			return false;
		}

		$("#admin").focus();
		
		var userInputId = getCookie("userInputId");
		$("input[name='mngrId']").val(userInputId).focus();
		
		if($("input[name='mngrId']").val() != ""){
		$("#idSaveCheck").attr("checked", true);
		}
		
		$("#idSaveCheck").change(function(){
			if($("#idSaveCheck").is(":checked")) {
				var userInputId = $("input[name='mngrId']").val();
				setCookie("userInputId", userInputId, 7);
			} else {
				deleteCookie("userInputId");
			}
		});
		
		
		$("input[name='adminId']").keyup(function(){
			if($("#idSaveCheck").is(":checked")) {
			var userInputId = $("input[name='mngrId']").val();
			setCookie("userInputId", userInputId, 7);
			}
		});
		
		
		
		
	});
	

	function checkLogin(){
		var valChk = true;
		$("#mngrId, #passWd").each(function() {
			if($.trim($(this).val()) == ""){
				$(this).attr("placeholder", "필수항목입니다.").focus();
				valChk = false;
				return;
			}
		});
		
		
		if(valChk) {
			excuteLogin();	
		}
	}
	

	function excuteLogin(){
		$.ajax({
			url : "/admin/login/excuteLogin.do"
			, type: "post"
			, dataType : "json"
			,data: { 
					  mngrId : AES_Encode($("#mngrId").val())
					, passWd : AES_Encode($("#passWd").val())
	 		}  
		}).done(function(data) {
			if (data.result == "NU") {
				alert("잘못된 인증입니다.");
				$("#mngrId").focus();
			} else if (data.result == "Y") {
				
				if(data.login_info.resultType == "FAIL_ACCOUNT_LOCK") {
					alert("계정상태가 비밀번호 잠김 상태입니다.\n 관리자에게 문의 해주세요.");
					return;
				}if(data.login_info.resultType == "FAIL_ACCOUNT_TWO_MONTH_LOCK") {
					alert("2달간 계정을 사용을 하지 않아 계정이 사용 정지 되었습니다.\n 관리자에게 문의 해주세요.");
					return;
				}
				else if(data.login_info.resultType == "FAIL_ACCOUNT_DISABLED"){
					alert("계정상태가 비활성화 상태입니다.\n 관리자에게 문의 해주세요.");
					return;
				}else if(data.login_info.resultType == "FAIL_ACCOUNT_PWD_LOCK"){
					alert("계정상태가 비밀번호 잠김 상태입니다.\n 관리자에게 문의 해주세요.");
					return;
				}else if(data.login_info.resultType == "PASSWORD_EXPIRED") {
					alert("비밀번호 사용 기간이 만료되었습니다.\n비밀번호를 변경해야 서비스 이용이 가능 합니다.");
					$(".dimmed").show();
					$("#confirmPassWordChgPopup").show();
					return;
				}else if(data.login_info.resultType == "FAIL_ACCOUNT_LOCK_INFO"){
					alert("비밀번호를 5회 잘못 입력 하여 로그인이 불가합니다.");
					return;
					
				}else if(data.login_info.resultType == "FAIL_COUNT_NOT_OVER"){
					alert("잘못된 인증입니다.");
					return;
					
				}else if(data.login_info.resultType == "FAIL_ACCOUNT_CHG_PWD"){
					$(".dimmed").show();
					$("#confirmPassWordChgPopup").show();
					return;
				}else if(data.login_info.resultType == "UN_USED_ID"){
					alert("현재 사용중인 계정이 아닙니다.\n 관리자에게 문의 해주세요.");
					return;
				}else{
					
				}
				location.href = data.redirectUrl;
			} else {
				alert("서버 내부 오류");
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
	
	function setCookie(cookieName, value, exdays){
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}
	 
	function deleteCookie(cookieName){
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
	 
	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if(start != -1){
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if(end == -1)end = cookieData.length;
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
		
	function confirmPassWordChg(){
		
			if (formValidationCheck(['oldSecrNo', 'newSecrNo', 'checkNewSecrNo'])){
			var oldSecrNo = $("#oldSecrNo").val();
			var newSecrNo = $("#newSecrNo").val();
			var checkNewSecrNo = $("#checkNewSecrNo").val();
			
			if(newSecrNo != checkNewSecrNo) {
				$("#newSecrNo").focus();
				alert("변경 할 비밀번호가 일치하지 않습니다.");
				return;
			}
			
			if(checkPassword(newSecrNo)) {
				$("#oldSecrNoEnc").val(AES_Encode(oldSecrNo));
				$("#newSecrNoEnc").val(AES_Encode(newSecrNo));
				
				updateAdminPwd();
				
			}
		}
	}

	function updateAdminPwd() {
			$.ajax({
				url : "/admin/login/updateAdminPwd.do"
				, type: "post"
				, dataType : "json"
				, data: { 
							mngrId : $("#mngrId").val()
							, oldSecrNoEnc : $("#oldSecrNoEnc").val() 
							, newSecrNoEnc : $("#newSecrNoEnc").val()
					}
			}).done(function(data) {
				if (data.result == "N") {
					alert("현재 비밀번호가 일치 하지 않습니다.");
					$("#oldSecrNoEnc").focus();
					return;
				} else if (data.result == "Y") {
					alert("비밀번호가 변경 되었습니다. 로그인 페이지로 이동합니다.");					
					location.href = data.redirectUrl;
				} else if(data.result == "F") {
					alert("비밀번호 변경에 실패 하였습니다. 최고 관리자에게 문의 해주세요.");
					return;
				} else if(data.result == "B") {
					alert("비정상 적인 요청입니다");
				}else{
					alert("에러남");
				}
			}).error(
					function(request, status, error) {
						if (request.status == 401) {
							alert("해당 권한이 없습니다.");
						} else {
							console.log("서버 내부 오류 발생", "code:" + request.status
									+ "\n" + "message:" + request.responseText
									+ "\n" + "error:" + error);
							if(request.status ==200){
								location.href = "<c:url value='/login/loginView.do' />";
							}
						}
			});
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
	    return true;
	}

	function alertMessageSource(elId){
		alert("입력되지 않은 항목이 있습니다.");
	}

</script>
<!--s: header -->
<div class="header_container">
	<div class="header_inner">
		<div class="header_top">
			<h1 class="logo center"></h1>
		</div>
	</div>
</div>
<!--e: header -->

<!-- s: login -->
<div class="login_form_wrap">
	<div class="login_form_in_wrap">
		<div class="login_form">
			<div class="userlogin_form">
				<h1 class="logo"><a href="#"><img src="<c:url value='/resources/common/images/logo.png' />" /></a></h1>
				<p style="font-size: 14px;"> LG U+ 커넥티드카 관리자 서비스에 오신것을 환영합니다.</p>
				<p style="font-size: 11px;"> 본 사이트는 운영자 전용 페이지입니다. 담당자 외에는 접근을 금지합니다.</p>
				<div class="detail">
					<div class="user">
						<input type="text"  class="input w01" autocomplete="off" placeholder="ID" id="mngrId" name="mngrId" onkeydown="if(event.keyCode==13) checkLogin();"/>
						<input type="password"  class="input w01" autocomplete="off" placeholder="PASSWORD" onkeydown="if(event.keyCode==13) excuteLogin();" id="passWd" name="passWd" />
					</div>
					<div class="btn_login">
						<a href="javascript:checkLogin();"><img src="<c:url value='/resources/common/images/btn_login.png" alt="Login' />"/></a>
					</div>
					<div class="login_sub">
						<a href ="/admin/login/findIdView.do"><label for="">아이디 찾기</label></a>
						&nbsp;&nbsp;
					</div>
					<br />
				</div>
			</div>
		</div>
	</div>
</div>
<!-- e: login -->

<body class="jui">
		<!--[if lt IE 11]>
			<div class="underIE9">커넥 티드가 Admin Web Page는 크롬에 최적화 되어 있습니다.<br/>크롬 브라우져를 사용해주세요.</div>
		<![endif]-->
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="confirmPassWordChgPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 300px">
			<div class="p_header">
				<h1>비밀번호 변경</h1>
				<p style="font-size: 11px; color:white;"> 비밀번호를 변경 해야만 서비스 이용이 가능합니다.</p>
				<a href="javascript:$('#confirmPassWordChgPopup').hide(); $('.dimmed').hide();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
							<h2>*현재 비밀번호</h2>
							<input type="password" autocomplete="off" class="input w01" placeholder="PASSWORD" id="oldSecrNo" name="oldSecrNo" onkeydown="if(event.keyCode==13) confirmPassWordChg();" />
							<h2>*변경 비밀번호</h2>
							<input type="password" autocomplete="off" class="input w01" placeholder="PASSWORD" id="newSecrNo" name="newSecrNo" onkeydown="if(event.keyCode==13) confirmPassWordChg();" />
							<h2>*변경 비밀번호 확인</h2>
							<input type="password" autocomplete="off" class="input w01" placeholder="PASSWORD" onkeydown="if(event.keyCode==13) confirmPassWordChg();" id="checkNewSecrNo" name="checkNewSecrNo" style="margin-top: 5px"/>
							
							<input type="hidden" id="oldSecrNoEnc" name="oldSecrNoEnc" class="input w01"/>
							<input type="hidden" id="newSecrNoEnc" name="newSecrNoEnc" class="input w01"/>

						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:confirmPassWordChg();">확인</span>
					</div>
					<!-- e: btn -->

				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
</body>