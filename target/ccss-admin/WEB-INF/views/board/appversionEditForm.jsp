<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input:radio[name='useYn']:radio[value='${boardVO.useYn}']").attr("checked",true);
	$("input:radio[name='fixYn']:radio[value='${boardVO.fixYn}']").attr("checked",true);
	$("input:radio[name='contentsType']:radio[value='${boardVO.contentsType}']").attr("checked",true);
	$("input:radio[name='serviceClassifyCode']:radio[value='${boardVO.serviceClassifyCode}']").attr("checked",true);
	
	if('${boardVO.fileInfoVO.filePath}' != "") {
		$("#imgPreview").css("display", "block");
		$("#imgPreview").attr('src', '${boardVO.fileInfoVO.filePath}');	
	} 
	
	// 데이터 피커 생성
	datePicker({
		datePickerGroupId: "datepicker1_group",
		datePickerId: "datepicker1",
		//type: "monthly",
		//format: "yyyy-MM",
		nextFunction: function() {
			//alert("next");
		},
		prevFunction: function() {
            //alert("prev");
        }
	});
	
	if('${boardVO.boardId}' == "") {
		$("#postDate").val(getCurrentDate());	
	}
});


// 앱버전 등록/수정
function appversionEdit(kind) {
	if (kind == "insert") {
		$.ajax({
			url : "<c:url value='/board/appversionValidationCheck.do'/>",
			type : "POST",
			data : getFormData($("#appversionEditForm")),
			dataType : "json",
			contentType: "application/json"
		}).done(function(data) {
			if (data.result == "Y") {
				alert("이미 등록되어 있는 버전입니다.");
				return;
			} else {
				if ( checkAlert() ) {
					$("#appversionEditForm").submit();
				}
			}
		});
	} else {
		if ( checkAlert() ){
			$("#appversionEditForm").submit();
		}
	}
}


function checkAlert() {
	if (formValidationCheck(['title','originFileName'])){
		// 버전 정규식 숫자 또는 . 외 값들 입력되지 않도록한다.
		var pattern = /[0-9.]/;
		var version = $("#title").val();
		
		for (var i=0; i<version.length; i++ ) {
			if(version.charAt(i) != "" && pattern.test(version.charAt(i))==false) {
				alert("잘못된 버전양식입니다.\n 버전 정보를 다시 입력하여 주시길 바랍니다.");
				return false;
			}
		}
		 var verArray = version.split('.');
		 if (verArray.length != 3 && version.length > 3 ) {
			alert("잘못된 버전양식입니다.\n 버전 정보를 다시 입력하여 주시길 바랍니다.");
			return false;
		 }
		 for (var k=0; k<verArray.length; k++ ){
			 if(verArray[k].length > 2 ) {
				alert("잘못된 버전양식입니다.\n 버전 정보를 다시 입력하여 주시길 바랍니다.");
				return false;
			 }
		 }
		 return true;
	}else{
		return false;
	}
	
}


//미입력 항목 alert
function alertMessageSource(elId){
	switch (elId) {
	case 'title': 
		alert("버전은 필수항목입니다.");
		break;
	case 'originFileName': 
		alert("파일 업로드는 필수항목입니다.");
		break;
	}
}


function checkUploadImg(fileObj) {
	var filePath = fileObj.value;
	var fileName = filePath.substring(filePath.lastIndexOf("\\")+1);
	var fileArr = fileName.split(".");
	var fileKind = fileArr[fileArr.length-1];
	
	if(fileKind != "apk" && fileKind != "APK" ) {
		alert("APK 파일형식 또는 용량을 확인해주세요.");
		return;
	}

	if(fileObj.files[0].size > 5000000) {
		alert("이미지 파일형식 또는 용량을 확인해주세요.");
		return;
	}
	
	$("#originFileName").val(fileName);
	
}
</script>
<!-- 내용-->
<div class="contents_wrap">
<input type="hidden" name="checkYn" />
    <form id="appversionEditForm" name="appversionEditForm" method="POST" action="<c:url value='/board/appversionEdit.do'/>" enctype="multipart/form-data" >
		<input type="hidden" name="boardMstId" value="${boardMstVO.boardMstId}" />
		<input type="hidden" name="boardId" value="${boardVO.boardId}" />
		<input type="hidden" name="opt1" value="${boardVO.opt1}" />
  
    	<div class="main_top">
			<h2>버전 등록</h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">기본정보</div>
			</div>
			<div class="rtl">
				<div class="table_info01">* 필수입력</div>
			</div>
		</div>
		<!-- e: table top-->
			
		<!-- s: table wrap-->
		<div class="table_wrap">
			<table class="table simple table_write_type">
				<colgroup>
					<col width="16%"/>
					<col width="34%"/>
					<col width="16%"/>
					<col width="34%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>버전 <span class="imp">*</span></th>
						<td colspan="3" class="last">
						<c:if test="${not empty boardVO.boardId }">
							<input type="text" id="title" name="title" class="input w01" value="<c:out value="${boardVO.title}" />" readonly="readonly"/>
						</c:if>
						<c:if test="${empty boardVO.boardId }">
							<input type="text" id="title" name="title" class="input w01" value="<c:out value="${boardVO.title}" />" />
						</c:if>
						</td>
					</tr>
					<tr>
						<th>파일명<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<div class="inp_fileUpload">
								<input type="text" id="originFileName" name="originFileName" style="width: 400px;" class="input w04"  value="<c:out value="${boardVO.fileInfoVO.originFileName}" />" readonly>
								<span class="inp_fileFind"><input type="file" name="uploadfile" accept=".apk,.APK" onchange="checkUploadImg(this);"></span>
								<span class="btn focus">찾기</span>
							</div>
							<span class="imp">*</span>APK 파일 (.apk)
						</td>
					</tr>
					<tr>
						<th>비고 </th>
						<td colspan="10" class="last">
							<textarea id="content" name="content" class="input textareabox" ><c:out value="${boardVO.content}" /></textarea>
						</td>
					</tr>
					
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
		<div class="popup_container" style="display : none;">
			<div class="popup_inner w01"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px,-->
				<div class="p_header">
					<h1>미리보기</h1>
					<a href="javascript:exitPopup();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
				</div> 
				<div class="p_body">
					<div class="p_content">

						<img id="imgPreview" width="620px" height="300px">
					
						<!-- s: btn -->
						<div class="btn_wrap02">
							<a href="javascript:exitPopup();"><span class="btn large focus">확인</span></a>
						</div>
						<!-- e: btn -->
					</div>
				</div>
			</div>
		</div>
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<c:if test="${not empty boardVO.boardId }"><a href="javascript:appversionEdit('modify');"></c:if>
			<c:if test="${empty boardVO.boardId }"><a href="javascript:appversionEdit('insert');"></c:if>
				<span class="btn large focus">
					<c:if test="${not empty boardVO.boardId }">수정</c:if>
					<c:if test="${empty boardVO.boardId }">등록</c:if>
				</span>
			</a>
			<a href="javascript:history.back();"><span class="btn large">취소</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
