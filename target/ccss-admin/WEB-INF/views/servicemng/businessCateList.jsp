<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>


<script>
$(document).ready(function(){
	
	$("#menuTree").cate_tree_init( {
		"url" : "/admin/business/cateListAjax.do",
		"multiple_select" : true,
		"plugins" : [ "contextmenu", "dnd", "search", "types" ],
		"select_node" : { "callback" : selectedNode },
		"move_node"  : { "callback" : movedNode },
		"refresh"    : { "callback" : refreshCallback },
		"loaded"     : { "callback" : loadedCallback }
	});
	
	/*
	$("#iconFile").on("change", function() {
		var fileName = $(this).val().split('\\').pop();
		var ext = fileName.substring(fileName.lastIndexOf(".")+1, fileName.length);
		ext = ext.toUpperCase();
		
		if(ext == 'JPG' || ext == 'PNG') {
			$("#text_iconFileName").val(fileName);
		} else {
			$("#text_iconFileName").val("");
			alert("이미지 파일형식을 확인해주세요.");
			return;
		}
	});
	*/
	
});

//업종/카테고리 트리 우클릭 메뉴 커스터마이징
function customMenu(node) {
	var nodeDepth = node.original.businessCategoryDepth;
	var items;
	
	if(nodeDepth == 1) {
		items = {
			addBusiness: {
				label : "업종 등록",
				action: addBusiness
			}
		}
	} else if (nodeDepth == 2) {
		items = {
			modifyBusiness: {
				separator_before : false,
				separator_after : false,
				label : "업종 수정",
				action: modifyBusiness
			},
			deleteBusiness: {
				separator_before : false,
				separator_after : false,
				label : "업종 삭제",
				action: deleteBusiness
			},
			addCategory: {
				separator_before : false,
				separator_after : false,
				label : "카테고리 등록",
				action: addCategory
			}
		}
	} else if (nodeDepth == 3) {
		items = {
			modifyCategory: {
				separator_before : false,
				separator_after : false,
				label : "카테고리 수정",
				action: modifyCategory
			},
			deleteCategory: {
				separator_before : false,
				separator_after : false,
				label : "카테고리 삭제",
				action: deleteCategory
			}
		}
	}
	return items;
	
}

//노드 선택
function selectedNode(e, data) {
	
	var nodeOriginal = data.node.original;
	
	if(nodeOriginal.businessCategoryDepth == 2) {
		$("#businessCode").text(nodeOriginal.seqBusinessCategory);
		$("#text_businessName > span").text(nodeOriginal.businessCategoryName);
		$("#businessUseYn").find("input[type='radio']").attr("checked", false);
		$("#businessUse"+nodeOriginal.useYn).attr("checked", true);
		$("[id ^= table_]").hide();
		$("#table_businessInfo").show();
		$("#table_top_businessInfo").show();
	} else if(nodeOriginal.businessCategoryDepth == 3) {
        var parentNode = $("#" + data.node.parents[0]);
		
		$("#categoryCode").text(nodeOriginal.seqBusinessCategory);
		$("#categoryName > span").text(nodeOriginal.businessCategoryName);
		$("#parentBusinessName").text(parentNode.children()[1].text);
		$("#text_targetAlliance > span").text(nodeOriginal.targetAlliance);
		$("#text_iconFileName").val(nodeOriginal.iconFileName);
		$("#categoryKeyword").val(nodeOriginal.keywords);
//		$("#categoryKeyword").attr("disabled", true);
		$("#text_description").val(nodeOriginal.description);
		$("#text_description").attr("disabled", true);
		$("#iconFile").attr("disabled", true);
		
		$("#iconImageFileUrl").attr("src", nodeOriginal.categoryImageUrl);
		
		$("#categoryUseYn").find("input[type='radio']").attr("checked", false);
		$("#categoryUse"+nodeOriginal.useYn).attr("checked", true);

		$("[id ^= table_]").hide();
		$("#table_categoryInfo").show();
		$("#table_top_categoryInfo").show();
		
	}
	
	
	setMode("normal");

}

//노드 이동
function movedNode(e, data) {
	
	var moveNode = data.node.original;
	var targetNode = $.tree_get_node(data.parent)
	
	if("#" == data.parent) {
		alert("Root 메뉴로는 이동할 수 없습니다.");
		$.cate_tree_reload();
		return false;
	}
	
	if(moveNode.businessCategoryDepth-1 != targetNode.original.businessCategoryDepth) {
		alert("업종/카테고리 상하위 이동은 불가능합니다.");
		$.cate_tree_reload();
		return false;
	}
	
	
	
	
	$("#businessCategoryDepth").val(moveNode.businessCategoryDepth);
	$("#seqBusinessCategorys").val(targetNode.children)
	
	$.ajax({
		url : "/admin/business/updateBusinessCategoryOrderAjax.do",
		type: "POST",
		data: getFormData($("#frm")),
		contentType: "application/json"		
	}).done(function(data) {
		$.cate_tree_reload();
	});
}

function refreshCallback(e, data) {
	//alert("refreshCallback");
	//console.log(e);
	//console.log(data);
}

function loadedCallback(e, data) {
	//alert("loadedCallback");
	//console.log(e);
	//console.log(data);
}

//업종 등록 폼 생성
function addBusiness(obj) {
	
	var tree_ref = $.jstree.reference(obj.reference);
	var selected = tree_ref.get_selected();
	var node = tree_ref.get_node(selected[0]);
	
	$("#businessCode").text("");
	$("#text_businessName > span").text("");
	$("#text_businessName").find("input[type='text']").val("");
	$("#text_businessName").find("input[type='text']").show();
	$("#businessUseYn").find("input[type='radio']").attr("disabled", false);
	$("#businessUseN").attr("checked", true);
	$("[id ^= table_]").hide();
	$("#table_businessInfo").show();	
	$("#table_top_businessInfo").show();
	
    $("#parentSeqBusinessCategory").val(node.id);

	setMode("create_business");
	
}

//업종 수정 폼 생성
function modifyBusiness(obj) {
	var tree_ref = $.jstree.reference(obj.reference);
	var selected = tree_ref.get_selected();
	var node = tree_ref.get_node(selected[0]);
	
	$("#seqBusinessCategory").val(node.id);
	$("#text_businessName").find("input[type='text']").val(node.text);
	$("#businessUseYn").find("input[type='radio']").attr("disabled", false);
	$("[id ^= table_]").hide();
	$("#table_businessInfo").show();	

	setMode("modify_business");

}

//업종 삭제
function deleteBusiness(obj) {
	
	var tree_ref = $.jstree.reference(obj.reference);
	var selected = tree_ref.get_selected();
	var node = tree_ref.get_node(selected[0]);
	
	var leafCnt = 0;
	leafCnt = selected.map(function(value) {
		return $.tree_is_leaf(value) ? leafCnt + 1 : leafCnt;
	}).reduce(function(a, b) { return a + b; });
	
	if( leafCnt != selected.length ) {
		alert("해당 업종에 속한 카테고리를 먼저 삭제하세요.");
		return false;
	}
	
	if( confirm("삭제하시겠습니까?") ) {
		selected.forEach(function(value) {
			tree_ref.delete_node(value);
		});
		
		$("#parentSeqBusinessCategory").val(node.parent)
		setMode("delete_business");
		save(selected);
	}
}

//카테고리 등록 폼 생성
function addCategory(obj) {
	
	var tree_ref = $.jstree.reference(obj.reference);
	var selected = tree_ref.get_selected();
	var node = tree_ref.get_node(selected[0]);
	
	$("#categoryCode").text("");
	$("#categoryName > span").text("");
	$("#categoryName").find("input[type='text']").val("");
	$("#parentBusinessName").text(node.text);
	$("#text_iconFileName").val("");
	$("#text_description").val("");
	$("#categoryUseYn").find("input[type='radio']").attr("disabled", false);
	$("#categoryUseY").attr("checked", true);
	$("#categoryKeyword").val("");
	
//	$("#categoryKeyword").attr("disabled", false);
	$("#text_description").attr("disabled", false);
	$("#iconFile").attr("disabled", false);
    $("#iconImageFileUrl").attr("src", "/admin/resources/common/images/default_user.png");

	
	$("#parentSeqBusinessCategory").val(node.id);
	$("[id ^= table_]").hide();
	$("#table_categoryInfo").show();

	
	setMode("create_category");
}

//카테고리 수정 폼 생성
function modifyCategory(obj) {
	var tree_ref = $.jstree.reference(obj.reference);
	var selected = tree_ref.get_selected();
	var node = tree_ref.get_node(selected[0]);
	
	$("#seqBusinessCategory").val(node.id);
	$("#categoryName").find("input[type='text']").val(node.text);
	$("#categoryUseYn").find("input[type='radio']").attr("disabled", false);

	$("#text_targetAlliance").find("select").val(node.original.targetAlliance)
	$("#text_description").val(node.original.description);
//	$("#categoryKeyword").attr("disabled", false);
	$("#text_description").attr("disabled", false);
	$("#iconFile").attr("disabled", false);
	$("#iconFileName").val(node.original.iconFileName);
	$("#iconFileSeq").val(node.original.iconFileSeq);

	$("#parentSeqBusinessCategory").val(node.parent);
	$("[id ^= table_]").hide();
	$("#table_categoryInfo").show();

	
	setMode("modify_category");

}

//카테고리 삭제
function deleteCategory(obj) {
	
	var tree_ref = $.jstree.reference(obj.reference);
	var selected = tree_ref.get_selected();
	var node = tree_ref.get_node(selected[0]);
	
	
	if( confirm("삭제하시겠습니까?") ) {
		$("#seqBusinessCategory").val(node.id);
		setMode("delete_category");
		save(selected);
	}
	
	
	

}

//모드 변경
function setMode(mode) {

	$(".create_business, .modify_business, .create_category, .modify_category, .delete, .normal").hide();
	$("."+mode).show();
	
	if(mode == 'normal') {
		$("input[type='radio']").attr("disabled", true);
	}
	
	$("#mode").val(mode);
}

//등록, 수정, 삭제 액션
function save(selected) {
	var mode = $("#mode").val();
	var url = "";
	switch (mode) {
	case 'create_business':	//업종 등록
		var parentNode = $.tree_get_node($("#parentSeqBusinessCategory").val());
		
		var newBusinessName = $("#text_businessName > input").val().trim();
		if(!newBusinessName) {
			alert("업종명을 입력하세요.");
			return;
		}

		for(var i=0; i<parentNode.children.length; i++) {
			var childNode = $.tree_get_node(parentNode.children[i]);
			
			if(newBusinessName == childNode.text) {
				alert("이미 등록된 업종입니다.");
				return;
			}
		}
		
		url = "/admin/business/editBusinessAjax.do";
		$("#seqBusinessCategory").val("");
		$("#businessCategoryName").val(newBusinessName);
		$("#useYn").val($("input[name='businessUseYn']:checked").val());
		$("#orderNo").val(parentNode.children.length+1);
		break;
		
	case 'modify_business':	//업종 수정
		url = "/admin/business/editBusinessAjax.do";
		
		var newBusinessName = $("#text_businessName > input").val();
		if(!newBusinessName) {
			alert("업종명을 입력하세요.");
			return;
		}
		
		$("#businessCategoryName").val(newBusinessName);
		$("#useYn").val($("input[name='businessUseYn']:checked").val());
		break;
		
		
	case 'delete_business':	//업종 삭제
		url = "/admin/business/deleteBusinessAjax.do";
		$("#seqBusinessCategory").val(selected);
		break;
		
	case 'create_category':	//카테고리 등록
		var parentNode = $.tree_get_node($("#parentSeqBusinessCategory").val());

		var newCategoryName = $("#categoryName > input").val();
		var iconFileName = $("#text_iconFileName").val();
		var keywords = $("#categoryKeyword").val();
		
		if(!newCategoryName) {
			alert("카테고리명을 입력하세요.");
			return;
		}
		
		for(var i=0; i<parentNode.children.length; i++) {
			var childNode = $.tree_get_node(parentNode.children[i]);
			if(newCategoryName == childNode.text) {
				alert("이미 등록된 카테고리입니다.");
				return;
			}
		}
		
		if(!iconFileName) {
			alert("아이콘 이미지를 등록하세요.");
			return;
		}
		
		if(!keywords) {
			alert("키워드를 등록하세요.");
			return;
		}
		
		//아이콘 파일 업로드
		iconFileUpload();
		
		
		url = "/admin/business/editCategoryAjax.do";
		$("#seqBusinessCategory").val("");
		$("#businessCategoryName").val(newCategoryName);
		$("#useYn").val($("input[name='categoryUseYn']:checked").val());
		$("#orderNo").val(parentNode.children.length+1);
		$("#categoryKeywords").val(keywords);
		$("#description").val($("#text_description").val());
		$("#targetAlliance").val($("#text_targetAlliance").find("select option:selected").val());
		$("#businessName").val($("#parentBusinessName").text());
		break;
		
		
	case 'modify_category':	//카테고리 수정
		var parentNode = $.tree_get_node($("#parentSeqBusinessCategory").val());
		
		var newCategoryName = $("#categoryName > input").val();
		var keywords = $("#categoryKeyword").val();
		var iconFileObj = $("#iconFile").val();
		
		
		if(!newCategoryName) {
			alert("카테고리명을 입력하세요.");
			return;
		}
		
		for(var i=0; i<parentNode.children.length; i++) {
			var childNode = $.tree_get_node(parentNode.children[i]);
			if(newCategoryName == childNode.text) {
				alert("이미 등록된 카테고리입니다.");
				return;
			}
		}
		
		if(!keywords) {
			alert("키워드를 등록하세요.");
			return;
		}
		
		if(iconFileObj) {
			//아이콘 파일 교체한 경우 신규 아이콘 파일 업로드
			iconFileUpload();
		}
		
		url = "/admin/business/editCategoryAjax.do";
		$("#businessCategoryName").val(newCategoryName);
		$("#useYn").val($("input[name='categoryUseYn']:checked").val());
		$("#categoryKeywords").val(keywords);
		$("#description").val($("#text_description").val());
		$("#targetAlliance").val($("#text_targetAlliance").find("select option:selected").val());
		
		break;
	case 'delete_category':	//카테고리 삭제
		url = "/admin/business/deleteCategoryAjax.do";
		break;;
	}
	
	$.ajax({
		url: url,
		type: "POST",
		data: getFormData($("#frm")),
		contentType: "application/json"
	}).done(function(data) {
		console.log(data);
		/*
		if(mode == "create_category") {
			var removedKeywords = data.result.removedKeywords;
			if(removedKeywords.length > 0) {
				alert("입력하신 키워드 중 "+removedKeywords+" 은 제외하고 등록 되었습니다.");
			}
		}
		*/
		$.cate_tree_reload();
	});
	/*
	*/
}

function cancel() {
	
	if($("#mode").val().indexOf("business") > -1) {
		$("#businessUseYn").find("input[type='radio']").attr("checked", false);
		$("[id ^= table_]").hide();
		$("#table_businessInfo").show();
		$("#table_top_businessInfo").show();
	} else {
		$("#text_description").attr("disabled", true);
		$("#iconFile").attr("disabled", true);
		$("#categoryUseYn").find("input[type='radio']").attr("checked", false);
		$("[id ^= table_]").hide();
		$("#table_categoryInfo").show();
		$("#table_top_categoryInfo").show();
	}
	setMode("normal");
	$.cate_tree_reload();
}

//키워드 검색 팝업 오픈
function openCategoryKeywordPopup() {
	//getKeywordList();
	$("#keywordQuery").val('');
	openLayerPopup($("#keywordSearchPopup"));
}

// 아이콘 이미지 업로드
function iconFileUpload() {
    
    $("#iconFileUpladeForm").ajaxSubmit({
    	async : false,
    	success: function(responseText, statusText){
    		var resultData = responseText.resultData;
    		$("#iconFileName").val(resultData.fileName);
    		$("#iconFileSeq").val(resultData.seqFile);
    	}
    });
}


//이미지 validation 체크 및 미리보기
function checkUploadImg(fileObj) {
	
	var oriIconFileName = $("#text_iconFileName").val();
	var oriIconFileUrl = $("#iconImageFileUrl").attr("src");
	var filePath = fileObj.value;
	var fileName = filePath.substring(filePath.lastIndexOf("\\")+1);
	var fileArr = fileName.split(".");
	var fileKind = fileArr[fileArr.length-1].toUpperCase();
	
	if(fileKind != "JPG" && fileKind != "PNG") {
		alert("이미지 파일형식을 확인해주세요.");
		$("#iconFile").val('');
		return;
	}

	if(fileObj.files[0].size > 5000000) {
		alert("이미지 사이즈 또는 용량을 확인해주세요.");
		$("#iconFile").val('');
		return;
	}

	
	$("#text_iconFileName").val(fileName);
	
	if (fileObj.files && fileObj.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#iconImageFileUrl').attr('src', e.target.result);
        }
        reader.readAsDataURL(fileObj.files[0]);
        var i =0;
        $("#iconImageFileUrl").load(function() {
            // 이미지 크키가 정해져 있지 않을때
            var imgWidth = this.naturalWidth;
            // 이미지 크키가 정해져 있지 않을때
            var imgHeight = this.naturalHeight;
            if(i==0){
            	i++;
	            if(imgWidth != 135 || imgHeight != 135) {
	        		alert("이미지 사이즈 또는 용량을 확인해주세요.");
	        		
	        		if(oriIconFileName) {
		                $("#text_iconFileName").val(oriIconFileName);
		                $("#iconImageFileUrl").attr("src", oriIconFileUrl);
	        		} else {
		                $("#text_iconFileName").val("");
		                $("#iconImageFileUrl").attr("src", "/admin/resources/common/images/default_user.png");
	        		}
					$("#iconFile").val('');
	                return;
	            }
	        }
        });
    }
}

</script>

<input type="hidden" id="selectNodeE" 		name="selectNodeE" 		value="" />
<input type="hidden" id="selectNodeData" 	name="selectNodeData" 		value="" />

<form id="frm" name="frm" method="POST">
	<input type="hidden" id="businessCategoryDepth" 	name="businessCategoryDepth" 		value="" />
	<input type="hidden" id="businessCategoryName" 		name="businessCategoryName" 		value="" />
	<input type="hidden" id="useYn" 					name="useYn"				 		value="" />
	<input type="hidden" id="orderNo" 					name="orderNo"				 		value="" />
	<input type="hidden" id="seqBusinessCategory"		name="seqBusinessCategory"			value="" />
	<input type="hidden" id="parentSeqBusinessCategory" name="parentSeqBusinessCategory"	value="" />
	<input type="hidden" id="seqBusinessCategorys"		name="seqBusinessCategorys"			value="" />
	<input type="hidden" id="mode"						name="mode" 						value="" />
	<input type="hidden" id="categoryKeywords"			name="categoryKeywords"				value="" />
	<input type="hidden" id="seqCategoryKeywords"		name="seqCategoryKeywords"			value="" />
	<input type="hidden" id="description"				name="description"					value="" />
	<input type="hidden" id="targetAlliance"			name="targetAlliance"				value="" />
	<input type="hidden" id="iconFileName"				name="iconFileName"					value="" />
	<input type="hidden" id="iconFileSeq"				name="iconFileSeq"					value="" />
	<input type="hidden" id="businessName"				name="businessName"					value="" />
</form>

<div class="contents_wrap">
	<div class="tree_wrap cboth">
		<div class="ltr tree_box">
			<div class="tree_inner">
				<input type="text" class="input w01" style="margin-bottom:10px;" onKeyup="$.tree_search(this);" placeholder="검색"/>
				<span onclick="javascript:$.tree_open_all();" class="btn focus">전체열기</span>
				<span onclick="javascript:$.tree_close_all();" class="btn">전체닫기</span>			
				<div id="menuTree"></div>
			</div>
		</div>
		
		<div class="rtl table_box">
			<!-- s: 업종 정보 table wrap-->
			<!-- s: table top-->
			<div class="thead_wrap cboth" id="table_top_businessInfo" style="display: none;">
				<div class="ltr">
					<div class="tit_table">업종 정보</div>
				</div>
				<div class="rtl count">
					*필수입력
				</div>
			</div>
			<!-- e: table top-->
			<div class="table_wrap" id="table_businessInfo" style="display: none;">
				<table class="table simple table_write_type">
					<colgroup>
						<col width="25%"/>
						<col width="75%"/>
					</colgroup>
					<tbody>
						<tr>
							<th>업종코드 <span class="imp">*</span></th>
							<td id="businessCode"class="last"></td>
						</tr>
						<tr>
							<th>업종명 <span class="imp">*</span></th>
							<td id="text_businessName" class="last">
								<span class="normal"></span>
								<input type="text" class="inp_txt w01 modify_business create_business" maxLength="100" style="display: none;"/>
							</td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td id="businessUseYn" class="last">
								<div class="normal create_business modify_business">
									<input id="businessUseY" name="businessUseYn" type="radio" value="Y" disabled="disabled"/> Y&nbsp;&nbsp;
									<input id="businessUseN" name="businessUseYn" type="radio" value="N" disabled="disabled"/> N
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- e: 업종 정보 table wrap-->
			
			
			
			<!-- s: 카테고리 정보 table wrap -->
			<!-- s: table top-->
			<div class="thead_wrap cboth" id="table_top_categoryInfo" style="display: none;">
				<div class="ltr">
					<div class="tit_table">카테고리 정보</div>
				</div>
				<div class="rtl count">
					*필수입력
				</div>
			</div>
			<!-- e: table top-->
			
			<div class="table_wrap" id="table_categoryInfo" style="display: none;">
				<table class="table simple table_write_type">
					<colgroup>
						<col width="16%"/>
						<col width="34%"/>
						<col width="16%"/>
						<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
							<th>카테고리 코드</th>
							<td id="categoryCode" colspan="3" class="last"></td>
						</tr>
						<tr>
							<th>카테고리명 <span class="imp">*</span></th>
							<td id="categoryName" class="last" colspan="3">
								<span class="normal"></span>
								<input type="text" class="input w01 modify_category create_category" maxLength="100" style="display: none;"/>
							</td>
						</tr>
						<tr>
							<th>상위업종</th>
							<td id="parentBusinessName" class="last"></td>
							<th>연동 목적지 <span class="imp">*</span></th>
							<td id="text_targetAlliance" class="last">
								<span class="normal"></span>
								<select class="select w01 modify_category create_category" style="width:130px;">
									<option value="U+ POI" selected="selected">U+ POI</option>
									<option value="KT POI">KT POI</option>
									<option value="제휴 G/W">제휴 G/W</option>
								</select>								
							</td>
						</tr>
						<tr>
							<th>사용여부</th>
							<td id="categoryUseYn" class="last" colspan="3">
								<div class="normal create_category modify_category">
									<input id="categoryUseY" name="categoryUseYn" type="radio" value="Y" /> Y&nbsp;&nbsp;
									<input id="categoryUseN" name="categoryUseYn" type="radio" value="N" /> N
								</div>
							</td>
						</tr>
						<tr>
							<th>아이콘 이미지 <span class="imp">*</span></th>
							<td colspan="3"  class="last">
								<div class="inp_fileUpload">
								<form id="iconFileUpladeForm" method="post" action="/admin/business/categoryFileUpload.do" enctype="multipart/form-data">
									<input id="text_iconFileName" type="text" class="input w02 modify create" readonly="readonly">
									<span class="inp_fileFind"><input id="iconFile" name="categoryImage" accept=".jpg, .png" onchange="checkUploadImg(this);" type="file"></span>
									<span class="btn focus">찾기</span>
								</form>
								</div>
								<div class="pop_info02 color01">* 이미지는 jpg/png만 등록가능</div> 
								<div class="pop_info02 color01">* 사이즈 135x135(최대 5MB)</div> 
								<ul class="list_file">
									<li><img src="/admin/resources/common/images/default_user.png" width="80" height="80" id="iconImageFileUrl" > <!-- <a href="#" class="modify_category" ><img src="/admin/resources/common/images/btn_delete.png" width="13" height="13" alt="삭제"></a> --></li>
								</ul>
							</td>
						</tr>
						<tr>
							<th>키워드 <span class="imp">*</span><br><br><span class="btn create_category modify_category" onclick="openCategoryKeywordPopup();">키워드 검색</span></th>
							<td colspan="3"  class="last">
								<textarea id="categoryKeyword" class="input w01" rows="5" cols="100" disabled="disabled"></textarea>
							</td>
						</tr>
						<tr>
							<th>비고</th>
							<td colspan="3"  class="last">
								<textarea id="text_description" class="input w01" rows="3" cols="100"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- e: 카테고리 정보 table wrap -->
			
			
			<!-- s: btn wrap 양쪽 정렬-->
			<div class="btn_wrap01">
				<div class="rtl modify_business create_business" style="display: none;">
					<span onclick="javascript:save();" class="btn btn_type02_01 create_business"><a href="#none">등록</a></span>
					<span onclick="javascript:save();" class="btn btn_type02_01 modify_business"><a href="#none">수정</a></span>
					<span onclick="javascript:cancel();" class="btn btn_type01_01"><a href="#none">취소</a></span>
				</div>
				<div class="rtl modify_category create_category" style="display: none;">
					<span onclick="javascript:save();" class="btn btn_type02_01 create_category"><a href="#none">저장</a></span>
					<span onclick="javascript:save();" class="btn btn_type02_01 modify_category"><a href="#none">수정</a></span>
					<span onclick="javascript:cancel();" class="btn btn_type01_01"><a href="#none">취소</a></span>
				</div>
			</div>
			<!-- e: btn wrap-->

			
		</div>
	</div>
</div>
