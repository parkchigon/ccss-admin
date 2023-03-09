<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script>
function goDetail(mngrGrpId) {
	var f = document.frm;
	f.mngrGrpId.value = mngrGrpId
	f.action = "<c:url value='/system/role/roleRegistView.do'/>";
	f.submit();
}

function settingRoleDetail(mngrGrpId) {
	var url = '/admin/system/role/roleMenuListView.do?mngrGrpId=';
	if(mngrGrpId == 'TOP'){
		if('${USER_INFO.mngrLevel}' != mngrGrpId){
			alert("설정 권한이 없습니다.")
		}	
	}
	var f = document.frm;
	f.action = "<c:url value='/system/role/roleMenuListView.do'/>";
	f.mngrGrpId.value =  mngrGrpId
	f.submit();
	
}


function goPage(page){
	$("#page").val(page);
	var f = document.frm;
	frm.page.value=page;
	f.action = "<c:url value='/system/role/listView.do'/>";
	f.submit();
}


</script>


<div class="contents_wrap">
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<div class="tit_table">권한 그룹 리스트</div>
		</div>
		<div class="rtl">
			<span onclick="javascript:goDetail();" class="btn btn_w01"><a href="#none">등록</a></span>&nbsp;
			<strong>Total : <span id="totCnt"><c:out value="${resultData.totalCount}"/></span></strong>
		</div>
	</div>
	<!-- e: table top-->
	
	<form:form commandName="role" name="frm" id="frm" method="post">
		<form:hidden path="mngrGrpId"/>
		<input type="hidden" id="page" name="page" />
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
				<c:forEach items="${resultData.superAdminList}" var="superAdminList" varStatus="status">
					<tr>
						<td></td>
						<td></td>
						<td><font color="red">${superAdminList.grpNm}</font></td>
						<td><font color="red">${superAdminList.grpExplan}</font></td>
						<td></td>
						<td></td>
						<c:choose>
							<c:when test="${USER_INFO.mngrLevel eq 'TOP'}">
								<td><span class="btn btn_w01" onclick="javascript:settingRoleDetail('${superAdminList.mngrGrpId}');" ><a href="#none">설정</a></span></td>
							</c:when>
							<c:otherwise>
								<td></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
				<c:forEach items="${resultData.list}" var="list" varStatus="status">
					<tr>
						<td><fmt:parseNumber integerOnly="true" value="${list.rnum}"/></td>
						<c:if test="${list.useYn eq 'Y'}"><td>사용</td></c:if>
						<c:if test="${list.useYn eq 'N'}"><td>미사용</td></c:if>
						<c:if test="${list.mngrGrpId.toUpperCase() eq 'TOP'}"><td>${list.grpNm}</td></c:if>
						<c:if test="${list.mngrGrpId.toUpperCase() ne 'TOP'}"><td><a href="javascript:goDetail('${list.mngrGrpId}');" class="link">${list.grpNm}</a></td></c:if> 
						<td>${list.grpExplan}</td>
						<td>${list.regDt}</td>
						<td>${list.updDt}</td>
						<td>
							<span class="btn btn_w01" onclick="javascript:settingRoleDetail('${list.mngrGrpId}');" ><a href="#none">설정</a></span>
						</td>
							
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