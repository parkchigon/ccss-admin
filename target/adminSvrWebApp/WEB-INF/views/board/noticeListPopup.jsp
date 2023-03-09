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
	
	goSearch(1,"Y");

	$("#allCheck").change(function(){
		if($(this).prop("checked")) {
			$("input[name=deleteCheck]").attr("checked", true);
		} else {
			$("input[name=deleteCheck]").attr("checked", false);
		}
	});
});
// 리스트 조회
function goSearch(page) {
	$("#page").val(page);
	$.ajax({
		url : "/admin/board/noticeListAjax.do"
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
				html += '	<td><input type="radio" onclick="noticeDetail(\'' + list[i].boardId + '\');" name="noticeRadio"  value="'+list[i].boardId+'" class=""/></td>';
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td class='left'><a href='javascript:noticeDetail(\"" + list[i].boardId + "\");' class='link'>" + escapeHtml(list[i].title) + "</td>";
				var useYn = "미사용";
				if(list[i].useYn == "Y"){
					useYn ="사용";
				}
				html += "	<td>" + useYn + "</td>";
				html += "	<td>" + list[i].postDate + "</td>";
				html +="</tr>";
			}
		} else {
			html += "<tr>"
			html += "	<td colspan='5'> 검색조건에 부합되는 데이터가 없습니다.</td>";
			html += "</tr>"
		}
		
		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#noticeList").empty();
		$("#noticeList").append(html);
		$("#totCnt").text(totalResult);
		
	});
}
// 상세 화면
function noticeDetail(boardId) {
	$("#boardId").val(boardId);
	$.ajax({
		url : "/admin/board/noticeDetailAjax.do"
		,data : {boardId:boardId}
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		console.log(data);
		$("input:radio[name='noticeRadio']:radio[value='"+boardId+"']").attr("checked",true);
		$("#img").empty();
		if(data != null && data.boardVO != null){
			if(data.boardVO.content != null){
				$("#content").text(data.boardVO.content);
			}
			if(data.boardVO.fileInfoVO != null && data.boardVO.fileInfoVO.filePath != null){
				$("#img").append('<img width="300" src="'+data.boardVO.fileInfoVO.filePath+'">');
			}
		}
	});
}

function save() {
	 $(opener.document).find("#opt5").val("/home/noticeList?boardId="+$("#boardId").val());
	 exitPopup();
}
</script>
<!-- 내용-->

<body class="jui">
	<div class="popup_inner w03"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px, -->
		<div class="p_header">
             <h1>공지사항 찾기</h1>
             <a href="javascript:exitPopup();" class="btn_close"><span class="hidden_obj">닫기</span></a>
         </div> 
		<div class="p_body">
			<!-- s: table wrap-->
			
	<form id="noticeSearchForm" name="noticeSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" value="1" />
	<input type="hidden" id="useYn" name="useYn" value="Y" />
	<input type="hidden" id="serachOrderBy" name="serachOrderBy" value="POSTDATE" />
	<input type="hidden" id="boardMstId" name="boardMstId" value="${boardMstVO.boardMstId}"/>
	<input type="hidden" id="boardId" name="boardId"/>
	<!-- 내용-->
	<div class="notice_wrap">
		<div class="ltr notice_list">
			<div class="main_top">
				<h2></h2>
				<div class="location_wrap">
				배너 링크로 설정할 공지사항을 선택해주세요.
				</div>
			</div>
			
			<!-- s: 검색-->
			<!-- s: table wrap-->
			<div class="table_wrap">
				<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
					<colgroup>
						<col width="5%"/>
						<col width="5%"/>
						<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
					<th><div class="tit_search">기간</div></th>
					<td>
						<select id="searchDateDiv" name="searchDateDiv" class="select w01" style="width:100px;">
							<option value="INSERTDATE" selected="selected">등록일</option>
							<option value="POSTDATE">게시일</option>
						</select>
					</td>
					<td>
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
						<br/>
						<a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'MONTH', 1);"><span class="btn">1개월</span></a>
			            <a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'YEAR', 1);"><span class="btn">1년</span></a>
			            <a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'ALL', 1);"><span class="btn">전체</span></a>
					</td>
				</tr>
				 <tr>
					<th><div class="tit_search">검색</div></th>
					<td>
						<select id="searchType" name="searchType" class="select w01" style="width:100px;">
							<option value="TITLE" selected="selected">제목</option>
							<option value="CONTENT">내용</option>
						</select>
					</td>
					<td>
						<div class="input_wrap">
							<input type="text" class="input w01" id="title" name="title"  onkeydown="if(event.keyCode==13) goSearch(1,'Y');" />
							<a href="javascript:goSearch(1,'Y');"><span class="btn focus"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span></a>
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
					<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
				</div>
				<div class="rtl">
					<!-- <a href="javascript:boardListExcel();"><span class="btn btn_w01"><img src="/resources/common/images/icon_excel.png" alt=""/> 엑셀 다운로드</span></a> -->
					<select id="pageRowCount" name="pageRowCount" class="select w01" style="width:130px;" onchange="javascript:goSearch(1,'N');">
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
						<col width="7%"/>
						<col width="5%"/>
						<col width="*"/>
						<col width="10%"/>
						<col width="20%"/>
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th>No</th>
							<th>제목</th>
							<th>사용여부</th>
							<th>게시일시</th>
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
		
		</div>
	
	<div class="rtl notice_detail">
		<div class="main_top">
			<h2>상세내용</h2>
		</div>
		
		<!-- s: table wrap-->
		<div class="table_wrap">
			<table class="table simple table_write_type">
				<colgroup>
					<col width="16%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<th>내용</th>
						<td class="last">
							<textarea id="content" class="input textareabox" style="height:200px;"> </textarea>
						</td>
					</tr>
					<tr>
						<th>이미지</th>
						<td  id="img" class="last">
							
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- s: 하단 저장 -->
		<div class="center">
			<a href="javascript:save();"><span class="btn focus" style="width:90px;">등록</span></a>
			<a href="javascript:exitPopup();"><span class="btn" style="width:90px;">취소</span></a>
		</div>
		<!-- e: 하단 저장 -->
		<!-- e: table wrap-->
	</div>	
</div>
<!-- e: 내용-->
</body>


<script data-jui="#datepicker1" data-tpl="dates" type="text/template">
	<tr>
		<! for(var i = 0; i < dates.length; i++) { !>
		<td><!= dates[i] !></td>
		<! } !>
	</tr>
</script>

<script data-jui="#datepicker2" data-tpl="dates" type="text/template">
	<tr>
		<! for(var i = 0; i < dates.length; i++) { !>
		<td><!= dates[i] !></td>
		<! } !>
	</tr>
</script>

