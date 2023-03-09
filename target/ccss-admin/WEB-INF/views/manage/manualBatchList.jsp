<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
var nonAutoBatchPath = '${nonAutoBatchPath}';

$(document).ready(function(){
	goSearch(1);
});

// 리스트 조회
function goSearch(page) {
	$("#page").val(page);

	$.ajax({
		url : "/admin/manage/selectBatchStatusRecordListAjax.do",
		type : "POST",
		data : $("#manualBatchForm").serialize(),
		dataType : "JSON"
	}).success(function (data) {
		console.log(data);
		
		var resultCode = data.resultCode;
		if(resultCode == "1001") {
			var html = '';
			var resultList = data.resultList;
			var totalCount = data.totalCount;

			
			if(resultList.length > 0) {
				for(var i=0; i<resultList.length; i++) {
					html += '<tr>';
					html += '	<td>'+resultList[i].rnum+'</td>';
					html += '	<td><a class="link" href="javascript:openDetailListPopup(\''+resultList[i].batchCode+'\');">'+resultList[i].batchCodeKr+'</a></td>';
					html += '	<td>'+resultList[i].batchEndDate+'</td>';
					
					if(resultList[i].batchResultStatus == '0' || resultList[i].batchResultStatus == '1') {
						html += '<td>성공</td>';
					} else {
						html += '<td>실패</td>';
					}
					html += '</tr>';
				}
			} else {
					html += '<tr>';
					html += '	<td colspan="4"> 검색조건에 부합되는 데이터가 없습니다.</td>';
					html += '</tr>';
			}
			$("#paging").empty();
			$("#paging").append(data.paging);
			$("#resultList").empty();
			$("#resultList").append(html);
		} else {
			
		}
	
	}).error(function (data) {
		console.log(data);
	});
}

function openDetailListPopup(batchCode) {
	var url="/admin/manage/manualBatchDetailListPopup.do?batchCode="+batchCode; 
	commonPopup(url,'manualBatchDetailListPopup','width=1162,height=836,scrollbars=yes');
}
</script>
<!-- 내용-->
<div class="contents_wrap">
    <form id="manualBatchForm" name="manualBatchForm" method="POST" >
	    <input type="hidden" id="page" name="page" />
		
	    <div class="main_top">
	        <h2>수동배치 관리</h2>
	    </div>
	
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
		<div class="rtl">
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
				<col width="10%"/>
				<col width="*"/>
				<col width="20%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>배치 항목</th>
					<th>최종 작업완료일시</th>
					<th>배치결과</th>
				</tr>
			</thead>
			<tbody id="resultList">
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
