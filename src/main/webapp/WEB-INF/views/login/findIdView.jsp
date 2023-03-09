<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">

	$(document).ready(function(){
	
	
	
	});
	
	
	
	
	
	// validation check
	function checkFindId(){
		var valChk = true;
		$("#mngrNm, #emailAddr").each(function() {
			if($.trim($(this).val()) == ""){
				$(this).attr("placeholder", "필수항목입니다.").focus();
				valChk = false;
				return;
			}
		});
		
		// 아이디/비밀번호 확인
		if(valChk) {
			excuteFindId();	
		}
	}
	
	// ID 찾기 처리
	function excuteFindId(){
		$.ajax({
			url : "/admin/login/excuteFindId.do"
			, type: "post"
			, dataType : "json"
			
			,data: { 	mngrNm :  AES_Encode($("#mngrNm").val())
					  , emailAddr : AES_Encode($("#emailAddr").val()) //이메일 경우 AES 128로 암화화 하여 서버로 전송
		}  
		}).done(function(data) {
			console.log(data);
			if (data.result == "NU") {
				alert("등록된 정보가 없습니다.");
				$("#mngrNm").focus();
			} else if (data.result == "Y") {
				
				alert("해당 사용자 ID는 : "+ data.mngrId + " 입니다.");
				location.href = "/admin/login/loginView.do";
			} else if(data.result == "N") {
				alert("입력 하신 정보가 일치 하지 않습니다.");
				$("#mngrNm").focus();
			
			} else {
				alert("에러남");
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
				<h1 class="logo"><a href="/admin/admin/loginView.do"><img src="<c:url value='/resources/common/images/logo.png' />" /></a></h1>
				<p style="font-size: 14px;"> LG U+ 커넥티드카 관리자 서비스에 오신것을 환영합니다.</p>
				<p style="font-size: 11px;"> 본 사이트는 운영자 전용 페이지입니다. 담당자 외에는 접근을 금지합니다.</p>
				<div class="detail">
					<div class="user">
						<input type="text" class="input w01" placeholder="이름" id="mngrNm" name="mngrNm" onkeydown="if(event.keyCode==13) checkFindId();"/>
						<input type="text" class="input w01" placeholder="E-MAIL" onkeydown="if(event.keyCode==13) excuteFindId();" id="emailAddr" name="emailAddr" />
					</div>
					<div class="btn_login">
						<a href="javascript:checkFindId();"><img src="<c:url value='/resources/common/images/btn_find_id.png" alt="아이디 찾기' />"/></a>
					</div>
					<br />
				</div>
			</div>
		</div>
	</div>
</div>
<!-- e: login -->