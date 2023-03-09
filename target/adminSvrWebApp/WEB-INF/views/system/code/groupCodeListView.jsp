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
		url :"<c:url value='/system/code/selectGroupCodeList.do'/>"
		,data : $('#groupCodeSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		
		var html = '';
		var currentList = data.currentList;
		var list = data.resultList;
		var totalResult = data.totalCount;
		
		for (var i = 0; i < list.length ; i++) {					
			html += "<tr>";
			html += "	<td>" + list[i].rnum + "</td>";
			html += "	<td><a href='javascript:groupCodeDetailForm(\"" + list[i].grpCdId+ "\");' class='link'>" + list[i].grpCdNm + "</td>";  //버전
			html += "	<td>" + list[i].grpCdExplain + "</td>";
			var useYn = list[i].useYn;
			if(useYn == "Y"){
				html += " <td>" + "사용" + "</td>";
			}else{
				html += " <td>" + "미사용" + "</td>";
			}
			html += "	<td>" + list[i].regId + "</td>";  //등록자
			html += "	<td>" + list[i].regDt + "</td>";  //등록일
			html += '<td><input type="checkbox" value="'+list[i].grpCdId+'" name="groupCodeCheckBox"></td>';
			html +="</tr>";
		}

		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#groupCodeList").empty();
		$("#groupCodeList").append(html);
		
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


// 등록 화면
function groupCodeInsert() {
	location.href="<c:url value='/system/code/groupCodeInsert.do' />";
}

//세부 화면
function groupCodeDetailForm(grpCdId){
	location.href="<c:url value='/system/code/groupCodeDetail.do?grpCdId="+grpCdId+"'/>";
}

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='groupCodeCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='groupCodeCheckBox']").attr("checked", false);
			}
		}
	});
}


function deleteGroupCode(){
	var groupCodeCheckBoxSeqArray = $("input:checkbox[name='groupCodeCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(groupCodeCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.");
		return;
	}
	
	if(confirm("선택 하신 버전을 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "<c:url value='/system/code/deleteGroupCode.do' />",
			type : "POST",
			data : {
				groupCodeIdArray : groupCodeCheckBoxSeqArray.toString()
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
	<form id="groupCodeSearchForm" name="groupCodeSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>시스템 관리 > 공통 코드 관리</h2>
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
				</colgroup>
				<tbody>
					<tr>
						<th class="last" >그룹코드명<span class="imp">*</span></th>
						<td colspan="3">
							 <input type="text"  class="input w02" id="grpCdNm" name="grpCdNm" onkeydown="if(event.keyCode==13) goSearch(1);" /> 
							 <a href="javascript:goSearch(1);"><span class="btn focus" style="width: 90px;">
								<img src="/admin/resources/common/images/icon_search01.png" alt="" />조회</span>
							</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div>	
		
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
				<div class="tit_table">공통 코드 리스트</div>
		</div>
		<div class="rtl">
			<a href="javascript:deleteGroupCode();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
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
				<col width="30%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="20%"/>
				<col width="5%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>그룹코드명</th>
					<th>그룹코드설명</th>
					<th>사용여부</th>
					<th>등록자</th>
					<th>등록일</th>
					<th class="last">선택</th>
				</tr>
			</thead>
			<tbody id="groupCodeList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:groupCodeInsert();">등록하기</a></span>
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>
