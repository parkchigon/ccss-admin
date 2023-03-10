<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/tiles/script.jsp" %>
<%@include file="/WEB-INF/tiles/css.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>LG U+</title>
		<script type="text/javaScript">
			 setTimeout(function(){history.back();}, 5000);
		</script>
	</head>	
	<body class="jui">
		<!--[if lt IE 9]>
			<div class="underIE9">오래된 브라우저를 사용하는 것은 컴퓨터를 안전하지 않게 만듭니다.<br>업그레이드 또는 더 좋은 인터넷 경험을 위해 크롬을 사용하세요.</div>
		<![endif]-->
		
		<!--s: header -->
		<div class="header_container">
			<div class="header_inner">
				<div class="header_top">
					<h1 class="logo center"><a href="#">LG U+</a></h1>
				</div>
			</div>
		</div>
		<!--e: header -->

		
		<!-- s: body_contents-->
		<div class="body_container">
			<div class="body_inner">
				
				<!-- s: main_contents-->	
				<div class="main_contents">
					<div class="container_wrap">
						<div class="error_wrap">
							<h2></h2>
							<h3>해당 메뉴 및 기능 수행에 대한 권한이 없습니다.(5초후 이전 페이지로 돌아갑니다.)</h3>
							<!-- [Fortify] Cross-Site Scripting: Reflected	-->
							<div class="error_txt">사용중인 <c:out value='${USER_INFO.mngrId}'/> 에 대한 해당 메뉴 진입에 대한 권한이 없습니다.<br />관리자에게 문의하세요.</div>
						</div>
						
					</div>
				</div>
				<!-- e: main_contents-->
			</div>
		</div>	
		<!-- e: body_contents-->
		
		<!-- s: footer container -->
		<%@ include file="/WEB-INF/tiles/inc/footer.jsp" %>
		<!-- e: footer container -->
	</body>
</html>