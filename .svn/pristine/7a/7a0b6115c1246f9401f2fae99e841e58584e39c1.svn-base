<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/include/import.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title> LG U+ CCSS Admin </title>

    <tiles:insertAttribute name="css" />
    <tiles:insertAttribute name="script" />
    
	<script type="text/javascript">
	// <![CDATA[
	    // 공통으로 사용될 스크립트
		// [Fortify] Cross-Site Scripting: Reflected
		var scriptDateFormat = "<c:out value='${ServiceConfig.FORMAT_DATE}'/>";
		var loginPage = "<c:out value='${ServiceConfig.SERVICE_LOGIN_PAGE}'/>";
		
		$(document).ready(function(){
			var menuNavi = $('#menuNavi').text() ;
			var arr = menuNavi.split('>');
			var totalsize = arr.length;
			
			var editMenu = "";
			for(i=0; i<totalsize; i++){
				
				var currMenuNm = menuNavi.split('>')[i];
				if(i == totalsize - 1){
					currMenuNm = "<strong>" + currMenuNm + "</strong>";					
				}
				editMenu = editMenu + " > " + currMenuNm;
			}
			$('#menuNavi').html(editMenu);
			
			chkGnbFn();
		});
		
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
					<!-- s: left content -->
				<%-- 	<div class="main_top">
						<%@ include file="inc/location.jsp" %>
					</div> --%>
					<%@ include file="inc/lnb.jsp" %>
					<!-- e: left content -->
					<!-- s: main content -->
					<tiles:insertAttribute name="content" />
				</div>
			</div>
			<!-- e: main content -->
		</div>
	</div>
	<!-- e: body container -->
	<!-- s: popup containers -->
	<%@ include file="popupTiles.jsp" %>
	<!-- e: popup containers -->
	<!-- s: footer container -->
	<%@ include file="inc/footer.jsp" %>
	<!-- e: footer container -->
</body>
</html>