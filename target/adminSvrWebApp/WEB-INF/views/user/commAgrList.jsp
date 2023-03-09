<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
$(document).ready(function(){
	
	goSearch(1);
	checkboxClickEventHandler();
	
	//엑셀 Upload form 숨김.
	$("#excelUploadForm").hide();
	
	
	
});

// 리스트 조회
function goSearch(page) {
	$("#page").val(page);
	$.ajax({
		url :"<c:url value='/user/selectcommAgrList.do'/>"
		,data : $('#commAgrSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		

		for (var i = 0; i < list.length ; i++) {					
			html += "<tr>";
			html += "	<td>" + list[i].rnum + "</td>";
			html += "	<td>" + list[i].deviceCtn + "</td>"; 
			html += "	<td><a href='javascript:commAgrDetailForm(\"" + list[i].commAgrSeq+ "\");' class='link'>" + list[i].uiccid + "</td>";  
			
		/* 	html += "	<td>" + list[i].termsNo + "</td>"; 
			html += "	<td>" + list[i].termsAuthNo + "</td>"; 
			var agrYn = list[i].agrYn;
			if(agrYn == "Y"){
				html += " <td>" + "등록" + "</td>";
			}else{
				html += " <td>" + "미등록" + "</td>";
			} */
			
			html += "	<td>" + list[i].validStartDt + "</td>"; 
			html += "	<td>" + list[i].validEndDt + "</td>"; 
			
			/* html += "	<td>" + list[i].itemSn + "</td>"; 
			html += "	<td>" + list[i].usimModelNm + "</td>"; 
			html += "	<td>" + list[i].naviSn + "</td>";  */
			
			
			html += "	<td>" + list[i].regId + "</td>";
			html += "	<td>" + list[i].regDt + "</td>";
			html += '<td><input type="checkbox" value="'+list[i].commAgrSeq+'" name="commAgrCheckBox"></td>';
			html +="</tr>";
		}

		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#commAgrList").empty();
		$("#commAgrList").append(html);
		
		$("#totCnt").text(totalResult);
	}).error(
			function(request, status, error) {
				if (request.status == 401) {
					alert("해당 권한이 없습니다.");
				} else {
					console.log("서버 내부 오류 발생", "code:" + request.status
							+ "\n" + "message:" + request.responseText
							+ "\n" + "error:" + error);
					if(request.status ==200){
						location.href = "<c:url value='/login/loginView.do' />";
					}
				}
	});
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
	//var sDate = new Date(startDateArr[0], startDateArr[1], startDateArr[2]).valueOf();
	//var eDate = new Date(endDateArr[0], endDateArr[1], endDateArr[2]).valueOf();
	
	console.log("start:",start);
	console.log("end:",end);
	
	var sDate = start.replace(/-/g,"")+"00";
	var eDate = end.replace(/-/g,"")+"00";
	
	if( sDate > eDate )
	{
		alert(msg);
		return false;
	}
	else{
		
		var betweenDay = calDateRange(start,end);
		//console.log("betweenDay:",betweenDay)
		if(betweenDay >=31 ){
			alert("검색 기간은  최대 30일 이상 지정 하실 수 없습니다.");
			return false;
		}else{
			return true;
		}
	}
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

//검색 조건 초기화
function resetSearch(){
	$("#deviceCtn").val("");
	$("#uiccid").val("");
}


// 등록 화면
function commAgrInsertForm() {
	location.href="<c:url value='/user/insertCommAgrForm.do' />";
}

//세부 화면
function commAgrDetailForm(commAgrSeq){
	location.href="<c:url value='/user/selectcommAgrDetail.do?commAgrSeq="+commAgrSeq+"'/>";
}

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='commAgrCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='commAgrCheckBox']").attr("checked", false);
			}
		}
	});
}


function deleteCommAgr(){
	var commAgrCheckBoxSeqArray = $("input:checkbox[name='commAgrCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(commAgrCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.");
		return;
	}
	
	if(confirm("선택 하신 데이터 약관 정보를 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "<c:url value='/user/deleteCommAgr.do' />",
			type : "POST",
			data : {
				commAgrSeqArray : commAgrCheckBoxSeqArray.toString()
			},
			dataType : "json"
		}).done(function (data) {
			var resultCode = data.resultCode;
			if(resultCode == "0000") {
				alert("선택한 정보가 삭제 되었습니다.");
				location.reload(true);
			} else {
				alert("삭제 중 오류가 발생하였습니다.");				
			}
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
}

function checkFileType(filePath) {
	var fileFormat = filePath.split(".");
	if (fileFormat.indexOf("xlsx") > -1) {
		return true;
	} else {
		return false;
	}

}

function check() {
	var file = $("#excelFile").val();
	if (file == "" || file == null) {
		alert("파일을 선택해주세요.");
		return false;
	} else if (!checkFileType(file)) {
		alert("엑셀 파일만 업로드 가능합니다.");
		return false;
	}

	if (confirm("업로드 하시겠습니까?")) {
		var options = {
			success : function(data) {
				var resultData = data.result;
				
				
				
				if(resultData=="Y"){
					alert("모든 데이터가 업로드 되었습니다.");
					location.href ="/admin/user/commAgrManagement.do";
				}else if(resultData=="D"){
					
					alert("현재 사용중인 \n DEVICE_CTN:"+data.deviceCtn  + "\n UICCID :"+ data.uiccId +" \n 정보가 포함되어 있어 업로드 실패 하였습니다.");
				}else{
					alert("엑셀 업로드에 실패 하였습니다.");
				}
				
			},
			beforeSend:function(){
			$('.wrap-loading').removeClass('display-none');
			}
			 ,complete:function(){
			$('.wrap-loading').addClass('display-none');
			 },
			type : "POST",
			error : function(e){
				alert("엑셀 파일 업로드가 실패 하였습니다.");
			}
		};
		
		$("#excelUploadForm").ajaxSubmit(options);
	}
}

function  downCommAgrExcel(){
	var iframe = document.createElement('iframe');
	iframe.id = "IFRAMEID";
	iframe.style.display = 'none';
	document.body.appendChild(iframe);
	iframe.src = '/admin/user/downCommAgrExcel.do';
	
	iframe.addEventListener("load", function () {
	});
}

function regCommAgrExcel(){
	$("#excelUploadForm").show();
}

function cancleUploadExcel(){
	$("#excelUploadForm").hide();
	$("#excelFile").val('');
}


</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="commAgrSearchForm" name="commAgSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>사용자 관리 > AM 데이터 약관 정보 관리</h2>
	</div>
		
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<div class="tit_table">검색 조건</div>
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
				<col width="24%"/>
				<col width="16%"/>
				<col width="24%"/>
				<col width="16%"/>
				<col width="24%"/>
			</colgroup>
			<tbody>
				<tr>
					<th class="last" >CTN<span class="imp">*</span></th>
					<td colspan="2" class="last">
						<!-- <input type="text" placeholder="형식(000-0000-0000)" autocomplete="off" id="deviceCtn" name="deviceCtn" class="input w01"/> -->
						<input type="text" onkeydown="isNumber(this)" autocomplete="off" id="deviceCtn" name="deviceCtn" class="input w01"/>
					</td>
					<th class="last" >UICCID<span class="imp">*</span></th>
					<td colspan="2" class="last">
						<input type="text"  autocomplete="off" id="uiccid" name="uiccid" class="input w01"/>
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
		
		<div class="ltr">
				<div class="tit_table">AM 데이터 약관 정보 리스트</div>
		</div>
		<div class="rtl">
			<a href="javascript:deleteCommAgr();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="10%"/>
				<col width="10%"/>
				<!-- <col width="10%"/>
				<col width="10%"/> -->
				<!-- <col width="10%"/> -->
				<col width="15%"/>
				<col width="15%"/>
				<!-- <col width="10%"/>
				<col width="10%"/>
				<col width="10%"/> -->
				<col width="5%"/>
				<col width="10%"/>
				<col width="5%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>DEVICE_CTN</th>
					<th>UICCID</th>
					<!-- <th>TERMS_NO</th>
					<th>TERMS_AUTH_NO</th> -->
					<!-- <th>AGR_YN</th> -->
					<th>VALID_START_DT</th>
					<th>VALID_END_DT</th>
					<!-- <th>ITEM_SN</th>
					<th>USIM_MODEL_NM</th>
					<th>NAVI_SN</th> -->
					<th>등록자</th>
					<th>등록일</th>
					<th class="last">선택</th>
				</tr>
			</thead>
			<tbody id="commAgrList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:commAgrInsertForm();">등록하기</a></span>
			<!-- <span class="btn btn_w01"><a href="javascript:downCommAgrExcel();">업로드양식다운</a></span>
			<span class="btn btn_w01"><a href="javascript:regCommAgrExcel();">엑셀업로드</a></span> -->
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
	
	<form id="excelUploadForm" name="excelUploadForm" enctype="multipart/form-data" method="post" action="/admin/user/commAgrExcelUpload.do">
		<div class="main_title">
			<h3 class="tit">사용자 데이터 약관 동의 엑셀 업로드(첨부파일은 한개만 등록 가능합니다.)</h3>
				<div class="rtl"> 
					<span class="btn"><a href="#" id="addExcelImportBtn" class="b_in" style="width:70px;" onclick="check();return false;">업로드</a></span>
					<span class="btn"><a href="#" id="addExcelImportBtn" class="b_in" style="width:70px;" onclick="cancleUploadExcel();return false;">취소</a></span>
				</div>
		</div>
		<table cellpadding="0" cellspacing="0" border="0" >
			<colgroup>
					<col width="600" />
					<col width="130" />
				</colgroup>
				<tbody>
					<tr>
						<td><input class="b_in" id="excelFile" type="file" name="excelFile" /></td>
					</tr>
				</tbody>
		</table>
	</form>
<!-- e: 내용-->
</div>
