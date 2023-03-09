<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javascript" src="<c:url value="/resources/common/ckeditor/ckeditor.js" />"></script>  
<script type="text/javaScript">
var serviceCardMap = new Map();
var serviceCategoryMap = new Map();

$(document).ready(function(){
	
	selectGrpCodeList("CARD_DECK","cardSortNumArea");
	selectGrpCodeList("CARD_DECK","pcardSortNumArea");
	selectGrpCodeList("SERVICE_CATEGORY","serviceCategory");		
	
	
});

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
		
		var html ="";
		for (var i = 0; i < list.length ; i++) {	
			
			serviceCardMap.put(list[i].dtlCdNm,list[i].cdVal);
		}
		var cardExpoureCnt = Number(serviceCardMap.get("CARD_EXPOURE_CNT")) + 1;
		
		if(grpCodeListAreaId =="cardSortNumArea"){
			for(var i=1; i< cardExpoureCnt; i++){
				html += "<input checked type='radio' name='cardSortNum' id='cardSortNum'  value=" +"'"+ i +"'"+ "/> <label for='cardSortNum'>" + i + "</label>&nbsp;&nbsp;"; 
			}	
		}else if(grpCodeListAreaId =="pcardSortNumArea"){
			for(var i=1; i< cardExpoureCnt; i++){
				html += "<input disabled checked type='radio' name='pcardSortNum' id='pcardSortNum'  value=" +"'"+ i +"'"+ "/> <label for='pcardSortNum'>" + i + "</label>&nbsp;&nbsp;"; 
			}
		}else if(grpCodeNm =='SERVICE_CATEGORY'){
			html ="";
			
			for(var i=0; i< list.length; i++){
				
				if(list[i].cdVal !="ALL"){
					if( i == 0){
						serviceCategoryMap.put(list[i].cdVal,list[i].dtlCdNm);
						html += "<option checked value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";	
					}else{
						serviceCategoryMap.put(list[i].cdVal,list[i].dtlCdNm);
						html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";	
					}
				}
			}
		}else{
			
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
	
	$("input[name=fixYn]").change(function() {
		var fixYnVal = $(this).val();
		 if (fixYnVal == "Y") {
			$("#cardNumArea").show();
		} else {
			$("#cardNumArea").hide();
		}
	});	 
}

//미리보기 팝업 화면 셋팅
function  preView(){
	
	var cardNm =  $("#cardNm").val();
	$("#pcardNm").val(cardNm);
	
	var serviceCategory =  $("#serviceCategory").val();
	$("#pserviceCategory").val(serviceCategory);
	
	
	var exposureYn =  $(":input:radio[name=exposureYn]:checked").val();
	$('input:radio[name=pexposureYn]:input[value=' + exposureYn + ']').attr("checked", true);
	var fixYn =  $(":input:radio[name=fixYn]:checked").val();
	$('input:radio[name=pfixYn]:input[value=' + fixYn + ']').attr("checked", true);
	

	//카드번호
	var cardSortNum =  $(":input:radio[name=cardSortNum]:checked").val();
	$('input:radio[name=pcardSortNum]:input[value=' + cardSortNum + ']').attr("checked", true);
	
	
	if (fixYn == "Y") {
		$("#pcardNumArea").show();
	} else {
		$("#pcardNumArea").hide();
	}
	
	

	$(".dimmed").show();
	$("#cardPreViewPopup").show();
}


//미입력 항목 alert
function alertMessageSource(elId){
	alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
}




function cardInsert() {
	var url = "<c:url value='/card/insertCard.do' />";
	
	var checkParamArr = ['exposureYn', 'fixYn', 'cardNm', 'cardAppId'];


	if (formValidationCheck(checkParamArr)){
		$.ajax({
			url : url
			,data : $('#cardInsertForm').serialize()
			,dataType : 'json'
			,type : "POST"
		}).done(function(data) {
			var result = data.result;
			if(result == 'Y'){ 
				alert("신규 서비스 카드가 등록 되었습니다.");
				location.href="<c:url value='/card/cardList.do' />";
			}else if(result =='DCN'){
				alert("서비스 카드 등록 실패  : 중복 되는 도메인 명이 있습니다.");
			}else if(result =='DCSN'){
				alert("서비스 카드 등록 실패  : 중복 되는 고정 카드 번호가 가 있습니다.");
			}else{
				alert("신규 서비스 카드 등록에 실패하였습니다.");
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

function historyBack(){
	if(confirm("저장 없이 목록으로 돌아가시 겠습니까?")) {
		history.back();
	}
}


function notAvailableSpecialChar(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9-_.]/g,""));
	}); 
}
function isVersion(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9_.]/g,""));
	}); 
}
function isURL(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^a-zA-Z0-9/&=:;%~.?+-_]/g,""));
	}); 
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="cardInsertForm" name="cardInsertForm">

		<div class="main_top">
			<h2> 카드덱관리 > 서비스 카드 관리 > 서비스 카드 등록</h2>
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
						<th class="last">카드명 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text"  autocomplete="off" id="cardNm" name="cardNm"  class="input w01" />
						</td>
					</tr>
					<tr>
						<th class="last" >서비스 카테고리 <span class="imp">*</span></th>
						<td id=""colspan="3" class="last">
							<select id="serviceCategory" name="serviceCategory" class="select w01"style="width: 380px;">
									
							</select>
						</td>
					</tr>
					<tr>
						<th class="last" >App ID <span class="imp">*</span></th>
						<td id=""colspan="3" class="last">
							<input type="text"  autocomplete="off" id="cardAppId" name="cardAppId"  class="input w01" />
						</td>
					</tr>
					<tr>
						<th class="last" >상태<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  checked="checked" type="radio" name="exposureYn" id="exposureYn" class="" value="Y" /> <label for="exposureYn">사용</label>&nbsp;&nbsp;
							<input  type="radio" name="exposureYn" id="exposureYn" class="" value="N" /> <label for="exposureYn">미사용</label>
						</td>
					</tr>
					<tr>
						<th class="last" >카드 고정 여부<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  checked="checked" type="radio" name="fixYn" id="fixYn" class="" value="Y" /> <label for="fixYn">사용</label>&nbsp;&nbsp;
							<input  type="radio" name="fixYn" id="fixYn" class="" value="N" /> <label for="fixYn">미사용</label>
						</td>
					</tr>
					
					<tr id="cardNumArea">
						<th class="last" >카드 번호<span class="imp">*</span></th>
						
						<td id="cardSortNumArea"colspan="3" class="last">
						
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
			<a href="javascript:cardInsert();">
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
	<div class="popup_container" id="cardPreViewPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 800px">
			<div class="p_header">
				<h1>미리보기</h1>
				<a href="javascript:$('#cardPreViewPopup').hide(); $('.dimmed').hide();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
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
												<th class="last">카드명 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text"  autocomplete="off" id="pcardNm" name="pcardNm"  class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th class="last">서비스 카테고리 <span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input type="text"  autocomplete="off" id="pserviceCategory" name="pserviceCategory"  class="input w01" readonly/>
												</td>
											</tr>
											<tr>
												<th class="last" >상태<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input  disabled checked="checked" type="radio" name="pexposureYn" id="pexposureYn" class="" value="Y" /> <label for="pexposureYn">사용</label>&nbsp;&nbsp;
													<input  disabled type="radio" name="pexposureYn" id="pexposureYn" class="" value="N" /> <label for="pexposureYn">미사용</label>
												</td>
											</tr>
											<tr>
												<th class="last" >카드 고정 여부<span class="imp">*</span></th>
												<td colspan="3" class="last">
													<input  disabled checked="checked" type="radio" name="pfixYn" id="pfixYn" class="" value="Y" /> <label for="pfixYn">사용</label>&nbsp;&nbsp;
													<input  disabled type="radio" name="pfixYn" id="pfixYn" class="" value="N" /> <label for="pfixYn">미사용</label>
												</td>
											</tr>
											
											<tr id="pcardNumArea">
												<th class="last" >카드 번호<span class="imp">*</span></th>
												<td id="pcardSortNumArea"colspan="3" class="last">
													<!-- 카드 카운트 영역 -->
												</td>
											</tr>
										</tbody>
									</table>
								</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:$('#cardPreViewPopup').hide(); $('.dimmed').hide();">확인</span>
					</div>
					<!-- e: btn -->
				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
