<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input:radio[name='useYn']:radio[value='${boardVO.useYn}']").attr("checked",true);
	$("input:radio[name='fixYn']:radio[value='${boardVO.fixYn}']").attr("checked",true);
	$("input:radio[name='contentsType']:radio[value='${boardVO.contentsType}']").attr("checked",true);
	$("input:radio[name='serviceClassifyCode']:radio[value='${boardVO.serviceClassifyCode}']").attr("checked",true);
	
	$("#content").val(safeTagToHtmlTag($("#content").val()));
	
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
		var today = new Date();
    	var hh = today.YYYYMMDDHHMMSS().substr(8,2);
    	$("#postHour").val(hh).attr("selected", "selected");
  	}else{
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
	radioCheckContentsType();
});

// 공지사항 등록/수정
function noticeEdit() {
	
	
	var contentsTypeVal = $("input:radio[name='contentsType']:checked").val();
	
	
	if(contentsTypeVal == "txt"){
		if (!formValidationCheck(['title','content'])){
			return;
		}else{
			if($("#originFileName").val() != ""){
				$("#originFileName").val("");
		        $("#uploadfile").val("");
			}
		}
		
		 
    }else if(contentsTypeVal == "img"){
		if (!formValidationCheck(['title','originFileName'])){
			return;
		}else{
			if($("#content").val() != ""){
				$("#content").val("");
			}
		}
	}else if(contentsTypeVal == "txtimg"){
		if (!formValidationCheck(['title','content','originFileName'])){
			return;
		}
	}
	var fixCount =  "${fixCount}";
	if(isEmpty(fixCount)){
		fixCount =  0;
	}
	var fixYnVal = $("input:radio[name='fixYn']:checked").val();
	
	
	var today = new Date();
	var nowDate = today.YYYYMMDDHHMMSS().substr(0,12);
	
	var postDate = $("#postDate").val().replace(/-/gi,"")+$("#postHour").val()+$("#postMinute").val();
	
	if('${boardVO.boardId}' == ""){
		
		if(Number(nowDate) >= Number(postDate)){
    		alert("게시일시를 확인해주세요.\n이전날짜 또는 시간으로 설정하실 수 없습니다.");
			return;
    	}
    	if(fixYnVal == "Y"){
			fixCount = Number(fixCount) +1;
		}
    }else{
    	if(Number(postDate) != Number("${boardVO.postDate}".replace(/-/gi,"")+"${boardVO.postHour}"+"${boardVO.postMinute}")){
    		if(Number(nowDate) >= Number(postDate)){
        		alert("게시일시를 확인해주세요.\n이전날짜 또는 시간으로 설정하실 수 없습니다.");
    			return;
        	}
    	}
    	if('${boardVO.fixYn}' != "Y"){
	   	if(fixYnVal == "Y"){
			fixCount = Number(fixCount) +1;
		}else{
			fixCount = Number(fixCount) -1;
		}
    	}
	}

	if(fixCount > 5 && fixYnVal == "Y"){
		alert("상단 고정 설정은 최대5개까지 가능합니다.\n다른 게시물을 확인 후 재설정 해주세요.");
		return;
	}

	$("#noticeEditForm").submit();
	
}

//미입력 항목 alert
function alertMessageSource(elId){
	switch (elId) {
	case 'title': 
		alert("제목은 필수항목입니다.");
		break;
	case 'content': 
		alert("내용을 입력하세요.");
		break;	
	case 'originFileName': 
		alert("파일을 등록하세요.");
		break;	
	case 'serviceYn': 
		alert("서비스 선택은 필수항목입니다.");
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
		return;
	}

	if(fileObj.files[0].size > 5000000) {
		alert("이미지 사이즈 또는 용량을 확인해주세요.");
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
	            if(imgWidth != 938) {
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

function radioCheckUseYn(){
	if($("input:radio[name='useYn']:checked").val() == "N"){
		$("input:radio[name='fixYn']:radio[value='N']").attr("checked",true);
		$("input:radio[name='fixYn']").attr("disabled",true);
	} else {
		$("input:radio[name='fixYn']").attr("disabled",false);
	}
}
function radioCheckContentsType(){
	if($("input:radio[name='contentsType']:checked").val() == "txt"){
		$("#trContent").show();
		$("#trImg").hide();
	}else if($("input:radio[name='contentsType']:checked").val() == "img"){
		$("#trContent").hide();
		$("#trImg").show();
	}else if($("input:radio[name='contentsType']:checked").val() == "txtimg"){
		$("#trContent").show();
		$("#trImg").show();
	}
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="noticeEditForm" name="noticeEditForm" method="POST" action="<c:url value='/board/noticeEdit.do'/>" enctype="multipart/form-data" >
		<input type="hidden" name="boardMstId" value="${boardMstVO.boardMstId}" />
		<input type="hidden" name="boardId" value="${boardVO.boardId}" />
		<input type="hidden" name="opt1" value="${boardVO.opt1}" />
		<div class="main_top">
			<c:if test="${not empty boardVO.boardId }"><h2>공지사항 수정</h2></c:if>
			<c:if test="${empty boardVO.boardId }"><h2>공지사항 등록</h2></c:if>
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
						<th>사용여부 <span class="imp">*</span></th>
						<td class="last">
							<input type="radio" onclick="radioCheckUseYn();" name="useYn" id="useY" class="" checked="checked" value="Y" /> <label for="useY">사용</label>&nbsp;&nbsp;
							<input type="radio" onclick="radioCheckUseYn();" name="useYn" id="useN" class="" value="N" /> <label for="useN">미사용</label>
						</td>
						<th>상단고정여부 <span class="imp">*</span></th>
						<td class="last">
							<input type="radio" name="fixYn" id="fixY" class="" value="Y" /> <label for="fixY">상단고정</label>&nbsp;&nbsp;
							<input type="radio" name="fixYn" id="fixN" class="" value="N" checked="checked" /> <label for="fixN">고정안함</label>
						</td>
					</tr>
					<tr>
						<th>내용유형 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" onclick="radioCheckContentsType();" name="contentsType" id="contentsTypeT" checked="checked" value="txt" /> <label for="contentsTypeT">TEXT</label>&nbsp;&nbsp;
							<input type="radio" onclick="radioCheckContentsType();" name="contentsType" id="contentsTypeI" value="img" /> <label for="contentsTypeI">IMAGE</label>
							<input type="radio" onclick="radioCheckContentsType();" name="contentsType" id="contentsTypeTI" value="txtimg" /> <label for="contentsTypeTI">TEXT+IMAGE</label>
						</td>
					</tr>
					
				
					<tr id="trContent">
						<th>내용</th>
						<td colspan="3" class="last">
							<textarea id="content" name="content" class="input textareabox"  style="height:400px"><c:out value="${boardVO.content}" /></textarea>
						</td>
					</tr>
					<tr id="trImg">
						<th>이미지</th>
						<td colspan="3" class="last">
							<div class="inp_fileUpload">
								<input type="text" id="originFileName" name="originFileName" style="width: 400px;" class="input w04"  value="<c:out value="${boardVO.fileInfoVO.originFileName}" />" readonly>
								<span class="inp_fileFind"><input type="file" id="uploadfile" name="uploadfile" accept=".jpg, .png" onchange="checkUploadImg(this);"></span>
								<span class="btn focus">찾기</span>
							</div>
							<ul class="list_file">
								<li class="ltr">
									<span class="imp">*</span> 이미지는 jpg/png만 등록 가능 <br/>
									<span class="imp">*</span> 가로 사이즈 938px(최대 5MB)<br/>
									<img id="imgPreview" width="938" style="display: none;">
								</li>
							</ul>
						</td>
					</tr>
					<tr>
						<th><div class="tit_search">게시일시</div></th>
						<td colspan="3" class="last">
						<span id="baanerStartImg" >
							<div id="datepicker1_group" class="group">
								<fmt:parseDate value="${boardVO.postDate}" var='postDate' pattern="yyyy-mm-dd"/>
				                <input type="text" class="input" style="width: 120px;" id="postDate" name="postDate" value="<fmt:formatDate value="${postDate}" pattern="yyyy-mm-dd"/>" />
				                <a class="btn btn-gray"><i class="icon-calendar"></i></a>
				
				                <div id="datepicker1" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
				                    <div class="head">
				                        <div class="prev"><i class="icon-chevron-left"></i></div>
				                        <div class="title"></div>
				                        <div class="next"><i class="icon-chevron-right"></i></div>
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
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:noticeEdit();">
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
