<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script>
$(document).ready(function() {
	
	refresh();
	
});


function checkedNode(e, data) {
}

function uncheckedNode(e, data) {
}


function save(id, index) {
	
	// 부모노드의 id까지 저장함.(중복 제거)
	var menuIds = $.tree_get_checked()
		.reduce( function(list, menuId) {
			var id = menuId;
			while ( true ) {
				if (list.indexOf(id) < 0 ) list.push(id);
				id = $.tree_get_parent(id);
				if ( id == "#" ) break;
			}
			return list;
		}, [] );
	
	$("#menuIds").val(menuIds);
	console.log("####menuIds:", menuIds);
	
	var data = $("#frm").serialize();
	console.log("####data:", data);
	$.ajax({
		url: "/admin/system/role/editRoleMenuAjax.do"
		,type: "post"
		
		//data: getFormData($("#frm")),
		,dataType : "json"
		,data: data
		
		//contentType: "application/json"
	}).done (function(data) {
		
		$("#frm > #menuIds").val("");
		
		alert("저장되었습니다.");
		
		refresh();
	}).fail (function(data) {
		alert("메뉴 권한 정보 저장에 실패하였습니다.");
		refresh();
	});
}


function refresh() {
	
	$("#menuTree").empty().jstree('destroy');
	var formData = getFormData($("#frm"));
	console.log("formData:",formData);
	$("#menuTree").tree_init({
		"url" : "/admin/system/role/roleMenuListAjax.do",
		"data" : formData,
		"multiple_select" : true,
		"plugins" : [ "checkbox", "search" ],
		"check_node" : { "callback" : checkedNode },
		"uncheck_node" : { "callback" : uncheckedNode },
	});
}



function goProgramRole(mngrGrpId) {
	location.href="<c:url value='/system/role/roleProgramListView.do?mngrGrpId='/>" + mngrGrpId;
}
</script>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="mngrGrpId"     name="mngrGrpId" value="<c:out value="${role.mngrGrpId}" escapeXml="false"/>"/>
	<input type="hidden" id="menuIds"       name="menuIds"      value=""/>
	<input type="hidden" id="mode"          name="mode"         value=""/>
</form>
 
<div class="contents_wrap">
	<div class="tree_wrap cboth">
		<div class="ltr tree_box">
			<div class="tree_inner">
				<div class="searchWrap">
					<input class="search-input inp_txt" style="margin-bottom: 10px; width: 100%;" onKeyup="$.tree_search(this);" placeholder="검색"/>
				</div>
				<div class="btnWrap">
 					<span onclick="javascript:$.tree_open_all();" class="btn btn_type01_01"><a href="#none">전체 열기</a></span>
					<span onclick="javascript:$.tree_close_all();" class="btn btn_type01_01"><a href="#none">전체 닫기</a></span>
				</div>
				<div id="menuTree"></div>
			</div>
		</div>
		
		<div class="rtl table_box">
			<!-- s: table wrap-->
			<div class="table_wrap">
				<table class="table simple table_write_type">
					<colgroup>
						<col width="25%"/>
						<col width="75%"/>
					</colgroup>
					<tbody>
						<tr>
							<th>권한 ID<span class="imp">*</span></th>
							<td class="last" id="role_id"><c:out value="${role.mngrGrpId}" escapeXml="false"/></td>
						</tr>
						<tr>
							<th>권한 명<span class="imp">*</span></th>
							<td class="last" id="role_name"><c:out value="${role.grpName}" escapeXml="false"/></td>
						</tr>
						<tr>
							<th>설명</th>
							<td class="last" id="role_content"><c:out value="${role.grpExplan}" escapeXml="false"/></td>
						</tr>
						<tr>
							<th>사용 여부</th>
							<td class="last" id="role_use_yn"><c:out value="${role.useYn}" escapeXml="false"/></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- e: table wrap-->
			<!-- s: btn wrap 양쪽 정렬-->
			<div class="btn_wrap01">
				<div class="rtl modify create">
					<span onclick="javascript:save();" class="btn btn_type02_01"><a href="#none">저장</a></span>
					<span onclick="javascript:goProgramRole('${role.mngrGrpId}');" class="btn btn_type01_01"><a href="#none">프로그램별 상세 설정</a></span>
				</div>
			</div>
			<!-- e: btn wrap-->

			
		</div>
	</div>
</div>
