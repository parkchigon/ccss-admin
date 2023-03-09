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
});


function makeJuiTable(data, moveRow) {
	
	jui.ready([ "grid.table" ], function(table) {
		termsListTable = table("#termsListTable", {
	        fields: [ "rnum", "termsTitle", "requiredYn", "useYn", "postDate", "insertDate" ],
			data: data,
	        moveRow: moveRow,
	        event: {
	            move: function(row, e) {
	            	if(isNotEmpty(row.data.dndColor)){
	            		return true;
	            	}else{
	            		return false;
	            	}
	            },
	            moveend: function(row, e) {
					//console.log("Completed.");
	            }
	        }
	    });
	});
	
}

// 리스트 조회
function goSearch(page) {
	$("#page").val(page);
	//필터링 여부(Y : 필터링, N : 노필터링)
	var filterYn = 'N';
	
	if($("#startDate").val() != '') {
		filterYn = 'Y';
	}
	if($("#endDate").val() != '') {
		filterYn = 'Y';
	}
	if($("#useYn option:selected").val() != 'A') {
		filterYn = 'Y';
	}
	if($("#requiredYn option:selected").val() != 'A') {
		filterYn = 'Y';
	}
	if($("#searchText").val() != '') {
		filterYn = 'Y';
	}

	$("#filterYn").val(filterYn);
	
	$.ajax({
		url : "/admin/servicemng/selectTermsList.do"
		,data : $('#termsSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		var termsTypeCnt = data.termsTypeCnt;
		/*
		if(filterYn == "Y") {
			if(totalResult > 0) {
				for (var i = 0; i < list.length ; i++) {
					html += "<tr>";	
					html += "	<td>" + list[i].rnum + "</td>";
					html += "	<td class='left'><a href='javascript:termsDetail(\"" + list[i].seqTerms + "\");' class='link'>" + list[i].termsTitle + "</td>";
					if(list[i].requiredYn == 'Y') {
						html += "<td>필수</td>";
					} else {
						html += "<td>선택</td>";
					}
					if(list[i].useYn == 'Y') {
						html += "<td>사용</td>";
					} else {
						html += "<td>미사용</td>";
					}
					
					html += "	<td>" + list[i].postDate  + "</td>";
					html += "	<td>" + list[i].insertDate + "</td>";
					html +="</tr>";
				}
			} else {
				html += "<tr>"
				html += "	<td colspan='7'> 검색조건에 부합되는 데이터가 없습니다.</td>";
				html += "</tr>"
			}
			
			$("#termsList").empty();
			$("#termsList").append(html);
		} else {
			makeJuiTable(data.resultList);
		}
		*/
		
		if(data.totalCount > 0) {
		
			if(filterYn == "Y") {
				makeJuiTable(data.resultList, false);
			} else {
				makeJuiTable(data.resultList, true);
			}
			$("#paging").empty();
			$("#paging").append(data.paging);
			$("#totCnt").text(totalResult);
			if(filterYn == "Y") {
				$("#btnSaveInit").hide();	
			} else {
				$("#btnSaveInit").show();	
			}
		} else {
			html += "<tr>"
			html += "	<td colspan='6'> 검색조건에 부합되는 데이터가 없습니다.</td>";
			html += "</tr>"
			
			$("#termsList").empty();
			$("#termsList").append(html);
			
		}
	});
}


function orderSave() {

	var target = $("#termsList > tr[class ^= 'imp']");
	var termsArray = target.map(function() {return $(this).attr("seqTerms");}).get();

	$.ajaxSettings.traditional = true;
	$.ajax({
		url : "/admin/servicemng/updateTermsOrderAjax.do",
		type : "POST",
		data : {
			seqTermsArray : termsArray
		}
	}).done(function(data) {
		goSearch(1);
		alert("저장 되었습니다.");
	});
}


function openNewTermsWrite() {
	$("#termsTitle").val("");
	openLayerPopup($("#termsRegPopup"));
}	

// 등록 화면
function termsEditForm() {
	location.href="/admin/servicemng/termsEditForm.do";
}

// 상세 화면
function termsDetail(seqTerms) {
	location.href="/admin/servicemng/termsDetail.do?seqTerms="+seqTerms;
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="termsSearchForm" name="termsSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="filterYn" name="filterYn" />
	
	<div class="main_top">
		<h2>
			약관 관리
			<a href="javascript:openNewTermsWrite();"><span class="rtl btn focus" style="width:80px;" ><img src="/admin/resources/common/images/icon_add01.png" alt=""> 등록</span></a>
		</h2>
		
	</div>
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
				<col width="25%"/>
			</colgroup>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 검색-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
			<colgroup>
				<col width="15%"/>
				<col width="35%"/>
				<col width="35%"/>
				<col width="15%"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">기간</div></th>
					<td colspan="3">
						<select id="searchDateDiv" name="searchDateDiv" class="select w01" style="width:130px;">
							<option value="INSERT_DATE" selected="selected">등록일</option>
							<option value="POST_DATE">게시일</option>
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
							<option value="A" selected="selected">전체</option>
							<option value="Y">사용</option>
							<option value="N">미사용</option>
						</select>
					</td>
					<th><div class="tit_search">활용동의구분</div></th>
					<td>
						<select id="requiredYn" name="requiredYn" class="select w01" style="width:130px;">
							<option value="A" selected="selected">전체</option>
							<option value="Y">필수</option>
							<option value="N">선택</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><div class="tit_search">검색</div></th>
					<td colspan="3">
						<div class="input_wrap">
							<input type="text" class="input w01" id="searchText" name="searchText" onkeydown="if(event.keyCode==13) goSearch(1);" style="width:700px;" />
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
		<table id="termsListTable" cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="*"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="15%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>약관명</th>
					<th>활용 동의 구분</th>
					<th>사용여부</th>
					<th>게시일시</th>
					<th>등록일시</th>
				</tr>
			</thead>
			<tbody id="termsList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<!-- e: 페이징 -->
	</form>
	<!-- s: 하단 저장 초기화 -->
	<div class="center" id="btnSaveInit">
		<a href="javascript:orderSave();"><span class="btn focus" style="width:90px;">저장</span></a>
		<a href="javascript:goSearch('1');"><span class="btn" style="width:90px;">초기화</span></a>
	</div>
	<!-- e: 하단 저장 초기화 -->
<!-- e: 내용-->
</div>

<script data-jui="#termsListTable" data-tpl="row" type="text/template">
	<tr class="<!= dndColor !>" seqTerms="<!= seqTerms !>">
        <td><!= rnum !></td>
        <td><a href='javascript:termsDetail("<!= seqTerms !>");' class='link'><!= termsTitle !></td>
        <td><!= strRequiredYn !></td>
        <td><!= strUseYn !></td>
        <td><!= postDate !></td>
        <td><!= insertDate !></td>
    </tr>
</script>
