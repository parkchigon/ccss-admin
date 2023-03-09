<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
$(document).ready(function(){
	
	goSearch(1);
	checkboxClickEventHandler();
	
});

// 리스트 조회
function goSearch(page) {
	$("#page").val(page);
	$.ajax({
		url :"<c:url value='/app/selectAppList.do'/>"
		,data : $('#appSearchForm').serialize()
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
			html += "	<td class='rowhighlight'>현재</td>";
			
			var useYn = currentList[i].useYn;
			if(useYn == "Y"){
				html += " <td class='rowhighlight'>" + "사용" + "</td>";
			}else{
				html += " <td class='rowhighlight'>" + "미사용" + "</td>";
			}
			html += "	<td class='rowhighlight'>" + currentList[i].appType + "</td>"; //타입
			html += "	<td class='rowhighlight'>" + currentList[i].appVer + "</td>";  //버전
			html += "	<td class='rowhighlight'>" + currentList[i].osType + "</td>";  //버전
			html += "	<td class='rowhighlight'>" + currentList[i].regId + "</td>";  //등록자
			
			/* var pushNotiYn =  currentList[i].pushNotiYn;
			if(pushNotiYn == 'Y'){
				html += "	<td class='rowhighlight'>" + currentList[i].pushStartDt + "~" + currentList[i].pushEndDt + "</td>";  
			}else{
				html += " <td class='rowhighlight'>" + "미사용" + "</td>";
			} */
			html += "	<td class='rowhighlight'>" + currentList[i].regDt + "</td>";  //등록일
			html += "<td class='rowhighlight'></td>";  // 선택 Box 없음.
			html +="</tr>";
		}

		
		for (var i = 0; i < list.length ; i++) {					
			html += "<tr>";
			html += "	<td>" + list[i].rnum + "</td>";
			
			var useYn = list[i].useYn;
			if(useYn == "Y"){
				html += " <td>" + "사용" + "</td>";
			}else{
				html += " <td>" + "미사용" + "</td>";
			}
			html += "	<td>" + list[i].appType + "</td>"; //타입
			html += "	<td><a href='javascript:appDetailForm(\"" + list[i].appId+ "\");' class='link'>" + list[i].appVer + "</td>";  //버전
			html += "	<td>" + list[i].osType + "</td>";
			html += "	<td>" + list[i].regId + "</td>";  //등록자
			
			/* var pushNotiYn =  list[i].pushNotiYn;
			if(pushNotiYn == 'Y'){
				html += "	<td>" + list[i].pushStartDt + "~" + list[i].pushEndDt + "</td>";  
			}else{
				html += " <td>" + "미사용" + "</td>";
			} */
			html += "	<td>" + list[i].regDt + "</td>";  //등록일
			html += '<td><input type="checkbox" value="'+list[i].appId+'" name="appCheckBox"></td>';
			html +="</tr>";
		}

		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#appList").empty();
		$("#appList").append(html);
		
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
function appInsertForm() {
	location.href="<c:url value='/app/appInsertForm.do' />";
}

//세부 화면
function appDetailForm(appId){
	location.href="<c:url value='/app/appDetail.do?appId="+appId+"'/>";
}

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='appCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='appCheckBox']").attr("checked", false);
			}
		}
	});
}


function deleteApp(){
	var appCheckBoxSeqArray = $("input:checkbox[name='appCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(appCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.");
		return;
	}
	
	if(confirm("선택 하신 버전을 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "<c:url value='/app/deleteApp.do' />",
			type : "POST",
			data : {
				appSeqArray : appCheckBoxSeqArray.toString()
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

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="appSearchForm" name="appSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>전시관리 > App 버전 관리</h2>
	</div>
		
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
				<div class="tit_table">App 버전 리스트</div>
		</div>
		<div class="rtl">
			<a href="javascript:deleteApp();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="5%"/>
				<col width="5%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<!-- <col width="30%"/> -->
				<col width="15%"/>
				<col width="5%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>구분</th>
					<th>타입</th>
					<th>버전</th>
					<th>OS</th>
					<th>등록자</th>
					<!-- <th>푸시 일정</th> -->
					<th>등록일</th>
					<th class="last">선택</th>
				</tr>
			</thead>
			<tbody id="appList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:appInsertForm();">등록하기</a></span>
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>
