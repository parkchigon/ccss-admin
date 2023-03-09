<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
var domainList;
var guideVersionList;
var domainSearchListMap = new Map();
var prioYnListMap = new Map();
var exposureYnListMap = new Map();
var voiceGuideNoListMap = new Map();

var searchVer;
$(document).ready(function(){
	selectGrpCodeList("SERVICE_CATEGORY","marketType");
	
	goSearch(1);
	
	checkboxClickEventHandler();		//명령어 삭제 체크 이벤트 헨들러
	checkBoxDomainMenuEventHandler(); 	// 도메인 조회 메뉴 체크 이벤트 헨들러
	checkBoxPrioEventHandler();		 	// 우선 순위 체크 이벤트 헨들러
	
	checkBoxExposureEventHandler();		// 노출 여부 체크 이벤트 헨들러
	
	//도메인 메뉴 생성
	$('#domainMenuButton').click(function(){
		$("#domainMenuArea").empty();
		makeDomainMenuTable();
	});
	
	$('#searchVer').change(function(){
		searchVer = this.value;
	});
	
	//검색 조건 초기화
	$('#reset').click(function(){
		//음성 가이드 초기화
		$("#searchVer").val("");
		//도메인 선택 Map 초기화
		domainSearchListMap = new Map();
		//명령어 초기화
		$("#searchValue").val("");
	});
	
	//이벤트 카테고리 변경 시
	$('#marketType').change(function(){
		// 검색조건 초기화
		$("#searchVer").val("");
		//도메인 선택 Map 초기화
		domainSearchListMap = new Map();
		//명령어 초기화
		$("#searchValue").val("");
		
		goSearch(1);
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

function makeGuideVersionMenu(){
	var html ="<option value='' selected='selected'>전체</option>";
	for (var i = 0; i < guideVersionList.length ; i++) {
		html += "<option value="+guideVersionList[i].voiceVerNo+">"+ guideVersionList[i].ver + "</option>";
	}
	$("#searchVer").empty();
	$("#searchVer").append(html);
	
}
function makeDomainMenuTable (){
	
	var html = '';
	for (var i = 0; i < domainList.length ; i++) {
		//Map에서 체크 
		html += "<tr>";
		html += "	<td style=text-align:center;>" + domainList[i].domain + "</td>";
		if(domainSearchListMap.containsKey(domainList[i].voiceDomainNo)){
			html += "	<td style=text-align:center;> <input type='checkbox' value='" +domainList[i].voiceDomainNo+ "'" + " name='domainCheckBox' id='domainCheckBox' checked></td>";
		}else{
			html += "	<td style=text-align:center;> <input type='checkbox' value='" +domainList[i].voiceDomainNo+ "'" + " name='domainCheckBox' id='domainCheckBox'></td>";
		}
		html += "</tr>";
	}
	
	$("#domainList").empty();
	$("#domainList").append(html);
	
	//도메인 선택 조회 메뉴 노출
	showMenuSelectPopup();
}


function selectCommandModi(){
	
	//console.log("prioYnListMap",prioYnListMap.values().toString());
	//console.log("exposureYnListMap",exposureYnListMap.values().toString());
	//console.log("voiceGuideNoListMap",voiceGuideNoListMap.values().toString());
	

	if(confirm("우선 순위와 노출 여부를 수정 하시겠습니까?")) {
		$.ajax({
			url : "<c:url value='/voice/selectCommandModi.do' />",
			type : "POST",
			data : {
				prioSeqArray      :  prioYnListMap.values().toString(),
				exposureSeqArray  :  exposureYnListMap.values().toString(),
				voiceGuideNoArray :  voiceGuideNoListMap.values().toString()
			},
			dataType : "json"
		}).done(function (data) {
			var resultCode = data.resultCode;
			if(resultCode == "0000") {
				alert("우선 순위와 노출 여부가 수정 되었습니다.");
				location.reload(true);
			} else {
				alert("우선 순위와 노출 여부 수정 중 오류가 발생하였습니다.");				
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
// 리스트 조회
function goSearch(page) {
	
	var marketType =$("#marketType option:selected").val();	

	$("#page").val(page);
	$.ajax({
		url :"<c:url value='/voice/selectCommandList.do'/>"
		//,data : $('#commandSearchForm').serialize()
		,type : "POST"
		,data : { 
					voiceVerNo :  $("#searchVer").val(),
					command : $("#searchValue").val(),
					"marketType" : marketType,
					domainSearchList :  domainSearchListMap.values().toString(),
					page : $("#page").val()
				}
		,dataType : 'json'
		
	}).done(function(data) {
		
		var html = '';
		var list = data.commandList;
		var totalResult = data.totalCount;
		domainList = data.domainList;
		guideVersionList = data.guideVersionList;
		
		for (var i = 0; i < list.length ; i++) {
			
			/* html += "<tr class='rowhighlight'>";
			html += "	<td>" + list[i].rnum + "</td>"; */
			var guideVerUseYn = list[i].useYn;
			var deleteVerCheck='N';
			
			
			if(guideVerUseYn =='Y'){ //가이드 버전   & 가이드 사용 유무
				html += "<tr class='rowhighlight'>";
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td>" + list[i].ver;
				html += "(사용중)";	
				html += "</td>";
			}else{
				html += "<tr>";
				html += "	<td>" + list[i].rnum + "</td>";
				html += "	<td>" + list[i].ver;
				html += "(미사용)";	
				html += "</td>";
			}
			
			html += "	<td>" + list[i].domain + "</td>";			//도메인
			html += "	<td>" + list[i].guideLevel + "단계</td>";	//가이드 레벨
			html += "	<td><a href='javascript:openEditCommandForm(\"" + list[i].voiceGuideNo+ "\");' class='link'>" + list[i].command + "</td>";  //명령어
			if(list[i].prioYn =='Y'){
				html += '<td><input type="checkbox" value="'+list[i].voiceGuideNo+'" name="prioYnCheckBox" id="prioYnCheckBox" checked></td>';
				prioYnListMap.put(list[i].voiceGuideNo,list[i].voiceGuideNo);
			}else{
				html += '<td><input type="checkbox" value="'+list[i].voiceGuideNo+'" name="prioYnCheckBox" id="prioYnCheckBox"></td>';
			}
			
			if(list[i].exposureYn =='Y'){
				html += '<td><input type="checkbox" value="'+list[i].voiceGuideNo+'" name="exposureYnCheckBox" id="exposureYnCheckBox" checked></td>';
				exposureYnListMap.put(list[i].voiceGuideNo,list[i].voiceGuideNo);
			}else{
				html += '<td><input type="checkbox" value="'+list[i].voiceGuideNo+'" name="exposureYnCheckBox" id="exposureYnCheckBox"></td>';
				
			}
			html += "	<td>" + list[i].regDt + "</td>";  //등록일
			html += '<td><input type="checkbox" value="'+list[i].voiceGuideNo+'" name="commandCheckBox"></td>';
			html +="</tr>";
			
			
			voiceGuideNoListMap.put(list[i].voiceGuideNo,list[i].voiceGuideNo);
		}
		
		$("#paging").empty();
		$("#paging").append(data.paging);
		$("#commandList").empty();
		$("#commandList").append(html);
		$("#totCnt").text(totalResult);
		
		//음성가이드 버전 Select Box 생성
		makeGuideVersionMenu();
		
		//검색 조건 셋팅
		if(data.searchVer){
			$("#searchVer").val(data.searchVer);
		}
		if(data.searchValue){
			$("#searchValue").val(data.searchValue);
		}
		
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
function addCommand(){
	
	if(confirm("음성가이드 신규 명령어를 등록 하시겠습니까?")){
		
		var voiceVerNo = $("select[name=insertVoiceVerNo]").val();
		var voiceDomainNo = $("select[name=voiceDomainNo]").val();
		var prioYn =$(":input:radio[name=prioYn]:checked").val();
		var exposureYn =$(":input:radio[name=exposureYn]:checked").val();
		var command =$("#insertCommand").val();
		var guideLevel  =$("select[name=guideLevel]").val();

		if (formValidationCheck(['insertVoiceVerNo', 'voiceDomainNo' ,'prioYn' ,'exposureYn','insertCommand','guideLevel'])){
		
			$.ajax({
				url : "<c:url value='/voice/addCommandAjax.do' />",
				type : "POST",
				data : {
							"voiceVerNo" : voiceVerNo,
							"voiceDomainNo" : voiceDomainNo,
							"prioYn" : prioYn,
							"exposureYn" : exposureYn,
							"command"    : command,
							"guideLevel" : guideLevel
				},
				dataType : "json"
			}).done(function (data) {
				var result = data.result;
				if(result == "Y") {
					closeInserForm();
					alert("신규 음성 가이드 명령어가 등록 되었습니다.");
					location.reload(true);
				}else if(result == "D"){
					alert("해당 버전 해당 도메인에 대해 이미 음성 가이드 명령어가 존재합니다.");
				}else {
					alert("신규 음성 가이드 명령어 등록중 오류가 발생하였습니다.");				
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
function openEditCommandForm(voiceGuideNo){
	//음성 가이드 버전 조회
	var marketType =$("#marketType option:selected").val();
	var editTitle = "음성 가이드 명령어 수정 [ "+marketType + " ]";
	$("#editTitle").empty();
	$("#editTitle").append(editTitle);
	
	$.ajax({
		url : "<c:url value='/voice/selectAllVersionListAjax.do' />",
		type : "POST",
		data : {"marketType" : marketType},
		dataType : "json"
	}).done(function (data) {
		var list =  data.resultList;
		var html ="<option value='' selected='selected'>전체</option>";
		for (var i = 0; i < list.length ; i++) {
			html += "<option value="+list[i].voiceVerNo+">"+ list[i].ver + "</option>";
		}
		$("#editVoiceVerNo").empty();
		$("#editVoiceVerNo").append(html);
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
	
	
	//음성 가이드 도메인 조회
	$.ajax({
		url : "<c:url value='/voice/selectAllDomainListAjax.do' />",
		type : "POST",
		dataType : "json"
	}).done(function (data) {
		var list =  data.resultList;
		var html ="<option value='' selected='selected'>전체</option>";
		for (var i = 0; i < list.length ; i++) {
			html += "<option value="+list[i].voiceDomainNo+">"+ list[i].domain + "</option>";
		}
		
		$("#editVoiceDomainNo").empty();
		$("#editVoiceDomainNo").append(html);

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
	
	sleep(200);
	$.ajax({
		url : "<c:url value='/voice/selectCommadAjax.do'/>",
		type : "POST",
		data : {
			"voiceGuideNo" : voiceGuideNo
		},
		dataType : "json"
	}).done(function (data) {
		var voiceVO = data.voiceVO;
		console.log("voiceVO",voiceVO);	
		openCommandEditForm(voiceVO);
	
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




//수정
function editCommand(){
	
	if(confirm("해당 음성 가이드 명령어를 수정 하시겠습니까?")){
		
		var voiceVerNo 		= $("#editVoiceVerNo").val(); 
		var voiceDomainNo 	= $("#editVoiceDomainNo").val(); 
		var prioYn 			= $("#editPrioYn").val(); 
		var exposureYn  	= $("#editExposureYn").val(); 
		var command    		= $("#editCommand").val(); 
		var guideLevel  	= $("#editGuideLevel").val(); 
		var voiceGuideNo   	= $("#editVoiceGuideNo").val(); 
		
		if (formValidationCheck(['editVoiceVerNo', 'editVoiceDomainNo','editGuideLevel','editPrioYn','editExposureYn','editGuideLevel','editCommand'])){
			$.ajax({
				url : "<c:url value='/voice/editCommandAjax.do'/>",
				type : "POST",
				data : {
							"voiceVerNo" : voiceVerNo,
							"voiceDomainNo" : voiceDomainNo,
							"prioYn" : prioYn,
							"exposureYn" : exposureYn,
							"command"    : command,
							"guideLevel" : guideLevel,
							"voiceGuideNo" : voiceGuideNo,
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
				}else if(result == "D"){
					alert("해당 버전 해당 도메인에 대해 이미 음성 가이드 명령어가 존재합니다.");
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

function deleteCommand(){
	var commandCheckBoxSeqArray = $("input:checkbox[name='commandCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(commandCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	if(confirm("선택 하신 명령어를 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {
		$.ajax({
			url : "<c:url value='/voice/deleteCommandAjax.do' />",
			type : "POST",
			data : {
				commandSeqArray : commandCheckBoxSeqArray.toString()
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

//우선 순위 체크 박스 이벤트 핸들러
function checkBoxPrioEventHandler(){
	$(document).on("click", "#prioYnCheckBox", function() {
		if($(this).is(":checked")) {
			prioYnListMap.put(this.value,this.value);
		} else {
			prioYnListMap.remove(this.value);
		}
		console.log("prioYnListMap",prioYnListMap);
	});
}

//노출 여부 체크 박스 이벤트 핸들러
function checkBoxExposureEventHandler(){
	$(document).on("click", "#exposureYnCheckBox", function() {
		if($(this).is(":checked")) {
			exposureYnListMap.put(this.value,this.value);
		} else {
			exposureYnListMap.remove(this.value);
		}
		console.log("exposureYnListMap",exposureYnListMap);
	});
}


//도메인 조회 메뉴 체크 박스 이벤트 핸들러
function checkBoxDomainMenuEventHandler(){
	$(document).on("click", "#domainCheckBox", function() {
		if($(this).is(":checked")) {
			domainSearchListMap.put(this.value,this.value);
		} else {
			domainSearchListMap.remove(this.value);
		}
	});
}

//명령어 선택 삭제 체크 박스 이벤트 핸들러
function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='commandCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='commandCheckBox']").attr("checked", false);
			}
		}
	});
}
function closeMenuSelectPopup(){
	$('#domainMenuSelectPopup').hide(); 
	$('.dimmed2').hide();
}
function showMenuSelectPopup(){
	$('#domainMenuSelectPopup').show(); 
	$('.dimmed2').show();
}

function closeInserForm(){
	$('#commandAddPopup').hide(); 
	$('.dimmed').hide();
}


function closeEditForm(){
	$('#commandEditPopup').hide(); 
	$('.dimmed1').hide();
}

function commandInsertForm(){
	var marketType =$("#marketType option:selected").val();
	var insertTitle = "음성 가이드 명령어 등록 [ "+marketType + " ]";
	$("#insertTitle").empty();
	$("#insertTitle").append(insertTitle);
	//음성 가이드 버전 조회
	$.ajax({
		url : "<c:url value='/voice/selectAllVersionListAjax.do' />",
		type : "POST",
		data : {"marketType":marketType},
		dataType : "json"
	}).done(function (data) {
		var list =  data.resultList;
		var html ="<option value='' selected='selected'>전체</option>";
		for (var i = 0; i < list.length ; i++) {
			html += "<option value="+list[i].voiceVerNo+">"+ list[i].ver + "</option>";
		}
		
		$("#insertVoiceVerNo").empty();
		$("#insertVoiceVerNo").append(html);

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
	
	//음성 가이드 도메인 조회
	$.ajax({
		url : "<c:url value='/voice/selectAllDomainListAjax.do' />",
		type : "POST",
		dataType : "json"
	}).done(function (data) {
		var list =  data.resultList;
		var html ="<option value='' selected='selected'>전체</option>";
		for (var i = 0; i < list.length ; i++) {
			html += "<option value="+list[i].voiceDomainNo+">"+ list[i].domain + "</option>";
		}
		
		$("#voiceDomainNo").empty();
		$("#voiceDomainNo").append(html);

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
	
	$('#commandAddPopup').show(); 
	$('.dimmed').show();
}

function openCommandEditForm(voiceVO){
	
	//editVoiceVerNo  
	$("#editVoiceVerNo").val(voiceVO.voiceVerNo); 
	console.log("editVoiceVerNo",$("#editVoiceVerNo").val());
	//editVoiceDomainNo
	//$("#editVoiceDomainNo").val(voiceVO.voiceDomainNo); 
	//console.log("editVoiceDomainNo",$("#editVoiceDomainNo").val());
	$("#editVoiceDomainNo").val(voiceVO.voiceDomainNo).prop("selected", true);
	console.log("editVoiceDomainNo",$("#editVoiceDomainNo").val());
	//editGuideLevel
	$("#editGuideLevel").val(voiceVO.guideLevel); 
	//editPrioYn
	$('input:radio[name=editPrioYn]:input[value=' + voiceVO.prioYn + ']').attr("checked", true);
	//editExposureYn
	$('input:radio[name=editExposureYn]:input[value=' + voiceVO.exposureYn + ']').attr("checked", true);
	//editGuideLevel
	$("#editGuideLevel").val(voiceVO.guideLevel); 
	//editCommand
	$("#editCommand").val(voiceVO.command); 
	//editVoiceGuideNo
	$("#editVoiceGuideNo").val(voiceVO.voiceGuideNo); 
	//화면 뷰
	$('#commandEditPopup').show(); 
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


function sleep(num){	//[1/1000초]
	var now = new Date();
	var stop = now.getTime() + num;
	while(true){
		now = new Date();
		if(now.getTime() > stop)return;
	}

}

function notAvailableSpecialChar(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9-_.]/g,""));
	}); 
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="commandSearchForm" name="commandSearchForm" method="POST" onsubmit="return false;" >
	<input type="hidden" id="page" name="page" />
	
	<!-- <input type="hidden" id="domainSearchList" name="domainSearchList" /> -->
	
	<div class="main_top">
		<h2>음성  명령 관리 > 명령어 관리</h2>
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
	
	<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
		<colgroup>
			<col width="10%"/>
			<col width="15%"/>
			<col width="*%"/>
		</colgroup>
		<tbody>
			<tr>
				<th style=width:50px;><div class="tit_search">음성 가이드 버전</div></th>
				<td>
					<select id="searchVer" name="voiceVerNo" class="select w01"style="width: 130px;">
						<option value="" selected="selected">전체</option>
					</select>
				</td>
				<th style=width:70px;><div class="tit_search">도메인</div></th>
				<td colspan = 2 class="last">
					<div class="input_wrap">	
						<button id="domainMenuButton" style="width:150px; text-align:center;"  class="input w02" type="button">전체▼</button>
						<input style=width:300px; type="text" autocomplete="off" class="input w02" id="searchValue" name="command" placeholder="명령어 검색"/> 
						<a href="javascript:goSearch(1);">
							<span class="btn focus" style="width: 90px;">
								<img src="/admin/resources/common/images/icon_search01.png" alt="" />조회
							</span>
						</a>
						<span id="reset" class="btn focus" style="width: 90px;">
							초기화
						</span>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
	<br><br>
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<div class="tit_table">음성 명령어 리스트</div>
		</div>
		<div class="rtl">
			<a href="javascript:deleteCommand();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="10%"/>
				<col width="10%"/>
				<col width="20%"/>
				<col width="10%"/>
				<col width="22%"/>
				<col width="8%"/>
				<col width="5%"/>
				<col width="15%"/>
				<col width="5%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>음성가이드<br>버전</th>
					<th>도메인</th>
					<th>가이드레벨</th>
					<th>명령어</th>
					<th>우선순위</th>
					<th>노출</th>
					<th>등록일</th>
					<th class="last">선택</th>
				</tr>
			</thead>
			<tbody id="commandList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:selectCommandModi();">선택수정</a></span>
			<span class="btn btn_w01"><a href="javascript:commandInsertForm();">등록하기</a></span>
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>



<!--명령어 등록 Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="commandAddPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 600px">
			<div class="p_header">
				<h1 id="insertTitle">음성 가이드 명령어 등록</h1>
				<a href="javascript:closeInserForm();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
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
											<th>음성 가이드 버전 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<select id="insertVoiceVerNo" name="insertVoiceVerNo" class="select w01">
													<option value="" selected="selected">전체</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>도메인<span class="imp">*</span></th>
											<td colspan="3" class="last">
												
												<select id="voiceDomainNo" name="voiceDomainNo" class="select w01">
													<option value="" selected="selected">전체</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>명령어 가이드 레벨<span class="imp">*</span></th>
											<td colspan="3" class="last">
												<select id="guideLevel" name="guideLevel" class="select w01">
													<option value="1" selected="selected">1단계</option>
													<option value="2">2단계</option>
													<option value="3">3단계</option>
												</select>
											</td>
										</tr>
									
										<tr>
											<th> 우선 순위 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="radio" name="prioYn" id="prioYn" class="" value="Y" checked/> <label for="prioYn">사용</label>&nbsp;&nbsp;
												<input type="radio" name="prioYn" id="prioYn" class="" value="N" /> <label for="prioYn">미사용</label>&nbsp;&nbsp;
											</td>
										</tr>
										
										<tr>
											<th> 노출 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="radio" name="exposureYn" id="exposureYn" class="" value="Y" checked/> <label for="exposureYn">사용</label>&nbsp;&nbsp;
												<input type="radio" name="exposureYn" id="exposureYn" class="" value="N" /> <label for="exposureYn">미사용</label>&nbsp;&nbsp;
											</td>
										</tr>
										<tr>
											<th> 명령어 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="text" onkeydown="notAvailableSpecialChar(this)" autocomplete="off" id="insertCommand" name="insertCommand" class="input w01" />
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:addCommand()">등록</span>
						<span class="btn large focus" onclick="javascript:closeInserForm();">취소</span>
					</div>
					<!-- e: btn -->
				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
	
	
<!--명령어 수정 Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed1" style="display: none;"></div>
	<div class="popup_container" id="commandEditPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 600px">
			<div class="p_header">
				<h1 id="editTitle">음성가이드 명령어 수정</h1>
				<a href="javascript:closeEditForm();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
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
											<th>음성 가이드 버전 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<select id="editVoiceVerNo" name="editVoiceVerNo" class="select w01">
													<option value="" selected="selected">전체</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>도메인<span class="imp">*</span></th>
											<td colspan="3" class="last">
												<select id="editVoiceDomainNo" name="editVoiceDomainNo" class="select w01">
													<option value="" selected="selected">전체</option>
												</select>
											</td>
										</tr>
										<tr>
											<th>명령어 가이드 레벨<span class="imp">*</span></th>
											<td colspan="3" class="last">
												<select id="editGuideLevel" name="editGuideLevel" class="select w01">
													<option value="1" selected="selected">1단계</option>
													<option value="2">2단계</option>
													<option value="3">3단계</option>
												</select>
											</td>
										</tr>
									
										<tr>
											<th> 우선 순위 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="radio" name="editPrioYn" id="editPrioYn" class="" value="Y" checked/> <label for="editPrioYn">사용</label>&nbsp;&nbsp;
												<input type="radio" name="editPrioYn" id="editPrioYn" class="" value="N" /> <label for="editPrioYn">미사용</label>&nbsp;&nbsp;
											</td>
										</tr>
										
										<tr>
											<th> 노출 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="radio" name="editExposureYn" id="editExposureYn" class="" value="Y" checked/> <label for="editExposureYn">사용</label>&nbsp;&nbsp;
												<input type="radio" name="editExposureYn" id="editExposureYn" class="" value="N" /> <label for="editExposureYn">미사용</label>&nbsp;&nbsp;
											</td>
										</tr>
										<tr>
											<th> 명령어 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="text" autocomplete="off" id="editCommand" name="editCommand" class="input w01" />
												<input type="hidden" autocomplete="off" id="editVoiceGuideNo" name="editVoiceGuideNo" class="input w01" />
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:editCommand();">수정</span>
						<span class="btn large focus" onclick="javascript:closeEditForm();">취소</span>
					</div>
					<!-- e: btn -->
				</div>
			</div>
		</div>
	</div>
	
	
<!--도메인 조회 선택 영역 POP  -->
<body class="jui">
<!-- s: popup -->
<div class="dimmed2" style="display: none;"></div>
<div class="popup_container" id="domainMenuSelectPopup" style="display: none;">
	<div class="popup_inner w01" style="width: 500px; height:300px">
		<div class="p_header">
			<h1>도메인 선택</h1>
			<a href="javascript:closeMenuSelectPopup();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 
		<div style="overflow:scroll;  height:275px;" class="p_body">
			<div class="p_content">
				<div class="detail">
					<div class="user">
						<div class="table_wrap">
							<table class="table simple table_write_type">
								<colgroup>
									<col width="*%"/>
									<col width="10%"/>
								</colgroup>
								<thead>
								<tr>
									<th style=text-align:center;>도메인</th>
									<th style=text-align:center; class="last">선택</th>
								</tr>
							</thead>
							<tbody id="domainList">
							</table>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:closeMenuSelectPopup();">확인</span>
					</div>
					<!-- e: btn -->
				</div>

			</div>
		</div>

	</div>
</div>

<!-- e: popup -->
	
