<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
var serviceCategoryMap = new Map();
//var notiImportanceMap = new Map();
var notiTypeMap = new Map();
//var serviceExposureMap = new Map();
var notiContTypeMap = new Map();

$(document).ready(function(){
	
	//그룹 코드 설정 영역
	selectGrpCodeList("NOTI_TYPE","notiType");
	//selectGrpCodeList("SERVICE_EXPOSURE","serviceExposure");
	//selectGrpCodeList("NOTI_IMPORTANCE","notiImportance");
	selectGrpCodeList("SERVICE_CATEGORY","serviceCategory");		
	//selectGrpCodeList("CARD_NOTI_CONT_TYPE","cardNotiContType");	
	selectGrpCodeList("CARD_NOTI_CONT_TYPE","contType");	
	
	goSearch(1);
	checkboxClickEventHandler();
	
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
		
		var html ="<option value='ALL' selected='selected'>전체</option>";
		
		for (var i = 0; i < list.length ; i++) {	
			if(grpCodeNm =='SERVICE_CATEGORY'){
				serviceCategoryMap.put(list[i].cdVal,list[i].dtlCdNm);
				/* if(list[i].cdVal !='ALL'){
					html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
				} */
			}else if(grpCodeNm =='NOTI_TYPE'){
				notiTypeMap.put(list[i].dtlCdNm,list[i].cdVal);
			}else if(grpCodeNm =='CARD_NOTI_CONT_TYPE'){
				notiContTypeMap.put(list[i].cdVal,list[i].dtlCdNm);
				if(list[i].cdVal !='ALL'){
					html += "<option value="+list[i].cdVal+">"+ list[i].codeDesc  +"</option>";
				}
			}else{
				//nothing
			}
			
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
	})
}

// 리스트 조회
function goSearch(page) {
	$("#page").val(page);
	$("#notiType").val(notiTypeMap.get("카드덱"));
	
	$.ajax({
		url :"<c:url value='/card/selectCardNoticeList.do'/>"
		,data : $('#cardNoticeSearchForm').serialize()
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
				html += "<tr>";
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td><a href='javascript:cardNoticeDetailForm(\"" + list[i].notiId+ "\");' class='link'>" + list[i].notiTitle + "</td>"; 
				html += "	<td>" + list[i].firmVer + "</td>";
				html += "	<td>" + list[i].regId + "</td>";  //등록자
				html += "	<td>" + list[i].notiStartDt  + "~" + list[i].notiEndDt +"</td>";  //공지일정  firmVer
				
				var exposureYn = list[i].exposureYn;
				if(exposureYn == "Y"){
					html += " <td>" + "사용" + "</td>";
				}else{
					html += " <td>" + "미사용" + "</td>";
				}
				
				html += "	<td>" + list[i].contType + "</td>";  
				var serviceCategory = serviceCategoryMap.get(list[i].serviceCategory);
				html += "	<td>" + serviceCategory + "</td>";  //서비스 카테고리
				
				
				html += '<td><input type="checkbox" value="'+list[i].notiId+'" name="noticeCheckBox"></td>';
				html +="</tr>";
			}
		}
	

		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#cardNoticeList").empty();
		$("#cardNoticeList").append(html);
		
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
function cardNoticeInsertForm() {
	location.href="<c:url value='/card/cardNoticeInsertForm.do' />";
}

//세부 화면
function cardNoticeDetailForm(notiId){
	location.href="<c:url value='/card/cardNoticeDetail.do?notiId="+notiId+"'/>";
}

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='noticeCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='noticeCheckBox']").attr("checked", false);
			}
		}
	});
}


function deleteCardNotice(){
	var noticeCheckBoxSeqArray = $("input:checkbox[name='noticeCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(noticeCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.");
		return;
	}
	
	if(confirm("선택 하신 카드덱 공지사항을 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "<c:url value='/card/deleteCardNotice.do' />",
			type : "POST",
			data : {
				notiIdArray : noticeCheckBoxSeqArray.toString()
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


function isNumber(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	}); 
}

//검색 조건 초기화
function resetSearch(){

	$("#firmVer").val("");
	$("#exposureYn").val("ALL").prop("selected", true);
	$("#contType").val("ALL").prop("selected", true);
	//$("#serviceCategory").val("ALL").prop("selected", true);
	
	//var html="";
	//html += "	<tr><th colspan='6'></td></tr>";
	
	//$("#paging").empty();

	//$("#cardNoticeList").empty();
	//$("#cardNoticeList").append(html);
	
	//$("#totCnt").text("0");
	
	goSearch(1);
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="cardNoticeSearchForm" name="cardNoticeSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="notiType" name="notiType" />
	
	<div class="main_top">
		<h2>카드덱 관리> 카드덱 공지 사항 관리 > 카드덱 공지사항 리스트</h2>
	</div>
	
	<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">카드덱 공지사항 검색 조건</div>
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
					<col width="34%"/>
					<col width="16%"/>
					<col width="34%"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="last" >F/W 버전<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text"  maxlength="80"  autocomplete="off" id="firmVer" name="firmVer" class="input w01"/>
						</td>
						<th class="last" >상태<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="exposureYn" name="exposureYn" class="select w01"style="width: 380px; text-align: center;">
								<option value="ALL" selected="selected">전체</option>
								<option value="Y" >사용</option>
								<option value="N" >미사용</option>
							</select>
						</td>
					</tr>
					<tr>
						<th class="last" >본문 타입<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<select id="contType" name="contType" class="select w01"style="width: 380px;">
								<option value="ALL" selected="selected">전체</option>
								
							</select>
						</td>
						<th class="last" >서비스 카테고리</th>
						<td colspan="1" class="last">
							<!-- <select id="serviceCategory" name="serviceCategory" class="select w01"style="width: 380px;">
								<option value="ALL" selected="selected">전체</option>
							</select> -->
							<input type="hidden"  maxlength="80"  autocomplete="off" id="serviceCategory" name="serviceCategory" value="AM" />
							AM (After 마켓 서비스)
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
			<br><br>
			
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
				<div class="tit_table">카드덱 공지 사항 리스트</div>
		</div>
		<div class="rtl">
			<a href="javascript:deleteCardNotice();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="25%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="5%"/>
				<col width="15%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>제목</th>
					<th>F/W버전</th>
					<th>등록자</th>
					<th>등록일정</th>
					<th>상태</th>
					<th>본문타입</th>
					<th>서비스<br>카테고리</th>
					<th class="last">선택</th>
				</tr>
			</thead>
			<tbody id="cardNoticeList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:cardNoticeInsertForm();">등록하기</a></span>
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>
