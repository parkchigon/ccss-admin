<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script>
$(document).ready(function() {
	
	// 검색조건 일별 기본값 세팅
	getCurrentDateAfter('startDate', 'endDate', 'DAY', 30, 10);
	
	// 데이터 피커 생성
	compareDatePicker({
		startDatePickerGroupId: "datepicker1_group",
		startDatePickerId: "datepicker1",
		endDatePickerGroupId: "datepicker2_group",
		endDatePickerId: "datepicker2",
	});	
	
	// 검색조건 일,월,연 구분 selectbox
	$("#searchDateDiv").change(function(){
		if($(this).val() == "TIME"){
			setDatePicker(null, "yyyy-MM-dd", null, 2);
			getCurrentDateAfter('startDate', 'endDate', 'DAY', 30, 10);
			$("#startHour").show();
			$("#startHourText").show();
			$("#endHour").show();
			$("#endHourText").show();
		} else if($(this).val() == "DAY"){
			setDatePicker(null, "yyyy-MM-dd", null, 2);
			getCurrentDateAfter('startDate', 'endDate', 'DAY', 30, 10);
			$("#startHour").hide();
			$("#startHourText").hide();
			$("#endHour").hide();
			$("#endHourText").hide();
		} else if($(this).val() == "WEEK") {
			setDatePicker(null, "yyyy-MM-dd", null, 2);
			getCurrentDateAfter('startDate', 'endDate', 'DAY', 7, 10);
			$("#datepicker2_group").find("a").off("click");
			$("#startHour").show();
			$("#startHourText").show();
			$("#endHour").show();
			$("#endHourText").show();
		} else if($(this).val() == "MONTH"){
			setDatePicker("monthly", "yyyy-MM", "yyyy년", 1);
			getCurrentDateAfter('startDate', 'endDate', 'MONTH', 12, 7);
			$("#startHour").hide();
			$("#startHourText").hide();
			$("#endHour").hide();
			$("#endHourText").hide();
		} else if($(this).val() == "YEAR"){
			setDatePicker("yearly", "yyyy", "연도", 0);
			getCurrentDateAfter('startDate', 'endDate', 'YEAR', 5, 4);
			$("#startHour").hide();
			$("#startHourText").hide();
			$("#endHour").hide();
			$("#endHourText").hide();
		};
	});
	
	goSearch(1);
	
});

function goSearch(page) {
    if(!checkDatePickerStartEnd()){
    	return;
    }

    $("#page").val(page);

    $.ajax({
		url : "/admin/stats/selectUserHistReportListAjax.do",
		data : $("#userHistReprotSearchForm").serialize(),
		dataType : "JSON",
		type : "POST"
	}).done(function(data) {
		console.log(data);
		var resultCode = data.resultCode;
		
		if(resultCode == "1001") {
			var html = '';
			var resultList = data.resultList;
			var totalCount = data.totalCount;
			
// 			var accCount = data.accumulateCount;
// 			html += '<tr class="imp">';
// 			html += '	<td>현재기준(누적)</td>';
// 			html += '	<td>-</td>';
// 			html += '	<td>-</td>';
// 			html += '	<td>'+addComma(accCount.accMandatoryTermsAgreeCnt)+'</td>';
// 			html += '	<td>'+addComma(accCount.accOptionTermsAgreeCnt)+'</td>';
// 			html += '	<td>-</td>';
// 			html += '	<td>-</td>';
// 			html += '</tr>';
			
			var searchAccumulateCount = data.searchAccumulateCount;
			html += '<tr class="imp">';
			html += '	<td>검색기준(누적)</td>';
			html += '	<td>-</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accMandatoryTermsAgreeCnt-searchAccumulateCount.accTermsCancelCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accMandatoryTermsAgreeCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accOptionTermsAgreeCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accTermsCancelCnt)+'</td>';
			html += '	<td>'+addComma(searchAccumulateCount.accUseUserCnt)+'</td>';
			html += '</tr>';
			if(resultList.length > 0) {
				for(var i=0; i<resultList.length; i++) {
					html += '<tr>';
					html += '	<td>' +resultList[i].statDate+ '</td>';
					html += '	<td>' +addComma(resultList[i].accUserCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].uniqueNewMemberCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].mandatoryTermsAgreeCnt)+ '</td>';
					html += '	<td><a class="link" href="javascript:openOptionDetailPopup(\''+$("#searchDateDiv option:selected").val()+'\', \''+resultList[i].statDate+'\');">' +addComma(resultList[i].optionTermsAgreeCnt)+ '</a></td>';
					html += '	<td>' +addComma(resultList[i].termsCancelCnt)+ '</td>';
					html += '	<td>' +addComma(resultList[i].useUserCnt)+ '</td>';
					html += '</tr>';
				}
			} else {
					html += '<tr>';
					html += '	<td colspan="7"> 검색조건에 부합되는 데이터가 없습니다.</td>';
					html += '</tr>';
			}
			
			$("#userHistReportList").empty();
			$("#userHistReportList").append(html);
			$("#totCnt").text(totalCount);
			$("#paging").empty();
			$("#paging").append(data.paging);
		}
		
		
	}).error(function() {
		alert("목록 조회중 오류가 발생하였습니다.");
	});
	
	
}

function setDatePicker(typeFlag, formatFlag, titleFormatFlag, dateFlag){
	// 이전 데이트피커 초기화
	resetDatePickerDiv("datepicker1_group", "datepicker1", "startDate");
	// 데이터 피커 생성
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
	resetDatePickerDiv("datepicker2_group", "datepicker2", "endDate");
	customDatePicker({
		datePickerGroupId: "datepicker2_group",
		datePickerId: "datepicker2",
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
	                if($("#searchDateDiv option:selected").val() == "WEEK") {
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

function downloadExcel() {
	$("#userHistReprotSearchForm").attr("action", "/admin/stats/userHistReportListExcel.do");
	$("#userHistReprotSearchForm").submit();
}

</script>

<!-- 내용-->
<div class="contents_wrap">
	<form id="userHistReprotSearchForm" name="userHistReprotSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>
			사용자 이력 리포트
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
							<option value="TIME" selected="selected">시간별</option>
							<option value="DAY">일별</option>
							<option value="MONTH">월별</option>
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
						<select id="startHour" name="startHour" class="select w04">
							<c:forEach var="hours" begin="00" end="23">
								<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
								<option value="${hour}">${hour}</option>
							</c:forEach>
						</select>
						<span id="startHourText">시 ~</span>
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
						<select id="endHour" name="endHour" class="select w04">
							<c:forEach var="hours" begin="00" end="23">
								<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
								<option value="${hour}" <c:if test="${hour eq 23}">selected="selected"</c:if>>${hour}</option>
							</c:forEach>
						</select>
						<span id="endHourText">시</span>
					</td>
					<td>
			            <a href="javascript:goSearch(1);"><span class="btn focus" style="width:90px;"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span></a>
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
				<col width="15%"/>
				<col width="*"/>
				<col width="14%"/>
				<col width="14%"/>
				<col width="14%"/>
				<col width="14%"/>
				<col width="14%"/>
			</colgroup>
			<thead>
				<tr>
					<th rowspan="2">날짜</th>
					<th rowspan="2">전체 누적가입자수</th>
					<th rowspan="2">신규가입자 수</th>
					<th colspan="2">약관동의자 수</th>
					<th rowspan="2">약관철회자 수</th>
					<th rowspan="2">데일리 이용자 수</th>
				</tr>
				<tr>
					<th>필수</th>
					<th>선택</th>
				</tr>
			</thead>
			<tbody id="userHistReportList">
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