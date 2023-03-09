<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<Style>
tr.rowhighlight td, tr.rowhighlight th{
    background-color:#f0f8ff;
}
</Style>
<script type="text/javaScript">
var termsDivListMap = new Map();

$(document).ready(function(){
	
	selectTermsDivList();
	
	//console.log("termsDivListMap",termsDivListMap);
	
	goSearch(1);
	checkboxClickEventHandler();
	
	
});

function selectTermsDivList (){
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

// 리스트 조회
function goSearch(page) {
	$("#page").val(page);
	$.ajax({
		url :"<c:url value='/term/selectTermsList.do'/>"
		,data : $('#termsSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		
		var html = '';
		var currentList = data.currentList;
		var list = data.resultList;
		var totalResult = data.totalCount;
		
		//Use Version Top Area
		for (var i = 0; i < currentList.length ; i++) {					
			html += "<tr>";
			html += "	<td class='rowhighlight'><font color='red'>현재</td>";
			
			var exposureYn = currentList[i].exposureYn;
			if(exposureYn == "Y"){
				html += " <td class='rowhighlight'><font color='red'>" + "사용" + "</td>";
			}else{
				html += " <td class='rowhighlight'><font color='red'>" + "미사용" + "</td>";
			}
			var termsDiv =  currentList[i].termsDiv;
			
			var termsDivNm = termsDivListMap.get(termsDiv);
			
			html += " <td class='rowhighlight'><font color='red'>" +termsDivNm + "</td>";
			/* if(termsDiv == "1"){
				html += " <td class='rowhighlight'><font color='red'>" +termsDivNm + "</td>";
			}else if (termsDiv == "2" ){
				html += " <td class='rowhighlight'><font color='red'>" + "위치기반 서비스 이용약관" + "</td>";
			}else if (termsDiv == "3"){
				html += " <td class='rowhighlight'><font color='red'>" + "개인정보 처리방침" + "</td>";
			}else {
				html += "<td class='rowhighlight'></td>";
			} */
			
			//html += "	<td class='rowhighlight'><font color='red'>" + currentList[i].termsVer + "</td>";  //버전
			html += "	<td class='rowhighlight' ><a href='javascript:termsDetailForm(\"" + currentList[i].termsNo+ "\");' class='link'>" + currentList[i].termsVer + "</td>";  //버전
			html += "	<td class='rowhighlight'>" + currentList[i].termsSortNum + "</td>";   
			html += "	<td class='rowhighlight'>" + currentList[i].requiredYn + "</td>";   
			html += "	<td class='rowhighlight'>" + currentList[i].regId + "</td>";  //등록자
			html += "	<td class='rowhighlight'>" + currentList[i].regDt + "</td>";  //등록일
			html += "<td class='rowhighlight'></td>";  // 선택 Box 없음.
			html +="</tr>";
		}

		
		for (var i = 0; i < list.length ; i++) {					
			html += "<tr>";
			html += "	<td>" + list[i].rnum + "</td>";
			
			var exposureYn = list[i].exposureYn;
			if(exposureYn == "Y"){
				html += " <td>" + "사용" + "</td>";
			}else{
				html += " <td>" + "미사용" + "</td>";
			}
			var termsDiv =  list[i].termsDiv;
			
			var termsDivNm = termsDivListMap.get(termsDiv);
			
			html += " <td>" +termsDivNm + "</td>";
			
			/* if(termsDiv == "1"){
				html += " <td>" + "서비스 이용약관" + "</td>";
			}else if (termsDiv == "2" ){
				html += " <td>" + "위치기반 서비스 이용약관" + "</td>";
			}else if (termsDiv == "3"){
				html += " <td>" + "개인정보 처리방침" + "</td>";
			}else {
				html += '<td></td>';
			} */
			
			//html += "	<td>v." + list[i].termsVer + "</td>";  //버전
			html += "	<td><a href='javascript:termsDetailForm(\"" + list[i].termsNo+ "\");' class='link'>" + list[i].termsVer + "</td>";  //버전
			html += "	<td></td>";   
			html += "	<td>" + currentList[i].requiredYn + "</td>";   
			html += "	<td>" + list[i].regId + "</td>";  //등록자
			html += "	<td>" + list[i].regDt + "</td>";  //등록일
			html += '<td><input type="checkbox" value="'+list[i].termsNo+'" name="termsCheckBox"></td>';
			html +="</tr>";
		}

		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#termsList").empty();
		$("#termsList").append(html);
		
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


// 등록 화면
function termInsertForm() {
	location.href="<c:url value='/term/termsInsertForm.do' />";
}

//세부 화면
function termsDetailForm(termsNo){
	location.href="<c:url value='/term/termsDetail.do?termsNo="+termsNo+"'/>";
}

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='termsCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='termsCheckBox']").attr("checked", false);
			}
		}
	});
}


function deleteTerms(){
	var termsCheckBoxSeqArray = $("input:checkbox[name='termsCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(termsCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	
	if(confirm("선택 하신 버전을 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "<c:url value='/term/deleteTermsAjax.do' />",
			type : "POST",
			data : {
				termsSeqArray : termsCheckBoxSeqArray.toString()
			},
			dataType : "json"
		}).done(function (data) {
			var resultCode = data.resultCode;
			if(resultCode == "0000") {
				alert("삭제 되었습니다.");
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

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="termsSearchForm" name="termsSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>전시관리 > 약관 관리</h2>
	</div>
		
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<div class="tit_table">약관 정보 리스트</div>
		</div>
		<div class="rtl">
			<a href="javascript:deleteTerms();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="10%"/>
				<col width="10%"/>
				<col width="20%"/>
				<col width="5%"/>
				<col width="5%"/>
				<col width="5%"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="5%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>구분</th>
					<th>약관구분</th>
					<th>버전</th>
					<th>노출<br>순서</th>
					<th>필수<br>여부</th>
					<th>등록자</th>
					<th>등록일</th>
					<th class="last">선택</th>
				</tr>
			</thead>
			<tbody id="termsList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:termInsertForm();">등록하기</a></span>
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>
