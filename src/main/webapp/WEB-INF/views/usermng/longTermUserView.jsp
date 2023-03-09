<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script>

$(document).ready(function() {
	goSearch('1');
});


function checkBoxEventHandler() {
	$("input[type = 'checkbox']").on("click", function() {
		var type = $(this).attr("name");
		var checked = $(this).is(":checked");

		if(type == 'checkAll') {
			//전체 체크 박스
			if(checked) {
				//체크
				$("input:checkbox[name = 'checkRow']").attr("checked", true);
			} else {
				$("input:checkbox[name = 'checkRow']").attr("checked", false);
				//언체크
			}
		} else {
			//Row 체크 박스
			var allRowCount = $("input:checkbox[name='checkRow']").length;
			var checkedRowCount = $("input:checkbox[name='checkRow']:checked").length;
	
			if(allRowCount == checkedRowCount) {
				$("input:checkbox[name = 'checkAll']").attr("checked", true);
			} else {
				$("input:checkbox[name = 'checkAll']").attr("checked", false);
			}
		}
	})
}

function deleteUser() {
	var deleteListSeqArray = $("input:checkbox[name = 'checkRow']:checked").map(function(){return $(this).val();}).get();
	
	if(deleteListSeqArray.length == 0) {
		alert("선택된 사용자가 없습니다.");
		return;
	} else {
		if(confirm("정말로 삭제하시겠습니까?\n삭제된 데이터는 복구되지 않습니다.")) {
			$.ajaxSettings.traditional = true;
			$.ajax({
				url : "/admin/usermng/deleteLongTermUserAjax.do",
				type : "POST",
				data : {
					deleteListSeqArray : deleteListSeqArray
				},
				success : function(response) {
					var resultCode = response.resultCode;
					
					if(resultCode = "1001") {
						alert("선택된 장기 미사용자가 삭제되었습니다.");
						$("input:checkbox[name = 'checkAll']").attr("checked", false);
						goSearch(1);
					} else {
						alert("선택된 장기 미사용자 삭제중 에러가 발생하였습니다.");
					}			
				} 
			}).error(function(data) {
				alert("선택된 장기 미사용자 삭제중 에러가 발생하였습니다.");
			});
		}
	}
}

function goSearch(page) {
	
	var startMonth = $("#startMonth option:selected").val();
	var endMonth = $("#endMonth option:selected").val();
	
	if(startMonth > endMonth) {
		alert("기간 선택을 다시 확인 해주세요");
		return;
	}
	
	$("#page").val(page);
	
	$.ajax({
		url : "/admin/usermng/selectUserListAjax.do"
		,data : $('#longTermUserSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data){
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		
		if(totalResult > 0) {
			for (var i=0; i<list.length; i++) {
		
				html += '<tr>';
				html += '	<td><input type="checkbox" name="checkRow" value="'+list[i].seqMember+'"/></td>';
				html += '	<td>' + list[i].rnum + '</td>';
				html += '	<td>' + list[i].ctn + '</td>';
				html += '	<td>' + list[i].hash +'</td>';
				html += '	<td>' + list[i].haVer  + '</td>';
				html += '	<td>' + list[i].osInfo  + '</td>';
				html += '	<td>' + list[i].model  + '</td>';
				html += '	<td>' + list[i].joinDate  + '</td>';
				html += '	<td>' + list[i].updateTypeName  + '</td>';
				html += '	<td>' + list[i].updateDate  + '</td>';
				html += '	<td>' + list[i].latestUseDate  + '</td>';
				html += '</tr>';
			}
		} else {
			html += "<tr>"
			html += "	<td colspan='11'> 검색조건에 부합되는 데이터가 없습니다.</td>";
			html += "</tr>"			
		}
		
		$("#longTermUserList").empty();
		$("#longTermUserList").append(html);
		$("#paging").empty();
		$("#paging").append(data.paging);
		$("#totCnt").text(totalResult);
		checkBoxEventHandler();
	});
}

function downloadExcel() {
	$("#longTermUserSearchForm").attr("action", "/admin/usermng/longTermUserListExcel.do");
	$("#longTermUserSearchForm").submit();
}

</script>

<!-- 내용-->
<div class="contents_wrap">
	<form id="longTermUserSearchForm" name="longTermUserSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>
			장기 미사용자 조회
		</h2>
		
	</div>
	
	<!-- s: 검색-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">기간</div></th>
					<td>
						<select id="startMonth" name="startMonth" class="select w04">
							<c:forEach var="months" begin="01" end="12">
								<fmt:formatNumber var="month" value="${months}" pattern="00" />
							<option value="${month}" <c:if test="${month eq 01}"> selected="selected" </c:if>>${month}</option>				
							</c:forEach>
						</select>
						개월&nbsp;&nbsp;&nbsp; ~ &nbsp;&nbsp;
						<select id="endMonth" name="endMonth" class="select w04">
							<c:forEach var="months" begin="01" end="12">
								<fmt:formatNumber var="month" value="${months}" pattern="00" />
							<option value="${month}" <c:if test="${month eq 12}"> selected="selected" </c:if>>${month}</option>				
							</c:forEach>
						</select>
						개월
					</td>
				</tr>
				<tr>
					<th><div class="tit_search">검색</div></th>
					<td>
						<div class="input_wrap">
							<select id="searchType" name="searchType" class="select w01" style="width:130px;">
								<option value="CTN" selected="selected">전화번호</option>
								<option value="HASH">회원 ID</option>
							</select>
							<input type="text" class="input w02" id="searchText" name="searchText" onkeydown="if(event.keyCode==13) goSearch(1);"/>
							<a href="javascript:goSearch(1);"><span class="btn focus" style="width:90px;"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span></a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	<!-- e: 검색-->
	
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<span class="btn" onclick="deleteUser();">삭제</span>&nbsp;&nbsp;<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
		<div class="rtl">
			<span class="btn" onclick="downloadExcel();"><img src="/admin/resources/common/images/icon_excel.png" alt=""> 엑셀 다운로드</span>
			<select id="pageRowCount" name="pageRowCount" class="select w01" style="width:130px;" onchange="javascript:goSearch(1);">
				<option value="20" selected="selected">20개씩 보기</option>
				<option value="50" >50개씩 보기</option>
				<option value="100" >100개씩 보기</option>
			</select>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="3%"/>
				<col width="5%"/>
				<col width="10%"/>
				<col width="*"/>
				<col width="10%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="12%"/>
				<col width="7%"/>
				<col width="12%"/>
				<col width="12%"/>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="checkAll"/></th>
					<th>No</th>
					<th>전화번호</th>
					<th>회원 ID</th>
					<th>히든앱버전정보</th>
					<th>OS버전정보</th>
					<th>단말기모델명</th>
					<th>가입 일자</th>
					<th>수정 타입</th>
					<th>수정 일자</th>
					<th>최근 이용 일자</th>
				</tr>
			</thead>
			<tbody id="longTermUserList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>