<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">

$(document).ready(function(){
	
	goSearch(1);
	checkboxClickEventHandler();
	
});


function pad2(n) { return n < 10 ? '0' + n : n }


// 리스트 조회
function goSearch(page) {
	$("#page").val(page);
	$.ajax({
		url :"<c:url value='/card/selectEventCardList.do'/>"
		,data : $('#eventCardSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		if (list.length == 0) {

			html += "	<tr><th colspan='9'>조회된 결과가 없습니다.</td></tr>";
		}else{
			for (var i = 0; i < list.length ; i++) {					
				
				var exposureStartDt = list[i].exposureStartDt;
				var exposureEndDt = list[i].exposureEndDt;
				
				var date = new Date();
				var nowTime = date.getFullYear().toString() 
				+ pad2(date.getMonth() + 1) 
				+ pad2( date.getDate()) ;
				
				html += "<tr>";
				html += "	<td>" + list[i].rnum + "</td>";
				
				if (list[i].eventCardType == '00') {
					html += "	<td>신규</td>";
				} else if (list[i].eventCardType == '01') {
					html += "	<td>기존</td>";
				} else if (list[i].eventCardType == '02') {
					html += "	<td>프로모션</td>";
				} else {
					html += "	<td>ERROR</td>";
				}
				
				html += "	<td>" + list[i].exposureStartDt + "~"+ list[i].exposureEndDt + "</td>";
				html += " <td>" + list[i].cardNm + "</td>";
				html += "	<td><a href='javascript:eventCardDetailForm(\"" + list[i].eventCardId+ "\");' class='link'>" + list[i].eventCardUrl + "</td>";  
				html += " <td>" + list[i].regDt + "</td>";
				html += " <td>" + list[i].regId + "</td>";
				
				if( exposureEndDt.replace(/-/g,"") < nowTime){//등록 상태 종료
					html += " <td style='color:red'>" + "종료" + "</td>";
					html += '<td><input disabled type="checkbox" value="'+list[i].eventCardId+'" name="eventCardCheckBox"></td>';
				}else if(nowTime < exposureStartDt.replace(/-/g,"") ){
					html += " <td>" + "노출전" + "</td>";
					html += '<td><input type="checkbox" value="'+list[i].eventCardId+'" name="eventCardCheckBox"></td>';
				}else{
					html += " <td>" + "노출중" + "</td>";
					html += '<td><input type="checkbox" value="'+list[i].eventCardId+'" name="eventCardCheckBox"></td>';
				}
				
				
					html +="</tr>";
			}		
		}
		
	

		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#eventCardList").empty();
		$("#eventCardList").append(html);
		
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
function eventCardInsertForm() {
	location.href="<c:url value='/card/eventCardInsertForm.do' />";
}

//세부 화면
function eventCardDetailForm(eventCardId){
	location.href="<c:url value='/card/eventCardDetail.do?eventCardId="+eventCardId+"'/>";
}

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='eventCardCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='eventCardCheckBox']").attr("checked", false);
			}
		}
	});
}


function deleteEventCard(){
	var cardCheckBoxSeqArray = $("input:checkbox[name='eventCardCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(cardCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.");
		return;
	}
	
	if(confirm("선택 하신 이벤트 카드 정보를 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "<c:url value='/card/deleteEventCard.do' />",
			type : "POST",
			data : {
				eventCardIdArray : cardCheckBoxSeqArray.toString()
			},
			dataType : "json"
		}).done(function (data) {
			var resultCode = data.resultCode;
			if(resultCode == "0000") {
				alert("선택한 이벤트 카드 정보가 삭제 되었습니다.");
				location.reload(true);
			}else {
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


function isNumber(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	}); 
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="eventCardSearchForm" name="eventCardSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>카드덱 관리 > 이벤트 카드 관리</h2>
	</div>
	
		<!-- s: table top-->
		<!-- <div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">이벤트 카드 검색 조건</div>
			</div>
			<div class="rtl">
				<div class="table_info01">* 선택입력</div>
			</div>
		</div>
		e: table top
			
		s: search table wrap
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
						<th class="last" >상태<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<select id="status" name="status" class="select w01"style="width: 380px; text-align: center;">
								<option value="ALL" selected="selected">전체</option>
								<option value="1" >노출전</option>
								<option value="2" >노출중</option>
								<option value="3" >종료</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<tr>
							<th class="last" >URL<span class="imp">*</span></th>
							<td colspan="4" class="last">
								<input type="text"  maxlength="80"  autocomplete="off" id="cardNm" name="cardNm" class="input w01"/>
							</td>
						</tr>
				</tbody>
			</table>
			<div class="thead_wrap cboth">
				<div class="rtl">
					<a href="javascript:goSearch(1);"><span class="btn btn_w01"> 조회</span></a>&nbsp;
				</div>
				<div class="rtl">
					<a href="javascript:resetSearch();"><span class="btn btn_w01"> 초기화</span></a>&nbsp;
				</div>
			</div>
			<br><br> -->
			
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
				<div class="tit_table">이벤트 카드 리스트</div>
		</div>
		<div class="rtl">
			<a href="javascript:deleteEventCard();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="7%"/>
				<col width="14%"/>
				<col width="10%"/>
				<col width="*%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="5%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>유형</th>
					<th>등록기간</th>
					<th>서비스카드</th>
					<th>URL</th>
					<th>등록일</th>
					<th>등록자</th>
					<th>등록상태</th>
					<th class="last">선택</th>
				</tr>
			</thead>
			<tbody id="eventCardList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:eventCardInsertForm();">등록하기</a></span>
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>
