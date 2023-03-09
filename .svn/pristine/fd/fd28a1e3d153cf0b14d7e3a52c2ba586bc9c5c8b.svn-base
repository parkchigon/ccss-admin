<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {

	// 데이터 피커 생성
	compareDatePicker({
		startDatePickerGroupId: "datepicker1_group",
		startDatePickerId: "datepicker1",
		endDatePickerGroupId: "datepicker2_group",
		endDatePickerId: "datepicker2",
	});
	
	goSearch('1');
	
});

function goSearch(page) {
	$("#page").val(page);
	
	$.ajax({
		url : "/admin/usermng/selectUserListAjax.do"
		,data : $('#userHistSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data){
		console.log(data);
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		
		if(totalResult > 0) {
			for (var i=0; i<list.length; i++) {
				html += '<tr>';
				html += '	<td>' + list[i].rnum + '</td>';
				html += '	<td>' + list[i].ctn + '</td>';
				html += '	<td>' + list[i].hash +'</td>';
				html += '	<td>' + list[i].haVer  + '</td>';
				html += '	<td>' + list[i].osInfo  + '</td>';
				html += '	<td>' + list[i].model  + '</td>';
				html += '	<td>' + list[i].joinDate  + '</td>';
				html += '	<td>' + list[i].updateTypeName  + '</td>';
				html += '	<td>' + list[i].updateDate  + '</td>';
				html += '	<td>' + list[i].latestUseDate  + '</td>';
				html += '</tr>';
			}
		} else {
			html += "<tr>"
			html += "	<td colspan='10'> 검색조건에 부합되는 데이터가 없습니다.</td>";
			html += "</tr>"			
		}
		
		$("#userHistList").empty();
		$("#userHistList").append(html);
		$("#paging").empty();
		$("#paging").append(data.paging);
		$("#totCnt").text(totalResult);
	});
}

function downloadExcel() {
	$("#userHistSearchForm").attr("action", "/admin/usermng/selectUserListExcel.do");
	$("#userHistSearchForm").submit();
}


function openUserServiceUseStatPopup(hash, ctn) {
	var url="/admin/usermng/userServiceUseListPopup.do?hash="+hash+"&ctn="+ctn; 
	commonPopup(url,'selectUserServiceUseListPopup','width=1162,height=756,scrollbars=yes');
}
function openUserInfoPopup(cnt, haVer, osInfo, model, nwInfo, pushRegDate) {
	
	$("#userCtn").text(cnt);
	$("#haVer").text(haVer);
	$("#osInfo").text(osInfo);
	$("#model").text(model);
	$("#nwInfo").text(nwInfo);
	$("#pushRegDate").text(pushRegDate);
	openLayerPopup($("#userInfoPopup"));
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="userHistSearchForm" name="userHistSearchForm" method="POST"  >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>
			사용자 정보
		</h2>
		
	</div>
	
	<!-- s: 검색-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">기간</div></th>
					<td>
						<select id="searchDateDiv" name="searchDateDiv" class="select w01" style="width:130px;">
							<option value="JOIN_DATE" selected="selected">가입일자</option>
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
					<th><div class="tit_search">검색</div></th>
					<td>
						<div class="input_wrap">
							<select id="searchType" name="searchType" class="select w01" style="width:130px;">
								<option value="CTN" selected="selected">전화번호</option>
								<option value="HASH">회원 ID</option>
							</select>
							<input type="text" class="input w02" id="searchText" name="searchText" onkeydown="if(event.keyCode==13) goSearch(1);"/>
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
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
		<div class="rtl">
			<span class="btn" onclick="downloadExcel();"><img src="/admin/resources/common/images/icon_excel.png" alt=""> 엑셀 다운로드</span>
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
				<col width="10%"/>
				<col width="*"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="13%"/>
				<col width="10%"/>
				<col width="13%"/>
				<col width="13%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>전화번호</th>
					<th>회원 ID</th>
					<th>히든앱버전정보</th>
					<th>OS버전정보</th>
					<th>단말기모델명</th>
					<th>가입 일자</th>
					<th>수정 타입</th>
					<th>수정 일자</th>
					<th>최근 이용 일자</th>
				</tr>
			</thead>
			<tbody id="userHistList">
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