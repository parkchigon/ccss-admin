<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	//S:Radio Data Set
	var agrYn =  "${commAgrVO.agrYn}";
	$('input:radio[name=agrYn]:input[value=' + agrYn + ']').attr("checked", true);
	//E:Radio Data Set	
	
	//Start 시간 설정
	/* var startDate = "${commAgrVO.startDate}"; */
	var startDate = "${commAgrVO.validStartDt}";	
	if(startDate !=null && startDate != ""){
		$('#startDate').val(startDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
		
	}else{
		$('#startDate').val(dateAdd(new Date().toISOString().slice(0,10),0,"d"));
	}
	//End 시간 설정
	/* var endDate = "${endDate}"; */
	var endDate = "${commAgrVO.validEndDt}";
	if(endDate !=null && endDate != ""){
		$('#endDate').val(endDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
	}else{
		$('#endDate').val(dateAdd(new Date().toISOString().slice(0,10),+365,"d"));
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
});

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
//미리보기 팝업 화면 셋팅
function  preView(){
	
	var agrYn =  $(":input:radio[name=agrYn]:checked").val();
	var deviceCtn =  $("#deviceCtn").val();
	var uiccid =  $("#uiccid").val();
	var termsNo =  $("#termsNo").val();
	var termsAuthNo =  $("#termsAuthNo").val();
	/* var validStartDt =  $("#validStartDt").val();
	var validEndDt =  $("#validEndDt").val(); */
	
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	
	var itemSn =  $("#itemSn").val();
	var usimModelNm =  $("#usimModelNm").val();
	var naviSn =  $("#naviSn").val();
	
	$('input:radio[name=pagrYn]:input[value=' + agrYn + ']').attr("checked", true);
	$("#pdeviceCtn").val(deviceCtn);
	$("#puiccid").val(uiccid);
	$("#ptermsNo").val(termsNo);
	$("#ptermsAuthNo").val(termsAuthNo);
	$("#pvalidStartDt").val(startDate);
	$("#pvalidEndDt").val(endDate);
	$("#pitemSn").val(itemSn);
	$("#pusimModelNm").val(usimModelNm);
	$("#pnaviSn").val(naviSn);
	
	
	$(".dimmed").show();
	$("#commAgrPreViewPopup").show();
}



//미입력 항목 alert
function alertMessageSource(elId){
	alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
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


// App 등록/수정
function commAgrUpdate() {
	
	if(confirm("해당 데이터 약관 정보를 수정 하시겠습니까?")) {
		
		var startDate =$("#startDate").val();
		var endDate = $("#endDate").val();
		
		$("#validStartDt").val(startDate.replace(/-/gi, ""));
		$("#validEndDt").val(endDate.replace(/-/gi, ""));
		
		var validCheck = false;
		validCheck = checkStartEndDate($('#validStartDt').val(), $('#validEndDt').val(),  " 시작일, 종료일이 잘못되었습니다.");
		
		if(!validCheck){
			return false;
		}
		
	
		var url = "<c:url value='/user/updateCommAgr.do' />";
		
		/* checkParamArr = ['agrYn', 'deviceCtn', 'uiccid', ,'termsNo', 'termsAuthNo','validStartDt','validEndDt','itemSn','usimModelNm','naviSn']; */
		checkParamArr = ['agrYn', 'deviceCtn', 'uiccid', ,'termsNo', 'termsAuthNo','validStartDt','validEndDt'];
		
		if (formValidationCheck(checkParamArr)){
			$.ajax({
				url : url
				,data : $('#commAgrUpdateForm').serialize()
				,dataType : 'json'
				,type : "POST"
			}).done(function(data) {
				var result = data.result;
				if(result == 'Y'){ 
					alert(" 데이터 약관 정보가 수정 되었습니다.");
					location.href="<c:url value='/user/commAgrManagement.do' />";
				} else if(result == 'E'){
					alert("현재 중복된 데이터 약관 정보이 있습니다.");
				}else{
					alert("데이터 약관 정보 수정에 실패하였습니다.");
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
}

function historyBack(){
	if(confirm("저장 없이 목록으로 돌아가시 겠습니까?")) {
		var commAgrSeq = ${commAgrVO.commAgrSeq}
		location.href="<c:url value='/user/selectcommAgrDetail.do?commAgrSeq="+commAgrSeq+"'/>";
	}
}


</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="commAgrUpdateForm" name="commAgrUpdateForm">
		<input type="hidden" id="commAgrSeq" name="commAgrSeq" value="${commAgrVO.commAgrSeq}" />
		<input type="hidden" id="validStartDt" name="validStartDt" />
		<input type="hidden" id="validEndDt" name="validEndDt" />
		
		<div class="main_top">
			<h2> 사용자 관리 > AM 데이터 약관 정보 관리 > AM 데이터 약관 상세 정보 수정</h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">기본정보</div>
			</div>
			<div class="rtl">
				<div class="table_info01">* 필수입력</div>
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
						<th>DEVICE_CTN <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="deviceCtn" name="deviceCtn"  value ="${commAgrVO.deviceCtn}" class="input w01" />
						</td>
					</tr>
					
					<tr>
						<th>UICCID <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="uiccid" name="uiccid"  value ="${commAgrVO.uiccid}" class="input w01" />
						</td>
					</tr>
					
					<tr>
						<th>TERMS_NO <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="termsNo" name="termsNo"  value ="${commAgrVO.termsNo}" class="input w01" />
						</td>
					</tr>
					
					<tr>
						<th>TERMS_AUTH_NO <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="termsAuthNo" name="termsAuthNo"  value ="${commAgrVO.termsAuthNo}" class="input w01" />
						</td>
					</tr>
					
					<tr>
						<th>AGR_YN<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  type="radio" name="agrYn" id="agrYn" class="" value="Y" /> <label for="agrYn">등록</label>&nbsp;&nbsp;
							<input  type="radio" name="agrYn" id="agrYn" class="" value="N" /> <label for="agrYn">미등록</label>
						</td>
					</tr>
					
					
					<tr>
						<th><div class="tit_search">VALID_START_DT<span class="imp">*</span></div></th>
						<td colspan="3" class="last">
							<div id="datepicker1_group" class="group">
								<fmt:parseDate value="${commAgrVO.validStartDt}" var='startDate' pattern="yyyy-mm-dd"/>
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
					</tr>
					
					<tr>
						<th><div class="tit_search">VALID_END_DT<span class="imp">*</span></div></th>
						<td colspan="3" class="last">
							<div id="datepicker2_group" class="group">
								<fmt:parseDate value="${commAgrVO.validEndDt}" var='endDate' pattern="yyyy-mm-dd"/>
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
						</td>
					</tr>
					
					
					<tr>
						<th>ITEM_SN</th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="itemSn" name="itemSn"  value ="${commAgrVO.itemSn}" class="input w01" />
						</td>
					</tr>
					
					<tr>
						<th>USIM_MODEL_NM</th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="usimModelNm" name="usimModelNm" value ="${commAgrVO.usimModelNm}"  class="input w01" />
						</td>
					</tr>
					
					<tr>
						<th>NAVI_SN</th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="naviSn" name="naviSn" value ="${commAgrVO.naviSn}"  class="input w01" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
		
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<a href="javascript:preView();"><span class="btn large">미리보기</span></a>
			<a href="javascript:commAgrUpdate();">
				<span class="btn large focus">저장</span>
			</a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>



<!--PreView Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="commAgrPreViewPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 800px">
			<div class="p_header">
				<h1>미리보기</h1>
				<a href="javascript:$('#commAgrPreViewPopup').hide(); $('.dimmed').hide();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
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
												<th>DEVICE_CTN <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pdeviceCtn" name="pdeviceCtn"  class="input w01" readonly/>
												</td>
											</tr>
											
											<tr>
												<th>UICCID <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="puiccid" name="puiccid"  class="input w01" readonly/>
												</td>
											</tr>
											
											<tr>
												<th>TERMS_NO <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="ptermsNo" name="ptermsNo"  class="input w01" readonly/>
												</td>
											</tr>
											
											<tr>
												<th>TERMS_AUTH_NO <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="ptermsAuthNo" name="ptermsAuthNo"  class="input w01" readonly/>
												</td>
											</tr>
											
											<tr>
												<th>AGR_YN<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input disabled type="radio" name="pagrYn" id="pagrYn" class="" value="Y" /> <label for="pagrYn">등록</label>&nbsp;&nbsp;
													<input disabled type="radio" name="pagrYn" id="pagrYn" class="" value="N" /> <label for="pagrYn">미등록</label>
												</td>
											</tr>
											
											
											<tr>
												<th>VALID_START_DT <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pvalidStartDt" name="pvalidStartDt"  class="input w01" readonly/>
												</td>
											</tr>
											
											<tr>
												<th>VALID_END_DT <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pvalidEndDt" name="pvalidEndDt"  class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>ITEM_SN</th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pitemSn" name="pitemSn"  class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>USIM_MODEL_NM</th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pusimModelNm" name="pusimModelNm"  class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th>NAVI_SN</th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pnaviSn" name="pnaviSn"  class="input w01" readonly/>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:$('#commAgrPreViewPopup').hide(); $('.dimmed').hide();">확인</span>
					</div>
					<!-- e: btn -->

				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
