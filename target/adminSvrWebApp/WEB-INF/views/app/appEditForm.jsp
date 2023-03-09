<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	
	
	

	
	//S:Radio Data Set
	var useYn 		=  "${appVO.useYn}";
	var forcedUpdYn =  "${appVO.forcedUpdYn}";
	
	var appType  	=  "${appVO.appType}";
	
	var osType  	=  "${appVO.osType}";
	
	$('input:radio[name=useYn]:input[value=' + useYn + ']').attr("checked", true);
	$('input:radio[name=forcedUpdYn]:input[value=' + forcedUpdYn + ']').attr("checked", true);
	
	$("#appType").val(appType);
	
	$("#osType").val(osType);
	
	//E:Radio Data Set

});


 

//미리보기 팝업 화면 셋팅
function  preView(){
	
	var useYn =  $(":input:radio[name=useYn]:checked").val();
	var appType =  $("#appType").val();
	var osType =  $("#osType").val();
	var appNm =  $("#appNm").val();
	var appVer =  $("#appVer").val();
	var appFileNm =  $("#appFileNm").val();
	var appMarketUrl =  $("#appMarketUrl").val();
	var forcedUpdYn = $(":input:radio[name=forcedUpdYn]:checked").val();
	var appCont = $("#appCont").val();
	
	$('input:radio[name=puseYn]:input[value=' + useYn + ']').attr("checked", true);
	$("#pappType").val(appType);
	$("#posType").val(osType);
	
	$("#pappNm").val(appNm);
	$("#pappVer").val(appVer);
	$("#pappFileNm").val(appFileNm);
	$("#pappMarketUrl").val(appMarketUrl);
	$('input:radio[name=pforcedUpdYn]:input[value=' + forcedUpdYn + ']').attr("checked", true);
	$("#pappCont").val(appCont);
	
	$(".dimmed").show();
	$("#appPreViewPopup").show();
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
function appUpdate() {
	
	if(confirm("해당 App 버전 정보를 수정 하시겠습니까?")) {
		
	
		var url = "<c:url value='/app/updateApp.do' />";
		
		checkParamArr = ['useYn', 'appType', 'appNm', 'appVer', 'appFileNm','appMarketUrl','forcedUpdYn','appCont'];
		
		if (formValidationCheck(checkParamArr)){
			$.ajax({
				url : url
				,data : $('#appUpdateForm').serialize()
				,dataType : 'json'
				,type : "POST"
			}).done(function(data) {
				var result = data.result;
				if(result == 'Y'){ 
					alert(" App 버전 정보가 수정 되었습니다.");
					location.href="<c:url value='/app/appList.do' />";
				} else if(result == 'E'){
					alert("현재 사용중인 버전이 있습니다.\n버전 선택은 1개만 가능 합니다.");
				}else{
					alert("버전 수정에 실패하였습니다.");
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
		location.href="<c:url value='/app/appList.do' />";
	}
}



</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="appUpdateForm" name="appUpdateForm">
		<input type="hidden" id="appId" name="appId" value="${appVO.appId}" />
		<div class="main_top">
			<h2> 전시관리 > App 버전 관리 > App 버전 수정</h2>
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
						<th>구분<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  type="radio" name="useYn" id="useYn" class="" value="Y" /> <label for="useYn">사용</label>&nbsp;&nbsp;
							<input  type="radio" name="useYn" id="useYn" class="" value="N" /> <label for="useYn">미사용</label>
						</td>
					</tr>
					<tr>
						<th>OS 타입 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<select  id="osType" name="osType" class="select w01"style="width: 130px;">
									<option value="android" selected="selected">ANDROID</option>
									<option value="ios">IOS</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>App 타입 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<select  id="appType" name="appType" class="select w01"style="width: 130px;">
									<option value="" selected="selected">선택▼</option>
									<option value="AM_MGR_APP">AM_MGR_APP</option>
									<option value="BM_MGR_APP">BM_MGR_APP</option>
									<option value="NS_AM_APP">NS_AM_APP</option>
									<!-- 	<option value="MNGR">MNGR</option> -->
							</select>
						</td>
					</tr>
					<tr>
						<th>App 이름 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="appNm" name="appNm"  value ="${appVO.appNm}" class="input w01" />
						</td>
					</tr>
					<tr>
						<th>App 버전 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="appVer" name="appVer" value ="${appVO.appVer}" class="input w01" />
						</td>
					</tr>
					<tr>
						<th>App 파일명 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="appFileNm" name="appFileNm"  value ="${appVO.appFileNm}" class="input w01" />
						</td>
					</tr>
					<tr>
						<th>APP 마켓 URL <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="appMarketUrl" name="appMarketUrl" value ="${appVO.appMarketUrl}" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th>강제 업데이트 유무<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  type="radio" name="forcedUpdYn" id="forcedUpdYn" class="" value="Y" /> <label for="forcedUpdYn">강제</label>&nbsp;&nbsp;
							<input  type="radio" name="forcedUpdYn" id="forcedUpdYn" class="" value="N" /> <label for="forcedUpdYn">선택</label>
						</td>
					</tr>
					<tr>
						<th>업데이트 내용 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<textarea id="appCont" name="appCont" class="input textareabox" style="height:200px"><c:out value="${appVO.appCont}" /></textarea>
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
			<a href="javascript:appUpdate();">
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
	<div class="popup_container" id="appPreViewPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 800px">
			<div class="p_header">
				<h1>미리보기</h1>
				<a href="javascript:$('#appPreViewPopup').hide(); $('.dimmed').hide();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
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
												<th>구분<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input disabled type="radio" name="puseYn" id="puseYn" class="" value="Y" /> <label for="puseYn">사용</label>&nbsp;&nbsp;
													<input disabled type="radio" name="puseYn" id="puseYn" class="" value="N" /> <label for="puseYn">미사용</label>
												</td>
											</tr>
											<tr>
												<th>OS 타입 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="posType" name="posType"  class="input w01" readOnly />
												</td>
											</tr>
											<tr>
												<th>App 타입 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pappType" name="pappType"  class="input w01" readOnly />
												</td>
											</tr>
											<tr>
												<th>App 이름 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pappNm" name="pappNm"  class="input w01" readOnly />
												</td>
											</tr>
											<tr>
												<th>App 버전 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pappVer" name="pappVer" class="input w01" readOnly/>
												</td>
											</tr>
											<tr>
												<th>App 파일명 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pappFileNm" name="pappFileNm"  class="input w01" readOnly/>
												</td>
											</tr>
											<tr>
												<th>APP 마켓 URL <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="pappMarketUrl" name="pappMarketUrl"  class="input w01" readOnly/>
												</td>
											</tr>
											<tr>
												<th>강제 업데이트 유무<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input disabled type="radio" name="pforcedUpdYn" id="pforcedUpdYn" class="" value="Y" /> <label for="pforcedUpdYn">강제</label>&nbsp;&nbsp;
													<input disabled type="radio" name="pforcedUpdYn" id="pforcedUpdYn" class="" value="N" /> <label for="pforcedUpdYn">선택</label>
												</td>
											</tr>
											<tr>
												<th>업데이트 내용 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<textarea id="pappCont" name="pappCont" class="input textareabox" style="height:400px" readOnly></textarea>
												</td>
											</tr>
											<tr>
										</tbody>
									</table>
								</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:$('#appPreViewPopup').hide(); $('.dimmed').hide();">확인</span>
					</div>
					<!-- e: btn -->

				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
