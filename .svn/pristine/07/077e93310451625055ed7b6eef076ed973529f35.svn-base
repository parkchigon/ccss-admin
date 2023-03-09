<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
$(document).ready(function(){
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
	
	
	timeDefault();
	goSearch(1);
	
	
});
function timeDefault(){
	var today = new Date();
	$("#date").val(today.YYYYMMDDHHMMSS().substr(0,4)+"-"+today.YYYYMMDDHHMMSS().substr(4,2)+"-"+today.YYYYMMDDHHMMSS().substr(6,2));	
	var hh = today.YYYYMMDDHHMMSS().substr(8,2);
	$("#startHour").val(hh).attr("selected", "selected");
	var endHH = 24;
	if(Number(hh)<=23){
		endHH = Number(hh)+1;
		if(endHH < 10){
			endHH = "0"+endHH;
		}
		
	}
	$("#endHour").val(endHH).attr("selected", "selected");
}

// 리스트 조회
function goSearch(page) {
	if(!checkTime()){
		return;	
	}
	
	
	$("#page").val(page);
	$("#startTime").val(""+$("#date").val()+$("#startHour").val()+"00");
	var endHour = $("#endHour").val();
	if(Number(endHour)==24){
		var today = new Date($("#date").val());
		today.setDate(today.getDate() + 1);
		var date = today.YYYYMMDDHHMMSS().substr(0,8);
		$("#endTime").val(""+date.substr(0,4)+"-"+date.substr(4,2)+"-"+date.substr(6,2)+"0000");
	}else{
		$("#endTime").val(""+$("#date").val()+$("#endHour").val()+"00");
	}
	
	
	
	$.ajax({
		url : "/admin/manage/serverErrorAjax.do"
		,data : $('#serverError').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		goGraph(data.errorGraph,data.maxFailCount);
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
			
		if(totalResult > 0) {
			for (var i = 0; i < list.length ; i++) {
				html += "<tr>";	
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td class='left'>" + list[i].sectionName + "</td>";
				html += "	<td class='left'>" + list[i].actionKindName + "</td>";
				html += "	<td>" + addComma(list[i].totalCount) + "</td>";
				html += "	<td>" + addComma(list[i].successCount) + "</td>";
				if(list[i].failCount == 0){
					html += '	<td>' + addComma(list[i].failCount) + '</td>';
				}else{
					html += '	<td><a class="link"  href="javascript:urlSearch(\''+list[i].actionKind+'\',\'\',\''+list[i].actionKindName+'\')">' + addComma(list[i].failCount) + '</a></td>';
				}
				html += "	<td>" + addComma(parseInt(list[i].successCount*100/list[i].totalCount)) + "%</td>";
				html +="</tr>";
			}
		} else {
			html += "<tr>"
			html += "	<td colspan='7'> 검색조건에 부합되는 데이터가 없습니다.</td>";
			html += "</tr>"
		}

		$("#paging").empty();
		$("#paging").append(data.paging);
	
		$("#errorList").empty();
		$("#errorList").append(html);
		$("#totCnt").text(totalResult);
		
	});
    
}



function goGraph(graph,maxFailCount) {
	 console.log(graph);
	 $("#chart").empty();
	 jui.ready([ "chart.builder" ], function(chart) {
	        chart("#chart", {
	            width: 1181,
	            height : 400,
	            axis : [
	                {
	                    data : graph,
	                    y : {
	                        type : "range",
	                        domain : [ 0, maxFailCount ],
	                        step : 10,
	                        line : true
	                       // orient  : "left"
	                    },
	                    x : {
	                        type : "block",
	                        domain : "date",
	                        line : true,
	                        orient : "bottom"
	                    },
	                    buffer : 10
	                }

	            ],
	            brush : [{
	                type : "column",
	                size : 15,
	                target : "failCount",
	                display : "max",
	                activeEvent : "mouseover",
	                active : 1,
	                minSize : 5,
	                animate : "bottom",
	                colors : function(data, dataKey) {
	                    if(data.sales > 99) {
	                        return "#D0006F";
	                    }

	                    return "#999";
	                }
	            }],
	            widget : [{
	                type : "scroll"
	            },{
	            	type : "title",
	                text : "* 최대 6시간 데이터만 조회 가능",
	                align : "start"
	            },{
	                type : "tooltip",
	                orient : "bottom"
	            }
	            ],
	            event : {
	                click : function(obj,e) {
	                    console.log(obj.data);
	                    urlSearch("",obj.data.startTime,obj.data.startTime);
	                }
	            },
	            style : {
	                //gridYFontSize : 20,
	                //gridXFontSize : 20,
	                /*/
	                tooltipPointRadius : 0,
	                gridYAxisBorderWidth : 0,
	                gridXAxisBorderWidth : 1,
	                gridXAxisBorderColor : "#ebebeb",
	                gridTickBorderSize : 0
	                /**/
	            }
	        });
		})
    
}


function urlSearch(actionKind,startTime,title) {
	var endTime = "";
	if(isEmpty(startTime) && !isEmpty(actionKind)){
		startTime =$("#startTime").val();
		endTime = $("#endTime").val();
	}
	
	var popUrl = "/admin/manage/serverErrorPopup.do?actionKind="+actionKind+"&startTime="+startTime+"&endTime="+endTime+"&title="+encodeURIComponent(title);
	var popOption = "width=1500, height=700, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
	window.open(popUrl,"previewObj",popOption);

// 	openLayerPopup($("#noticeListPopup"));
}

function checkTime() {
	var today = new Date();
	var hh = today.YYYYMMDDHHMMSS().substr(8,2);
	var todayDate = today.YYYYMMDDHHMMSS().substr(0,8);
		
	var startHour = $("#startHour").val();
	var endHour = $("#endHour").val();
	var date = $("#date").val();
    date = date.replace(/-/gi, "");
    if(Number(startHour) >= Number(endHour)){
	 	alert("끝나는 시간이 시작시간보다 빠를수 없습니다.");
		return false;
		
	}else if(Number(endHour)-Number(startHour)> 6){
		alert("시간 설정을 확인해주세요.\n6시간 데이터만 조회 가능합니다.");
		return false;
	}else if(Number(date)>=Number(todayDate) && (Number(endHour) > Number(hh)+1 || Number(startHour)>hh) ){
		alert("현재시간 이후의 날짜는 조회 하실수 없습니다.");
		return false;
	}
	return true;
}

function changeTime() {
	var startHour = $("#startHour").val();
	var endHour = 0;
	endHour = Number(startHour) + 6;
	if(Number(endHour) >= 24){
		endHour = 24;
	}
	if(endHour<10){
		endHour = "0"+endHour;
	}
	 $("#endHour").val(endHour);
}

</script>
<!-- 내용-->
<div class="contents_wrap">
<form id="serverError" name="serverError" method="POST" >
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="startTime" name="startTime" />
	<input type="hidden" id="endTime" name="endTime" />
<div class="main_top">
	<h2>서버 오류 현황</h2>
	<div class="location_wrap">
<!-- 									<a href="#">홈</a> &gt; <a href="#">운영관리</a> &gt; <strong>서버오류현황</strong> -->
	</div>
</div>

<!-- s: 검색-->
<!-- s: table wrap-->
<div class="table_wrap">
	<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
		<colgroup>
			<col width="15%"/>
			<col width="85%"/>
		</colgroup>
		<tbody>
			<tr>
				<th><div class="tit_search">기간</div></th>
				<td>
					<div class="input_wrap">
						<div id="datepicker1_group" class="group">
							<input type="text" class="input" style="width: 130px;" id="date" name="date" />
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
						<select id="startHour" name="startHour" onchange="changeTime();" class="select w02">
							<c:forEach var="startHours" begin="00" end="23">
								<fmt:formatNumber var="hour" value="${startHours}" pattern="00" />
								<option value="${hour}">${hour}</option>
							</c:forEach>
						</select> 시~ 
						<select id="endHour" name="endHour"  class="select w02">
							<c:forEach var="endHours" begin="00" end="24">
								<fmt:formatNumber var="hour" value="${endHours}" pattern="00" />
								<option value="${hour}" >${hour}</option>
							</c:forEach>
						</select> 시
						<span onclick="goSearch(1);" class="btn focus" style="width:90px;"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- e: table wrap-->
<!-- e: 검색-->

<!-- <div id="chart" class="chart_wrap" style="width:100%; overflow:auto;"></div> -->
 <div id="chart" class="chart_wrap"></div> 
<!-- s: table top-->
<div class="thead_wrap cboth">
	<div class="ltr">
		<span class="count">Total : <span id="totCnt"></span></span>
	</div>
</div>
<!-- e: table top-->

<!-- s: table wrap-->
<div class="table_wrap">
	<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
		<colgroup>
			<col width="10%"/>
			<col width="30%"/>
			<col width="*"/>
			<col width="8%"/>
			<col width="8%"/>
			<col width="8%"/>
			<col width="8%"/>
		</colgroup>
		<thead>
			<tr>
				<th>No</th>
				<th>구간</th>
				<th>기능명</th>
				<th>호출 건 수</th>
				<th>성공 건 수</th>
				<th>실패 건 수</th>
				<th class="last">성공률(%)</th>
			</tr>
		</thead>
		<tbody id="errorList">
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