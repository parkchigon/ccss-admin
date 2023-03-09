<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title> LG U+ </title>

    <tiles:insertAttribute name="css" />
    <tiles:insertAttribute name="script" />
	<script type="text/javascript">
	// <![CDATA[
	    // 공통으로 사용될 스크립트
		var scriptDateFormat = "<%= ServiceConfig.FORMAT_DATE %>";
		
		var loginPage = "<%= ServiceConfig.SERVICE_LOGIN_PAGE %>";
		
		$(document).ready(function(){
		});
		
	// ]]>
	</script>    
    
    
    
    
</head>
<body class="jui"> 
	<!-- s: header container -->
	<%@ include file="inc/head.jsp" %>
	<!-- e: header container -->
	<!-- s: body_contents-->
	<div class="body_container">
		<div class="body_inner">
			<!-- s: main_contents-->	
			<div class="main_contents">
				<div class="container_wrap">
					<!-- s: main content -->
					<tiles:insertAttribute name="content" />
				</div>
			</div>
			<!-- e: main content -->
		</div>
	</div>
	<!-- e: body container -->
	<!-- s: footer container -->
	<%@ include file="inc/footer.jsp" %>
	<!-- e: footer container -->
</body>
</html>