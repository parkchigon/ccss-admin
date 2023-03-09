<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
$(document).ready(function(){
	// 데이터 피커 생성
	compareDatePicker({
		startDatePickerGroupId: "datepicker1_group",
		startDatePickerId: "datepicker1",
		endDatePickerGroupId: "datepicker2_group",
		endDatePickerId: "datepicker2",
	});
	
	goSearch(1);
	checkboxClickEventHandler();
	$(".termsType").click(function() {
		$(".termsType").removeClass("focus");
		$(this).addClass("focus");
	});
	
});

// 리스트 조회
function goSearch(page) {
	$("#page").val(page);
	
	$.ajax({
		url : "/admin/notice/noticeListAjax.do"
		,data : $('#noticeSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
			
		if(totalResult > 0) {
			for (var i = 0; i < list.length ; i++) {
				html += "<tr>";	
				if(list[i].useYn == "Y"){
					html += '	<td></td>';
				}else{
					html += '	<td><input type="checkbox" value="'+list[i].noticeId+'" name="noticeCheckBox"></td>';
				}
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td class='left'><a href='javascript:noticeDetail(\"" + list[i].noticeId + "\");' class='link'>" + escapeHtml(list[i].title) + "</td>";
				html += "	<td>" + escapeHtml(list[i].content) + "</td>";
				html += "	<td>" + list[i].linkUrl + "</td>";
				var useYn = "미사용";
				if(list[i].useYn == "Y"){
					useYn ="사용";
				}
				html += "	<td>" + useYn + "</td>";
				html += "	<td>" + list[i].insertDate + "</td>";
				html += "	<td>" + list[i].updateDate + "</td>";
				html +="</tr>";
			}
		} else {
			html += "<tr>"
			html += "	<td colspan='8'> 검색조건에 부합되는 데이터가 없습니다.</td>";
			html += "</tr>"
		}
	
		if(data.noticeShowYn != null) {
			$("#currnetNoticeShowYn").val(data.noticeShowYn.opt1);
			$("#noticeShowYn").val(data.noticeShowYn.opt1);
			if(data.noticeShowYn.opt1 == "Y") {
				$("#settingFlagSpan").html('<font color="blue" style="font-weight: bold;">ON</font> 상태입니다.&nbsp;');
			} else {
				$("#settingFlagSpan").html('<font color="red" style="font-weight: bold;">OFF</font> 상태입니다.&nbsp;');
			}
		} else {
			$("#settingFlagSpan").html('<font color="red" style="font-weight: bold;">OFF</font> 상태입니다.&nbsp;');
		}
		
		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#noticeList").empty();
		$("#noticeList").append(html);
		$("#totCnt").text(totalResult);
		
	});
}

//등록 화면
function noticeEditForm() {
	location.href="/admin/notice/noticeEditForm.do";
}

//상세 화면
function noticeDetail(noticeId) {
	location.href="/admin/notice/noticeDetail.do?noticeId="+noticeId;
}

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='noticeCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='noticeCheckBox']").attr("checked", false);
			}
		}
	});
}


function deleteNotice(){
	var noticeCheckBoxSeqArray = $("input:checkbox[name='noticeCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(noticeCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	if(confirm("정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "/admin/notice/deleteNoticeAjax.do",
			type : "POST",
			data : {
				noticeIdArray : noticeCheckBoxSeqArray.toString()
			},
			dataType : "json"
		}).done(function (data) {
			var resultCode = data.resultCode;
			if(resultCode == "1001") {
				alert("삭제 되었습니다.");
				location.reload(true);
			} else {
				alert("삭제 중 오류가 발생하였습니다.");				
			}
		
		}).error(function(data){
			alert("삭제 중 오류가 발생하였습니다.");				
		});
	}
}

function openOnOffPopup(){
	if($("#currnetNoticeShowYn").val() == "Y") {
		toggleOnOff(true);
	} else {
		toggleOnOff(false);
	}
	openLayerPopup($("#noticeOnOffPopup"));
}

</script>
<!-- 내용-->
<div class="contents_wrap">
<form id="noticeSearchForm" name="noticeSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" value="1" />
	
	<div class="main_top">
		<h2>
			Notice 관리
			<a href="javascript:noticeEditForm();"><span class="rtl btn focus" style="width:80px;" ><img src="/admin/resources/common/images/icon_add01.png" alt=""> 등록</span></a>
			<a href="javascript:openOnOffPopup();"><span class="rtl btn focus" style="width:80px;" ><img src="/admin/resources/common/images/icon_add01.png" alt=""> 설정</span></a>
			<span class="rtl">현재 Notice 노출은 <span id="settingFlagSpan"> 상태입니다.&nbsp;</span>
		</h2>
		
	</div>
	
	<!-- s: 검색-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
			<colgroup>
				<col width="10%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">기간</div></th>
					<td>
						<select id="searchDateDiv" name="searchDateDiv" class="select w01" style="width:130px;">
							<option value="INSERT_DATE" selected="selected">등록일</option>
							<option value="UPDATE_DATE">수정일</option>
						</select>
						<div id="datepicker1_group" class="group">
							<input type="text" class="input" style="width: 157px;" id="startDate" name="startDate" maxlength="8" readonly />
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
						<div id="datepicker2_group" class="group">
							<input type="text" class="input" style="width: 157px;" id="endDate" name="endDate" maxlength="8" readonly />
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
						<a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'MONTH', 1);"><span class="btn">1개월</span></a>
			            <a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'YEAR', 1);"><span class="btn">1년</span></a>
			            <a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'ALL', 1);"><span class="btn">전체</span></a>
					</td>
				</tr>
				<tr>	
					<th><div class="tit_search">사용여부</div></th>
					<td>
						<select id="useYn" name="useYn" class="select w01" style="width:130px;">
							<option value="" selected="selected">전체</option>
							<option value="Y">사용</option>
							<option value="N">미사용</option>
						</select>
					</td>
				</tr>
				 <tr>
					<th><div class="tit_search">검색</div></th>
					<td>
						<div class="input_wrap">
							<select id="searchType" name="searchType" class="select w01" style="width:130px;">
								<option value="TITLE" selected="selected">제목</option>
								<option value="CONTENT">내용</option>
							</select>
							<input type="text" class="input w01" id="content" name="content" style="width: 700px;" onkeydown="if(event.keyCode==13) goSearch(1,'Y');" />
							<a href="javascript:goSearch(1,'Y');"><span class="btn focus" style="width:90px;"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span></a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	<!-- e: 검색-->
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<a href="javascript:deleteNotice();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
		<div class="rtl">
			<!-- <a href="javascript:boardListExcel();"><span class="btn btn_w01"><img src="/resources/common/images/icon_excel.png" alt=""/> 엑셀 다운로드</span></a> -->
			<select id="pageRowCount" name="pageRowCount" class="select w01" style="width:130px;" onchange="javascript:goSearch(1,'N');">
				<option value="20" >20개씩 보기</option>
				<option value="50" >50개씩 보기</option>
				<option value="100" >100개씩 보기</option>
			</select>
		</div>
	</div>
	<!-- e: table top-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="5%"/>
				<col width="15%"/>
				<col width="*"/>
				<col width="15%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck" id="allCheck" /></th>
					<th>No</th>
					<th>제목</th>
					<th>내용</th>
					<th>링크(URL)</th>
					<th>사용여부</th>
					<th>등록일시</th>
					<th>수정일시</th>
				</tr>
			</thead>
			<tbody id="noticeList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>
