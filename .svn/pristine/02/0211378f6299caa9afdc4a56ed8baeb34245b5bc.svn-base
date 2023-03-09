<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script>
function goDetail(mngrGrpId) {
	var f = document.frm;
	
	f.roleId.value = roleId;
	f.action = "<c:url value='/system/role/roleRegistView.do'/>";
	f.submit();
}

function settingRoleDetail(url) {
	location.href = url;
}


</script>


<div class="contents_wrap">
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<div class="count"><strong>Total : <span id="totCnt"><c:out value="${resultData.totalCount}"/></span></strong></div>
		</div>
		<div class="rtl">
			<span onclick="javascript:goDetail();" class="btn btn_w01"><a href="#none">등록</a></span>
		</div>
	</div>
	<!-- e: table top-->
	
	<form:form commandName="role" name="frm" id="frm" method="post">
		<form:hidden path="roleId"/>
		<%-- <form:hidden path="currPage"/> --%>
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="*"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>사용여부</th>
					<th>권한명</th>
					<th>설명</th>
					<th>등록일시</th>
					<th>수정일시</th>
					<th class="last">메뉴 권한</th>
				</tr>
			</thead>
			<tbody id="noticeList">
				<c:forEach items="${resultData.list}" var="list" varStatus="status">
					<tr>
						<td><fmt:parseNumber integerOnly="true" value="${list.rnum}"/></td>
						<c:if test="${list.useYn eq 'Y'}"><td>사용</td></c:if>
						<c:if test="${list.useYn eq 'N'}"><td>미사용</td></c:if>
						<c:if test="${list.mngrGrpId.toUpperCase() eq 'TOP'}"><td>${list.grpName}</td></c:if>
						<c:if test="${list.mngrGrpId.toUpperCase() ne 'TOP'}"><td><a href="javascript:goDetail('${list.mngrGrpId}');" class="link">${list.grpName}</a></td></c:if>
						<td>${list.grpExplan}</td>
						<td>${list.regDt}</td>
						<td>${list.upeDt}</td>
						<td><span onclick="javascript:settingRoleDetail('/admin/system/role/roleMenuListView.do?mngrGrpId=${list.mngrGrpId}');" class="btn btn_w01"><a href="#none">설정</a></span></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	</form:form>
		<!-- s: 페이징 -->
	<div id="paging" class="paging">
		${resultData.paging}
	</div>
	<!-- e: 페이징 -->
</div>