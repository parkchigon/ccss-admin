<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javascript" src="<c:url value="/resources/common/ckeditor/ckeditor.js" />"></script>
<script type="text/javaScript">
var serviceCategoryMap = new Map();
var notiImportanceMap = new Map();
var serviceExposureMap = new Map();

$(document).ready(function(){
	
	selectGrpCodeList("NOTI_IMPORTANCE","notiImportanceArea");
	//selectGrpCodeList("SERVICE_CATEGORY","serviceCategoryArea");	
	//selectGrpCodeList("SERVICE_EXPOSURE","serviceExposureArea");
	
	$("input, textarea").attr("disabled",true);
	
	
	//상태
	var exposureYn = "${noticeVO.exposureYn}";
	$('input:radio[name=exposureYn]:input[value=' + exposureYn + ']').attr("checked", true);
	//서비스분류
	//var serviceCategory = "${noticeVO.serviceCategory}";
	//$('input:radio[name=serviceCategory]:input[value=' + serviceCategoryMap.get(serviceCategory) + ']').attr("checked", true);
	//푸시알림
	var pushYn = "${noticeVO.pushYn}";
	$('input:radio[name=pushYn]:input[value=' + pushYn + ']').attr("checked", true);
	//공지중요도
	var notiImportance ="${noticeVO.notiImportance}";
	console.log(notiImportance);
	$('input:radio[name=notiImportance]:input[value="' + notiImportance + '"]').attr("checked", true);
	var impo = $('input:radio[name=notiImportance]:input[value="' + notiImportance + '"]');
	console.log(impo);
	
	//서비스 노출
	//var serviceExposure ="${noticeVO.serviceExposure}";
	//$('input:radio[name=serviceExposure]:input[value=' + serviceExposureMap.get(serviceExposure) + ']').attr("checked", true);
	
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
		//var html ="<input type='radio' name='serviceCategory' id='serviceCategory'  value='ALL'/> <label for='serviceCategory'>전체</label>&nbsp;&nbsp;";
		var html ="";
		for (var i = 0; i < list.length ; i++) {	
			

		if(grpCodeNm =='SERVICE_CATEGORY'){
			serviceCategoryMap.put(list[i].cdVal,list[i].dtlCdNm);
			//html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
			
			if( i == 0){
				html += "<input disabled checked type='radio' name='serviceCategory' id='serviceCategory'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='serviceCategory'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
			}else{
				html += "<input disabled type='radio' name='serviceCategory' id='serviceCategory'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='serviceCategory'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
			}
		}else if(grpCodeNm =='NOTI_IMPORTANCE'){
			notiImportanceMap.put(list[i].cdVal,list[i].dtlCdNm);
			if( i == 0){
				html += "<input disabled checked type='radio' name='notiImportance' id='notiImportance'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='notiImportance'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
			}else{
				html += "<input disabled type='radio' name='notiImportance' id='notiImportance'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='notiImportance'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
			}
		}else if(grpCodeNm =='SERVICE_EXPOSURE'){
			serviceExposureMap.put(list[i].cdVal,list[i].dtlCdNm);
			if( i == 0){
				html += "<input disabled checked type='radio' name='serviceExposure' id='serviceExposure'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='serviceExposure'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
			}else{
				html += "<input disabled type='radio' name='serviceExposure' id='serviceExposure'  value=" +"'"+ list[i].cdVal +"'"+ "/> <label for='serviceExposure'>" + list[i].dtlCdNm + "</label>&nbsp;&nbsp;"; 
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
	});
}

function noticeEditForm() {
	if(confirm("해당 공지사항을 수정 하시겠습니까?")) {
		var notiId = "${noticeVO.notiId}";
		location.href="<c:url value='/notice/noticeEditForm.do?notiId="+notiId+"'/>";
	}
}

function historyBack(){
		//history.back();
	location.href="<c:url value='/notice/noticeList.do'/>";
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="noticeDetailForm" name="noticeDetailForm">
	<input type="hidden" id="notiId" name="notiId" value="${noticeVO.notiId}" />
		<div class="main_top">
			<h2>전시관리 > 공지사항  관리 > 공지사항 상세 정보</h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">기본정보</div>
			</div>
		</div>
		<!-- e: table top-->
			
		<!-- s: table wrap-->
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
						<th class="last" >제목 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="notiTitle" name = "notiTitle" value="${noticeVO.notiTitle}" class="input w01" readonly/>
						</td>
					</tr>
					<tr>
						<th class="last" >상태<span class="imp">*</span></th>
						<td colspan="" class="last">
							<input  disabled type="radio" name="exposureYn" id="exposureYn" class="" value="Y" /> <label for="exposureYn">사용</label>
							<input  disabled type="radio" name="exposureYn" id="exposureYn" class="" value="N" /> <label for="exposureYn">미사용</label>
						</td>
						<th class="last" >서비스 분류<span class="imp">*</span></th>
						<td id="serviceCategoryArea" colspan="1" class="last">
							<input type="hidden"  maxlength="80"  autocomplete="off" id="serviceCategory" name="serviceCategory" value="AM" />
							AM (After 마켓 서비스)
						</td>
					</tr>
					
					<tr>
						<th class="last" >서비스 노출<span class="imp">*</span></th>
						<td id="serviceExposureArea" colspan="1" class="last">
							<input type="hidden"  maxlength="80"  autocomplete="off" id="serviceExposure" name="serviceExposure" value="A001" />
							APP (매니저앱)
						</td>
						<th class="last" >푸시 알림<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input disabled type="radio" name="pushYn" id="pushYn" class="" value="Y" /> <label for="pushYn">사용</label>&nbsp;&nbsp;
							<input  disabled type="radio" name="pushYn" id="pushYn" class="" value="N" /> <label for="pushYn">미사용</label>
						</td>
					</tr>
					<tr>
						<th class="last" >푸시 알림 시작 일시<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" autocomplete="off" id="pushStartDt" name="pushStartDt"  value ="${noticeVO.pushStartDt}" class="input w01" readonly/>
						</td>
						<th class="last" >푸시 알림 종료 일시<span class="imp">*</span></th>
						<td colspan="1" class="last">
							<input type="text" autocomplete="off" id="pushEndDt" name="pushEndDt" value ="${noticeVO.pushEndDt}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th class="last" >공지 중요도<span class="imp">*</span></th>
						<td id="notiImportanceArea" colspan="3" class="last">
							<input type="text" autocomplete="off" id="notiImportance" name="notiImportance" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr id="notiStartDtArea">
						<th class="last" >공지 노출 일시<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="notiStartDt" name="notiStartDt" value ="${noticeVO.notiStartDt}" class="input w01" readonly/>
						</td>
					</tr>
					<tr id="notiEndDtArea">
						<th class="last" >공지 노출 종료 일시<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="notiEndDt" name="notiEndDt" value ="${noticeVO.notiEndDt}" class="input w01" readonly/>
						</td>
					</tr>
					<tr>
						<th class="last" >내용 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<textarea id="notiCont" name="notiCont" class="input textareabox" style="height:400px" readOnly><c:out value="${noticeVO.notiCont}" /></textarea>
							<!-- <textarea name="notiCont" id="notiCont" class="input textareabox" style="height:400px" readOnly></textarea> -->
							<script>
							
							// Replace the <textarea id="editor1"> with a CKEditor
								// instance, using default configuration.
								///var notiCont = $("#notiCont").val();
								//CKEDITOR.instances.notiCont.setData(notiCont);
								
								CKEDITOR.editorConfig = function( config ) {
									config.enterMode = CKEDITOR.ENTER_BR // pressing the ENTER Key puts the <br/> tag
									config.shiftEnterMode = CKEDITOR.ENTER_P; //pressing the SHIFT + ENTER Keys puts the <p> tag
								};
  							
								CKEDITOR.replace( 'notiCont' ,
								{
									enterMode:'2',
									toolbar: 'Custom', //makes all editors use this toolbar
									toolbarStartupExpanded : false,
									toolbarCanCollapse  : false,
									toolbar_Custom: [] //define an empty array or whatever buttons you want.
								});
								
							
								
								
							</script>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<a href="javascript:noticeEditForm();"><span class="btn large focus">수정</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
