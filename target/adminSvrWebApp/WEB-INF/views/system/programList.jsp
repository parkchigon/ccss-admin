<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script>
$(document).ready(function(){
	
	$("#menuTree").tree_init({
		"url" : "/admin/system/program/menuListAjax.do",
		"multiple_select" : false,
		"plugins" : [ "search" ],
		"select_node" : { "callback" : selectedNode }
	});
});


function selectedNode(e, data) {
	
	// 값 Setting
	if ( $.tree_is_leaf(data.node) == false ) {
		$("#program_list").html(makeProgram(null, "empty"));
		$("#btn_regist").hide();
		setMode("empty", "empty");
	} else {
		$("#menuId").val(data.node.id);
		
		$.ajax({
			url: "/admin/system/program/programListAjax.do"
			,type: "post"
		    ,dataType : "json"
			//,data: getFormData($("#frm"))
			,data: $("#frm").serialize()
			//,contentType: "application/json"
		}).done (function(data) {
			if ( !makeProgramList(data.programList) ) {
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

	if(list.length == 0) {
		html += '<tr><td colspan="6">등록된 프로그램 데이터가 없습니다.</td></tr>';
	}
	
	list.forEach(function(program, index) {
		html += makeProgram(program, index);
	});
	
	
	
	$("#program_list").html(html);
	$("#btn_regist").show();
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
	
	html += '<tr id="'+programRowId+'">';
	html += '	<td id="program_id">';
	html += '		<span>'+programId+'</span>';
	html += '	</td>';
	
	
	html += '	<td id="program_name">';
	html += "		<span class=\"normal\">"+programNm+"</span>\n";
	html += "		<input type=\"text\" onkeydown=\"notAvailableSpecialChar(this)\" class=\"inp_txt w01 modify create\" maxLength=\"100\" style=\"display: none;\"/>\n";
	html += '	</td>';
	
	
	html += '	<td id="program_url">';
	html += "		<span class=\"normal\">"+programUrl+"</span>\n";
	html += "		<input type=\"text\" onkeydown=\"isURL(this)\" class=\"inp_txt w01 modify create\" maxLength=\"100\" style=\"display: none;\"/>\n";
	html += '	</td>';
	
	
	html += '	<td id="st_program_yn">';
	html += "		<span class=\"normal\">"+stProgramYn+"</span>\n";
	html += "		<div class=\"modify create\" style=\"display: none;\">\n";
	html += "			<input type=\"radio\" name=\"st_program_yn\" value=\"Y\" /> Y&nbsp;&nbsp;"
	html += "			<input type=\"radio\" name=\"st_program_yn\" value=\"N\" checked=\"checked\"/> N\n"
	html += "		</div>\n";
	html += '	</td>';
	
	
	html += '	<td id="program_use_yn">';
	html += "		<span class=\"normal\">"+useYn+"</span>\n";
	html += "		<div class=\"modify create\" style=\"display: none;\">\n";
	html += "			<input type=\"radio\" name=\"program_use_yn\" value=\"Y\" checked=\"checked\"/> Y&nbsp;&nbsp;"
	html += "			<input type=\"radio\" name=\"program_use_yn\" value=\"N\" /> N\n"
	html += "		</div>\n";	
	html += '	</td>';
	
	html += '	<td>';
	html += "		<div class=\"normal\">\n";
	html += '			<span onclick="javascript:modify(\''+programIndex+'\');" class="btn btn_type02_01"><a href="#none">수정</a></span>';
	html += '			<span onclick="javascript:removed(\''+programRowId+'\',\''+programIndex+'\');" class="btn btn_type02_01"><a href="#none">삭제</a></span>';
	html += '		</div>';
	html += "		<div class=\"modify create\" style=\"display: none;\">\n";
	html += '			<span onclick="javascript:save(\''+programRowId+'\',\''+programIndex+'\');" class="btn btn_type02_01"><a href="#none">저장</a></span>';
	html += '			<span onclick="javascript:cancel(\''+programIndex+'\');" class="btn btn_type02_01"><a href="#none">취소</a></span>';
	html += '		</div>';
	html += '	</td>';
	html += '</tr>';

	return html;
}


function regist() {
	
	$("#btn_regist").hide();
	
	if ( $("tr[id^='program-']").length == 0 ) {
		$("#program_list").html(makeProgram(null, "create"));
	} else {
		$("#program_list").append(makeProgram(null, "create"));
	}
	
	$("tr[id^='program-']").find("#st_program_yn > span").each(function() {
		if ( $(this).text() == "Y" ) {
			$("#program-create").find("#st_program_yn > div > input[name=\"st_program_yn\"]:radio[value='Y']").prop("disabled",true);;
		}
	});
	setMode("create", "create");
}


function modify(index) {
	
	var $programRowId = $("#program-" + index);
	$("tr[id^='program-']").not("tr#program-"+index).find("#st_program_yn > span").each(function() {
		if ( $(this).text() == "Y" ) {
			$programRowId.find("#st_program_yn > div > input[name=\"st_program_yn\"]:radio[value='Y']").prop("disabled",true);;
		}
	});
	
	$programRowId.find("#program_name > input").val($programRowId.find("#program_name > span").text());
	$programRowId.find("#program_url > input").val($programRowId.find("#program_url > span").text());
	$programRowId.find("#st_program_yn > div > input[name=\"st_program_yn\"]:radio[value=\""+$programRowId.find("#st_program_yn > span").text()+"\"]").prop("checked", true);
	$programRowId.find("#program_use_yn > div > input[name=\"program_use_yn\"]:radio[value=\""+$programRowId.find("#program_use_yn > span").text()+"\"]").prop("checked", true);
	
	setMode("modify", index);
}

function cancel(index) {
	
	setMode("normal", index);
	
	$("#program-create").remove();
	
	if ( $("tr[id^='program-']").length == 0 ) {
		$("#program_list").html("<tr><td colspan='6'>등록된 프로그램 데이터가 없습니다.</td></tr>");
	}
	
	$("#btn_regist").show();
}



function removed(id, index) {
	
	if(confirm('삭제하시겠습니까?')) {
		
		if ( $("#program-" + index).find("#program_id > span").text() == "" ) {
			return false;
		}
		$("#programId").val($("#program-" + index).find("#program_id > span").text());
		
		$.ajax({
			url: "/admin/system/program/deleteProgramMenuAjax.do"
			,type: "post"
			,dataType : "json"
			//,data: getFormData($("#frm"))
			,data: $("#frm").serialize()
			//,contentType: "application/json"
		}).done (function(data) {
			if ( data.result == "fail" )
				alert("삭제에 실패 했습니다. 권한 설정을 확인해주세요.");
			
			$("#frm > input").not("#mode").val("");
			
			$.tree_reload();
		}).fail (function(data) {
			alert("프로그램 정보 삭제 실패");
			$.tree_reload();
		});
	}
}


function save(id, index) {
	
	var $programRowId = $("#"+id);
	
	$("#programId").val($programRowId.find("#program_id > span").text());
	$("#programNm").val($programRowId.find("#program_name > input").val());
	$("#programUrl").val($programRowId.find("#program_url > input").val());
	$("#stProgramYn").val($programRowId.find("input[name='st_program_yn']:checked").val());
	$("#useYn").val($programRowId.find("input[name='program_use_yn']:checked").val());
	
	$.ajax({
		url: "/admin/system/program/editProgramMenuAjax.do"
		,type: "post"
		,dataType : "json"
		//,data: getFormData($("#frm"))
		,data: $("#frm").serialize()
		//,contentType: "application/json"
	}).done (function(data) {
		$("#frm > input").not("#mode").val("");
		
		$.tree_reload();
	}).fail (function(data) {
		alert("프로그램 정보 조회 실패");
		$.tree_reload();
	});
	
	setMode("normal", index);
}


function setMode(mode, index) {
	
	$("#program-" + index).find(".empty, .create, .modify, .normal").hide();
	
	$("#mode").val(mode);
	$("#program-" + index).find("."+mode).show();
}

function notAvailableSpecialChar(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9-_.]/g,""));
	}); 
}
function isURL(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^a-zA-Z0-9/&=:;%~.?+-_]/g,""));
	}); 
}

</script>

<form id="frm" name="frm" method="post">
	<input type="hidden" id="menuId"        name="menuId"       value=""/>
	<input type="hidden" id="programId"     name="programId"    value=""/>
	<input type="hidden" id="programNm"     name="programNm"    value=""/>
	<input type="hidden" id="programUrl"    name="programUrl"   value=""/>
	<input type="hidden" id="stProgramYn"   name="stProgramYn"  value=""/>
	<input type="hidden" id="useYn"         name="useYn"        value=""/>
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
				<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
					<colgroup>
						<col width="15%"/>
						<col width="15%"/>
						<col width="*"/>
						<col width="12%"/>
						<col width="10%"/>
						<col width="15%"/>
					</colgroup>
					<thead>
						<tr>
							<th>프로그램 ID</th>
							<th>프로그램명</th>
							<th>URL</th>
							<th>첫페이지 설정</th>
							<th>사용여부</th>
							<th class="last">비고</th>
						</tr>
					</thead>
					<tbody id="program_list">
					</tbody>
				</table>
			</div>
			<!-- e: table wrap-->
			<!-- s: btn wrap 양쪽 정렬-->
			<div class="btn_wrap01">
				<div class="rtl modify create">
					<span id="btn_regist" onclick="javascript:regist();" class="btn btn_type02_01" style="display: none;"><a href="#none">등록</a></span>
				</div>
			</div>
			<!-- e: btn wrap-->

			
		</div>
	</div>
</div>