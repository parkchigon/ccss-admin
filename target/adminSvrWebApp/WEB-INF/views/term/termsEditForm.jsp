<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
var termsDivListMap = new Map();
$(document).ready(function(){

	selectTermsDivList()
	$("#termsCont").val(safeTagToHtmlTag($("#termsCont").val()));
	
	var requiredYn = '${termsVO.requiredYn}';
	$('input:radio[name=requiredYn]:input[value=' + requiredYn + ']').attr("checked", true);
	
	
	// 데이터 피커 생성
	datePicker({
		datePickerGroupId: "datepicker1_group",
		datePickerId: "datepicker1",
		defaultDt : $('#spostDate').val()
		
	});
	
	datePicker({
		datePickerGroupId: "datepicker2_group",
		datePickerId: "datepicker2",
		defaultDt : $('#epostDate').val()
	});
	
	
	// Terms Type 선택시 제목 자동 생성. 
	 $("input[name=termsDiv]").change(function() {
			var radioValue = $(this).val();
			
			 if (radioValue == "1") {
				 $("#termsTitle").val("서비스이용약관");
			} else if (radioValue == "2") {
				$("#termsTitle").val("위치기반 서비스 이용약관");
			} else if (radioValue == "3") {
				$("#termsTitle").val("개인정보 처리방침");
			}
		});
	
});

function makeTermsDivArea(){
	$("#termsDivArea").empty();
	$("#termsDivPreViewArea").empty();
	var termsDivAtreaHtml ="";
	var termsDivPreViewAreaHtml="";
	var termsDivMapKeyList =termsDivListMap.keys();
	
	for(var i=0; i< termsDivListMap.size(); i++){
		termsDivAtreaHtml += "<input type='radio' name='termsDiv' id='termsDiv'  value=" +"'"+ termsDivMapKeyList[i] +"'"+ "/> <label for='termsDiv'>" + termsDivListMap.get(termsDivMapKeyList[i]) + "</label>&nbsp;&nbsp;"; 
		termsDivPreViewAreaHtml += "<input disabled type='radio' name='ptermsDiv' id='ptermsDiv'  value=" +"'"+ termsDivMapKeyList[i] +"'"+ "/> <label for='termsDiv'>" + termsDivListMap.get(termsDivMapKeyList[i]) + "</label>&nbsp;&nbsp;"; 
	}
	
	$("#termsDivArea").append(termsDivAtreaHtml);
	$("#termsDivPreViewArea").append(termsDivPreViewAreaHtml);
	
	
	var termsDiv = "${termsVO.termsDiv}";
	var exposureYn = "${termsVO.exposureYn}";
	$('input:radio[name=termsDiv]:input[value=' + termsDiv + ']').attr("checked", true);
	$('input:radio[name=exposureYn]:input[value=' + exposureYn + ']').attr("checked", true);
	
	
	
	// Terms Type 선택시 제목 자동 생성. 
	 $("input[name=termsDiv]").change(function() {
		var radioValue = $(this).val();
		 $("#termsTitle").val(termsDivListMap.get(radioValue));
	});
	
}
function selectTermsDivList(){
	$.ajax({
		url : "<c:url value='/system/code/selectDtlCodeListByGrpCodeNm.do' />",
		type : "POST",
		data : {
			"grpCdNm" : "TERMS_DIV"
		},
		dataType : "json"
	}).done(function (data) {
		var list = data.resultList;
		for (var i = 0; i < list.length ; i++) {		
			termsDivListMap.put(list[i].cdVal,list[i].codeDesc);
		}
		
		 makeTermsDivArea();
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

//시작일, 종료일 체크
function checkStartEndDate(start, end, msg){
	
	//공백 체크
	if(start.trim() == "" || start.trim() == null){
		alert("시작 날짜를 선택해주세요.");
		return false;
	}
	if(end.trim() == "" || end.trim() == null){
		alert("종료 날짜를 선택해주세요.");
		return false;
	}
	 
	if( start > end )
	{
		alert(msg);
		return false;
	}
	else{
		return true;
	}
}

function updateTerms() {
	if(confirm("해당 약관 버전을 수정 하시겠습니까?")) {
		var spostDate =$("#spostDate").val();
		var spostHour = $("#spostHour").val();
		var spostMinute =$("#spostMinute").val();

		var epostDate = $("#epostDate").val();
		var epostHour =$("#epostHour").val();
		var epostMinute =$("#epostMinute").val();
		

		var termsDiv = $("#termsDiv").val();
		var exposureYn = $("#exposureYn").val();
		var termsTitle = $("#termsTitle").val();
		var termsVer = $("#termsVer").val();
		var termsCont = $("#termsCont").val();
		
		//Date 형식 Set
		var spostDate =$("#spostDate").val();
		var spostHour = $("#spostHour").val();
		var spostMinute =$("#spostMinute").val();
		var epostDate = $("#epostDate").val();
		var epostHour =$("#epostHour").val();
		var epostMinute =$("#epostMinute").val();
		
		$("#exposureStartDt").val(spostDate.replace(/-/gi, "") + spostHour + spostMinute +"00");
		$("#exposureEndDt").val(epostDate.replace(/-/gi, "") + epostHour + epostMinute +"00");
		
		var validCheck = false;
		validCheck = checkStartEndDate($('#exposureStartDt').val(), $('#exposureEndDt').val(),  " 시작일, 종료일이 잘못되었습니다.");
		
		if(!validCheck){
			return false;
		}
		
		
		$("#termsCont").val(safeTagToHtmlTag($("#termsCont").val()));
		
		if (formValidationCheck(['termsDiv', 'exposureYn', 'termsTitle', 'termsVer', 'termsCont','spostDate','spostHour','spostMinute','epostDate','epostHour','epostMinute'])){
			
			var url = "<c:url value='/term/updateTerms.do' />";
			
			$.ajax({
				url : url
				,data : $('#termsDetailForm').serialize()
				,dataType : 'json'
				,type : "POST"
			}).done(function(data ,request) {
				var result = data.result;
				console.log("data",data);
				if(result == 'Y'){ 
					alert("약관이 수정 되었습니다.");
					location.href="<c:url value='/term/termsDetail.do?termsNo="+"${termsVO.termsNo}"+"'/>";
				} else if(result == 'E'){
					alert("현재 사용중인 버전이 있습니다.\n버전 선택은 1개만 가능 합니다.");
				}else if(result == 'DTSN'){
					alert("현재 사용중인 노출 순서 번호가 있습니다.");
				}else{
					alert("약관 수정에 실패하였습니다.");
				}
			}).error(function(request,status,error){
				//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				if(request.status == 401){
					alert("해당 권한이 없습니다.");
				}else{
					console.log("서버 내부 오류 발생","code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					if(request.status ==200){
						location.href = "<c:url value='/login/loginView.do' />";
					}
				}
			});
		}
	}
}

//미리보기  팝업 화면 셋팅
function  preView(){
	
	var termsDiv = $(":input:radio[name=termsDiv]:checked").val();
	var exposureYn = $(":input:radio[name=exposureYn]:checked").val();
	var requiredYn = $(":input:radio[name=requiredYn]:checked").val();
	var termsTitle = $("#termsTitle").val();
	var termsVer = $("#termsVer").val();
	var termsCont = $("#termsCont").val();
	var termsSortNum = $("#termsSortNum").val();
	//Date 형식 Set
	var spostDate =$("#spostDate").val();
	var spostHour = $("#spostHour").val();
	var spostMinute =$("#spostMinute").val();
	var epostDate = $("#epostDate").val();
	var epostHour =$("#epostHour").val();
	var epostMinute =$("#epostMinute").val();
	

	$('input:radio[name=ptermsDiv]:input[value=' + termsDiv + ']').attr("checked", true);
	$('input:radio[name=pexposureYn]:input[value=' + exposureYn + ']').attr("checked", true);
	$('input:radio[name=prequiredYn]:input[value=' + requiredYn + ']').attr("checked", true);
	
	$("#ptermsTitle").val(termsTitle);
	$("#ptermsVer").val(termsVer);
	
	$("#ptermsSortNum").val(termsSortNum);
	
	
	$("#ptermsCont").val(safeTagToHtmlTag($("#termsCont").val()));
	$("#pexposureStartDt").val(spostDate + " "+spostHour + ":" + spostMinute +":00");
	$("#pexposureEndDt").val(epostDate + " "+epostHour + ":" + epostMinute +":00");
	
	$(".dimmed").show();
	$("#termsPreViewPopup").show();
}


function historyBack() {
	if(confirm("저장 없이 목록으로 돌아가시겠습니까?")) {
		history.back();
	}
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
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="termsDetailForm" name="termsDetailForm">
	<input type="hidden" id="termsNo" name="termsNo" value="${termsVO.termsNo}" />
	<input type="hidden" id="exposureStartDt" name="exposureStartDt"  />
	<input type="hidden" id="exposureEndDt" name="exposureEndDt" />
		<div class="main_top">
			<h2>전시관리 > 약관관리 > 약관 수정</h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">기본정보</div>
			</div>
		</div>
		<!-- e: table top-->
			
		<!-- s: table wrap-->
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
						<th>약관 구분 <span class="imp">*</span></th>
						<td id="termsDivArea" colspan="3" class="last">
							<!-- <input  type="radio" name="termsDiv" id="termsDiv" class="" value="1" /> <label for="termsDiv">서비스 이용약관</label>&nbsp;&nbsp;
							<input  type="radio" name="termsDiv" id="termsDiv" class="" value="2" /> <label for="termsDiv">위치기반 서비스 이용약관</label>&nbsp;&nbsp;
							<input  type="radio" name="termsDiv" id="termsDiv" class="" value="3" /> <label for="termsDiv">개인정보 처리방침</label> -->
						</td>
					</tr>
					<tr>
						<th>상태<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  type="radio" name="exposureYn" id="exposureYn" class="" value="Y" /> <label for="pexposureYn">사용</label>&nbsp;&nbsp;
							<input  type="radio" name="exposureYn" id="exposureYn" class="" value="N" /> <label for="pexposureYn">미사용</label>
						</td>
					</tr>
					<tr>
						<th><div class="tit_search">약관 게시 시작 일시<span class="imp">*</span></div></th>
						<td colspan="3" class="last">
							<div id="datepicker1_group" class="group">
								<fmt:parseDate value="${termsVO.spostDate}" var='spostDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 120px;" id="spostDate" name="spostDate" value="<fmt:formatDate value="${spostDate}" pattern="yyyy-mm-dd"/>" readonly />
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
							<select class="select w01" style="width: 100px;" id="spostHour" name="spostHour">
								<c:forEach var="hours" begin="00" end="23">
									<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
									<option value="${hour}" <c:if test="${empty termsVO.termsNo and hour eq 12}">selected="selected"</c:if>
															 <c:if test="${!empty termsVO.termsNo and hour eq termsVO.spostHour}">selected="selected"</c:if> >${hour}</option>
								</c:forEach>
							</select>
							 &nbsp;시 &nbsp;
							<select class="select w01" style="width: 100px;" id="spostMinute" name="spostMinute">
								<c:forEach var="minutes" begin="00" end="59">
									<fmt:formatNumber var="minute" value="${minutes}" pattern="00" />
									<option value="${minute}" <c:if test="${empty termsVO.termsNo and minute eq 00}">selected="selected"</c:if> 
																<c:if test="${!empty termsVO.termsNo and minute eq termsVO.spostMinute}">selected="selected"</c:if>>${minute}</option>
								</c:forEach>
							</select>
							&nbsp;분 &nbsp;
						</td>
					</tr>
					
					
					<tr>
						<th><div class="tit_search">약관 게시 종료 일시<span class="imp">*</span></div></th>
						<td colspan="3" class="last">
							<div id="datepicker2_group" class="group">
								<fmt:parseDate value="${termsVO.epostDate}" var='epostDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 120px;" id="epostDate" name="epostDate" value="<fmt:formatDate value="${epostDate}" pattern="yyyy-mm-dd"/>" readonly />
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
							<select class="select w01" style="width: 100px;" id="epostHour" name="epostHour">
								<c:forEach var="hours" begin="00" end="23">
									<fmt:formatNumber var="hour" value="${hours}" pattern="00" />
									<option value="${hour}" <c:if test="${empty termsVO.termsNo and hour eq 12}">selected="selected"</c:if>
															 <c:if test="${!empty termsVO.termsNo and hour eq termsVO.spostHour}">selected="selected"</c:if> >${hour}</option>
								</c:forEach>
							</select>
							 &nbsp;시 &nbsp;
							<select class="select w01" style="width: 100px;" id="epostMinute" name="epostMinute">
								<c:forEach var="minutes" begin="00" end="59">
									<fmt:formatNumber var="minute" value="${minutes}" pattern="00" />
									<option value="${minute}" <c:if test="${empty termsVO.termsNo and minute eq 00}">selected="selected"</c:if> 
																<c:if test="${!empty termsVO.termsNo and minute eq termsVO.spostMinute}">selected="selected"</c:if>>${minute}</option>
								</c:forEach>
							</select>
							&nbsp;분 &nbsp;
						</td>
					</tr>
					<tr>
						<th>제목 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="termsTitle" name="termsTitle" value ="${termsVO.termsTitle}"  class="input w01" readonly/>
						</td>
					</tr>
					<tr>
						<th>버전 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="termsVer" name="termsVer" value ="${termsVO.termsVer}" class="input w01" />
						</td>
					</tr>
					<tr>
						<th>내용 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<textarea id="termsCont" name="termsCont" class="input textareabox" style="height:400px"><c:out value="${termsVO.termsCont}" /></textarea>
						</td>
					</tr>
					
					<th>노출 순서 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input title="0 입력시 자동 마지막 순서로 저장 됩니다" type="number" autocomplete="off" id="termsSortNum" name="termsSortNum" value ="${termsVO.termsSortNum}" class="input w01" />
						</td>
					</tr>	
					<tr>
						<th>필수 여부 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  checked type="radio" name="requiredYn" id="requiredYn" class="" value="Y" /> <label for="requiredYn">필수</label>&nbsp;&nbsp;
							<input  type="radio" name="requiredYn" id="requiredYn" class="" value="N" /> <label for="requiredYn">선택</label>
						</td>
					</tr>	
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<!-- <a href="javascript:preView();"><span class="btn large">미리보기</span></a> -->
			<a href="javascript:updateTerms();"><span class="btn large focus">저장</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
<!--PreView Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="termsPreViewPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 600px">
			<div class="p_header">
				<h1>미리보기</h1>
				<a href="javascript:$('#termsPreViewPopup').hide(); $('.dimmed').hide();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
							<div class="table_wrap">
									<table class="table simple table_write_type">
										<colgroup>
											<col width="20%"/>
											<col width="30%"/>
											<col width="16%"/>
											<col width="34%"/>
										</colgroup>
										<tbody>
											<tr>
												<th>약관 구분 <span class="imp">*</span></th>
												<td id="termsDivPreViewArea" colspan="3" class="last">
													<!-- <input disabled type="radio" name="ptermsDiv" id="ptermsDiv" class="" value="1" /> <label for="termsDiv">서비스 이용약관</label>&nbsp;&nbsp;
													<input disabled type="radio" name="ptermsDiv" id="ptermsDiv" class="" value="3" /> <label for="termsDiv">위치기반 서비스 이용약관</label>&nbsp;&nbsp;
													<input disabled type="radio" name="ptermsDiv" id="ptermsDiv" class="" value="2" /> <label for="termsDiv">개인정보 처리방침</label> -->
												</td>
											</tr>
											<tr>
												<th>상태<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input disabled type="radio" name="pexposureYn" id="pexposureYn" class="" value="Y" /> <label for="pexposureYn">사용</label>&nbsp;&nbsp;
													<input disabled type="radio" name="pexposureYn" id="pexposureYn" class="" value="N" /> <label for="pexposureYn">미사용</label>
												</td>
											</tr>
											<tr>
												<th>약관 게시 시작 일시<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pexposureStartDt" name="pexposureStartDt" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>약관 게시 종료 일시<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pexposureEndDt" name="pexposureEndDt" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>제목 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="ptermsTitle" name="ptermsTitle" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>버전 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="ptermsVer" name="ptermsVer" class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>내용 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<textarea id="ptermsCont" name="ptermsCont" class="input textareabox" style="height:400px" readonly></textarea>
												</td>
											</tr>
											<tr>
												<th>노출 순서 <span class="imp">*</span></th>
												<td colspan="1" class="last">
													<input  type="text" autocomplete="off" id="ptermsSortNum" name="ptermsSortNum" class="input w01" readOnly"/>
												</td>
												<th>필수 여부 <span class="imp">*</span></th>
												<td colspan="1" class="last">
													<input disabled type="radio" name="prequiredYn" id="prequiredYn" class="" value="Y" /> <label for="prequiredYn">필수</label>&nbsp;&nbsp;
													<input disabled type="radio" name="prequiredYn" id="prequiredYn" class="" value="N" /> <label for="prequiredYn">선택</label>
												</td>
											</tr>		
										</tbody>
									</table>
								</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:$('#termsPreViewPopup').hide(); $('.dimmed').hide();">확인</span>
					</div>
					<!-- e: btn -->

				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
