<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	
	checkboxClickEventHandler();
	
	var useYn = "${codeVO.useYn}";
	$('input:radio[name=useYn]:input[value=' + useYn + ']').attr("checked", true);
	
	goSearch(1);
});


//리스트 조회
function goSearch(page) {
	var grpCdId = '${codeVO.grpCdId}';
	
	
	$("#page").val(page);
	$.ajax({
		url :"<c:url value='/system/code/selectDtlCodeListPaging.do'/>"
		,data : $('#groupCodeDetailForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		
		for (var i = 0; i < list.length ; i++) {					
			html += "<tr>";
			html += "	<td>" + list[i].rnum + "</td>";
			html += "	<td><a href='javascript:dtlCodeEditForm(\"" + list[i].dtlCdId+ "\");' class='link'>" + list[i].dtlCdNm + "</td>";
			html += "	<td>" + list[i].codeDesc + "</td>";
			html += "	<td>" + list[i].cdVal + "</td>";
			
			var useYn = list[i].useYn;
			
			if(useYn == "Y"){
				html += " <td>" + "사용" + "</td>";
			}else{
				html += " <td>" + "미사용" + "</td>";
			}
			html += "	<td>" + list[i].regId + "</td>";  //등록자
			html += "	<td>" + list[i].regDt + "</td>";  //등록일
			html += '<td><input type="checkbox" value="'+list[i].dtlCdId+'" name="dtlCodeCheckBox"></td>';
			html +="</tr>";
		}

		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#dtlCodeList").empty();
		$("#dtlCodeList").append(html);
		
		$("#totCnt").empty(totalResult);
		$("#totCnt").append(totalResult);
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


function dtlCodeEditForm(dtlCdId){
	
	$.ajax({
		url :"<c:url value='/system/code/dtlCodeDetail.do'/>"
		,data : {
			"dtlCdId" : dtlCdId
		}
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var result = data.codeVO;
		$("#editDtlCdId").val(result.dtlCdId);
		$("#editDtlCdNm").val(result.dtlCdNm);
		$("#editCodeDesc").val(result.codeDesc);
		$("#editCdVal").val(result.cdVal);
		var editUseYn = result.useYn
		$('input:radio[name=editUseYn]:input[value=' + editUseYn + ']').attr("checked", true);
		$(".dimmed").show();
		$("#dtlCodeEditPopup").show();	
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



function updateDtlCd() {
	if(confirm("해당상세 코드 정보를 수정 하시겠습니까?")) {
		var url = "<c:url value='/system/code/updateDtlCode.do' />";
		var checkParamArr = ['editDtlCdNm', 'editDtlCdId', 'editCodeDesc','editCdVal','editUseYn'];
		var editDtlCdNm = $("#editDtlCdNm").val();
		var editCdVal = $("#editCdVal").val();
		
		if (formValidationCheck(checkParamArr)){
			$.ajax({
				url : url
				,data : $('#dtlCodeUpdateForm').serialize()
				,dataType : 'json'
				,type : "POST"
			}).done(function(data) {
				var result = data.result;
				if(result == 'Y'){ 
					alert("상세 코드 정보가 수정 되었습니다.");
					location.href="<c:url value='/system/code/groupCodeDetail.do?grpCdId="+"${codeVO.grpCdId}"+"'/>";
				} else if(result == 'E'){
					alert("이미 " + editDtlCdNm + " 이름의 상세 코드 또는 "+editCdVal +" 코드 값이 있습니다.");  
				}else{
					alert("상세 코드 수정에 실패하였습니다.");
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


function groupCodeEdit() {
	if(confirm("해당 그룹 코드 정보를 수정 하시겠습니까?")) {
		var url = "<c:url value='/system/code/updateGroupCode.do' />";
		var checkParamArr = ['useYn', 'grpCdExplain', 'grpCdNm'];
		
		if (formValidationCheck(checkParamArr)){
			$.ajax({
				url : url
				,data : $('#groupCodeUpdateForm').serialize()
				,dataType : 'json'
				,type : "POST"
			}).done(function(data) {
				var result = data.result;
				if(result == 'Y'){ 
					alert("그룹 코드 정보가 수정 되었습니다.");
					location.href="<c:url value='/system/code/groupCodeDetail.do?grpCdId="+"${codeVO.grpCdId}"+"'/>";
				} else if(result == 'E'){
					alert("이미 해당 그룹 코드가 있습니다.");
				}else{
					alert("그룹 코드 수정에 실패하였습니다.");
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


function groupCodeEdit() {
	if(confirm("해당 그룹 코드를 수정 하시겠습니까?")) {
		var grpCdId = "${codeVO.grpCdId}";
	
		location.href="<c:url value='/system/code/groupCodeEdit.do?grpCdId="+grpCdId+"'/>";
	}
}

function historyBack(){
		//history.back();
	location.href="<c:url value='/system/code/groupCodeListView.do'/>";
}


function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='dtlCodeCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='dtlCodeCheckBox']").attr("checked", false);
			}
		}
	});
}


//등록 화면
function dtlCodeInsert() {
	var grpCdId = "${codeVO.grpCdId}";
	var grpCdNm = "${codeVO.grpCdNm}"; 
	location.href="<c:url value='/system/code/dtlCodeInsert.do?grpCdId="+grpCdId+"&grpCdNm="+grpCdNm+"'/>";
}




function deleteDtlCode(){
	var dtlCodeCheckBoxSeqArray = $("input:checkbox[name='dtlCodeCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(dtlCodeCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.");
		return;
	}
	
	if(confirm("선택 하신 상세 코드를 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "<c:url value='/system/code/deleteDtlCode.do' />",
			type : "POST",
			data : {
				dtlCodeIdArray : dtlCodeCheckBoxSeqArray.toString()
			},
			dataType : "json"
		}).done(function (data) {
			var resultCode = data.resultCode;
			if(resultCode == "0000") {
				alert("선택한 정보가 삭제 되었습니다.");
				goSearch(1);
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
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="groupCodeDetailForm" name="groupCodeDetailForm">
	<input type="hidden" id="grpCdId" name="grpCdId" value="${codeVO.grpCdId}" />
	<input type="hidden" id="page" name="page" />
		<div class="main_top">
			<h2>시스템 관리 > 코드 관리 > 그룹 코드 상세 정보</h2>
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
						<th>사용여부<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input disabled type="radio" name="useYn" id="useYn" class="" value="Y" /> <label for="useYn">사용</label>&nbsp;&nbsp;
							<input disabled type="radio" name="useYn" id="useYn" class="" value="N" /> <label for="useYn">미사용</label>
						</td>
					</tr>
					<tr>
						<th>그룹 코드 명<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" autocomplete="off" id="grpCdNm" name="grpCdNm" value ="${codeVO.grpCdNm}" class="input w01" readonly/>
						</td>
						<th>그룹 코드 설명<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" autocomplete="off" id="grpCdExplain" name="grpCdExplain" value ="${codeVO.grpCdExplain}" class="input w01" readonly/>
						</td>
					</tr>
					<tr>
						<th>등록자<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" autocomplete="off" id="regId" name="regId" value ="${codeVO.regId}" class="input w01" readonly/>
						</td>
						<th>등록일<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" autocomplete="off" id="regDt" name="regDt" value ="${codeVO.regDt}" class="input w01" readonly/>
						</td>
					</tr>
					
				</tbody>
			</table>
			<!-- s: 버튼-->
			<div class="btn_wrap02">
				<div class="rtl">
					<a title="그룹코드 목록으로 돌아갑니다." href="javascript:historyBack();"><span class="btn large">목록</span></a>
					<a title="그룹코드를 수정 합니다." href="javascript:groupCodeEdit();"><span class="btn large focus">수정</span></a>
				</div>
			</div>
		<!-- e: 버튼-->
		</div>
		<!-- e: table wrap-->
		<!--DTL Code List Area  -->
		<!-- s: table top-->
			<div class="thead_wrap cboth">
				<div class="ltr">
					<div class="tit_table">상세 코드 검색 조건</div>
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
					</colgroup>
					<tbody>
						<tr>
							<th class="last" >상세코드명<span class="imp">*</span></th>
							<td colspan="3">
								 <input type="text"  class="input w02" id="dtlCdNm" name="dtlCdNm" onkeydown="if(event.keyCode==13) goSearch(1);" />
								 <a href="javascript:goSearch(1);"><span class="btn focus" style="width: 90px;">
									<img src="/admin/resources/common/images/icon_search01.png" alt="" />조회</span>
								 </a> 
							</td>
						</tr>
						<!-- <tr>
							<th class="last" >코드값<span class="imp">*</span></th>
							<td colspan="1">
								 <input type="text"  class="input w02" id="cvVal" name="cdVal" onkeydown="if(event.keyCode==13) goSearch(1);" /> 
								
							</td>
						</tr> -->
					</tbody>
				</table>
			</div>	
			
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
					<div class="tit_table">상세 코드 리스트</div>
			</div>
			<div class="rtl">
				<a href="javascript:deleteDtlCode();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
				<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
			</div>
		</div>
		<!-- e: table top-->
		
		<!-- s: table wrap-->
		<div class="table_wrap">
			<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
				<colgroup>
					<col width="5%"/>
					<col width="20%"/>
					<col width="*%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="15%"/>
					<col width="5%"/>
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>상세코드명</th>
						<th>코드설명</th>
						<th>코드값</th>
						<th>사용여부</th>
						<th>등록자</th>
						<th>등록일</th>
						<th class="last">선택</th>
					</tr>
				</thead>
				<tbody id="dtlCodeList">
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
		
		<!-- s: 페이징 -->
		<div id="paging" class="paging">
		</div>
		<div class="thead_wrap cboth">
			<div class="rtl">
				<span class="btn btn_w01"><a href="javascript:dtlCodeInsert();">등록하기</a></span>
			</div>
		</div>
		<!-- e: 페이징 -->
	</form>
</div>


<!--PreView Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="dtlCodeEditPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 600px">
			<form id="dtlCodeUpdateForm" name="dtlCodeUpdateForm">
			 <input type="hidden" id="grpCdId" name="grpCdId" value="${codeVO.grpCdId}" />
			
			<div class="p_header">
				<h1>상세 코드 수정</h1>
				<a href="javascript:$('#dtlCodeEditPopup').hide(); $('.dimmed').hide();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
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
												<th>상세 코드명 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="editDtlCdNm" name="dtlCdNm" class="input w01" />
													<input type="hidden" autocomplete="off" id="editDtlCdId" name="dtlCdId" class="input w01" />
													
												</td>
											</tr>
											
											<tr>
												<th>코드 설명 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="editCodeDesc" name="codeDesc" class="input w01" />
												</td>
											</tr>
											<tr>
												<th>코드값<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text" autocomplete="off" id="editCdVal" name="cdVal" class="input w01" />
												</td>
											</tr>
											<tr>
												<th>사용여부<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input  type="radio"  id="editUseYn" name="useYn" class="" value="Y" /> <label for="editUseYn">사용</label>&nbsp;&nbsp;
													<input  type="radio"  id="editUseYn" name="useYn" class="" value="N" /> <label for="editUseYn">미사용</label>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large" onclick="javascript:$('#dtlCodeEditPopup').hide(); $('.dimmed').hide();">취소</span>
						<span class="btn large focus" onclick="javascript:updateDtlCd();">저장</span>
					</div>
					<!-- e: btn -->

				</div>
			</div>
			</form>
		</div>
	</div>
	<!-- e: popup -->
	