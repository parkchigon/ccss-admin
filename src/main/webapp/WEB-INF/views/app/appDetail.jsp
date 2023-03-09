<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	$("input, textarea").attr("disabled",true);
	
	var useYn = "${appVO.useYn}";
	var forcedUpdYn = "${appVO.forcedUpdYn}";

	$('input:radio[name=useYn]:input[value=' + useYn + ']').attr("checked", true);
	$('input:radio[name=forcedUpdYn]:input[value=' + forcedUpdYn + ']').attr("checked", true);
	
	
	
	
});

function appEditForm() {
	if(confirm("해당 App 버전을 수정 하시겠습니까?")) {
		var appId = "${appVO.appId}";
		location.href="<c:url value='/app/appEditForm.do?appId="+appId+"'/>";
	}
}

function historyBack(){
		//history.back();
	location.href="<c:url value='/app/appList.do'/>";
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="appDetailForm" name="appDetailForm">
	<input type="hidden" id="appId" name="appId" value="${appVO.appId}" />
		<div class="main_top">
			<h2>전시관리 > App 버전 관리 > App 상세 정보</h2>
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
						<th>구분<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input disabled type="radio" name="useYn" id="useYn" class="" value="Y" /> <label for="useYn">사용</label>&nbsp;&nbsp;
							<input disabled type="radio" name="useYn" id="useYn" class="" value="N" /> <label for="useYn">미사용</label>
						</td>
					</tr>
					<tr>
						<th>OS 타입 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="osType" name="osType" value ="${appVO.osType}" class="input w01" readonly"/>
						</td>
					</tr>
					<tr>
						<th>App 타입 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="appType" name="appType" value ="${appVO.appType}" class="input w01" readonly"/>
						</td>
					</tr>
					<tr>
						<th>App 이름 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="appNm" name="appNm" value ="${appVO.appNm}" class="input w01" readonly"/>
						</td>
					</tr>
					<tr>
						<th>App 버전 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="appVer" name="appVer" value ="${appVO.appVer}" class="input w01" readonly"/>
						</td>
					</tr>
					<tr>
						<th>App 파일명 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="appFileNm" name="appFileNm" value ="${appVO.appFileNm}" class="input w01" readonly"/>
						</td>
					</tr>
					<tr>
						<th>APP 마켓 URL <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="appMarketUrl" name="appMarketUrl" value ="${appVO.appMarketUrl}" class="input w01" readonly"/>
						</td>
					</tr>
					<tr>
						<th>강제 업데이트 유무<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input disabled type="radio" name="forcedUpdYn" id="forcedUpdYn" class="" value="Y" /> <label for="forcedUpdYn">강제</label>&nbsp;&nbsp;
							<input disabled type="radio" name="forcedUpdYn" id="forcedUpdYn" class="" value="N" /> <label for="forcedUpdYn">선택</label>
						</td>
					</tr>
					<tr>
						<th>업데이트 내용 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<textarea id="appCont" name="appCont" class="input textareabox" style="height:200px" readonly><c:out value="${appVO.appCont}" /></textarea>
						</td>
					</tr>
					<tr>
						<th>등록자<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="regId" name="regId" value ="${appVO.regId}" class="input w01" readonly"/>
						</td>
					</tr>
					<tr>
						<th>등록일<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="regDt" name="regDt" value ="${appVO.regDt}" class="input w01" readonly"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<a href="javascript:appEditForm();"><span class="btn large focus">수정</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
