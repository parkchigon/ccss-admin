<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">

	var time1;
	var time2;
	var authExprYn = false; // 인증번호 만료여부
	var refreshIntervalId;

	$(document).ready(function(){
		
		var userInputId = getCookie("userInputId");
	    $("input[name='mngrId']").val(userInputId).focus();
	     
	    if($("input[name='mngrId']").val() != ""){
	        $("#idSaveCheck").attr("checked", true);
	    }
	    
	    $("#idSaveCheck").change(function(){
	        if($("#idSaveCheck").is(":checked")) {
	            var userInputId = $("input[name='mngrId']").val();
	            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
	        } else {
	            deleteCookie("userInputId");
	        }
	    });
	     
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우 쿠키 저장
	    $("input[name='adminId']").keyup(function(){
	        if($("#idSaveCheck").is(":checked")) {
	            var userInputId = $("input[name='mngrId']").val();
	            setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
	        }
	    });
		
		// 재전송 버튼 클릭
		$("#reAuthBtn").click(function() {
			// TODO 로그인 시 SMS전송 로직 추가 필요
			authExprYn = false;
			clearInterval(refreshIntervalId);
			var date2 = new Date();
			time1 =  date2.getTime();
			time2 = new Date(Date.parse(date2) + 60000); // 180초 뒤
			getTime();
		});
		
	});
	
	// 인증번호 만료시간 타이머 start
	function startTimer() {
		refreshIntervalId = setInterval(getTime, 1000);
		var date = new Date();
		time1 = date.getTime();
		time2 = new Date(Date.parse(date) + 60000); // 180초 뒤
	}
	
	// 인증번호 만료시간 실시간노출
	function getTime() { 
		var now = new Date(); 
		var gap = Math.round((time2 - now) / 1000);
		if(gap < 0) {
			alert("인증번호를 재발급 받으세요.");
			authExprYn = true;
			clearInterval(refreshIntervalId);
		} else {
			var D = Math.floor(gap / 86400);
		    var H = Math.floor((gap - D * 86400) / 3600 % 3600);
		    var M = Math.floor((gap - H * 3600) / 60 % 60);
		    var S = Math.floor((gap - M * 60) % 60);

			$("#counter").text(M + " : " + S);
		}
	} 
	
	// validation check
	function checkLogin(){
		var valChk = true;
		$("#mngrId, #secrNo").each(function() {
			if($.trim($(this).val()) == ""){
				$(this).attr("placeholder", "필수항목입니다.").focus();
				valChk = false;
				return;
			}
		});
		
		// 아이디/비밀번호 확인
		if(valChk) {
			excuteLogin();	
		}
	}
	
	// 인증번호 체크
	function checkAuthNo() {
		if(!authExprYn) { // 인증번호 확인
			$.ajax({
		        url : "/admin/login/checkAuthNo.do"
		        , type: "post"
		        , dataType : "json"
		        , data: { mngrId : $("#mngrId").val()
	        		  	  , secrNo : AES_Encode($("#secrNo").val()) //비밀번호의 경우 AES 128로 암화화 하여 서버로 전송
		        		  , smsCertiNo : $("#smsCertiNo").val() }
		    }).done(function(data) {
				if (data.result == "N") {
					alert("인증번호가 잘못되었습니다.");
					$("#smsCertiNo").focus();
				} else if (data.result == "Y") {
					alert("인증번호가 확인되었습니다.");					
					location.href = data.redirectUrl;
				} else {
					alert("에러남");
				}
			});
		} else { // 인증번호만료
			alert("인증번호가 만료되었습니다. 재전송 버튼을 눌러주세요.");
		}
	}
	
	// 로그인처리
	function excuteLogin(){
		$.ajax({
			//  url : "/admin/login/excuteLogin.do"
			url : "/admin/login/excuteLogin.do"
			, type: "post"
			, dataType : "json"
		
	        ,data: { mngrId : $("#mngrId").val()
	        		  , secrNo : AES_Encode($("#secrNo").val()) //비밀번호의 경우 AES 128로 암화화 하여 서버로 전송
	        }  
	    }).done(function(data) {
	    	console.log(data);
			if (data.result == "NU") {
				alert("아이디 또는 비밀번호가 잘못 입력되었습니다.");
				$("#mngrId").focus();
			} else if (data.result == "Y") {
				if(data.login_info.resultType == "FAIL_ACCOUNT_LOCK") {
					alert("계정상태가 비밀번호 감김 상태입니다.\n최고 관리자에게 문의 해주세요.");
					return;
					
				} else if(data.login_info.resultType == "PASSWORD_EXPIRED") {
					alert("비밀번호 사용 기간이 만료되었습니다.\n최고 관리자에게 문의 해주세요.");
					return;
					
				}else if(data.login_info.resultType == "FAIL_ACCOUNT_LOCK_INFO"){
					alert("비밀번호를 5회 잘못 입력 하여 로그인이 불가합니다.");
					return;
					
				}else if(data.login_info.resultType == "FAIL_COUNT_NOT_OVER"){
					alert("비밀번호가 다릅니다. 오류 횟수 :" + data.login_info.loginFailCount);
					return;
					
				}else{
					//Nothing
				}
				
				// TODO 로그인 시 SMS전송 로직 추가 필요
				//$("#adminId, #adminPw").attr("readonly", true);
				//$("#smsCertiNoDiv").show();
				//startTimer();
				//excuteLogin();
				
				// SMS 인증없이 로그인 
				location.href = data.redirectUrl;
			} else {
				alert("에러남");
			}
		}).error(function(data) {
			alert("에러남");
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
						<input type="text" class="input w01" placeholder="ID" id="mngrId" name="mngrId" onkeydown="if(event.keyCode==13) checkLogin();"/>
						<input type="password" class="input w01" placeholder="PASSWORD" onkeydown="if(event.keyCode==13) excuteLogin();" id="secrNo" name="secrNo" />
					</div>
					<div class="btn_login">
						<a href="javascript:checkLogin();"><img src="<c:url value='/resources/common/images/btn_login.png" alt="Login' />"/></a>
					</div>
					<div class="login_sub">
						<input type="checkbox" id="idSaveCheck"/> <label for="idSaveCheck">아이디 기억하기</label>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href ="/admin/login/findIdView.do"><label for="">아이디 찾기</label></a>
						&nbsp;&nbsp;/&nbsp;&nbsp;
						<a href ="/admin/login/findPwdView.do"><label for="">비밀번호 찾기</label></a>
					</div>
					<br />
					<!-- <div class="login_sub" id="smsCertiNoDiv" style="display:none">
						<input type="text" class="input w01" id="smsCertiNo" name="smsCertiNo" onkeydown="if(event.keyCode==13) checkAuthNo();"  style="width: 130px;"/>
						<a href="javascript:checkAuthNo();"><span class="btn">인증번호확인</span></a>
						<a href="javascript:checkLogin();"><span class="btn" id="reAuthBtn">재전송</span></a>&nbsp;&nbsp;
						<span style="font: bold 12px Gulim; color: #000" id="counter"></span>
					</div> -->
				</div>
			</div>
		</div>
	</div>
</div>
<!-- e: login -->