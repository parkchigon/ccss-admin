<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javascript" src="<c:url value="/resources/common/ckeditor/ckeditor.js" />"></script>
<script type="text/javaScript">
var serviceCardMap = new Map();
$(document).ready(function(){

	//상태
	var cardNm = "${cardVO.cardNm}";
	var exposureYn = "${cardVO.exposureYn}";
	$('input:radio[name=exposureYn]:input[value=' + exposureYn + ']').attr("checked", true);
	
	var fixYn = "${cardVO.fixYn}";
	$('input:radio[name=fixYn]:input[value=' + fixYn + ']').attr("checked", true);
	
	
	if(fixYn=='Y'){
		$("#cardNumArea").show();
	}
	
	selectGrpCodeList("CARD_DECK","cardSortNumArea");
	
	var cardSortNum = "${cardVO.cardSortNum}";
	$('input:radio[name=cardSortNum]:input[value=' + cardSortNum + ']').attr("checked", true);		
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
		
		
		for(var i=1; i< cardExpoureCnt; i++){
			html += "<input disabled checked type='radio' name='cardSortNum' id='cardSortNum'  value=" +"'"+ i +"'"+ "/> <label for='cardSortNum'>" + i + "</label>&nbsp;&nbsp;"; 
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

function cardEditForm() {
	if(confirm("해당 서비스 카드 정보를 수정 하시겠습니까?")) {
		var cardId = "${cardVO.cardId}";
		location.href="<c:url value='/card/cardEditForm.do?cardId="+cardId+"'/>";
	}
}

function historyBack(){
		//history.back();
	location.href="<c:url value='/card/cardList.do'/>";
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="cardDetailForm" name="cardDetailForm">
	<input type="hidden" id="cardId" name="cardId" value="${cardVO.cardId}" />
		<div class="main_top">
			<h2>카드덱관리 > 서비스 카드 관리 > 서비스 카드 상세 정보</h2>
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
						<th class="last" >카드명 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="cardNm" name = "cardNm" value="${cardVO.cardNm}" class="input w01" readonly/>
						</td>
					</tr>
					<tr>
						<th class="last" >서비스 카테고리 </th>
						<td colspan="3" class="last">
							<%-- <input type="text" autocomplete="off" id="serviceCategory" name = "serviceCategory" value="${cardVO.serviceCategory}" class="input w01" readonly/> --%>
							<input type="hidden"  maxlength="80"  autocomplete="off" id="serviceCategory" name="serviceCategory" value="AM" />
							AM (After 마켓 서비스)
						</td>
					</tr>
					<tr>
						<th class="last" >App ID <span class="imp">*</span></th>
						<td id=""colspan="3" class="last">
							<input type="text"  autocomplete="off" id="cardAppId" name="cardAppId" value="${cardVO.cardAppId}" class="input w01" readonly/>
						</td>
					</tr>
					<tr>
						<th class="last" >상태<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  disabled type="radio" name="exposureYn" id="exposureYn" class="" value="Y" /> <label for="exposureYn">사용</label>
							<input  disabled type="radio" name="exposureYn" id="exposureYn" class="" value="N" /> <label for="exposureYn">미사용</label>
						</td>
					</tr>
					<tr>
						<th class="last" >카드 고정 여부<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input  disabled type="radio" name="fixYn" id="fixYn" class="" value="Y" /> <label for="fixYn">사용</label>
							<input  disabled type="radio" name="fixYn" id="fixYn" class="" value="N" /> <label for="fixYn">미사용</label>
						</td>
					</tr>
					
					<tr id="cardNumArea">
						<th class="last" >카드 번호<span class="imp">*</span></th>
						
						<td id="cardSortNumArea"colspan="3" class="last">
						
						</td>
					</tr>
					<tr>
						<th class="last" >등록자 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="regId" name = "regId" value="${cardVO.regId}" class="input w01" readonly/>
						</td>
					</tr>
					<tr>
						<th class="last" >등록일 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="regDt" name = "regDt" value="${cardVO.regDt}" class="input w01" readonly/>
						</td>
					</tr>				
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<a href="javascript:cardEditForm();"><span class="btn large focus">수정</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
