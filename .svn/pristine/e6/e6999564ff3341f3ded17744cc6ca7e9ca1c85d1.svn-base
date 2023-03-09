<%@ page language ="java"  pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%--
/**
 *******************************************************************************
 * DevOn Framework Sample JSP
 * NAME : employeeList.jsp
 * DESC : 페이지패턴 Web 페이지 목록조회
 * VER  : v1.0
 * Copyright 2014 LG CNS All rights reserved
 *******************************************************************************
 */
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="Tag" uri="http://www.dev-on.com/Tag"  %>
<%@ page import="com.lgu.ccss.admin.admin.domain.AdminPagingVO" %>
<%@ page import="devonframe.paging.*" %>
<%@ page import="devonframe.paging.ui.*" %>
<%@ page import="devonframe.paging.PagingUtil" %>

<script type="text/javascript" language="javascript">
//<![CDATA[
function fnRetrieveList() {
	document.searchForm.action = "<c:url value="/admin/admin/adminList.do"/>";
	document.searchForm.submit();
}
function fnUpdate(value) {
    document.searchForm.num.value = value;
    document.searchForm.mode.value = "update";
	document.searchForm.action = "<c:url value="/pattern/pp1/retrieveEmployeeForm.do"/>";
	document.searchForm.submit();
}
function fnAdd() {
    document.searchForm.mode.value = "insert";
	document.searchForm.action = "<c:url value="/pattern/pp1/retrieveEmployeeForm.do"/>";
	document.searchForm.submit();
}
//]]>
</script>

<style>


li {
    /* /*  margin: 0 0 0 0;
    padding: 0 0 0 0;  */ */
    border : 10;
    float: left;
}
</style>
<div class="contents_wrap">
	<div class="main_top">
		<h2>Admin 관리 > Admin 조회 및 수정</h2>
	</div>
	 	<Tag:paging resultList='${resultList}' >
	 	<Tag:pagingOut value="showJavaScript" />                
	        <div>
	            <div>
	                <div>
	                   <div class="table_wrap">
							<form:form commandName="input" name="searchForm" method="post">
								<Tag:pagingAddHiddenParam  />
								<input type="hidden" id="mode" name="mode" />
							 	<input type="hidden" id="num" name="num" />
								<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type" summary="<spring:message code="admin.search"/>">
									<caption><spring:message code="admin.search"/></caption>
									<caption>어드민 리스트</caption>
									<colgroup>
										<col style="width: 15%;" />
										<col style="width: *%;" />
									</colgroup>
									<tbody>
										<tr>
										<th><div class="tit_search">검색</div></th>
											<td>
												<div class="input_wrap">
													<select id="searchType" name="searchType" class="select w01" style="width:130px;">
														<option value="CTN" selected="selected">전화번호</option>
														<option value="ID">회원 ID</option>
														<option value="NAME">사용자 번호</option>
													</select>
													<input type="text" class="input w02" id="searchText" name="searchText" onkeydown="if(event.keyCode==13) goSearch(1);"/>
													<a href="javascript:fnRetrieveList();"><span class="btn focus" style="width:90px;"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 조회</span></a>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</form:form>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <div>
				<div class="Lwrapper">
					<div class="LblockListInfo">
						<span class="Ltotal"><Tag:pagingOut value="showCountFrame" /></span>
					</div>			
					<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type" summary="<spring:message code="admin.serchList"/>">
						<caption><spring:message code="admin.serchList" /> </caption> 
						<thead>
							<tr>
								<spring:message code="admin.level"  var="numLable"/>
								<th class="Lfirst"><Tag:pagingSort title="${numLable}"  column="ADMIN_LEVEL_NM" /></th>
								<th><spring:message code="admin.name" /></th>
								<spring:message code="admin.id" var="idLable"/>
								<th><Tag:pagingSort title="${idLable}"  column="MNGR_ID" />
								<th><spring:message code="admin.reg.date" /></th>
								<th><spring:message code="admin.emailAddr" /></th>
								<th><spring:message code="admin.ctn" /></th>
								<th><spring:message code="admin.account.status" /></th>
								<th class="Llast"><spring:message code="common.check" /></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status">
								<tr class="Lfirst">
									<td><c:out value="${result.adminLevelNm}" /></td>
									<td><c:out value="${result.mngrName}" /></td>
									<td class="Lfirst"><a href="javascript:fnUpdate('<c:out value="${result.mngrId}"/>')"><c:out value="${result.mngrId}" /></a></td>
									<td><c:out value="${result.regDt}" /></td>
									<td><c:out value="${result.emailAddr}" /></td>
									<td><Tag:phone><c:out value="${result.ctn}" /></Tag:phone></td>
									<td><c:out value="${result.accountStatus}" /></td>
									<td class="Llast"></td>
								</tr>
							</c:forEach>
							<c:if test="${empty resultList && !empty input}">
								<tr id="empty" style="background-color: #FFFFFF">
									<td colspan="8"><spring:message code="common.inf.com.nodata" /></td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<ul <c:if test="${empty resultList}">style="display:none"</c:if>>
						<Tag:pagingOut value='showMoveFirstPage' />
						<Tag:pagingOut value='showMoveBeforePage' />
						<Tag:pagingOut value='showIndex' />
						<Tag:pagingOut value='showMoveNextPage' />
						<Tag:pagingOut value='showMoveEndPage' />
					</ul>
	
				</div>
			</div>
		</Tag:paging>
	</div>
	<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:fnAdd();return false"><spring:message code="common.label.create"/></a></span>
	</div>
