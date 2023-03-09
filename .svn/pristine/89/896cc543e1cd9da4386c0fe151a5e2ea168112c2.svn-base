<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<Style>
tr.rowhighlight td, tr.rowhighlight th{
    background-color:#f0f8ff;
}
</Style>
<script type="text/javaScript">
$(document).ready(function(){
	selectGrpCodeList("SERVICE_CATEGORY","marketType");
	
	goSearch(1);
	getVersionList();
	checkboxClickEventHandler();
	
	//이벤트 카테고리 변경 시
	$('#marketType').change(function(){
		goSearch(1);
		getVersionList();
	});	
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
		
		//var html ="<option value='ALL' selected='selected'>전체</option>";
		var html ="";
		
		for (var i = 0; i < list.length ; i++) {
			if(grpCodeNm =='SERVICE_CATEGORY'){
				if(list[i].cdVal !='ALL'){
					html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
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
	$.ajax({
		url :"<c:url value='/voice/selectVersionList.do'/>"
		,data : $('#versionSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		
		var html = '';
		var list = data.resultList;
		var currentVersion = data.currentVO;
		var totalResult = data.totalCount;
		var totalRatio = data.totalRatio;
		
		if(currentVersion){
			// class='rowhighlight'
			html += "<tr>";
			html += "	<td class='rowhighlight'></td>";
			html += "	<td class='rowhighlight'>" + currentVersion.ver + "</td>";  //버전
			html += "	<td class='rowhighlight'><span onclick = avascript:openEditVersionForm(\"" + currentVersion.voiceVerNo+ "\"); style='width:200px;' class='btn btn_w01'><font color='red'>사용</span></td>";
			html += "	<td class='rowhighlight'>" + currentVersion.regDt + "</td>";  //등록일
			html += "	<td class='rowhighlight'>" + currentVersion.regId + "</td>";  //등록자
			html += "	<td class='rowhighlight'></td>";
			html +="</tr>";	
		}	
		

		for (var i = 0; i < list.length ; i++) {					
			html += "<tr>";
			html += "	<td>" + list[i].rnum + "</td>";
			html += "	<td>" + list[i].ver + "</td>";  //버전
			html += "<td><span onclick = avascript:openEditVersionForm(\"" + list[i].voiceVerNo+ "\"); style='width:200px;' class='btn btn_w01'>미사용</span></td>";
			html += "	<td>" + list[i].regDt + "</td>";  //등록일
			html += "	<td>" + list[i].regId + "</td>";  //등록자
			html += '<td><input type="checkbox" value="'+list[i].voiceVerNo+'" name="versionCheckBox"></td>';
			html +="</tr>";
		}
		
		$("#paging").empty();
		$("#paging").append(data.paging);
		$("#versionList").empty();
		$("#versionList").append(html);
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


//등록
function addVersion(){
	
	if(confirm("음성가이드 신규 버전을 등록 하시겠습니까?")){
	
		var ver =  $("#ver").val();
		var useYn =$(":input:radio[name=useYn]:checked").val();
		var copyVoiceVerNo =$("#copyVoiceVerNo option:selected").val();
		var marketType =$("#marketType option:selected").val();
		
		console.log("ver:"+ver+" useYn:"+useYn+" copyVoiceVerNo:",copyVoiceVerNo);


		if(copyVoiceVerNo == ''){
			alert("Copy 할 버전을 선택하세요.");
		}
		
		if (formValidationCheck(['ver', 'useYn','copyVoiceVerNo'])){
		
			$.ajax({
				url : "<c:url value='/voice/addVersionAjax.do' />",
				type : "POST",
				data : {
					"ver" : ver,
					"useYn" : useYn,
					"copyVoiceVerNo" : copyVoiceVerNo,
					"marketType" : marketType
				},
				dataType : "json"
			}).done(function (data) {
				var result = data.result;
				if(result == "Y") {
					closeInserForm();
					alert("신규 버전이 등록 되었습니다.");
					location.reload(true);
				}else if(result == "E"){
					alert("현재 사중중인 음성가이드 버전이 이미 존재 합니다.");	
				}else if(result == "D"){
					alert("사용중인 버전 선택은 1개만 가능 합니다.");	
				}else {
					alert("신규 버전 등록중 오류가 발생하였습니다.");				
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
	
}


//수정
function editVersion(){
	
	var marketType =$("#marketType option:selected").val();
	
	if(confirm("해당 버전을 수정 하시겠습니까?")){
		if (formValidationCheck(['editVoiceVerNo', 'editVer','editUseYn'])){
			$.ajax({
				url : "<c:url value='/voice/editVersionAjax.do'/>",
				type : "POST",
				data : {
							"voiceVerNo" :  $("#editVoiceVerNo").val(),
							"ver"		: $("#editVer").val(),
							"useYn" : $(":input:radio[name=editUseYn]:checked").val(),
							"marketType" : marketType
						},
				dataType : "json"
			}).done(function (data) {
				var result = data.result;
				if(result == "Y") {
					alert("음성 가이드 버전이 수정 되었습니다.");
					closeEditForm();
					location.reload(true);
				}else if(result == "D") {
					alert("사용중인 버전 선택은 1개만 가능 합니다.");	
				}else{
					alert("음성 가이드 버전이 수정중  오류가 발생하였습니다.");		
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
}

//수정 팝업
function openEditVersionForm(voiceVerNo){
	$.ajax({
		url : "<c:url value='/voice/selectVersionAjax.do' />",
		type : "POST",
		data : {
			"voiceVerNo" : voiceVerNo
		},
		dataType : "json"
	}).done(function (data) {
		var ver =  data.voiceVO.ver;
		var useYn = data.voiceVO.useYn;
		versionEditForm(ver,useYn,voiceVerNo);
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

function getVersionList(){
	var marketType =$("#marketType option:selected").val();
	$.ajax({
		url : "<c:url value='/voice/selectAllVersionListAjax.do' />",
		type : "POST",
		data : {
			"marketType" : marketType
		},
		dataType : "json"
	}).done(function (data) {
		var list =  data.resultList;
		var html ="";
		for (var i = 0; i < list.length ; i++) {
			if(i == 0){
				html += "<option  selected='selected' value="+list[i].voiceVerNo+">"+ list[i].ver + "</option>";
			}else{
				html += "<option value="+list[i].voiceVerNo+">"+ list[i].ver + "</option>";
			}
		
		}
		$("#copyVoiceVerNo").empty();
		$("#copyVoiceVerNo").append(html);
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

function deleteVersion(){
	var versionCheckBoxSeqArray = $("input:checkbox[name='versionCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(versionCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	if(confirm("선택 하신 버전을 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {
		$.ajax({
			url : "<c:url value='/voice/deleteVersionAjax.do' />",
			type : "POST",
			data : {
				versionSeqArray : versionCheckBoxSeqArray.toString()
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



function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='versionCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='versionCheckBox']").attr("checked", false);
			}
		}
	});
}

function closeInserForm(){
	$('#versionAddPopup').hide(); 
	$('.dimmed').hide();
	$("#ver").val(""); 
	$("#useYn").val(""); 
}

function closeEditForm(){
	$('#versionEditPopup').hide(); 
	$('.dimmed1').hide();
	$("#editVer").val(""); 
	$("#dditUseYn").val("");
}

function versionInsertForm(){
	getVersionList();
	$('#versionAddPopup').show(); 
	$('.dimmed').show();
}

function versionEditForm(version,useYn,voiceVerNo){
	$("#editVer").val(version); 	
	$('input:radio[name=editUseYn]:input[value=' + useYn + ']').attr("checked", true);
	console.log("voiceVerNo",voiceVerNo);
	$("#editVoiceVerNo").val(voiceVerNo); 
	$('#versionEditPopup').show(); 
	$('.dimmed1').show();
}

function onlyNumber(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	}); 
}

//미입력 항목 alert
function alertMessageSource(elId){
	console.log("elId",elId);
	alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
}
function isVersion(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9_.]/g,""));
	}); 
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="versionSearchForm" name="versionSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>음성 명령 관리 > 버전 관리</h2>
	</div>

	<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
		<colgroup>
			<col width="10%"/>
			<col width="*%"/>
		</colgroup>
		<tbody>
			<tr>
				<th><div class="tit_search">서비스 카테고리</div></th>
				<td class="last" style="text-align:left">
					<select id="marketType" name="marketType" class="select w01" style="align:left; width: 380px;">
						
					</select>
				</td>
			</tr>
		</tbody>
	</table>
	<br><br>
		
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<div class="tit_table">음성 명령 버전 리스트</div>
		</div>
		<div class="rtl">
			<a href="javascript:deleteVersion();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="10%"/>
				<col width="30%"/>
				<col width="20%"/>
				<col width="20%"/>
				<col width="10%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>음성가이드 버전</th>
					<th>사용 유무</th>
					<th>등록일</th>
					<th>등록자</th>
					<th class="last">선택</th>
				</tr>
			</thead>
			<tbody id="versionList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:versionInsertForm();">등록하기</a></span>
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>


<!-- Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="versionAddPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 600px">
			<div class="p_header">
				<h1>음성 가이드 버전 등록</h1>
				<a href="javascript:closeInserForm();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
							<div class="table_wrap">
								<table class="table simple table_write_type">
									<colgroup>
										<col width="20%"/>
										<col width="30%"/>
										<col width="16%"/>
										<col width="34%"/>
									</colgroup>
									<tbody>
										<tr>
											<th>버전명 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="text" onkeydown="isVersion(this)" autocomplete="off" id="ver" name="ver" class="input w01" />
											</td>
										</tr>
										<tr>
											<th>사용 유무 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="radio" name="useYn" id="useYn" class="" value="Y" checked/> <label for="useYn">사용</label>&nbsp;&nbsp;
												<input type="radio" name="useYn" id="useYn" class="" value="N" /> <label for="useYn">미사용</label>&nbsp;&nbsp;
											</td>
										</tr>
										<tr>
											<th>Copy 음성 가이드 버전 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<select id="copyVoiceVerNo" name="copyVoiceVerNo" class="select w01">
													<option value="" selected="selected">선택</option>
												</select>
											</td>
										</tr>	
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:addVersion()">등록</span>
						<span class="btn large focus" onclick="javascript:closeInserForm();">취소</span>
					</div>
					<!-- e: btn -->
				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
	
	
<!-- Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed1" style="display: none;"></div>
	<div class="popup_container" id="versionEditPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 600px">
			<div class="p_header">
				<h1>음성가이드 버전 수정</h1>
				<a href="javascript:closeEditForm();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
							<div class="table_wrap">
								<table class="table simple table_write_type">
									<colgroup>
										<col width="20%"/>
										<col width="30%"/>
										<col width="16%"/>
										<col width="34%"/>
									</colgroup>
									<tbody>
										<tr>
											<th>버전명 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="hidden" autocomplete="off" id="editVoiceVerNo" name="editVoiceVerNo" class="input w01" />
												<input type="text" autocomplete="off" id="editVer" name="editVer" class="input w01" />
											</td>
										</tr>
										<tr>
											<th>사용 유무 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input  type="radio" name="editUseYn" id="editUseYn" class="" value="Y" /> <label for="useYn">사용</label>&nbsp;&nbsp;
												<input  type="radio" name="editUseYn" id="editUseYn" class="" value="N" /> <label for="useYn">미사용</label>&nbsp;&nbsp;
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:editVersion();">수정</span>
						<span class="btn large focus" onclick="javascript:closeEditForm();">취소</span>
					</div>
					<!-- e: btn -->
				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->