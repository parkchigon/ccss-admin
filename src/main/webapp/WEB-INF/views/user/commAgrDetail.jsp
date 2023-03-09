<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">

$(document).ready(function(){
	
	var agrYn =  "${commAgrVO.agrYn}";
	$('input:radio[name=agrYn]:input[value=' + agrYn + ']').attr("checked", true);

});

function commAgrEditForm() {
	if(confirm("해당 데이터 약관 정보를 수정 하시겠습니까?")) {
		var commAgrSeq = "${commAgrVO.commAgrSeq}";
		location.href="<c:url value='/user/editCommAgrForm.do?commAgrSeq="+commAgrSeq+"'/>";
	}
}

function historyBack(){
		//history.back();
	location.href="<c:url value='/user/commAgrManagement.do'/>";
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="commAgrDetailForm" name="commAgrDetailForm">
	<input type="hidden" id="commAgrSeq" name="commAgrSeq" value="${commAgrVO.commAgrSeq}" />
		<div class="main_top">
			<h2>사용자 관리 > AM 데이터 약관 정보 관리 > AM 데이터 약관 상세 정보</h2>
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
						<th>DEVICE_CTN <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="deviceCtn" name="deviceCtn" value ="${commAgrVO.deviceCtn}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th>UICCID <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="uiccid" name="uiccid" value ="${commAgrVO.uiccid}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th>TERMS_NO <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="termsNo" name="termsNo" value ="${commAgrVO.termsNo}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th>TERMS_AUTH_NO <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="termsAuthNo" name="termsAuthNo" value ="${commAgrVO.termsAuthNo}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th>AGR_YN<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input disabled type="radio" name="agrYn" id="agrYn" class="" value="Y" /> <label for="agrYn">등록</label>&nbsp;&nbsp;
							<input disabled type="radio" name="agrYn" id="agrYn" class="" value="N" /> <label for="agrYn">미등록</label>
						</td>
					</tr>
					
					
					<tr>
						<th>VALID_START_DT <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="validStartDt" name="validStartDt" value ="${commAgrVO.validStartDt}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th>VALID_END_DT <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="validEndDt" name="validEndDt" value ="${commAgrVO.validEndDt}" class="input w01" readonly/>
						</td>
					</tr>
					
					
					
					<tr>
						<th>ITEM_SN</th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="itemSn" name="itemSn" value ="${commAgrVO.itemSn}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th>USIM_MODEL_NM</th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="usimModelNm" name="usimModelNm" value ="${commAgrVO.usimModelNm}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th>NAVI_SN</th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="naviSn" name="naviSn" value ="${commAgrVO.naviSn}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th>등록자 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="regId" name="regId" value ="${commAgrVO.regId}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th>등록일 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="regDt" name="regDt" value ="${commAgrVO.regDt}" class="input w01" readonly/>
						</td>
					</tr>
					
					
					<tr>
						<th>수정자 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="updId" name="updId" value ="${commAgrVO.updId}" class="input w01" readonly/>
						</td>
					</tr>
					
					<tr>
						<th>수정일 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="updDt" name="updDt" value ="${commAgrVO.updDt}" class="input w01" readonly/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
			<a href="javascript:commAgrEditForm();"><span class="btn large focus">수정</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
