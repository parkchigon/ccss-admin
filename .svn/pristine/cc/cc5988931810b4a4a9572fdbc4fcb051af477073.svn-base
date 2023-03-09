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
});

// URL 복사
function CopyToClipboard ( textToClipboard, textarea ){ 

    textarea.parentNode.style.display = "block"; 

    var success = false; 

    if ( window.clipboardData ){ 
            window.clipboardData.setData ( "Text", textToClipboard ); 
            success = true; 
    } 
    else { 
            textarea.value = textToClipboard; 
            
            var rangeToSelect = document.createRange(); 
            rangeToSelect.selectNodeContents( textarea ); 
            
            var selection = window.getSelection(); 
            selection.removeAllRanges(); 
            selection.addRange( rangeToSelect ); 

            success = true; 

            try { 
                if ( window.netscape && (netscape.security && netscape.security.PrivilegeManager) ){ 
                    netscape.security.PrivilegeManager.enablePrivilege( "UniversalXPConnect" ); 
                } 

                textarea.select(); 
                success = document.execCommand( "copy", false, null ); 
            } 
            catch ( error ){ 
                success = false; 
                console.log( error ); 
            } 
    } 

    textarea.parentNode.style.display = "none"; 
    textarea.value = ""; 

    if ( success ){ alert( ' URL이 복사되었습니다. ' ); } 
    else {    alert( " 복사하지 못했습니다. " );    } 

} 

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='push']").attr("checked", true);
			} else {
				$("input:checkbox[name='push']").attr("checked", false);
			}
		} else if($(this).attr("name") == 'push') {
			if($(this).is(":checked")) {
				if($("input:checkbox[name='push']").length == $("input:checkbox[name='push']:checked").length) {
					$("#allCheck").attr("checked", true);
				}
			} else {
				if($("input:checkbox[name='push']").length != $("input:checkbox[name='push']:checked").length) {
					$("#allCheck").attr("checked", false);
				}
			}
		}
	});
}


// 리스트 조회
function goSearch(page) {
	$("#page").val(page);

	$.ajax({
		url : "/admin/board/pushListAjax.do"
		,data : $('#pushSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
			
		if(totalResult > 0) {
			for (var i = 0; i < list.length ; i++) {
				html += "<tr>";	
				html += "	<td><input type='checkbox' value=\""+list[i].boardId+"\" name='push'></td>";
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td class='left'><a href='javascript:pushDetail(\"" + list[i].boardId + "\");' class='link'>" + escapeHtml(list[i].title) + "</td>";
				html += "	<td>" + list[i].opt7 + "</td>";
				html += "	<td>" + list[i].insertId + "</td>";
				html += "	<td>" + list[i].postDate + "</td>";
				html += "	<td>" + list[i].insertDate + "</td>";
				if ( list[i].opt1 != '' ) {
					html += "	<td ><span onclick='javascript:CopyToClipboard(\"" + list[i].fileInfoVO.filePath + "\",myClipboard )' class='btn btn_type01_01'><a href='#none'>URL복사</a></span></td>";
				} else {
					html += "	<td></td>";	
				}
				
				html +="</tr>";
			}
		} else {
			html += "<tr>"
			html += "	<td colspan='8'> 검색조건에 부합되는 데이터가 없습니다.</td>";
			html += "</tr>"
		}

		$("#paging").empty();
		$("#paging").append(data.paging);
	
		$("#pushList").empty();
		$("#pushList").append(html);
		$("#totCnt").text(totalResult);
		
	});
}

function deletePush(){
	var pushSeqArray = $("input:checkbox[name='push']:checked").map(function(){return $(this).val();}).get();
	
	if(pushSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	if(confirm("정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "/admin/board/deleteBoardAjax.do",
			type : "POST",
			data : {
				boardIdArray : pushSeqArray.toString()
			},
			dataType : "json"
		}).done(function (data) {
			var resultCode = data.resultCode;
			if(resultCode == "1001") {
				alert("푸시가 삭제 되었습니다.");
				location.reload(true);
			} else {
				alert("푸시 삭제 중 오류가 발생하였습니다.");				
			}
		
		}).error(function(data){
			alert("푸시 삭제 중 오류가 발생하였습니다.");				
		});
	}

}
// 등록 화면
function pushEditForm() {
	location.href="/admin/board/pushEditForm.do";
}

// 업데이트 주기 팝업 띄우기
function pushUpdateTimeForm() {
	commonPopup('/admin/board/pushUpdateTimePopup.do', 'appUpdateTimePopup', 'width=350, height=250, resizable=no, scrollbars=no, status=no;');
}

// 상세 화면
function pushDetail(boardId) {
	location.href="/admin/board/pushDetail.do?boardId="+boardId;
}


</script>


<!-- 내용-->

<div style="display: none;"><textarea id="myClipboard"></textarea></div>
<div class="contents_wrap">
	<form id="pushSearchForm" name="pushSearchForm" method="POST" >
	<input type="hidden" id="boardIdArr" name="boardIdArr" />
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="boardMstId" name="boardMstId" value="${boardMstVO.boardMstId}"/>
	<input type="hidden" id="useYn" name="userYn" value="Y" />
	
	
	<div class="main_top">
		<h2>
			PUSH 관리
			<a href="javascript:pushUpdateTimeForm();"><span class="rtl btn focus" style="width:80px;" > 업데이트주기</span></a>
			<a href="javascript:pushEditForm();"><span class="rtl btn focus" style="width:80px;" ><img src="/admin/resources/common/images/icon_add01.png" alt=""> 등록</span></a>
		</h2>
		
	</div>
	
	<!-- s: 검색-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
			<colgroup>
				<col width="5%"/>
				<col width="10%"/>
				<col width="30%"/>
				<col width="20%"/>
				<col width="10%"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">기간</div></th>
					<td>
						<select id="searchDateDiv" name="searchDateDiv" class="select w01" style="width:130px;">
							<option value="INSERTDATE" selected="selected">등록일</option>
							<option value="POSTDATE">발송일</option>
						</select>
					</td>
					<td colspan="2">
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
					<th><div class="tit_search">발송상태</div></th>
					<td>
						<select id="opt7" name="opt7" class="select w01" style="width:130px;">
							<option value="" selected="selected">전체</option>
							<option value="1">대기</option>
							<option value="2">성공</option>
							<option value="3">취소</option>
						</select>
					</td>
				</tr>
					
				 <tr>
					<th><div class="tit_search">검색</div></th>
					<td >
						<select id="searchType" name="searchType" class="select w01" style="width:130px;">
							<option value="TITLE" selected="selected">제목</option>
							<option value="INSERTID">작성자</option>
						</select>
					</td>
					<td colspan="4">
						<div class="input_wrap">
							<input type="text" class="input w01" id="title" name="title" style="width: 700px;" onkeydown="if(event.keyCode==13) goSearch(1);" />
							<a href="javascript:goSearch(1);"><span class="btn focus" style="width:90px;"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span></a>
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
			<a href="javascript:deletePush();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
		<div class="rtl">
			<select id="pageRowCount" name="pageRowCount" class="select w01" style="width:130px;" onchange="javascript:goSearch(1);">
				<option value="20" selected="selected">20개씩 보기</option>
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
				<col width="*"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck" id="allCheck" /></th>
					<th>No</th>
					<th>제목</th>
					<th>발송상태</th>
					<th>작성자</th>
					<th>발송일시</th>
					<th>등록일시</th>
					<th>이미지경로</th>
				</tr>
			</thead>
			<tbody id="pushList">
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
