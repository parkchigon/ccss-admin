<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>

function openOptionDetailPopup(dateType, statDate) {
	$.ajax({
		url : "/admin/stats/selectOptionTermsDetailListAjax.do",
		data : {
			searchDateDiv : dateType,
			startDate : statDate
		},
		dataType : "JSON",
		type : "POST"
	}).done(function(data) {
		if(dateType == "DAY") {
			$("#title").text(statDate + " 일별")
		} else if(dateType == "MONTH") {
			$("#title").text(statDate + " 월별")
		} else {
			$("#title").text(statDate + " 연별")
		}
		var resultCode = data.resultCode;
		var html = '';
		if(resultCode == "1001") {
			var list = data.resultList;
			if(list.length > 0) {
				for(var i=0; i<list.length; i++) {
					html += '<tr>';
					html += '	<td>'+list[i].rnum+'</td>';
					html += '	<td>'+addComma(list[i].termsTitle)+'</td>';
					html += '	<td>'+addComma(list[i].agreeCnt)+'</td>';
					html += '</tr>';
				}
			} else {
					html += '<tr>';
					html += '	<td colspan="3">결과가 없습니다.</td>';
					html += '</tr>';
			}
			
			$("#optionTermsDetailList").empty();
			$("#optionTermsDetailList").append(html);
		}
	});
	
	openLayerPopup($("#optionTermsDetailPopup"));
}

</script>
<!-- s: popup -->
<div class="popup_container" id="optionTermsDetailPopup" style="display: none;">
	<div class="popup_inner w01"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px,-->
		<div class="p_header">
			<h1>선택 약관동의자수 상세</h1>
			<a href="javascript:closeLayerPopup($('#optionTermsDetailPopup'));" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 
		<div class="p_body">
			<div class="p_content">

				<!-- s: table top-->
				<div class="thead_wrap cboth">
					<div class="ltr">
						<span id="title"></span> 상세 정보입니다.
					</div>
				</div>
				<!-- e: table top-->
				
				<!-- s: table wrap-->				
				<div class="table_wrap table_scroll">
					<table class="table simple table_list_type">
						<colgroup>
							<col width="10%"/>
							<col width="50%"/>
							<col width="40%"/>
						</colgroup>
						<thead>
							<tr>
								<th>NO</th>
								<th>약관명</th>
								<th class="last">동의자 수</th>
							</tr>
						</thead>
						<tbody id="optionTermsDetailList">
						</tbody>
					</table>
				</div>
				<!-- e: table wrap-->
			
				<!-- s: btn -->
				<div class="btn_wrap02">
					<span class="btn large" onclick="closeLayerPopup($('#optionTermsDetailPopup'));">확인</span>
				</div>
				<!-- e: btn -->
			</div>
		</div>
	</div>
</div>
<!-- e: popup -->