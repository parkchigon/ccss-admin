<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javascript">
$(document).ready(function() {

	var formData = getFormData($("#frm"));
	//var formData = $("#frm").serialize();
	console.log("role Program List formData:",formData);
	$("#menuTree").tree_init({
		"url" : "/admin/system/role/roleMenuListOneRoleAjax.do",
		"data" : formData,
		"multiple_select" : false,
		"plugins" : [ "search" ],
		"select_node" : { "callback" : selectedNode },
	});
	
	$("#checkAll").on("click", function() {
		$(".checkbox").prop("checked", this.checked);
	});
	
	$(document).on("click", ".checkbox", function() {
		if ( $(".checkbox").length == $(".checkbox:checked").length ) {
			$("#checkAll").prop("checked", true);
		} else {
			$("#checkAll").prop("checked", false);
		}
	});
});


function selectedNode(e, data) {
	
	// 값 Setting
	if ( $.tree_is_leaf(data.node) == false ) {
		$("#program_list").html(makeProgram(null, "empty"));
		$("#checkAll").prop("checked", false);
	} else {
		$("#menuId").val(data.node.id);
		
		$.ajax({
			url: "/admin/system/role/roleProgramListAjax.do",
			type: "POST",
			data: getFormData($("#frm")),
			contentType: "application/json"
		}).done (function(data) {
			
			$("#checkAll").prop("checked", false);
			if ( makeProgramList(data.roleProgramList) ) {
				if ( $(".checkbox").length != 0 && $(".checkbox").length == $(".checkbox:checked").length ) {
					$("#checkAll").prop("checked", true);
				}
			}

		}).fail(function() {
			
			alert("fail.");
		});
	}
}

function makeProgramList(list) {

	var html = "";
	
	if ( typeof list == 'undefined' || list == null ) {
		return false;
	}
	
	if ( list.length == 0 ) {
		html += "<tr><td colspan='5'>등록된 프로그램 데이터가 없습니다.</td></tr>";
	}
	
	list.forEach( function(program, index) {
		html += makeProgram(program, index);
	} );
	
	$("#program_list").html(html);
	return true;
}

function makeProgram(program, suffix) {
	
	var html = "";
	
	var programRowId = ( typeof suffix != "undefined" ) ? "program-" + suffix : "";
	var programIndex = ( typeof suffix != "undefined" ) ? suffix : "";
	var programId    = ( program && program.programId   ) ? program.programId   : "";
	var programNm    = ( program && program.programNm   ) ? program.programNm   : "";
	var programUrl   = ( program && program.programUrl  ) ? program.programUrl  : "";
	var stProgramYn  = ( program && program.stProgramYn ) ? program.stProgramYn : "";
	var useYn        = ( program && program.useYn       ) ? program.useYn       : "";

	
	html += "<tr id=\""+programRowId+"\">\n";
	if ( suffix == "empty" ) {
		html += "	<td></td>\n";
	} else {
		html += "	<td>\n";
		if ( program.roleProgramYn == "Y" ) {
			html += "		<input type=\"checkbox\" class=\"checkbox\" id=\""+programId+"\" checked=\"checked\" >\n";
		} else {
			html += "		<input type=\"checkbox\" class=\"checkbox\" id=\""+programId+"\" >\n";
		}
		html += "	</td>\n";
	}
	html += "	<td id=\"program_id\">\n";
	html += "		<span>"+programId+"</span>\n";
	html += "	</td>\n";
	html += "	<td id=\"program_name\">\n";
	html += "		<span class=\"normal\">"+programNm+"</span>\n";
	html += "	</td>\n";
	html += "	<td id=\"program_url\">\n";
	html += "		<span class=\"normal\">"+programUrl+"</span>\n";
	html += "	</td>\n";
	html += "	<td id=\"st_program_yn\">\n";
	html += "		<span class=\"normal\">"+stProgramYn+"</span>\n";
	html += "	</td>\n";
	html += "</tr>\n";
	
	return html;
}

function save() {
	
	var programIds = [];
	$(".checkbox").each(function(index, value) {
		if ( this.checked ) {
			programIds.push(value.id);
		}
	});
	
	$("#programIds").val(programIds.join());
	
	
	//var formData = getFormData($("#frm"));
	var formData =$("#frm").serialize();
	console.log("#1### formData :" + formData);
	//return false;
	$.ajax({
		url: "/admin/system/role/roleProgramRegistAjax.do",
		type: "POST",
		dataType : "json",
		data: formData,
		//contentType: "application/json"
	}).done (function(data) {
		$("#frm > #programIds").val("");
		
		alert("저장되었습니다.");
		
		$.tree_reload("", getFormData($("#frm")));
		
	}).fail (function(data) {
		$("#frm > #programIds").val("");
		
		alert("메뉴 권한 정보 등록 실패");
		$.tree_reload("", getFormData($("#frm")));
	});
}


</script>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="roleId"        name="mngrGrpId"       value="<c:out value="${role.mngrGrpId}" escapeXml="false"/>"/>
	<input type="hidden" id="programIds"    name="programIds"   value=""/>
	<input type="hidden" id="menuId"        name="menuId"       value=""/>
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
				<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
					<colgroup>
						<col width="5%"/>
						<col width="20%"/>
						<col width="20%"/>
						<col width="*"/>
						<col width="15%"/>
					</colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" id="checkAll"></th>
							<th>프로그램 ID</th>
							<th>프로그램명</th>
							<th>URL</th>
							<th class="last">시작<br/>여부</th>
						</tr>
					</thead>
					<tbody id="program_list">
						<tr><td></td><td></td><td></td><td></td><td></td></tr>
					</tbody>
				</table>
			</div>
			<!-- e: table wrap-->
			<!-- s: btn wrap 양쪽 정렬-->
			<div class="btn_wrap01">
				<div class="rtl">
					<span id="btn_regist" onclick="javascript:history.back();" class="btn btn_type02_01"><a href="#none">뒤로</a></span>
					<span id="btn_regist" onclick="javascript:save();" class="btn btn_type02_01"><a href="#none">저장</a></span>
				</div>
			</div>
			<!-- e: btn wrap-->
		</div>
	</div>
</div>