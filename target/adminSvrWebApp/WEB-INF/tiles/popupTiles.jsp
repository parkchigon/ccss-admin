<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

	<!-- URL에 따라 필요한 레이어 팝업 붙이기 -->
    <c:if test="${fn:indexOf(requestScope['javax.servlet.forward.request_uri'], 'cateListView') > -1}">
		<%@ include file="/WEB-INF/views/common/popup/keywordSearchPopup.jsp"%>
		<div class="dimmed" style="display: none;"></div>
    </c:if>
    
    <c:if test="${fn:indexOf(requestScope['javax.servlet.forward.request_uri'], 'keyword/listView') > -1}">
		<%@ include file="/WEB-INF/views/common/popup/keywordEditPopup.jsp"%>
		<div class="dimmed" style="display: none;"></div>
    </c:if>
    
    <c:if test="${fn:indexOf(requestScope['javax.servlet.forward.request_uri'], 'servicemng/termsList') > -1}">
		<%@ include file="/WEB-INF/views/common/popup/termsRegPopup.jsp"%>
		<div class="dimmed" style="display: none;"></div>
    </c:if>
    
    <c:if test="${fn:indexOf(requestScope['javax.servlet.forward.request_uri'], 'stats/userHistReportView') > -1}">
		<%@ include file="/WEB-INF/views/common/popup/optionTermsDetailPopup.jsp"%>
		<div class="dimmed" style="display: none;"></div>
    </c:if>
    
    <c:if test="${fn:indexOf(requestScope['javax.servlet.forward.request_uri'], 'usermng/userListView') > -1}">
		<%@ include file="/WEB-INF/views/common/popup/userInfoPopup.jsp"%>
		<div class="dimmed" style="display: none;"></div>
    </c:if>
    
    <c:if test="${fn:indexOf(requestScope['javax.servlet.forward.request_uri'], 'notice/noticeList') > -1}">
		<%@ include file="/WEB-INF/views/common/popup/noticeOnOffPopup.jsp"%>
		<div class="dimmed" style="display: none;"></div>
    </c:if>
