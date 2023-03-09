<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
var ajaxDtlCodeData;
var step3ViewFlag =false;

var apiCodeMap = new Map();
var serviceCategoryMap = new Map();
var joinStatusMap = new Map();
var genderMap = new Map();
var ageMap = new Map();
var productMap = new Map();
var statSvcMap = new Map();

var statAppMap = new Map();
var statCat1Map = new Map();
var statItemMap = new Map();


//Step3 Html value
var statCat1CheckAppendItemHtml ="";


var codeMap = new Map();

$(document).ready(function(){
	
	//=== StatCat1, StatItem Area Hidden & Show==============
	$("#step3ViewTableArea").hide();
	$('#statNm').bind('click', function() {
		if(step3ViewFlag){
			$("#step3ViewTableArea").hide();
			step3ViewFlag = false;
		}else{
			$("#step3ViewTableArea").show();
			step3ViewFlag = true;
		}
	});
	//=== StatCat1, StatItem Area Hidden & Show ==============
		
	//===  시간 설정 & DataPicker =======================	
	var startDate = "${startDate}";
	if(startDate !=null && startDate != ""){
		$('#startDate').val(startDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
		replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
	}else{
		$('#startDate').val(dateAdd(new Date().toISOString().slice(0,10),0,"d"));
	}
	
	var endDate = "${endDate}";
	if(endDate !=null && endDate != ""){
		$('#endDate').val(endDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
	}else{
		$('#endDate').val(dateAdd(new Date().toISOString().slice(0,10),+1,"d"));
	}	
	
	//datePicker설정
	datePicker({
		datePickerGroupId: "datepicker1_group",
		datePickerId: "datepicker1",
		defaultDt : $('#startDate').val()
	});
	datePicker({
		datePickerGroupId: "datepicker2_group",
		datePickerId: "datepicker2",
		defaultDt : $('#endDate').val()
	});
	
	//===  시간 설정 & DataPicker =======================	
		
	//===  Default Select Code Set =======================	
	selectGrpCodeSet();
	//===  Default Select Code Set =======================	
	
		
	//=== App 선택 변경 이벤트 =======================	
	$("#statApp").change(function() { 
		 var selectAppValue = $("#statApp").val();
		 //console.log(" ## selectAppValue",selectAppValue);
		 var statCat1Html =  "";
		//var statItemHtml =  "";
		
		 if(selectAppValue =="ALL"){
			 
			 selectServiceStatDtlCodeList();
			 
		 }else{
			 
		 	var serviceStatAppKeyList = Object.keys(ajaxDtlCodeData);
			//console.log("serviceStatAppKeyList",serviceStatAppKeyList);
			for(var i=0; i < serviceStatAppKeyList.length; i++){
				
				var splitValue = serviceStatAppKeyList[i].split(":");
				if(splitValue[1] != selectAppValue){
					continue;
				}
				
				var serviceStatCat1KeyList = Object.keys(ajaxDtlCodeData[serviceStatAppKeyList[i]]);
				
				 for(var j=0; j< serviceStatCat1KeyList.length; j++){
				
					var stat1SplitValue = serviceStatCat1KeyList[j].split(":");
					statCat1Html += "<input  type='checkbox'  id ='stepCat1Checkbox' name='stepCat1Checkbox' value="+splitValue[1]+":"+stat1SplitValue[1]+">&nbsp;"+ stat1SplitValue[0] +"</br>";

					var serviceStatItemKeyList = Object.keys(ajaxDtlCodeData[serviceStatAppKeyList[i]][serviceStatCat1KeyList[j]]);
					//for(var k=0; k < serviceStatItemKeyList.length; k++ ){
					//	var statItemSplitValue = serviceStatItemKeyList[k].split(":");
					//	statItemHtml += "<input  type='checkbox'  id ='statItemCheckbox' name='statItemCheckbox' value="+splitValue[1]+":"+stat1SplitValue[1]+":"+ajaxDtlCodeData[serviceStatAppKeyList[i]][serviceStatCat1KeyList[j]][serviceStatItemKeyList[k]]+">&nbsp;"+ serviceStatItemKeyList[k] +"</br>";
					//}
				} 
			}
			
			//statItem Append
			$("#statItem").empty();
			//$("#statItem").append(statItemHtml);
				
			//Stat1 Append
			$("#statCat1").empty();
			$("#statCat1").append(statCat1Html);
			
			
			//통계명 선택 시 - > item Value append
			$("input[name^='stepCat1Checkbox']").click(function() { 
				statCat1CheckAppendItemHtml = "";
				
				var stepCat1CheckBoxSeqArray = $("input:checkbox[name='stepCat1Checkbox']:checked").map(function(){return $(this).val();}).get();
				//console.log("stepCat1CheckBoxSeqArray",stepCat1CheckBoxSeqArray);
				
				//console.log(stepCat1CheckBoxSeqArray.size);
				//console.log(stepCat1CheckBoxSeqArray.length);
				
				for(var idx=0; idx < stepCat1CheckBoxSeqArray.length; idx++){
//					console.log("## check value:",this.value);  //WEATHER_APP:0
					var splitCheckKey = stepCat1CheckBoxSeqArray[idx].split(":");
					var appValue = splitCheckKey[0];
					var statCat1CodeVal = splitCheckKey[1];
					//console.log("appValue",appValue);
					//console.log("statCat1CodeVal",statCat1CodeVal);
					var serviceStatAppKeyList = Object.keys(ajaxDtlCodeData);
					//console.log("serviceStatAppKeyList",serviceStatAppKeyList);
					for(var i=0; i < serviceStatAppKeyList.length; i++){
						
						var splitValue = serviceStatAppKeyList[i].split(":");
						if(splitValue[1] != appValue){
							continue;
						}
						 var serviceStatCat1KeyList = Object.keys(ajaxDtlCodeData[serviceStatAppKeyList[i]]);
						 for(var j=0; j< serviceStatCat1KeyList.length; j++){
						
							var stat1SplitValue = serviceStatCat1KeyList[j].split(":");
							//console.log("stat1SplitValue[0]",stat1SplitValue[0]);
							//console.log("stat1SplitValue[1]",stat1SplitValue[1]);
							if(stat1SplitValue[1] != statCat1CodeVal){
								continue;
							}
							var serviceStatItemKeyList = Object.keys(ajaxDtlCodeData[serviceStatAppKeyList[i]][serviceStatCat1KeyList[j]]);
							for(var k=0; k < serviceStatItemKeyList.length; k++ ){
								var statItemSplitValue = serviceStatItemKeyList[k].split(":");
								statCat1CheckAppendItemHtml += "<input  type='checkbox'  id ='statItemCheckbox' name='statItemCheckbox' value="+splitValue[1]+":"+stat1SplitValue[1]+":"+ajaxDtlCodeData[serviceStatAppKeyList[i]][serviceStatCat1KeyList[j]][serviceStatItemKeyList[k]]+">&nbsp;"+ serviceStatItemKeyList[k] +"</br>";
							}
						} 
					}
				}
				$("#statItem").empty();
				$("#statItem").append(statCat1CheckAppendItemHtml);
				//$("input:checkbox[name='statItemCheckbox']").attr("checked", true);
			});
		 }
		

	}); 
	//=== App 선택 변경 이벤트 =======================	
	
	//=== 추출 기간 조회 타입 변경 이벤트 =======================		
	$("#searchType").change(function() { 
		var searchType = $("#searchType").val();
		if(searchType =='time'){
			$("#startHour").show();
			$("#endHour").show();
			$("#startHour").val("00");
			$("#endHour").val("00");
		}else{
			$("#startHour").hide();
			$("#endHour").hide();
		}
	});
	//=== 추출 기간 조회 타입 변경 이벤트 =======================				
});


//코드 정보 조회
function selectGrpCodeSet(){
	selectGrpCodeList("SERVICE_CATEGORY","svcType");
	selectGrpCodeList("JOIN_STATUS","joinStatus");
	selectGrpCodeList("GENDER","gender");
	selectGrpCodeList("AGE","age");
	selectGrpCodeList("PRODUCT","product");
	selectGrpCodeList("STAT_SVC","statSvc");

	//코드 값 조회
	selectServiceStatDtlCodeList();
}


function selectServiceStatDtlCodeList(){
	$.ajax({
		url : "<c:url value='/stat/selectServiceStatDtlCodeList.do' />",
		type : "POST",
		async: false,
		dataType : "json"
	}).done(function (data) {
		var serviceStatAppTypeHtml = "<option value='ALL' selected='selected'>전체</option>";
		var statCat1Html =  "";
		var statItemHtml =  "";
		ajaxDtlCodeData = data;
		
		//console.log("## Data :",data);
		//console.log("###",Object.keys(data));  // 키값.
		var serviceStatAppKeyList = Object.keys(ajaxDtlCodeData);
		//console.log("serviceStatAppKeyList",serviceStatAppKeyList);
		for(var i=0; i < serviceStatAppKeyList.length; i++){
			var splitValue = serviceStatAppKeyList[i].split(":");
			serviceStatAppTypeHtml += "<option value="+splitValue[1]+">"+ splitValue[0] + " (" + splitValue[1] + ")" +"</option>";		
			statAppMap.put(splitValue[1],splitValue[1]);
			//console.log(ajaxDtlCodeData[serviceStatAppKeyList[i]]);
			var serviceStatCat1KeyList = Object.keys(ajaxDtlCodeData[serviceStatAppKeyList[i]]);
			//console.log("##serviceStatCat1KeyList",serviceStatCat1KeyList);
			for(var j=0; j< serviceStatCat1KeyList.length; j++){
				//console.log(serviceStatCat1KeyList[j]);
				var stat1SplitValue = serviceStatCat1KeyList[j].split(":");
				//statCat1Html += "<option value="+stat1SplitValue[1]+">"+ stat1SplitValue[0] +  "</option>";	
				statCat1Html += "<input  type='checkbox'  id ='stepCat1Checkbox' name='stepCat1Checkbox' value="+splitValue[1]+":"+stat1SplitValue[1]+">&nbsp;"+ stat1SplitValue[0] +"</br>";
				statCat1Map.put(splitValue[1]+":"+stat1SplitValue[1],stat1SplitValue[0]);
				//console.log(ajaxDtlCodeData[serviceStatAppKeyList[i]][serviceStatCat1KeyList[j]]);
				var serviceStatItemKeyList = Object.keys(ajaxDtlCodeData[serviceStatAppKeyList[i]][serviceStatCat1KeyList[j]]);
				//console.log("##serviceStatItemKeyList",serviceStatItemKeyList);
				for(var k=0; k < serviceStatItemKeyList.length; k++ ){
					var statItemSplitValue = serviceStatItemKeyList[k].split(":");
					statItemHtml += "<input  type='checkbox'  id ='statItemCheckbox' name='statItemCheckbox' value="+splitValue[1]+":"+stat1SplitValue[1]+":"+ajaxDtlCodeData[serviceStatAppKeyList[i]][serviceStatCat1KeyList[j]][serviceStatItemKeyList[k]]+">&nbsp;"+ serviceStatItemKeyList[k] +"</br>";
					statItemMap.put(splitValue[1]+":"+stat1SplitValue[1]+":"+ajaxDtlCodeData[serviceStatAppKeyList[i]][serviceStatCat1KeyList[j]][serviceStatItemKeyList[k]],serviceStatItemKeyList[k]);
				}
			}
		}
		//console.log("#statCat1Html",statCat1Html);
		//console.log("#statItemHtml",statItemHtml);
		
		//Stat App Append
		$("#statApp").empty();
		$("#statApp").append(serviceStatAppTypeHtml);
		//Stat1 Append
		$("#statCat1").empty();
		$("#statCat1").append(statCat1Html);
		//statItem Append
		$("#statItem").empty();
		$("#statItem").append(statItemHtml);
		
		//Default Append 후 저체 Check.
		$("input:checkbox[name='stepCat1Checkbox']").attr("checked", true);
		$("input:checkbox[name='statItemCheckbox']").attr("checked", true);
		
		//console.log("productMap:",productMap);
		//console.log("joinStatusMap:",joinStatusMap);
		//console.log("genderMap:",genderMap);
		//console.log("ageMap:",ageMap);
		//console.log("statAppMap:",statAppMap);
		//console.log("statCat1Map:",statCat1Map);
		//console.log("statItemMap:",statItemMap);
		
	}).error(function(request,status,error){
		//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		if(request.status == 401){
			alert("해당 권한이 없습니다.");
		}else if(request.status == 400){
			alert("비정상적인 요청입니다.");
		}else{
			console.log("서버 내부 오류 발생","code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			if(request.status ==200){
				location.href = "<c:url value='/login/loginView.do' />";
			}
		}
	});
}

function selectGrpCodeList(grpCodeNm,grpCodeListAreaId){
	$.ajax({
		url : "<c:url value='/system/code/selectDtlCodeList.do' />",
		type : "POST",
		data : {
			"grpCdNm" : grpCodeNm
		},
		async: false,
		dataType : "json"
	}).done(function (data) {
		var list = data.resultList;
		var html ="<option value='ALL' selected='selected'>전체</option>";
		for (var i = 0; i < list.length ; i++) {	
			if(grpCodeNm =='SERVICE_CATEGORY'){
				if(list[i].cdVal !="ALL"){
					serviceCategoryMap.put(list[i].cdVal,list[i].dtlCdNm);
					html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";		
				}
			}else if(grpCodeNm =='JOIN_STATUS'){
				if(list[i].cdVal !="ALL"){
					joinStatusMap.put(list[i].cdVal,list[i].dtlCdNm);
					html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";		
				}
			}else if(grpCodeNm =='GENDER'){
				if(list[i].cdVal !="ALL"){
					genderMap.put(list[i].cdVal,list[i].dtlCdNm);
					html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";		
				}
			}else if(grpCodeNm =='AGE'){
				if(list[i].cdVal !="ALL"){
					ageMap.put(list[i].cdVal,list[i].dtlCdNm);
					html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";		
				}
			}else if(grpCodeNm =='PRODUCT'){
					if(list[i].cdVal !="ALL"){
					productMap.put(list[i].cdVal,list[i].dtlCdNm);
						html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";		
					}
			}else if(grpCodeNm =='STAT_SVC'){
				if(list[i].cdVal !="ALL"){
					statSvcMap.put(list[i].cdVal,list[i].dtlCdNm);
					html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";		
				}
			}else{
			 html += "<option value="+list[i].dtlCdNm+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
			}
		}
		
		$("#"+ grpCodeListAreaId).empty();
		$("#"+ grpCodeListAreaId).append(html);
		
	}).error(function(request,status,error){
		//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		if(request.status == 401){
			alert("해당 권한이 없습니다.");
		}else if(request.status == 400){
			alert("비정상적인 요청입니다.");
		}else{
			console.log("서버 내부 오류 발생","code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			if(request.status ==200){
				location.href = "<c:url value='/login/loginView.do' />";
			}
		}
	});
}


 function dateAdd(sDate, v, t) {
	var yy = parseInt(sDate.substr(0, 4), 10);
	var mm = parseInt(sDate.substr(5, 2), 10);
	var dd = parseInt(sDate.substr(8), 10);
	var d;
	if(t == "d"){
		d = new Date(yy, mm - 1, dd + v);
	}else if(t == "m"){
		d = new Date(yy, mm - 1 + v, dd);
	}else if(t == "y"){
		d = new Date(yy + v, mm - 1, dd);
	}else{
		d = new Date(yy, mm - 1, dd + v);
	}
	yy = d.getFullYear();
	mm = d.getMonth() + 1; mm = (mm < 10) ? '0' + mm : mm;
	dd = d.getDate(); dd = (dd < 10) ? '0' + dd : dd;
	return '' + yy + '-' +  mm  + '-' + dd;
}

// 검색 조건 초기화
function resetSearch(){
	//console.log("statStatNmMap" , statStatNmMap);
	//return false;
	if(step3ViewFlag){
		$("#step3ViewTableArea").hide();
		step3ViewFlag = false;
	}
	//Time Reset
	$('#startDate').val(dateAdd(new Date().toISOString().slice(0,10),0,"d"));
	$('#endDate').val(dateAdd(new Date().toISOString().slice(0,10),+1,"d"));
	$('#startHour').val("00");
	$('#endHour').val("00");
	//Time Reset
	
	//Search Condition Reset
	$('#svcType').val("ALL");
	$('#joinStatus').val("ALL");
	$('#gender').val("ALL");
	$('#age').val("ALL");
	$('#product').val("ALL");
	$('#statSvc').val("ALL");
	//Search Condition Reset
	$('#statApp').val("ALL"); 
	//append Date Reset

	selectServiceStatDtlCodeList();
	
	var html="";
	html += "	<tr><th colspan='12'></td></tr>";
	
	$("#paging").empty();
	$("#serviceStatList").empty();
	$("#serviceStatList").append(html);
	$("#totCnt").text("0");
}

//엑셀 다운로드
function downLoadExcel(){
	
	if($("input:checkbox[name='stepCat1Checkbox']:checked").length == 0 && $("input:checkbox[name='statItemCheckbox']:checked").length == 0){
		$("input:checkbox[name='stepCat1Checkbox']").attr("checked", true);
		$("input:checkbox[name='statItemCheckbox']").attr("checked", true);
	}
	
	if($("input:checkbox[name='statItemCheckbox']:checked").length == 0){
		alert("상세 Item명을 선택해 주세요.");
		return false;
	}
	
	
	var statItemArray = $("input:checkbox[name='statItemCheckbox']:checked").map(function(){return $(this).val();}).get();
	var statNmArray = $("input:checkbox[name='stepCat1Checkbox']:checked").map(function(){return $(this).val();}).get();
	$("#statNmArray").val(statNmArray);
	$("#statItemArray").val(statItemArray);
	
	$('#serviceStatSearchForm').attr("action", "<c:url value='/stat/selectServiceStatListExcel.do'/>");
	$('#serviceStatSearchForm').attr("method", "POST");
	$('#serviceStatSearchForm').submit();
}

//시작일, 종료일 체크
function checkStartEndDate(start, end, spliter, msg){
	
	//공백 체크
	if(start.trim() == "" || start.trim() == null){
		alert("시작 날짜를 선택해주세요.");
		return false;
	}
	if(end.trim() == "" || end.trim() == null){
		alert("종료 날짜를 선택해주세요.");
		return false;
	}
	 
	var startDateArr = start.split(spliter);
	var endDateArr  = end.split(spliter);

	//console.log("start:",start);
	//console.log("end:",end);
	
	var sDate = start.replace(/-/g,"")+"00";
	var eDate = end.replace(/-/g,"")+"00";
	
	if( sDate > eDate )
	{
		alert(msg);
		return false;
	}else{
		
		var betweenDay = calDateRange(start,end);
		
		if(betweenDay >=31 ){
			alert("기간은  최대 30일 이상 지정 하실 수 없습니다.");
			return false;
		}else{
			return true;
		}
	}
}


// 리스트 조회
function goSearch(page) {
	
	//console.log("statStatNmMap",statStatNmMap);
	
	//console.log("@@ step3Checkbox checkLength:",$("input:checkbox[name='step3Checkbox']:checked").length);
	//console.log("@@ statItem3Checkbox checkLength:",$("input:checkbox[name='statItem3Checkbox']:checked").length);
	
	if($("input:checkbox[name='stepCat1Checkbox']:checked").length == 0 && $("input:checkbox[name='statItemCheckbox']:checked").length == 0){
		$("input:checkbox[name='stepCat1Checkbox']").attr("checked", true);
		$("input:checkbox[name='statItemCheckbox']").attr("checked", true);
	}
	
	if($("input:checkbox[name='statItemCheckbox']:checked").length == 0){
		alert("상세 Item명을 선택해 주세요.");
		return false;
	}
	
	//return false;
	//$("input:checkbox[name='noticeCheckBox']").attr("checked", true);statItemCheckbox
	var statItemArray = $("input:checkbox[name='statItemCheckbox']:checked").map(function(){return $(this).val();}).get();
	var statNmArray = $("input:checkbox[name='stepCat1Checkbox']:checked").map(function(){return $(this).val();}).get();
	$("#statNmArray").val(statNmArray);
	$("#statItemArray").val(statItemArray);
	
	var validCheck = false;
	validCheck = checkStartEndDate($('#startDate').val(), $('#endDate').val(),"-" , " 시작일, 종료일이 잘못되었습니다.");
	
	if(!validCheck){
		return false;
	}
	
	
	$("#page").val(page);
	$.ajax({
		url : "<c:url value='/stat/selectServiceStatList.do'/>",
		data : $('#serviceStatSearchForm').serialize(),
		dataType : 'json',
		type : "POST"
	}).done(function(data) {
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		if (list.length == 0) {
			html += "	<tr><th colspan='12'>조회된 결과가 없습니다.</td></tr>";
		} else {
			//Use Version Top Area
			for (var i = 0; i < list.length; i++) {
				html += "<tr>";
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td>" + replaceNullValue(list[i].statDt) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].svcType) + "</td>";
				
				if(list[i].product == null || list[i].product == "" || list[i].product == "undefined" || list[i].product == "N"){
					html += "	<td>" + "-" + "</td>";					
				}else{
					html += "	<td>" + productMap.get(replaceNullValue(list[i].product)) + "</td>";			
				}
				if(list[i].joinStatus == null || list[i].joinStatus == "" || list[i].joinStatus == "undefined" || list[i].joinStatus == "N"){
					html += "	<td>" + "-" + "</td>";					
				}else{
					html += "	<td>" + joinStatusMap.get(replaceNullValue(list[i].joinStatus)) + "</td>";			
				}
				if(list[i].gender == null || list[i].gender == "" || list[i].gender == "undefined" || list[i].gender == "N"){
					html += "	<td>" + "-" + "</td>";					
				}else{
					html += "	<td>" + joinStatusMap.get(replaceNullValue(list[i].gender)) + "</td>";			
				}
				if(list[i].age == null || list[i].age == "" || list[i].age == "undefined" || list[i].age == "N"){
					html += "	<td>" + "-" + "</td>";					
				}else{
					html += "	<td>" + joinStatusMap.get(replaceNullValue(list[i].age)) + "</td>";			
				}
				
				html += "	<td>" + replaceNullValue(list[i].statSvc) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].statApp) + "</td>";
				html += "	<td>" + statCat1Map.get(replaceNullValue(list[i].statApp)+":"+ replaceNullValue(list[i].statCat1)) + "</td>";
				html += "	<td>" + statItemMap.get(replaceNullValue(list[i].statApp)+":"+ replaceNullValue(list[i].statCat1)+":"+replaceNullValue(list[i].statItem)) + "</td>";
				html += "	<td>" + replaceNullValue(list[i].statVal) + "</td>";
				html += "</tr>";
			}
		}

			$("#paging").empty();
			$("#paging").append(data.paging);
			$("#serviceStatList").empty();
			$("#serviceStatList").append(html);
			$("#totCnt").text(totalResult);
			
	}).error(
			function(request, status, error) {
				if (request.status == 401) {
					alert("해당 권한이 없습니다.");
				} else {
					console.log("서버 내부 오류 발생", "code:" + request.status	+ "\n" + "message:" + request.responseText	+ "\n" + "error:" + error);
					if(request.status ==200){
						location.href = "<c:url value='/login/loginView.do' />";
					}
				}
	});
	}

function replaceNullValue(txt){
	//console.log('txt',txt);
	if(txt =='null' || txt == null){
		return 'Unknown';
	}
	return txt;
}
function isNumber(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	}); 
}
function calDateRange(val1, val2)
{
	var FORMAT = "-";
	// FORMAT을 포함한 길이 체크
	if (val1.length != 10 || val2.length != 10)
		return null;

	// FORMAT이 있는지 체크
	if (val1.indexOf(FORMAT) < 0 || val2.indexOf(FORMAT) < 0)
		return null;

	// 년도, 월, 일로 분리
	var start_dt = val1.split(FORMAT);
	var end_dt = val2.split(FORMAT);

	// 월 - 1(자바스크립트는 월이 0부터 시작하기 때문에...)
	// Number()를 이용하여 08, 09월을 10진수로 인식하게 함.
	start_dt[1] = (Number(start_dt[1]) - 1) + "";
	end_dt[1] = (Number(end_dt[1]) - 1) + "";

	var from_dt = new Date(start_dt[0], start_dt[1], start_dt[2]);
	var to_dt = new Date(end_dt[0], end_dt[1], end_dt[2]);

	return (to_dt.getTime() - from_dt.getTime()) / 1000 / 60 / 60 / 24;
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="serviceStatSearchForm" name="serviceStatSearchForm">
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="statItemArray" name="statItemArray" />
	<input type="hidden" id="statNmArray" name="statNmArray" />
	
		<div class="main_top">
			<h2> 서비스 통계 > 서비스 통계 이력 조회 </h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">서비스 통계 검색 조건</div>
			</div>
			<div class="rtl">
				<div class="table_info01">* 선택입력</div>
			</div>
		</div>
		<!-- e: table top-->
			
		<!-- s: search table wrap-->
		<div class="table_wrap">
			<table class="table simple table_write_type">
				<colgroup>
					<col width="16%"/>
					<col width="34%"/>
					<col width="16%"/>
					<col width="34%"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="last" >추출 기간<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<div id="datepicker1_group" class="group">
								<fmt:parseDate value="${serviceStatVO.startDate}" var='startDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 120px;" id="startDate" name="startDate" value="<fmt:formatDate value="${startDate}" pattern="yyyy-mm-dd"/>" readonly />
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
							&nbsp;
							<select class="select w01" style="width: 100px;" id="startHour" name="startHour">
								<c:forEach var="hours" begin="00" end="23">
									<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
									<option value="${hour}" <c:if test="${empty serviceStatVO.svcStatSeq and hour eq 00}">selected="selected"</c:if>
															 <c:if test="${!empty serviceStatVO.svcStatSeq and hour eq serviceStatVO.startHour}">selected="selected"</c:if> >${hour}</option>
								</c:forEach>
							</select>
							 ~ 
							<div id="datepicker2_group" class="group">
								<fmt:parseDate value="${serviceStatVO.startDate}" var='endDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 120px;" id="endDate" name="endDate" value="<fmt:formatDate value="${endDate}" pattern="yyyy-mm-dd"/>" readonly />
								<a class="btn btn-gray"><i class="icon-calendar"></i></a>
				
								<div id="datepicker2" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
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
							&nbsp;
							<select class="select w01" style="width: 100px;" id="endHour" name="endHour">
								<c:forEach var="hours" begin="00" end="23">
									<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
									<option value="${hour}" <c:if test="${empty serviceStatVO.svcStatSeq and hour eq 00}">selected="selected"</c:if>
															 <c:if test="${!empty serviceStatVO.svcStatSeq and hour eq serviceStatVO.endHour}">selected="selected"</c:if> >${hour}</option>
								</c:forEach>
							</select>
							  &nbsp;&nbsp;
							 
							 <select class="select w01" style="width: 100px;" id="searchType" name="searchType">
								 	<option value="time" selected="selected">시간</option>
									<option value="day">일</option>
							 </select>
						</td>
					</tr>
					<tr>
						<th class="last" >서비스 구분<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="svcType" name="svcType" class="select w01"style="width: 380px; ">
								
							</select>
						</td>
						<th class="last" >가입 상태<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="joinStatus" name="joinStatus" class="select w01"style="width: 380px; ">
								
							</select>
						</td>
					</tr>
					
					<tr>
						<th class="last" >성별<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="gender" name="gender" class="select w01"style="width: 380px; ">
								
							</select>
						</td>
						<th class="last" >연령대<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="age" name="age" class="select w01"style="width: 380px; ">
								
							</select>
						</td>
					</tr>
					
					<tr>
						<th class="last" >가입상품명<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<select id="product" name="product" class="select w01"style="width: 380px;">
								
							</select>
						</td>
					</tr>
					
					<tr>
						<th class="last" >선택1.서비스<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="statSvc" name="statSvc" class="select w01"style="width: 380px;">
							</select>
						</td>
						<th class="last" >선택2.APP<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="statApp" name="statApp" class="select w01"style="width: 380px;">
							
							</select>
						</td>
					</tr>
					<tr>
						<th class="last" >선택3.통계명<span class="imp">*</span></th>
						<td  colspan="3" class="last">
							<select id="statNm" name="statNm" class="select w01"style="width: 100%;">
								<option value='ALL' selected='selected'>전체</option>
							</select>
						</td>
					</tr>
					<tr id="step3ViewTableArea">
						<th class="last" ><span class="imp"></span></th>
						<td colspan="1" class="last">
							<div style="width:100%; height:200px; overflow:auto">
							<table>
								<colgroup>
									<col width="16%"/>
									<col width="*%"/>
								</colgroup>
									<tr>
										<th class="last" ><span class="imp"></span></th>
										<td id = "statCat1" colspan="1" class="last">
										</td>
									</tr>
							</table>
							</div>
						</td>
						<th class="last" >상세 Item 명<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<div style="width:100%; height:200px; overflow:auto">
							<table>
								<colgroup>
									<col width="16%"/>
									<col width="*%"/>
								</colgroup>
								<tr>
									<th class="last" ><span class="imp"></span></th>
									<td id = "statItem" colspan="1" class="last">
									</td>
								</tr>
							</table>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="thead_wrap cboth">
				<div class="rtl">
					<a href="javascript:goSearch(1);"><span class="btn btn_w01"> 조회</span></a>&nbsp;
				</div>
				<div class="rtl">
					<a href="javascript:resetSearch();"><span class="btn btn_w01"> 초기화</span></a>&nbsp;
				</div>
			</div>
			<br><br>
			<div class="thead_wrap cboth">
				<div class="ltr">
					<div class="tit_table">통합 서비스 통계 리스트</div>
				</div>
				<div class="rtl">
					<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
				</div>
		</div>
	<!-- e: search table wrap-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="10%"/>
				<col width="5%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="5%"/>
				<col width="5%"/>
				<col width="5%"/>
				<col width="10%"/>
				<col width="12%"/>
				<col width="22%"/>
				<col width="5%"/>
			</colgroup>
			<thead>
				<tr>
					<th colspan="1" scope="colgroup">No</th>
					<th colspan="1" scope="colgroup">기간</th>
					<th colspan="1" scope="colgroup">서비스<br>구분</th>
					<th colspan="1" scope="colgroup">가입상품명<br>Type</th>
					<th colspan="1" scope="colgroup">가입상태</th>
					<th colspan="1" scope="colgroup">성별</th>
					<th colspan="1" scope="colgroup">연령</th>
					<th colspan="1" scope="colgroup">서비스</th>
					<th colspan="1" scope="colgroup">APP</th>
					<th colspan="1" scope="colgroup">통계명</th>
					<th colspan="1" scope="colgroup">상세</th>
					<th colspan="1" scope="colgroup">Count</th>
				</tr>
			</thead>
			<tbody id="serviceStatList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:downLoadExcel();">엑셀 다운로드</a></span>
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>

