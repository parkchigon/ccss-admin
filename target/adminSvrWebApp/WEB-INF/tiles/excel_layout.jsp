<%@ page language="java" contentType="application/vnd.ms-excel; name='excel', text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>   
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	java.text.DateFormat df = new java.text.SimpleDateFormat("yyyyMMdd");
	String type = (String)request.getAttribute("type");
	String filename = type + "_" + df.format(new java.util.Date()) + ".xls";
	String excel_name = new String(filename.getBytes("KSC5601"),"8859_1");
	response.setHeader("Content-Disposition", "attachment;filename="+excel_name);
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel;charset=utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
	<title> LGU+ CCSS</title>
	<meta name="generator" content="editplus" />
	<meta name="author" content="" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="/resources/js/jquery-1.10.0.min.js"></script>
	
	<script type="text/javascript" src="/resources/js/jquery-ui.js"></script>  
	<script type="text/javascript" src="/resources/js/ui.js"></script>  
	<script type="text/javascript" src="/resources/js/jquery.monthpicker-0.1.js"></script>
	<script type="text/javascript" src="/resources/js/parseParam.js"></script>
</head>
<body>

	<div> 
		<tiles:insertAttribute name="body" />
	</div>

</body>

</html>
