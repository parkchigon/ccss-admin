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

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='appversion']").attr("checked", true);
			} else {
				$("input:checkbox[name='appversion']").attr("checked", false);
			}
		} else if($(this).attr("name") == 'appversion') {
			if($(this).is(":checked")) {
				if($("input:checkbox[name='appversion']").length == $("input:checkbox[name='appversion']:checked").length) {
					$("#allCheck").attr("checked", true);
				}
			} else {
				if($("input:checkbox[name='appversion']").length != $("input:checkbox[name='appversion']:checked").length) {
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
		url : "<c:url value='/board/appversionListAjax.do'/>"
		,data : $('#appversionSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		console.log(data);
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
			
		if(totalResult > 0) {
			for (var i = 0; i < list.length ; i++) {
				html += "<tr>";	
				html += "	<td><input type='checkbox' value=\""+list[i].boardId+"\" name='appversion'></td>";
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td class='center'><a href='javascript:appversionDetail(\"" + list[i].boardId + "\");' class='link'>" + escapeHtml(list[i].title) + "</td>";
				if(list[i].fileInfoVO != null){
					html += "	<td>" + list[i].fileInfoVO.originFileName + "</td>";
				}else{
					html += "	<td></td>";
				}
				html += "	<td>" + list[i].insertDate + "</td>";
				html +="</tr>";
			}
		} else {
			html += "<tr>"
			html += "	<td colspan='5'> 검색조건에 부합되는 데이터가 없습니다.</td>";
			html += "</tr>"
		}

		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#appversionList").empty();
		$("#appversionList").append(html);
		$("#totCnt").text(totalResult);
			
	});
}

//앱버전 삭제
function deleteAppversion(){
	var appversionSeqArray = $("input:checkbox[name='appversion']:checked").map(function(){return $(this).val();}).get();
	
	if(appversionSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	if(confirm("정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "<c:url value='/board/deleteBoardAjax.do'/>",
			type : "POST",
			data : {
				boardIdArray : appversionSeqArray.toString()
			},
			dataType : "json"
		}).done(function (data) {
			var resultCode = data.resultCode;
			if(resultCode == "1001") {
				alert("앱 버전이 삭제 되었습니다.");
				location.reload(true);
			} else {
				alert("앱 버전 삭제 중 오류가 발생하였습니다.");				
			}
		
		}).error(function(data){
			alert("앱 버전 삭제 중 오류가 발생하였습니다.");				
		});
	}

}

// 등록 화면
function appversionEditForm() {
	location.href="<c:url value='/board/appversionEditForm.do'/>";
}

// 상세 화면
function appversionDetail(boardId) {
	location.href="<c:url value='/board/appversionDetail.do?boardId='/>"+boardId;
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="appversionSearchForm" name="appversionSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="boardIdArr" name="boardIdArr" />
	<input type="hidden" id="page" name="page" value="1" />
	<input type="hidden" id="boardMstId" name="boardMstId" value="${boardMstVO.boardMstId}"/>
	<input type="hidden" id="fixYn" name="fixYn" />
	<input type="hidden" id="searchDateDiv" name="searchDateDiv" value="INSERTDATE" />
	
	
	<div class="main_top">
		<h2>
			버전 관리
			<a href="javascript:appversionEditForm();"><span class="rtl btn focus" style="width:80px;" ><img src="<c:url value='/resources/common/images/icon_add01.png'/>" alt=""> 등록</span></a>
		</h2>
		
	</div>

	<!-- s: 검색-->
	<!-- s: table wrap-->
	
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="15%"/>
				<col width="35%"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">등록일</div></th>
					<td colspan="3">
						<div id="datepicker1_group" class="group">
							<input type="text" class="input" style="width: 157px;" id="startDate" name="startDate" maxlength="8"  readonly="readonly" />
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
							<input type="text" class="input" style="width: 157px;" id="endDate" name="endDate" maxlength="8" readonly="readonly"/>
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
				    <td>
							<a href="javascript:goSearch(1);"><span class="btn focus" style="width:90px;"><img src="<c:url value='/resources/common/images/icon_search01.png'/>"  alt=""/> 검색</span></a>
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
			<a href="javascript:deleteAppversion();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
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
				<col width="10%"/>
				<col width="*"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck" id="allCheck" /></th>
					<th>No</th>
					<th>버전</th>
					<th>파일명</th>
					<th>등록일시</th>
				</tr>
			</thead>
			<tbody id="appversionList">
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
