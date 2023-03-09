<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script>
$(document).ready(function(){
	$("#menuTree").tree_init( {
		"url" : "/admin/system/menu/listAjax.do",
		// "data" : formData,
		"multiple_select" : true,
		"plugins" : [ "contextmenu", "dnd", "search" ],
		"select_node" : { "callback" : selectedNode },
		"move_node"  : { "callback" : movedNode },
		"refresh"    : { "callback" : refreshCallback },
		"loaded"     : { "callback" : loadedCallback },
		"contextmenu" : {
			"items"  : ["create", "edit", "remove"],
			"create" : { "callback" : createdNode },
			"edit"   : { "callback" : editedNode },
			"remove" : { "callback" : deletedNode }
		},
	});
	
});

function selectedNode(e, data) {
	
	if ( $("#mode").val() == "create" ) {
		$.tree_reload();
	}
	
	// 값 Setting
	$("#menu_id").text(data.node.id);
	$("#menu_parent").text(data.node.parent);
	$("#menu_text > span").text(data.node.text);
	$("#menu_use_yn > span").text(data.node.original.useYn);
	
	setMode("normal");
}

function movedNode(e, data) {
	
	if ( "#" == data.parent ) {
		alert("Root 메뉴로는 이동할 수 없습니다.");
		$.tree_reload();
		return false;
	}
	
	if ( $.tree_get_node(data.parent).original.stProgramUrl ) {
		alert("프로그램 URL이 등록된 메뉴로는 이동할 수 없습니다.");
		$.tree_reload();
		return false;
	}
	
	var old_parent = data.old_parent;
	var parent = data.parent;
	
	// parent == old_parent
	if ( parent == old_parent ) {
		// Parent Node의 모든 Child 업데이트
		var $parent = $.tree_get_node(parent);
		
		$("#menuIds").val($parent.children);
		updateOrder({ "success" : function() { $.tree_reload(); }});
		
	} else {
		// Old Parent Node의 Child 업데이트
		var $old_parent = $.tree_get_node(data.old_parent);
		
		$("#menuIds").val($old_parent.children);
		$("#parentmenuId").val(old_parent);
		updateOrder({
			"success" : function() {
				// New Parent Node의 Child 업데이트
				var $parent = $.tree_get_node(parent);
				
				$("#menuIds").val($parent.children);
				$("#parentmenuId").val(parent);
				updateOrder({ "success" : function() { $.tree_reload(); }});
			}
		});
		
	}
}

function updateOrder(args) {
	
	var success = function() { /* console.log("success");  */};
	var fail = function() { /* console.log("fail"); */ };
	
	if ( typeof args != "undefined" ) {
		if ( typeof args.success != "undefined" && args.success != null ) {
			success = args.success;
		}
		
		if ( typeof args.fail != "undefined" && args.fail != null ) {
			fail = args.fail;
		}
	}
	
	var formData = getFormData($("#frm"));
	$.ajax({
		url: "/admin/system/menu/updateMenuOrderAjax.do",
		type: "POST",
		//data: formData,
		//contentType: "application/json"
		dataType : "json",
		//,data: getFormData($("#frm"))
		data: $("#frm").serialize()
		//,contentType: "application/json"
	})
	.done ( success )
	.fail ( fail );
}


function createdNode(tree_ref, node) {
	if ( $.tree_get_parent_node(node).original.stProgramUrl ) {
		alert("프로그램 URL이 등록된 메뉴에 하위 메뉴를 생성할 수 없습니다.");
		cancel();
		return false;
	 }
	
	$("#menu_id").text("");
	$("#menu_text > input").val("");
	$("#menu_use_yn > div > input[name=\"menu_use_yn\"]:radio[value=\"Y\"]").prop("checked", true);
	
	setMode("create");
}

function editedNode(tree_ref, node) {
	
	$("#menu_text > input").val($("#menu_text > span").text());
	$("#menu_use_yn > div > input[name=\"menu_use_yn\"]:radio[value=\""+$("#menu_use_yn > span").text()+"\"]").prop("checked", true);

	setMode("modify");
}

function deletedNode(tree_ref, node, selected) {
	
	var leafCnt = 0;
	leafCnt = selected.map(function(value) {
		return $.tree_is_leaf(value) ? leafCnt + 1 : leafCnt;
	}).reduce(function(a, b) { return a + b; });
	
	if ( leafCnt != selected.length ) {
		alert("하위 메뉴를 먼저 삭제하세요.");
		return false;
	}
	
	if(confirm('삭제하시겠습니까?')) {
		selected.forEach(function(value) {
			tree_ref.delete_node(value);
		});
		
		setMode("delete");
		save(selected);
	}
}

function loadedCallback() {
	$.tree_node_click();
}

function refreshCallback() {
	
	// form reset
	$("#frm > input").not("#mode").val("");
	
	setMode("normal");
}

function setMode(mode) {
	
	$(".create, .modify, .delete, .normal").hide();
	
	$("#mode").val(mode);
	$("."+mode).show();
}


function save(selected) {
	
	var mode = $("#mode").val();
	var url = "";
	switch (mode) {
	case 'create':
		url = "/admin/system/menu/editMenuAjax.do";
		var parentNode = $.tree_get_node($("#menu_parent").text());

		$("#menuNm").val($("#menu_text > input").val());
		$("#parentmenuId").val(parentNode.id);
		
		// Order No는 등록되는 메뉴의 Parent의 Child 수로 계산함.
		$("#useYn").val($("input[name='menu_use_yn']:checked").val());
		/* $("#orderNo").val(parentNode.children.length); */
		$("#menuOrder").val(parentNode.children.length);
		$("#menuDepth").val(Number(parentNode.original.menuDepth) + 1);
		break;
		
	case "modify":
		url = "/admin/system/menu/editMenuAjax.do";
		
		var currentNode = $.tree_get_node($("#menu_id").text());
		
		$("#menuId").val(currentNode.id);
		$("#menuNm").val($("#menu_text > input").val());
		$("#parentmenuId").val(currentNode.parent);
		
		$("#useYn").val($("input[name='menu_use_yn']:checked").val());
		/* $("#orderNo").val(currentNode.original.orderNo); */
		$("#menuOrder").val(currentNode.original.orderNo);
		$("#menuDepth").val(currentNode.original.menuDepth);
		break;
		
	case "delete":
		url = "/admin/system/menu/deleteMenuAjax.do";
		
		$("#parentmenuId").val($("#menu_parent").text());
		$("#menuIds").val(selected);
		break;
	default:
		break;
	}
	
	
	$.ajax({
		url: url
		,type: "post"
	    ,dataType : "json"
		//,data: getFormData($("#frm"))
		,data: $("#frm").serialize()
		//,contentType: "application/json"
	}).done (function(data) {

		$.tree_reload($("#menu_parent").text());
		
	}).fail (function() {
		
		$.tree_reload();
	});
	
	
}

function cancel() {
	
	$("#menu_id").text("");
	$("#menu_parent").text("");
	$("#menu_text > span").text("");
	$("#menu_use_yn > span").text("");
	$.tree_reload();
}


</script>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="menuId"        name="menuId"       value=""/>
	<input type="hidden" id="menuNm"        name="menuNm"       value=""/>
	<input type="hidden" id="parentmenuId"  name="parentmenuId" value=""/>
	<!-- <input type="hidden" id="orderNo"       name="orderNo"      value=""/> -->
	<input type="hidden" id="menuOrder"       name="menuOrder"      value=""/>
	<input type="hidden" id="menuDepth"     name="menuDepth"    value=""/>
	<input type="hidden" id="useYn"         name="useYn"        value=""/>
	<input type="hidden" id="menuIds"       name="menuIds"      value=""/>
	<input type="hidden" id="mode"          name="mode"         value=""/>
</form>

<div class="contents_wrap">
	<div class="tree_wrap cboth">
		<div class="ltr tree_box">
			<div class="tree_inner">
				<div class="searchWrap">
					<input class="input w01" style="margin-bottom: 10px; width: 100%;" onKeyup="$.tree_search(this);" placeholder="검색"/>
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
							<th>메뉴 ID <span class="imp">*</span></th>
							<td class="last" id="menu_id"></td>
						</tr>
						<tr>
							<th>상위 메뉴 ID <span class="imp">*</span></th>
							<td id="menu_parent"  class="last"></td>
						</tr>
						<tr>
							<th>메뉴 명</th>
							<td id="menu_text" class="last">
								<span class="normal"></span>
								<input type="text" class="inp_txt w01 modify create" maxLength="100" style="display: none;" />
							</td>
						</tr>
						<tr>
							<th>사용 여부</th>
							<td id="menu_use_yn" class="last">
								<span class="normal"></span>
								<div class="modify create" style="display: none;">
									<input type="radio" name="menu_use_yn" value="Y" checked="checked"/> Y&nbsp;&nbsp;
									<input type="radio" name="menu_use_yn" value="N" /> N
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- e: table wrap-->
			<!-- s: btn wrap 양쪽 정렬-->
			<div class="btn_wrap01">
				<div class="rtl modify create" id="btnmodify" style="display: none;">
					<span onclick="javascript:save();" class="btn btn_type02_01"><a href="#none">저장</a></span>
					<span onclick="javascript:cancel();" class="btn btn_type01_01"><a href="#none">취소</a></span>
				</div>
			</div>
			<!-- e: btn wrap-->

			
		</div>
	</div>
</div>
