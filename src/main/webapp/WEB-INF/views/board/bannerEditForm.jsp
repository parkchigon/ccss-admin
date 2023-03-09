<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input:radio[name='useYn']:radio[value='${boardVO.useYn}']").attr("checked",true);
	$("input:radio[name='contentsType']:radio[value='${boardVO.contentsType}']").attr("checked",true);
	
	if('${boardVO.fileInfoVO.filePath}' != "") {
		$("#imgPreview").css("display", "block");
		$("#imgPreview").attr('src', '${boardVO.fileInfoVO.filePath}');	
	} 
	compareDatePicker({
		startDatePickerGroupId: "datepicker1_group",
		startDatePickerId: "datepicker1",
		endDatePickerGroupId: "datepicker2_group",
		endDatePickerId: "datepicker2",
	});
	
	if('${boardVO.boardId}' == "") {
	  	$("#postDate").val(getCurrentDate());
		$("#bannerEndDate").val(getCurrentDate());
		var today = new Date();
    	var hh = today.YYYYMMDDHHMMSS().substr(8,2);
    	$("#postHour").val(hh).attr("selected", "selected");
    	$("#bannerEndHour").val(hh).attr("selected", "selected");
	}else{
		if('${boardVO.bannerEndDate}' == ""){
			$("input:checkbox[name='endYn']").attr("checked", true);
			checkBoxEndYn();
		}
		if('${boardVO.postDate}' != ""){
	    	var postDate = "${boardVO.postDate}".replace(/-/gi,"")+"${boardVO.postHour}"+"${boardVO.postMinute}";
	    	var today = new Date();
	    	var nowDate = today.YYYYMMDDHHMMSS().substr(0,12);
	    	if(Number(nowDate) >= Number(postDate)){
	    		$("#baanerStartImg").hide();
	    		$("#baanerStartImg").after("${boardVO.postDate}&nbsp;"+"${boardVO.postHour}"+"&nbsp;시"+"${boardVO.postMinute}"+"&nbsp;분");
	    	}
		}
	}
	var contentsTypeVal = $("input:radio[name='contentsType']:checked").val();
	if(contentsTypeVal == "NOTICE"){
		$("#noticeBtn").show();
	}else{
		$("#noticeBtn").hide();
	}
});

// 배너 등록/수정
function bannerEdit(){
	var useYn = $("input:radio[name='useYn']:checked").val();
 	var checkStr = ['title','opt5','originFileName'];
	if(useYn == "N"){
		checkStr = ['title','opt5'];
	}
	if (formValidationCheck(checkStr)){
		var contentsTypeVal = $("input:radio[name='contentsType']:checked").val();
		if(contentsTypeVal == "NOTICE" && $("#opt5").val() == ""){
			alert("선택된 공지사항이 없습니다.");
			return;
		}else if(contentsTypeVal == "OUTERLINK" && $("#opt5").val() == ""){
			alert("배너링크(URL) 은 필수항목입니다.");
			return;
		}
		
		var bannerCount =  "${bannerCount}";
		if(isEmpty(bannerCount)){
			bannerCount =  0;
		}
		var today = new Date();
    	var nowDate = today.YYYYMMDDHHMMSS().substr(0,12);
    	
    	var postDate = $("#postDate").val().replace(/-/gi,"")+$("#postHour").val()+$("#postMinute").val();
    	var bannerEndDate = $("#bannerEndDate").val().replace(/-/gi,"")+$("#bannerEndHour").val()+$("#bannerEndMinute").val();
    	
    	var useYnVal = $("input:radio[name='useYn']:checked").val();
    	
		if('${boardVO.boardId}' == ""){
			if(Number(nowDate) >= Number(postDate)){
	    		alert("게시시작일시를 확인해주세요.\n이전날짜 또는 시간으로 설정하실 수 없습니다.");
				return;
	    	}
			if(useYnVal == "Y"){
				bannerCount = Number(bannerCount) +1;
			}
			
	    }else{
			if(useYnVal == "Y"){
				bannerCount = Number(bannerCount) +1;
			}else{
				bannerCount = Number(bannerCount) -1;
			}
		}
		
		if((Number(nowDate) >= Number(bannerEndDate) || Number(postDate) >= Number(bannerEndDate)) && $("input[name=endYn]:checked").length == 0){
    		alert("게시 기간 설정을 확인해주세요.");
			return;
    	}
		
		if(bannerCount > 5){
			if(confirm("현재 노출중인 배너가5개 이상이며,\n기존 배너 게시종료일시에 맞추어 순차적으로 게시됩니다.")) {
				$("#bannerEditForm").submit();
			}
		}else if(bannerCount <= 0 && '${boardVO.boardId}' != ""){
			alert("최소 1개의 배너를 노출해야합니다.");
			$("input:radio[name='useYn']:radio[value='Y']").attr("checked",true);
			return;
		}else{
			$("#bannerEditForm").submit();
		}
	}
}

//미입력 항목 alert
function alertMessageSource(elId){
	switch (elId) {
	case 'title': 
		alert("제목은 필수항목입니다.");
		break;
	case 'opt5': 
		alert("배너링크(URL) 은 필수항목입니다.");
		break;
	case 'originFileName': 
		alert("이미지는 필수항목입니다.");
		break;	
		
	}
}


function checkUploadImg(fileObj) {
	var filePath = fileObj.value;
	var fileName = filePath.substring(filePath.lastIndexOf("\\")+1);
	var fileArr = fileName.split(".");
	var fileKind = fileArr[fileArr.length-1];
	
	if(fileKind != "jpg" && fileKind != "png" && fileKind != "JPG" && fileKind != "PNG") {
		alert("이미지 파일형식을 확인해주세요.");
		$("#originFileName").val("");
		$("#uploadfile").val("");
        $("#imgPreview").attr("src", "");
        $("#imgPreview").css("display", "none");
		return;
	}

	if(fileObj.files[0].size > 5000000) {
		alert("이미지 사이즈 또는 용량을 확인해주세요.");
		$("#originFileName").val("");
		$("#uploadfile").val("");
        $("#imgPreview").attr("src", "");
        $("#imgPreview").css("display", "none");
		return;
	}
		
	$("#originFileName").val(fileName);
	
	if (fileObj.files && fileObj.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#imgPreview').attr('src', e.target.result);
            $("#imgPreview").css("display", "block");
        }
        reader.readAsDataURL(fileObj.files[0]);
        var i =0;
        $("#imgPreview").load(function() {
            // 이미지 크키가 정해져 있지 않을때
            var imgWidth = this.naturalWidth;
            // 이미지 크키가 정해져 있지 않을때
            var imgHeight = this.naturalHeight;
            
            if(i==0){
            	i++;
	            if(imgWidth != 1080) {
	                alert("이미지 사이즈 또는 용량을 확인해주세요.");
	                $("#originFileName").val("");
	                $("#uploadfile").val("");
	                $("#imgPreview").attr("src", "");
	                $("#imgPreview").css("display", "none");
	                return;
	            }
	            
	            if(imgHeight != 150) {
	                alert("이미지 사이즈 또는 용량을 확인해주세요.");
	                $("#originFileName").val("");
	                $("#uploadfile").val("");
	                $("#imgPreview").attr("src", "");
	                $("#imgPreview").css("display", "none");
	                return;
	            }
            
            }
            
        });
    }
}
function checkBoxEndYn() {
	if($("input[name=endYn]:checked").length > 0) {
		$("#bannerEndDate").val("");
		$("#bannerEndHour").val("");
		$("#bannerEndMinute").val("");
		$("#bannerEndDate").attr("disabled",true);
		$("#bannerEndHour").attr("disabled",true);
		$("#bannerEndMinute").attr("disabled",true);
		$("#baanerEndImg").hide();
		
		
	}else{
		$("#bannerEndDate").val(getCurrentDate());
		$("#bannerEndDate").attr("disabled",false);
		$("#bannerEndHour").attr("disabled",false);
		$("#bannerEndMinute").attr("disabled",false);
		$("#baanerEndImg").show();
	}
	
}

function radioContentsType(){
	var contentsTypeVal = $("input:radio[name='contentsType']:checked").val();
	if(contentsTypeVal == "NOTICE"){
		$("#noticeBtn").show();
		$("#opt5").attr("readonly",true);
		$("#opt5").val("");
	}else{
		$("#noticeBtn").hide();
		$("#opt5").attr("readonly",false);
		$("#opt5").val("");
	}
}

function bannerUrlSearch() {
	
	var popUrl = "<c:url value='/board/noticeListPopup.do'/>";
	var popOption = "width=1300, height=700, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
	window.open(popUrl,"previewObj",popOption);

// 	openLayerPopup($("#noticeListPopup"));
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="bannerEditForm" name="bannerEditForm" method="POST" action="<c:url value='/board/bannerEdit.do'/>" enctype="multipart/form-data" >
		<input type="hidden" name="boardMstId" value="${boardMstVO.boardMstId}" />
		<input type="hidden" name="boardId" value="${boardVO.boardId}" />
		<input type="hidden" name="opt1" value="${boardVO.opt1}" />
		<div class="main_top">
			<c:if test="${not empty boardVO.boardId }"><h2>배너 수정</h2></c:if>
			<c:if test="${empty boardVO.boardId }"><h2>배너 등록</h2></c:if>
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
						<th>제목 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" id="title" name="title" class="input w01" value="<c:out value="${boardVO.title}" />" />
						</td>
					</tr>
					<tr>
						<th>링크유형<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" onclick="radioContentsType();" name="contentsType" id="contentsTypeT" value="NOTICE" /> <label for="contentsTypeT">공지시항</label>&nbsp;&nbsp;
							<input type="radio" onclick="radioContentsType();" name="contentsType" id="contentsTypeI" checked="checked"  value="OUTERLINK" /> <label for="contentsTypeI">외부링크</label>
							
						</td>
					</tr>
					<tr>
						<th>배너링크(URL) <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" id="opt5" name="opt5" style="width: 500px;" class="input w01" value="<c:out value="${boardVO.opt5}" />" />
							<span id="noticeBtn" onclick="bannerUrlSearch();" class="btn focus">찾기</span>
						</td>
					</tr>
					<tr>
						<th>사용여부 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" name="useYn" id="useY" class="" checked="checked" value="Y" /> <label for="useY">사용</label>&nbsp;&nbsp;
							<input type="radio" name="useYn" id="useN" class="" value="N" /> <label for="useN">미사용</label>
						</td>
					</tr>
					<tr>
						<th>이미지<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<div class="inp_fileUpload">
								<input type="text" id="originFileName" name="originFileName" style="width: 400px;" class="input w04"  value="<c:out value="${boardVO.fileInfoVO.originFileName}" />" readonly>
								<span class="inp_fileFind"><input type="file" id="uploadfile" name="uploadfile" accept=".jpg, .png" onchange="checkUploadImg(this);"></span>
								<span class="btn focus">찾기</span>
							</div>
							<ul class="list_file">
								<li class="ltr">
									<span class="imp">*</span> 이미지는 jpg/png만 등록 가능 <br/>
									<span class="imp">*</span> 이미지 사이즈 1080X150px(최대 5MB)<br/>
									<img id="imgPreview" width="1080" height="150" style="display: none;">
								</li>
							</ul>
						</td>
					</tr>
					<tr>
					<th>게시 기간</th>
					<td colspan="3" style="border-right: 0;">
						<span id="baanerStartImg" >
						<div id="datepicker1_group" class="group">
							<fmt:parseDate value="${boardVO.postDate}" var='postDate' pattern="yyyy-mm-dd"/>
							<input type="text" class="input" style="width: 157px;" id="postDate" name="postDate" maxlength="8" readonly="readonly" value="<fmt:formatDate value="${postDate}" pattern="yyyy-mm-dd"/>" />
							<a class="btn btn-gray"><i class="icon-calendar"></i></a>
							<div id="datepicker1" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
								<div class="head">
									<div class="prev">
										<i class="icon-chevron-left"></i>
									</div>
									<div class="title"></div>
									<div class="next">
										<i class="icon-chevron-right"></i>
									</div>
								</div>
								<table class="body">
									<tr>
										<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
									</tr>
								</table>
							</div>
						</div>
			            &nbsp;
						<select class="select w01" style="width: 100px;" id="postHour" name="postHour">
							<c:forEach var="hours" begin="00" end="23">
								<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
								<option value="${hour}" <c:if test="${empty boardVO.boardId and hour eq 12}">selected="selected"</c:if>
														 <c:if test="${!empty boardVO.boardId and hour eq boardVO.postHour}">selected="selected"</c:if> >${hour}</option>
							</c:forEach>
						</select>
						 &nbsp;시 &nbsp;
						<select class="select w01" style="width: 100px;" id="postMinute" name="postMinute">
							<c:forEach var="minutes" begin="00" end="59">
								<fmt:formatNumber var="minute" value="${minutes}" pattern="00" />
								<option value="${minute}" <c:if test="${empty boardVO.boardId and minute eq 00}">selected="selected"</c:if> 
															<c:if test="${!empty boardVO.boardId and minute eq boardVO.postMinute}">selected="selected"</c:if>>${minute}</option>
							</c:forEach>
						</select>
						&nbsp;분 &nbsp; 
						</span>
						<span id="baanerEndImg" >
						~ &nbsp;&nbsp;
						<div id="datepicker2_group" class="group">
							<fmt:parseDate value="${boardVO.bannerEndDate}" var='bannerEndDate' pattern="yyyy-mm-dd"/>
							<input type="text" class="input" style="width: 157px;" id="bannerEndDate" name="bannerEndDate" maxlength="8" readonly="readonly" value="<fmt:formatDate value="${bannerEndDate}" pattern="yyyy-mm-dd"/>" />
							<a class="btn btn-gray"><i class="icon-calendar"></i></a>
							<div id="datepicker2" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
								<div class="head">
									<div class="prev">
										<i class="icon-chevron-left"></i>
									</div>
									<div class="title"></div>
									<div class="next">
										<i class="icon-chevron-right"></i>
									</div>
								</div>
								<table class="body">
									<tr>
										<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
									</tr>
								</table>
							</div>
						</div>
			            &nbsp;
						<select class="select w01" style="width: 100px;" id="bannerEndHour" name="bannerEndHour">
							<c:forEach var="hours" begin="00" end="23">
								<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
								<option value="${hour}" <c:if test="${empty boardVO.boardId and hour eq 12}">selected="selected"</c:if>
														 <c:if test="${!empty boardVO.boardId and hour eq boardVO.bannerEndHour}">selected="selected"</c:if> >${hour}</option>
							</c:forEach>
						</select>
						 &nbsp;시 &nbsp;
						<select class="select w01" style="width: 100px;" id="bannerEndMinute" name="bannerEndMinute">
							<c:forEach var="minutes" begin="00" end="59">
								<fmt:formatNumber var="minute" value="${minutes}" pattern="00" />
								<option value="${minute}" <c:if test="${empty boardVO.boardId and minute eq 00}">selected="selected"</c:if> 
															<c:if test="${!empty boardVO.boardId and minute eq boardVO.bannerEndMinute}">selected="selected"</c:if>>${minute}</option>
							</c:forEach>
						</select>
						&nbsp;분 &nbsp;
						</span> 
						<input type="checkbox" onclick="checkBoxEndYn()" name="endYn" id="endYn" value="Y" /> <label for="useYn">종료일 설정 없응</label>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:bannerEdit();">
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
