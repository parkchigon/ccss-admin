<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
$(document).ready(function(){
	$("#userHash").val(getUrlParameter("hash"));
	$("#userCtn").text(getUrlParameter("ctn"));
	goPage();
})
function goPage() {
	$.ajax({
		url : "/admin/usermng/selectUserServiceUseListAjax.do",
		type : "POST",
		data : {
			hash : $("#userHash").val()
		},
		dataType : "JSON"
	}).success(function(data) {
		console.log(data);
		var resultCode = data.resultCode;
		if(resultCode = "1001") {
			var list = data.resultList;
			var html = '';
			if(list.length >0) {
				for(var i=0; i<list.length; i++) {
					html += '<tr>';
					html += '	<td>'+list[i].rnum+'</td>';
					html += '	<td>'+list[i].serviceType+'</td>';
					html += '	<td>'+list[i].actionKindKr+'</td>';
					html += '	<td>'+list[i].serviceUseLatestDate+'</td>';
					html += '	<td>'+list[i].serviceUseCnt+'</td>';
					html += '</tr>';
				}
			} else {
				html += '<tr>';
				html += '	<td colspan="5"> 검색조건에 부합되는 데이터가 없습니다.</td>';
				html += '</tr>';
			}
			
			$("#userServiceUseLis").empty();
			$("#userServiceUseLis").append(html);
		}
	}).error(function() {
		alert("목록 조회중 오류가 발생 하였습니다.");
	});
};

</script>
<input type="hidden" id="userHash" />

<body class="jui">
	<div class="popup_inner w04"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px,-->
		<div class="p_header">
			<h1><span id="userCtn"></span>님 사용 이력(전일 데이터 기준)</h1>
			<a href="javascript:window.close();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 
		<div class="p_body">
			<div class="p_content">
				
				<!-- s: table wrap-->				
				<div class="table_wrap table_scroll" style="max-height: 600px">
					<table class="table simple table_list_type">
						<colgroup>
							<col width="7%"/>
							<col width="10%"/>
							<col width="*"/>
							<col width="15%"/>
							<col width="15%"/>
						</colgroup>
						<thead>
							<tr>
								<th>NO</th>
								<th>구분</th>
								<th>서비스 사용 이력</th>
								<th>최근 이용 시간</th>
								<th class="last">이용횟수</th>
							</tr>
						</thead>
						<tbody id="userServiceUseLis">
						</tbody>
					</table>
				</div>
				<!-- e: table wrap-->
			
				<!-- s: btn -->
				<div class="btn_wrap02">
					<span class="btn large" onclick="javascript:window.close();">닫기</span>
				</div>
				<!-- e: btn -->
			</div>
		</div>
	</div>
</body>
<!-- e: popup -->