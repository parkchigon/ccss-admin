<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
$(document).ready(function(){
	 
	//$("input:radio[name='useYn']:radio[value='${detail.useYn}']").attr("checked", true);
	
	var detail = '${detail}';
	if(detail) {
		$("#regMangetNotice").hide();
		$("#modifyMangetNotice").show();
	} else {
		$("#regMangetNotice").show();
		$("#modifyMangetNotice").hide();
	}
	
	var start = '${detail.startDtime}';
	
	if(start) {
		$("#startHour").val(start.split(" ")[1].split(":")[0]);
		$("#startMinute").val(start.split(" ")[1].split(":")[1]);
	}
	
	
	
	var seqMaintenanceNoticeId = '${detail.seqMaintenanceNoticeId}';
	if(seqMaintenanceNoticeId) {
		$("input[type='radio']").attr("disabled", true);
		$("input[type='text']").attr("disabled", true);
		$("textarea").attr("disabled", true);
		$("select").attr("disabled", true);
		$("a").attr("disabled", true);
	} else {
		makeDatePicker();
		$("#startDate").val(getCurrentDate());
		$("#winnerPublDate1").val(getCurrentDate());
		$("#postDtimeDate").val(getCurrentDate());
	}

});

//데이터 피커 생성
function makeDatePicker(){

	compareDatePicker({
		startDatePickerGroupId: "datepicker1_group",
		startDatePickerId: "datepicker1",
	});
}


function modifyBtn() {
	$("input[type='radio']").attr("disabled", false);
	$("input[type='text']").attr("disabled", false);
	$("textarea").attr("disabled", false);
	$("select").attr("disabled", false);
	$("a").attr("disabled", false);
	makeDatePicker();
	$("#regMangetNotice").show();
	$("#modifyMangetNotice").hide();
}

//등록/수정
function regManageNotice() {
	if(noticeEditValidation()) {
		$.ajax({
			url : "/admin/manage/insertMaintenanceFadeOutAjax.do",
			data : $("#manageNoiceRegForm").serialize().replace(/%/g,'%25'),
			method : "POST",
			success : function(response) {
				if(response.resultCode == "1001") {
					if($("#seqMaintenanceNoticeId").val()) {
						//alert("서비스 종료 공지가 수정되었습니다.");
					} else {
						//alert("서비스 종료 공지가 등록되었습니다.");
					}
					location.href = "/admin/manage/fadeOutList.do";
				} else {
					if($("#seqMaintenanceNoticeId").val()) {
						alert("서비스 종료 공지가 수정중 에러가 발생하였습니다.");
					} else {
						alert("서비스 종료 공지가 등록중 에러가 발생하였습니다.");
					}
				}
			}
		}).error(function(data) {
			if($("#seqMaintenanceNoticeId").val()) {
				alert("서비스 종료 공지가 수정중 에러가 발생하였습니다.");
			} else {
				alert("서비스 종료 공지가 등록중 에러가 발생하였습니다.");
			}
		});
	}
}

function noticeEditValidation() {
	//var useYn = $("input[name='useYn']:checked").val();
	var targetType = $("input[name='targetType']:checked").val();
	//var title = $("#title").val();
	var webContent = $("#web_content").val();
	var appContent = $("#app_content").val();
	var startDate = $("#startDate").val();
	var startHour = $("#startHour").val();
	var startMinute = $("#startMinute").val();

	
// 	if(title == null || title == '') {
// 		alert("제목 항목을 입력해 주세요");
// 		$("#title").focus();
// 		return false;
// 	}
	
	if(targetType == "COM") {
		if(webContent == null || webContent == '') {
			alert("Web 내용 항목을 입력해 주세요");
			$("#web_content").focus();
			return false;
		}
		if(appContent == null || appContent == '') {
			alert("App 내용 항목을 입력해 주세요");
			$("#app_content").focus();
			return false;
		}
	} else if(targetType == "WEB") {
		if(webContent == null || webContent == '') {
			alert("Web 내용 항목을 입력해 주세요");
			$("#web_content").focus();
			return false;
		}
	} else if(targetType == "APP") {
		if(appContent == null || appContent == '') {
			alert("App 내용 항목을 입력해 주세요");
			$("#app_content").focus();
			return false;
		}
	}

	
	if(startDate == null || startDate == '') {
		alert("게시 시작 날짜를 선택해 주세요.");
		return false;
	}
	
	var startArray = startDate.split("-");
	var startDTime = new Date(startArray[0], Number(startArray[1])-1, startArray[2], startHour, startMinute);
	var nowDTime = new Date(); 
	
	
	return true;
}

</script>


<!-- 내용-->
<div class="contents_wrap">
	    <div class="main_top">
	        <h2 id="titleh2">서비스 종료 공지 등록</h2>
			
	    </div>
	    
	
	<form id="manageNoiceRegForm">
	<input type="hidden" id="seqMaintenanceNoticeId" name="seqMaintenanceNoticeId" value="${detail.seqMaintenanceNoticeId}">
	<input type="hidden" name="noticeType" value="FADEOUT" id="noticeType" class="" /> 
	<input type="hidden" id="title" name="title" class="input w01" value="서비스종료" />
	<input type="hidden" id="useYn" name="useYn" class="input w01" value="Y" />
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table class="table simple table_write_type">
			<colgroup>
				<col width="11%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
			
<!-- 				<tr> -->
<!-- 					<th>제목&nbsp;<span class="imp">*</span></th> -->
<!-- 					<td colspan="3" class="last"> -->
<%-- 						<input type="text" id="title" name="title" class="input w01" value="<c:out value="${detail.title}" />" /> --%>
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<th>사용여부&nbsp;<span class="imp">*</span></th> -->
<!-- 					<td colspan="3" class="last"> -->
<!-- 						<input type="radio" name="useYn" value="Y"id="useYes" class="" checked="checked"/> <label for="useYes">사용</label>&nbsp;&nbsp; -->
<!-- 						<input type="radio" name="useYn" value="N"id="useNo" class="" /> <label for="useNo">미사용</label>&nbsp;&nbsp; -->
<!-- 					</td> -->
<!-- 				</tr> -->
				<tr id="tr_web_content">
					<th>내용</th>
					<td colspan="3" class="last">
						<textarea id="web_content" name="content" class="input textareabox" style="height: 500px;" placeholder="텍스트 형태로 입력해주세요"><c:out value="${detail.content}"/></textarea>
					</td>
				</tr>
				<tr>
					<th>서비스종료일</th>
					<td colspan="3" style="border-right: 0;">
						<div id="datepicker1_group" class="group">
							<input type="text" class="input" style="width: 157px;" id="startDate" name="startDate" maxlength="8" readonly="readonly" value='<c:out value="${fn:substring(detail.startDtime,0, 10)}"/>'/>
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
						<select class="select w01" style="width: 100px;" id="startHour" name="startHour">
							<c:forEach var="hours" begin="00" end="23">
								<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
								<option value="${hour}" <c:if test="${empty boardVO.boardId and hour eq 12}">selected="selected"</c:if>
														 <c:if test="${!empty boardVO.boardId and hour eq boardVO.postHour}">selected="selected"</c:if> >${hour}</option>
							</c:forEach>
						</select>
						 &nbsp;시 &nbsp;
						<select class="select w01" style="width: 100px;" id="startMinute" name="startMinute">
							<c:forEach var="minutes" begin="00" end="11">
								<fmt:formatNumber var="minute" value="${minutes*5}" pattern="00" />
								<option value="${minute}" <c:if test="${empty boardVO.boardId and minute eq 00}">selected="selected"</c:if> 
															<c:if test="${!empty boardVO.boardId and minute eq boardVO.postMinute}">selected="selected"</c:if>>${minute}</option>
							</c:forEach>
						</select>
						&nbsp;분 &nbsp;
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</form>
<!-- 	<div class="rtl">
		<a href="javascript:openPopup();"><span class="btn focus"><img src="/resources/common/images/icon_search01.png"  alt=""/> 미리보기</span></a>
	</div> -->
	<div class="btn_wrap02">
		<a href="javascript:regManageNotice();" id="regMangetNotice"><span class="btn large focus" id="editEventBtn">
					<c:if test="${not empty detail.seqMaintenanceNoticeId }">수정</c:if>
					<c:if test="${empty detail.seqMaintenanceNoticeId }">등록</c:if></span></a>
		<a href="javascript:modifyBtn();" id="modifyMangetNotice" style="display: none;"><span class="btn large focus" >수정</span></a>
		<a href="javascript:returnToEdit();" id="returnToEdit" style="display: none;"><span class="btn large focus" >확인</span></a>
		<a href="javascript:history.back();"><span class="btn large" id="editEventBackBtn">취소</span></a>
	</div>
</div>
				
				