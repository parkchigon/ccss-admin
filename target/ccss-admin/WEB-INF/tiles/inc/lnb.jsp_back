<%@page import="com.lgu.ccss.common.utility.StringUtil"%>
<%@page import="com.lgu.ccss.common.utility.JsonUtil"%>
<%@page import="com.fasterxml.jackson.annotation.JsonUnwrapped"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/import.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<script>
$(document).ready(function() {
	var currentUrl = window.location.href;
	$(".depth03 > li").each(function(index) {
		var url = $(this).children("a").attr("href");
		if(currentUrl.indexOf(url) > -1) {
			 $(this).parent("ul").addClass("on");
		}
	});
});

</script>


<%!
	public String getSubMenu(HashMap menuMap, Object[] programList, String menuId, String idx) {
	    String subMenuHtml = "";
	    ArrayList subNodeList = (ArrayList)menuMap.get("subNodeList");
        boolean currentMenuYN = false;
        
	    for( int i = 0; i < subNodeList.size(); i++ )
	    {
	        HashMap _menuMap = (HashMap)subNodeList.get( i );
	        if( i == 0 ){
	            /* subMenuHtml = "<ul class='depth0" + idx + "'>\n"; */
	            //subMenuHtml = "<ul class='depth03'>\n";
	        }
	        String menuOn = "";
	        if(_menuMap.get("menuId").equals(menuId)){
	        	menuOn = "class='on'";
	        	currentMenuYN = true;
	        }
	        if( i != subNodeList.size() - 1 ){
	            subMenuHtml += "<li><a " + menuOn + " href=\"" + getMenuUrl( _menuMap, programList ) + "\">" + _menuMap.get("menuNm") + "</a></li>\n";
	        }
	        else{
	            subMenuHtml += "<li><a " + menuOn + " href=\"" + getMenuUrl( _menuMap, programList ) + "\">" + _menuMap.get("menuNm") + "</a></li>\n</ul>\n";
	        }
	    }
	    
	    if(subNodeList.size() > 0) {
		    if(currentMenuYN) {
		    	subMenuHtml = "<ul class='depth03 on'>\n" + subMenuHtml;
		    } else {
		    	subMenuHtml = "<ul class='depth03'>\n" + subMenuHtml;
		    }
	    }
		return subMenuHtml;
	}
	
%>



<!-- s: LEFT contents-->
<div class="left_wrap">
	<div class="lnb_wrap">
		<h2><%= _leftMenuTopTitle %></h2>
		<ul class="depth02">
<%
	/** 1depth*/
	ArrayList _selectMenuList = (ArrayList)_selectTopMenuMap.get("subNodeList");
	StringBuilder locationHref = new StringBuilder();// 메뉴 Location 표시
	
	if( _selectMenuList != null )
	{
		for( int j = 0; j < _selectMenuList.size(); j++ )
		{
			HashMap _subMenuMap = (HashMap)_selectMenuList.get( j );
			String _currMenuId = String.valueOf(_subMenuMap.get("menuId"));
			/** 2depth */
			String menuOn = "";
			if(_menuPath.indexOf(_currMenuId) > -1){
				menuOn = "class='on'";
			}
			out.println( "<li><a href=\"" + getMenuUrl( _subMenuMap, _objProgramList ) + "\" "+ menuOn + " alt=\"" + _subMenuMap.get("menuNm") + "\">" + _subMenuMap.get("menuNm") + "</a>" + getSubMenu( _subMenuMap, _objProgramList, _menuId, menuIdx + "") + "</li>\n" );
		}
	}
	  
%>		
		</ul>
	</div>
</div>
<!-- e: LEFT contents-->
