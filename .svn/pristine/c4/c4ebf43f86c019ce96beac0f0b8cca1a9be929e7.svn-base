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
	checkboxClickEventHandler();

	//이벤트 카테고리 변경 시
	$('#marketType').change(function(){
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

// 리스트 조회
function goSearch(page) {
	$("#page").val(page);
	$.ajax({
		url :"<c:url value='/voice/selectDomainList.do'/>"
		,data : $('#domainSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		var totalRatio = data.totalRatio;
	
		
		for (var i = 0; i < list.length ; i++) {					
			html += "<tr>";
			html += "	<td>" + list[i].rnum + "</td>";
			html += "	<td>" + list[i].domain + "</td>";  //도메인
			html += "	<td>" + list[i].domainExplain + "</td>";  //설명
			html += "<td><span onclick= 'javascript:openEditDomainForm(\"" + list[i].voiceDomainNo+ "\");'  style='width:200px;' class='btn btn_w01'>"+list[i].exposureRatio+"%▼</span></td>";
			html += '<td><input type="checkbox" value="'+list[i].voiceDomainNo+'" name="domainCheckBox"></td>';
			html +="</tr>";
			
		}
		
		$("#paging").empty();
		$("#paging").append(data.paging);
		
		console.log("totalRatio",totalRatio);
		if(totalRatio != 100){

			$("#totalRatio").html("<font color=red>" + totalRatio+"% <br>(노출 빈도 합이 100%가 아닙니다)");
		}else{

			$("#totalRatio").html(totalRatio+"%");
		}
		$("#domainList").empty();
		$("#domainList").append(html);
		
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
function addDomain(){
	
	if(confirm("도메인을 등록 하시겠습니까?")){
		
		var domain = $("#domain").val();
		var domainExplain = $("#domainExplain").val();
		var exposureRatio = $("#exposureRatio").val();
		if (formValidationCheck(['domain', 'exposureRatio'])){
			$.ajax({
				url : "<c:url value='/voice/addDomainAjax.do' />",
				type : "POST",
				data : {
					"marketType" : $("#marketType").val(),
					"domain" : domain,
					"domainExplain" : domainExplain,
					"exposureRatio" : exposureRatio
				},
				dataType : "json"
			}).done(function (data) {
				var result = data.result;
				if(result == "Y") {
					closeInserForm();
					alert("도메인이 등록 되었습니다.");
					
					goSearch($("#page").val());					
					//location.reload(true);
				}else if(result == "E"){
					alert("해당 도메인이 이미 존재 합니다.");	
				}else if(result == "O"){
					alert("노출빈도의 합이 100%가 아닙니다.");	
				}else {
					alert("도메인 등록중 오류가 발생하였습니다.");				
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
function editDomain(){
	if(confirm("도메인을 수정 하시겠습니까?")){
		
		var domain = $("#editDomain").val();
		var exposureRatio = $("#editExposureRatio").val();
		if (formValidationCheck(['editDomain', 'editExposureRatio','editDomainExplain'])){
			$.ajax({
				url : "<c:url value='/voice/editDomainAjax.do'/>",
				type : "POST",
				data : {
					"marketType" : $("#marketType").val(),
					"voiceDomainNo" : $("#editVoiceDomainNo").val(),
					"domainExplain" : $("#editDomainExplain").val(),
					"domain" : domain,
					"exposureRatio" : exposureRatio
				},
				dataType : "json"
			}).done(function (data) {
				var result = data.result;
				if(result == "Y") {
					alert("도메인이 수정 되었습니다.");
					closeEditForm();
					
					goSearch($("#page").val());	
				}else if(result == "O"){
					alert("노출빈도의 합이 100%가 아닙니다.");	
				}else {
					alert("도메인 수정중  오류가 발생하였습니다.");				
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
function openEditDomainForm(voiceDomainNo){

	$.ajax({
		url : "<c:url value='/voice/selectDomainAjax.do' />",
		type : "POST",
		data : {
			"voiceDomainNo" : voiceDomainNo
		},
		dataType : "json"
	}).done(function (data) {
		var result = data.voiceVO;
		var domain =  result.domain;
		var exposureRatio =result.exposureRatio;
		var domainExplain =result.domainExplain;
		domainEditForm(domain,exposureRatio,voiceDomainNo,domainExplain);
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

function deleteDomain(){
	
	var domainCheckBoxSeqArray = $("input:checkbox[name='domainCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(domainCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	if(confirm("선택 하신 도메인을 정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {
		$.ajax({
			url : "<c:url value='/voice/deleteDomainAjax.do' />",
			type : "POST",
			data : {
				"marketType" : $("#marketType").val(),
				domainSeqArray : domainCheckBoxSeqArray.toString()
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
				$("input:checkbox[name='domainCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='domainCheckBox']").attr("checked", false);
			}
		}
	});
}

function closeInserForm(){
	$('#domainAddPopup').hide();
	$('.dimmed').hide();
	$("#domain").val("");
	$("#domainExplain").val("");
	$("#exposureRatio").val(""); 
}


function closeEditForm(){
	$('#domainEditPopup').hide(); 
	$('.dimmed').hide();
	$("#edomain").val(""); 
	$("#eexposureRatio").val("");
}

function domainInsertForm(){
	$('#registerTitle').text('도메인 등록 (' + $('#marketType').val() + ')');
	
	$('#domainAddPopup').show(); 
	$('.dimmed').show();
}

function domainEditForm(domain,exposureRatio,voiceDomainNo,domainExplain){
	$("#editDomain").val(domain); 
	$("#editExposureRatio").val(exposureRatio); 
	$("#editVoiceDomainNo").val(voiceDomainNo); 
	$("#editDomainExplain").val(domainExplain); 
	
	$('#editTitle').text('도메인 수정 (' + $('#marketType').val() + ')');
	
	$('#domainEditPopup').show(); 
	$('.dimmed').show();
}


function onlyNumber(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^0-9]/g,""));
	}); 
}

//미입력 항목 alert
function alertMessageSource(elId){
	alert("입력되지 않은 항목이 있습니다.\n필수입력 항목을 모두 작성해주세요.");
}
function notAvailableSpecialChar(obj) {
	$(obj).keyup(function(){
		$(this).val($(this).val().replace(/[^가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9-_.]/g,""));
	}); 
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="domainSearchForm" name="domainSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>음성 명령 관리 > 도메인 관리</h2>
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
				<div class="tit_table">음성 명령 도메인 리스트</div>
		</div>
		<div class="rtl">
			<a href="javascript:deleteDomain();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
	</div>
	<!-- e: table top-->

	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="10%"/>
				<col width="25%"/>
				<col width="25%"/>
				<col width="20%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>도메인명(Skill)</th>
					<th>설명</th>
					<th>노출빈도</th>
					<th class="last">선택</th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<th>합</th>
					<th></th>
					<th></th>
					<th id="totalRatio"></th>
					<th class="last"></th>
				</tr>
			</tfoot>
			<tbody id="domainList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:domainInsertForm();">등록하기</a></span>
		</div>
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>



<!-- 도메인 등록 Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="domainAddPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 600px">
			<div class="p_header">
				<h1 id="registerTitle"></h1>
				<a href="javascript:closeInserForm();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
							<div class="table_wrap">
								<table class="table simple table_write_type">
									<colgroup>
										<col width="30%"/>
										<col width="20%"/>
										<col width="16%"/>
										<col width="34%"/>
									</colgroup>
									<tbody>
										<tr>
											<th>도메인명(Skill) <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="text" onkeydown="notAvailableSpecialChar(this)" autocomplete="off" id="domain" name="domain" class="input w01" />
											</td>
										</tr>
										<tr>
											<th>설명 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="text" autocomplete="off" id="domainExplain" name="domainExplain" class="input w01" />
											</td>
										</tr>
										<tr>
											<th>노출빈도(%)<span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="text" onkeydown="onlyNumber(this)" autocomplete="off" id="exposureRatio" name="exposureRatio" class="input w01" />
												
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:addDomain()">등록</span>
						<span class="btn large focus" onclick="javascript:closeInserForm();">취소</span>
					</div>
					<!-- e: btn -->
				</div>
			</div>
		</div>
	</div>
	<!-- e: 도메인 등록 popup -->
	
	
<!-- Popup Area  -->
<body class="jui">
	<!-- s: popup -->
	<div class="dimmed1" style="display: none;"></div>
	<div class="popup_container" id="domainEditPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 600px">
			<div class="p_header">
				<h1 id="editTitle"></h1>
				<a href="javascript:closeEditForm();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
							<div class="table_wrap">
								<table class="table simple table_write_type">
									<colgroup>
										<col width="30%"/>
										<col width="20%"/>
										<col width="16%"/>
										<col width="34%"/>
									</colgroup>
									<tbody>
										<tr>
											<th>도메인명(Skill) <span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="hidden" autocomplete="off" id="editVoiceDomainNo" name="editVoiceDomainNo" class="input w01" />
												<input type="text" autocomplete="off" id="editDomain" name="editDomain" class="input w01" readonly/>
											</td>
										</tr>
										<tr>
											<th>설명 <span class="imp">*</span></th>
											<td colspan="3" class="last">
												
												<input type="text" autocomplete="off" id="editDomainExplain" name="editDomainExplain" class="input w01" />
											</td>
										</tr>
										<tr>
											<th>노출빈도(%)<span class="imp">*</span></th>
											<td colspan="3" class="last">
												<input type="text" onkeydown="onlyNumber(this)" autocomplete="off" id="editExposureRatio" name="editExposureRatio" class="input w01" />
												
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:editDomain();">수정</span>
						<span class="btn large focus" onclick="javascript:closeEditForm();">취소</span>
					</div>
					<!-- e: btn -->
				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
	
