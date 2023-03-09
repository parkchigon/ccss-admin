<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script>
$(document).ready(function(){
	changeDatePicker("DAY");
	goSearch(1);
});


function goSearch(page) {
   // if(!checkDatePickerStartEnd()){
   // 	return;
   //}
    
    $("#page").val(page);
	
	$.ajax({
		url : "/admin/stats/selectBrandReportListAjax.do",
		data : $("#brandReportSearchForm").serialize(),
		dataType : "JSON",
		type : "POST"
	}).done(function(data) {
		console.log(data);
		var resultCode = data.resultCode;
		
		if(resultCode == "1001") {
			var html = '';
			var resultList = data.resultList;
			var totalCount = data.totalCount;
			if(resultList.length > 0) {
				for(var i=0; i<resultList.length; i++) {
					html += '<tr>';
					html += '	<td>' +resultList[i].rnum+ '</td>';
					html += '	<td>' +resultList[i].brandName+ '</td>';
					html += '	<td>' +resultList[i].brandTel+ '</td>';
					html += '	<td>' +resultList[i].brandBusinessName+ '</td>';
					html += '	<td>' +resultList[i].brandCategoryName+ '</td>';
					html += '	<td>' +resultList[i].poiId+ '</td>';
					if(resultList[i].poiId == "KT") {
						html += '<td>' +addComma(resultList[i].brandDetailKtOemCnt)+ '</td>';
						html += '<td>-</td>';
						html += '<td>' +addComma(resultList[i].brandCallKtCnt)+ '</td>';
						html += '<td>-</td>';
						html += '<td>-</td>';
					} else {
						html += '<td>-</td>';
						html += '<td>' +addComma(resultList[i].brandDetailLguPlusCnt)+ '</td>';
						html += '<td>-</td>';
						html += '<td>' +addComma(resultList[i].brandCallLguPlusListCnt)+ '</td>';
						html += '<td>' +addComma(resultList[i].brandCallLguPlusDetailCnt)+ '</td>';
					}
					html += '</tr>';
				}
			} else {
				html += '<tr>';
				html += '	<td colspan="11"> 검색조건에 부합되는 데이터가 없습니다.</td>';
				html += '</tr>';
			}
			
			$("#brandReportList").empty();
			$("#brandReportList").append(html);
			$("#totCnt").text(totalCount);
			$("#paging").empty();
			$("#paging").append(data.paging);
		}
	}).error(function(response){
		alert("목록 조회중 오류가 발생하였습니다.");
	});
}

function changeDatePicker(calendarType){
	
	$("#calendarType").val(calendarType);
	$("[id ^= btn_").removeClass("focus");
	$("#btn_"+calendarType).addClass("focus");
	
	if(calendarType == "DAY") {
		$("#datepicker1_group").show();
		$("#endDate").hide();
		$("#endDate").val("");
		$("#startHour").show();
		$("#startHourText").show();
		$("#endHour").show();
		$("#endHourText").show();
		setDatePicker(null, "yyyy-MM-dd", null, 2);
	} else if(calendarType == "WEEK") {
		$("#datepicker1_group").show();
		$("#endDate").show();
		$("#startHour").hide();
		$("#startHourText").hide();
		$("#endHour").hide();
		$("#endHourText").hide();
		setDatePicker(null, "yyyy-MM-dd", null, 2);
	} else if(calendarType == "MONTH") {
		$("#datepicker1_group").show();
		$("#endDate").hide();
		$("#endDate").val("");
		$("#startHour").hide();
		$("#startHourText").hide();
		$("#endHour").hide();
		$("#endHourText").hide();
		setDatePicker("monthly", "yyyy-MM", "yyyy년", 1);
	} else if(calendarType == "YEAR") {
		$("#datepicker1_group").show();
		$("#endDate").hide();
		$("#endDate").val("");
		$("#startHour").hide();
		$("#startHourText").hide();
		$("#endHour").hide();
		$("#endHourText").hide();
		setDatePicker("yearly", "yyyy", "연도", 0);
	} else {
		$("#datepicker1_group").hide();
		$("#endDate").hide();
		$("#startDate").val("");
		$("#endDate").val("");
		$("#startHour").hide();
		$("#startHourText").hide();
		$("#endHour").hide();
		$("#endHourText").hide();
	}
	
	getCurrentDateSingle(calendarType, "#startDate");
}

function setDatePicker(typeFlag, formatFlag, titleFormatFlag, dateFlag){
	
	resetDatePickerDiv("datepicker1_group", "datepicker1", "startDate");
	customDatePicker({
		datePickerGroupId: "datepicker1_group",
		datePickerId: "datepicker1",
		type: typeFlag,
		format: formatFlag,
		titleFormat : titleFormatFlag,
		nextFunction: function() {
			//alert("next");
		},
		prevFunction: function() {
            //alert("prev");
        }
	});
}

function resetDatePickerDiv(datePickerDivId, datePickerId, InputFlag){
	$("#" + datePickerDivId).empty();
	var html = '';
	html+='<input type="text" class="input" style="width: 157px;" id="' + InputFlag + '" name="' + InputFlag + '" maxlength="8" readonly="readonly" />';
	html+='<a class="btn btn-gray"><i class="icon-calendar"></i></a>';
	html+='<div id="' + datePickerId + '" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">';
	html+='<div class="head">';
	html+='<div class="prev">';
	html+='<i class="icon-chevron-left"></i>';
	html+='</div>';
	html+='<div class="title"></div>';
	html+='<div class="next">';
	html+='<i class="icon-chevron-right"></i>';
	html+='</div>';
	html+='</div>';
	html+='<table class="body">';
	html+='<tr>';
	html+='<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>';
	html+='</tr>';
	html+='</table>';
	html+='</div>';
	$("#" + datePickerDivId).append(html);
}


function customDatePicker(attrs) {
	var type = isNotEmpty(attrs.type) ? attrs.type : "daily";
	var groupId = attrs.datePickerGroupId;
	var id = attrs.datePickerId;
	var format = isNotEmpty(attrs.format) ? attrs.format : "yyyy-MM-dd";
	var obj = eval(id);
	var baseTitleFormat = isNotEmpty(attrs.titleFormat) ? attrs.titleFormat : "yyyy년 MM월";
	var maxDate = attrs.maxDate;
	jui.ready(["ui.datepicker"], function(datepicker) {
		obj = datepicker("#" + id, {
			type: type,
	        titleFormat: baseTitleFormat,
	        format: format,
	        event: {
	            select: function(date, e) {
	                $("#" + groupId).find("input").val(this.getFormat(format));
	                $("#" + groupId).find("a").click();
	                if($("#calendarType").val() == "WEEK") {
	                	setAddDayDate($("#startDate").val(), 6, "#endDate");
	                }
	            },
	            prev: function(e) {
	            	if(attrs.prevFunction) {
	            		attrs.prevFunction();
	            	}
	            },
	            next: function(e) {
	            	if(attrs.nextFunction) {
	            		attrs.nextFunction();
	            	}
	            },
	            tpl: {
	            	date: $("#tpl_date").html()
	            }
	        }
	    });
		
	    $("#" + groupId).find("a").on("click", function(e) {
	        var $r = $(obj.root);

	        if($r.css("display") == "none") {
	            $r.show();
	        } else {
	            $r.hide();
	        }
	    });
	});	
}

function downloadExcel() {
	$("#brandReportSearchForm").attr("action", "/admin/stats/brandReportListExcel.do");
	$("#brandReportSearchForm").submit();
}

</script>

<!-- 내용-->
<div class="contents_wrap">
	<form id="brandReportSearchForm" name="brandReportSearchForm" method="POST" >
	<input type="hidden" id="calendarType" name="calendarType" />
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>
			상호별 리포트
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
					<td colspan="3">
						<a href="javascript:changeDatePicker('DAY');"><span class="btn" id="btn_DAY">일</span></a>
			            <a href="javascript:changeDatePicker('WEEK');"><span class="btn" id="btn_WEEK">주</span></a>
			            <a href="javascript:changeDatePicker('MONTH');"><span class="btn" id="btn_MONTH">월</span></a>
			            <a href="javascript:changeDatePicker('YEAR');"><span class="btn" id="btn_YEAR">연</span></a>
			            <a href="javascript:changeDatePicker('ACC');"><span class="btn" id="btn_ACC">누적</span></a>
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
						<select id="startHour" name="startHour" class="select w04">
							<c:forEach var="hours" begin="00" end="23">
								<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
								<option value="${hour}">${hour}</option>
							</c:forEach>
						</select>
						<span id="startHourText">시 ~</span>
						<select id="endHour" name="endHour" class="select w04">
							<c:forEach var="hours" begin="00" end="23">
								<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
								<option value="${hour}" <c:if test="${hour eq 23}">selected="selected"</c:if>>${hour}</option>
							</c:forEach>
						</select>
						<span id="endHourText">시</span>
						<input  type="text" class="input" style="width: 157px; display: none;" id="endDate" name="endDate" maxlength="8" readonly/>
					</td>
				</tr>
				<tr>
					<th><div class="tit_search">정렬</div></th>
					<td>
						<select id="orderType" name="orderType" class="select w02">
							<option value="LATEST" selected="selected">최신순</option>
							<option value="DETAIL_CNT">조회순</option>
							<option value="CALL_CNT">통화 호출순</option>
						</select>
					</td>
					<th><div class="tit_search">POI</div></th>
					<td>
						<select id="poiIdType" name="poiIdType" class="select w02">
							<option value="ALL" selected="selected">전체</option>
							<option value="KT">KT</option>
							<option value="LGU">U+</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><div class="tit_search">검색</div></th>
					<td colspan="3">
						<div class="input_wrap">
							<select id="keywordType" name="keywordType" class="select w02">
								<option value="BRAND_NAME" selected="selected">상호명</option>
								<option value="BRAND_TEL">상호 전화번호</option>
								<option value="BRAND_BUSINESS_NAME">업종</option>
								<option value="BRAND_CATEGORY_NAME">카테고리</option>
							</select>
							<input type="text" class="input w02" id="keyword" name="keyword" onkeydown="if(event.keyCode==13) goSearch(1);"/>
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
			<span class="imp">* 전일 기준 데이터</span>
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
				<col width="18%"/>
				<col width="10%"/>
				<col width="7%"/>
				<col width="*"/>
				<col width="6%"/>
				
				<col width="*"/>
				<col width="*"/>
				<col width="*"/>
				<col width="*"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th rowspan="3">NO</th>
					<th rowspan="3">상호명</th>
					<th rowspan="3">상호 전화번호</th>
					<th rowspan="3">업종</th>
					<th rowspan="3">카테고리</th>
					<th rowspan="3">POI_ID</th>
					<th colspan="2">상호 상세정보 조회</th>
					<th colspan="3">통화 호출</th>
				</tr>
				<tr>
					<th rowspan="2">OEM</th>
					<th rowspan="2">홈페이지</th>
					
					<th rowspan="2">OEM 검색</th>
					<th colspan="2">홈페이지 생활번호</th>
				</tr>
				<tr>
					<th>리스트</th>
					<th>상세</th>
				</tr>
			</thead>
			<tbody id="brandReportList">
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