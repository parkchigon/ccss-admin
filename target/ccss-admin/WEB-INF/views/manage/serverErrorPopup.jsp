<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
$(document).ready(function(){
	$("#startTime").val(getUrlParameter("startTime"));
	$("#endTime").val(getUrlParameter("endTime"));
	$("#actionKind").val(getUrlParameter("actionKind"));
	$("#title").text(getUrlParameter("title"));
	goSearch(1);
});



function goSearch(page) {
	$("#page").val(page);
	$.ajax({
		url : "/admin/manage/serverErrorPopupAjax.do"
		,data : $('#serverError').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
			
		if(totalResult > 0) {
			for (var i = 0; i < list.length ; i++) {
				html += "<tr>";	
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td class='left'>" + list[i].sectionName + "</td>";
				html += "	<td class='left'>" + list[i].actionKindName + "</td>";
				html += "	<td>" + list[i].httpCode + "</td>";
				html += "	<td>" + list[i].resultCode + "</td>";
				html += "	<td>" + list[i].resultMsg+ "</td>";
				html += "	<td>" + list[i].reqTime + "</td>";
				html += "	<td>" + list[i].rspTime + "</td>";
				html += "	<td>" + list[i].ctn + "</td>";
				html += '	<td><a class="link" href="javascript:layerPopup(\''+list[i].hash+'\',\''+list[i].head+'\',\''+list[i].body+'\');">선택</a></td>';
				html +="</tr>";
			}
		} else {
			html += "<tr>"
			html += "	<td colspan='10'> 검색조건에 부합되는 데이터가 없습니다.</td>";
			html += "</tr>"
		}

		$("#paging").empty();
		$("#paging").append(data.paging);
	
		$("#errorList").empty();
		$("#errorList").append(html);
		$("#totCnt").text(totalResult);
		
	});
    
}

function layerPopup(hash,head,body) {
	openLayerPopup($("#optionDetailPopup"));
	$("#layerHash").html(hash);
	$("#layerHead").html(head);
	$("#layerBody").html(body);
	$("input, textarea").attr("disabled",true);
}
</script>
<!-- 내용-->
	

<body class="jui">
<form id="serverError" name="serverError" method="POST" >
<input type="hidden" id="page" name="page" />
<input type="hidden" id="startTime" name="startTime" />
<input type="hidden" id="endTime" name="endTime" />
<input type="hidden" id="actionKind" name="actionKind"  />
<div class="popup_inner w03"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px, -->
		<div class="p_header">
			<h1>서버 오류 상세 : <span id="title"></span></h1>
			<a href="javascript:exitPopup();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 
		<div class="p_body">
			<div class="p_content">

				<!-- s: table top-->
				<div class="thead_wrap cboth">
					<div class="ltr">
					</div>
				</div>
				<!-- e: table top-->
				
				
				<!-- s: table top-->
				<div class="thead_wrap cboth">
					<div class="ltr">
						<span class="count">Total :  <span id="totCnt"></span></span>
					</div>
					<div class="rtl">
						<select class="select w02">
							<option value="20" >20개씩 보기</option>
		<option value="50" selected="selected">50개씩 보기</option>
		<option value="100" >100개씩 보기</option>
						</select>
					</div>
				</div>
				<!-- e: table top-->
				
				<!-- s: table wrap-->				
				<div class="table_wrap">
					<table class="table simple table_list_type">
						<colgroup>
							<col width="8%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="*"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
						</colgroup>
						<thead>
							<tr>
								<th>No</th>
								<th>구분</th>
								<th>기능명</th>
								<th>HTTP오류코드</th>
								<th>오류코드</th>
								<th>오류메세지</th>
								<th>호출일시</th>
								<th>응답일시</th>
								<th>CTN</th>
								<th>요청전문</th>
							</tr>
						</thead>
						<tbody id="errorList">
						</tbody>
					</table>
				</div>
	<!-- e: table wrap-->
	<!-- e: 검색-->
<!-- s: 페이징 -->
<div id="paging" class="paging">
</div>
<!-- e: 페이징 -->
					
		</div>
</div>
</div>
</form>


<!-- s: popup -->
<div class="popup_container" id="optionDetailPopup" style="display: none;">
	<div class="popup_inner w03"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px,-->
		<div class="p_header">
			<h1>선택  상세</h1>
			<a href="javascript:closeLayerPopup($('#optionDetailPopup'));" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
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
				<table class="table simple table_write_type">
					<colgroup>
						<col width="20%"/>
						<col width="*"/>
					</colgroup>
					<tbody>
							<tr>
								<th>HASH</th>
								<td id="layerHash"></td>
							</tr>
							<tr>
								<th>REQ Header</th>
								<td id="layerHead"></td>
							</tr>
							<tr>
								<th>REQ BODY</th>
								<td id="layerBody"></td>
							</tr>
					</tbody>
				</table>
				</div>
				<!-- e: table wrap-->
				<!-- s: btn -->
				<div class="btn_wrap02">
					<span class="btn large" onclick="closeLayerPopup($('#optionDetailPopup'));">확인</span>
				</div>
				<!-- e: btn -->
			</div>
		</div>
	</div>
</div>
<!-- e: popup -->
<div class="dimmed" style="display: none;"></div>
<!-- e: 내용-->
</body>

