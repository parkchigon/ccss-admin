<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
var userMngrLevel;
var emailArrValues = ["lguplus.co.kr","nate.com", "naver.com", "daum.net", "gamil.com"];
$(document).ready(function(){
	
	// [Fortify] Cross-Site Scripting: Reflected
	var encMngrId = "<c:out value='${result.mngrId}'/>";
	
	var decMngrID = AES_Decode(encMngrId);
	$("#mngrId").val(decMngrID);
	
	// [Fortify] Cross-Site Scripting: Reflected
	var encMngrNm ="<c:out value='${result.mngrNm}'/>";
	
	
	var decMngrNm = AES_Decode(encMngrNm);
	$("#mngrNm").val(decMngrNm);
	
	// [Fortify] Cross-Site Scripting: Reflected
	var encClphNo='${result.clphNo}'
	var encClphNo="<c:out value='${result.clphNo}'/>";
		
		
	var decClphNo = AES_Decode(encClphNo);
	$("#clphNo").val(decClphNo);
	
	
	
	$("#eamilAddrPostText").empty();
	$("#eamilAddrPostText").hide();
	
	// [Fortify] Cross-Site Scripting: Reflected
	userMngrLevel = "<c:out value='${USER_INFO.mngrLevel}'/>";
	
	$("input:radio[name='useYn']:radio[value='${result.useYn}']").attr("checked",true);
	$("input:radio[name='accountStatus']:radio[value='${result.accountStatus}']").attr("checked",true);
	
	/* [Fortify] Cross-Site Scripting: Reflected */
	var resultMngrLevel = "<c:out value='${result.mngrLevel}'/>";
	if(resultMngrLevel == 'TOP'){
		var html ="<option value='TOP' selected='selected'>최고관리자</option>";
		$("#mngrLevel").empty();
		$("#mngrLevel").append(html);
	}else{
		$("#mngrLevel").val(resultMngrLevel);
	}
	
	// [Fortify] Cross-Site Scripting: Reflected
	var encEmail = "<c:out value='${result.emailAddr}'/>'";
	
	
	var decEmail = AES_Decode(encEmail)
	var emailArr = decEmail.split("@");
	$("#emailAddrPre").val(emailArr[0]);
	
	if(emailArrValues.indexOf(emailArr[1]) <= -1){
		$("#emailAddrPost").val('directly');
		$("#eamilAddrPostText").val(emailArr[1]);
		$("#eamilAddrPostText").show();
	}else{
		$("#emailAddrPost").val(emailArr[1]);
	}
	
	$("#emailAddrPost").change(function() { 
		var emailAddrPostValue = $("#emailAddrPost").val();
		if(emailAddrPostValue =='directly'){
			$("#eamilAddrPostText").empty();
			$("#eamilAddrPostText").show();
		}else{
			$("#eamilAddrPostText").empty();
			$("#eamilAddrPostText").hide();
		}
	});
});

function checkPassword(password){
	
    var check = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9])(?=.*[0-9]).{8,15}$/;
	if (!check.test(password)) {
		  alert("숫자,영문자,특수문자 조합으로 8~15자리를 사용해야 합니다.");
		  return false;
	}
	
    var checkNumber = password.search(/[0-9]/g);
    var checkEnglish = password.search(/[a-z]/ig);
    var checkSc = password.search(/[=+-_`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
    
    if(checkNumber < 0 || checkEnglish < 0 || checkSc < 0) {
        alert("숫자,영문자,특수문자를 혼용하여야 합니다.");
        return false;
    }

	if(/(\w)\1\1/.test(password)) {
        alert("비밀번호에 같은 문자를 3번 이상 사용하실 수 없습니다.");
        return false;
    }
    var id = $.trim($("#mngrId").val());
   
    if(password.indexOf(id) > -1) {
        alert("아이디가 포함된 비밀번호는 사용하실 수 없습니다.");
        return false;
    }
    
    var ctn = $.trim($("#clphNo").val());  
    if(password.indexOf(ctn) > -1) {
        alert("전화번호가 포함된 비밀번호는 사용하실 수 없습니다.");
        return false;
    }
   
   
    return true;
}


function updateAdmin() {
	if (formValidationCheck(['mngrNm', 'clphNo'])){
		if(!isTelNum($("#clphNo").val())){
			$("#clphNo").focus();
			return;
		}
		
		
		var passWd = $("#passWd").val();
		var passWdRe = $("#passWdRe").val();
		
		if(passWd != '' && passWdRe != '') {
			if(passWd != passWdRe) {						//둘다 채워져 있는데 일치하지 않는 경우
				alert("비밀번호가 일치하지 않습니다.");
				return;
			} else {										//둘다 채워져 있고 일치하는 경우(암호화하여 서버로 전송)
				 if(checkPassword(passWd)) {
					$("#passWdEnc").val(AES_Encode($("#passWd").val()));
					$("#passWdEncRe").val(AES_Encode($("#passWdRe").val()));
				} else {
					return;
				} 
			}
		} else { //둘다 비어 있거나, 둘중 하나만 채워져 있거나
			if(passWd != '' || passWdRe != '') {
				//둘중 하나만 채워져 있는 경우
				alert("비밀번호가 일치하지 않습니다.");
				return;
			} else {
				//둘다 비어 있는 경우(처리 안함)
			}
		}
		
		var emailAddrPostValue = $("#emailAddrPost").val();
		if(emailAddrPostValue =='directly'){
			$("#emailAddr").val($("#emailAddrPre").val() + "@" + $("#eamilAddrPostText").val());
			
		}else{
			$("#emailAddr").val($("#emailAddrPre").val() + "@" + $("#emailAddrPost").val() );
		}
		
		$.ajax({
			url : "<c:url value='/admin/updateAdmin.do' />"
			//,data : $('#adminUpdateForm').serialize()
			,data : {
				// [Fortify] Cross-Site Scripting: Reflected
				updId : "<c:out value='${USER_INFO.mngrId}'/>",
				oldMngrLevel : '${result.mngrLevel}',
				emailAddr  : AES_Encode($("#emailAddr").val()),
				mngrId     : AES_Encode($("#mngrId").val()),
				mngrNm     : AES_Encode($("#mngrNm").val()),
				passWd	   : $("#passWdEnc").val(),
				passWdRe   : $("#passWdEncRe").val(),
				mngrLevel  : $("#mngrLevel").val(),
				useYn	   : $(':radio[name="useYn"]:checked').val(),
				accountStatus :$(':radio[name="accountStatus"]:checked').val(),
				ipAddr 		: $("#ipAddr").val(),
				clphNo      : AES_Encode($("#clphNo").val())
			}
			,dataType : 'json'
			,type : "POST"
		}).done(function(data) {
			var result = data.result;
			if(result == "Y") {
				alert("정상적으로 수정이 완료 되었습니다.");
				location.href = "<c:url value='/admin/adminListForm.do' />";
			} else if(result == "EXIST_PW_HIST") {
				alert("이전에 사용했던 비밀번호입니다.");
				return;
			} else if(result == "UPDATE_PW") {
				/* [Fortify] Cross-Site Scripting: Reflected */
				if(result.mngrId == "<c:out value='${USER_INFO.mngrId}'/>") {
					alert("비밀번호가 변경되었습니다.\n재 로그인이 필요합니다.");
					excuteLogout();
				} else {
					alert("비밀번호가 변경되었습니다.");
					location.href = "<c:url value='/admin/adminListForm.do' />";
				}
			} else if(result== "N") {
				alert(data.sayMessage);
			}else {
				alert("수정에 실패하였습니다.");
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

//미입력 항목 alert
function alertMessageSource(elId){
	alert("입력되지 않은 항목이 있습니다.");
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="adminUpdateForm" name="adminUpdateForm" method="POST" action="<c:url value='/admin/updateAdmin.do' />" >
		<!-- [Fortify] Cross-Site Scripting: Reflected -->
		<input type="hidden" id="regId" name="regId" value ="<c:out value='${USER_INFO.mngrId}'/>"/>
		<input type="hidden" id="updId" name="updId" value ="<c:out value='${USER_INFO.mngrId}'/>"/>
		
		<input type="hidden" id="oldMngrLevel" name="oldMngrLevel" value ='${result.mngrLevel}'/>
		<input type="hidden" id="emailAddr" name="emailAddr" />
		<div class="main_top">
			<h2>운영자 수정</h2>
		</div>
		
		<!-- s: table top-->
		<div class="thead_wrap cboth">
			<div class="ltr">
				<div class="tit_table">기본정보</div>
			</div>
			<div class="rtl">
				<div class="table_info01">* 필수입력</div>
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
						<th>운영자 ID<span class="imp"></span></th>
						<td colspan="3" class="last">
							<div class="input_wrap">   
								<input autocomplete="off" type="text" id="mngrId" name="mngrId"  class="input w03" readOnly/>
							</div>
						</td>
					</tr>
					<tr>
						<th>운영자 이름<span class="imp">*</span></th>
						<td>
							<input autocomplete="off" type="text" id="mngrNm" name="mngrNm"   class="input w01"/>
						</td>
						<th>전화 번호<span class="imp">*</span></th>
						<td class="last">
							<input autocomplete="off" type="text" id="clphNo"  name="clphNo" class="input w01"/>
							<!-- <input type="hidden" id="clphNoEnc" name="clphNo" class="input w01"/> -->
						</td>
					</tr>
					<tr>
						<th>비밀번호<span class="imp">*</span></th>
						<td>
							<input autocomplete="off" type="password" id="passWd" class="input w01"/>
							<input type="hidden" id="passWdEnc" name="passWd" class="input w01"/>
						</td>
						<th>비밀번호 확인<span class="imp">*</span></th>
						<td class="last">
							<input autocomplete="off" type="password" id="passWdRe" class="input w01"/>
							<input type="hidden" id="passWdEncRe" name="passWdRe" class="input w01"/>
						</td>
					</tr>
					<tr>
						<th>운영자 권한<span class="imp">*</span></th>
						<td class="last">
							<c:if test="${roleInfo ne null }">
							
							<select id="mngrLevel" name="mngrLevel" class="select w01" style="width:130px;">
								<c:forEach items="${roleInfo.list}" var="list" varStatus="status">
									<c:if test="${list.useYn eq 'Y' }">
										<c:if test="${list.mngrGrpId.toUpperCase() ne 'TOP' }">
											<c:choose>
												<c:when test="${status.index == 0}">
														<option value="${list.mngrGrpId}" selected="selected">${list.grpNm}</option>
												</c:when>
												<c:otherwise>
													<option value="${list.mngrGrpId}">${list.grpNm}</option>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:if>
								</c:forEach>
							</select>
							</c:if>
						</td>
						<th>사용여부<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" name="useYn" id="useY" class="" checked="checked" value="Y" /> <label for="useY">사용</label>&nbsp;&nbsp;
							<input type="radio" name="useYn" id="useN" class="" value="N" /> <label for="useN">미사용</label>
						</td>
						</tr>
						<tr>
						<th>아이피<span class="imp"></span></th>
						<td>
							<input type="text" id="ipAddr" name="ipAddr" value = '${result.ipAddr}' class="input w01"/>
						</td>
						<th>계정상태<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" name="accountStatus" id="accountStatus" class="" checked="checked" value="1" /> <label for="useY">활성화</label>&nbsp;&nbsp;
							<input type="radio" name="accountStatus" id="accountStatus" class="" value="3" /> <label for="useN">비활성화</label>
							<input type="radio" name="accountStatus" id="accountStatus" class="" value="2" /> <label for="useN">계정잠김</label>
							<input type="radio" name="accountStatus" id="accountStatus" class="" value="4" /> <label for="useN">비밀번호잠김</label>
						</td>
					</tr>
					<tr>
						<th>이메일<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" id="emailAddrPre" class="input w01"  style="width: 150px;"/>@
							<select  id="emailAddrPost" name="emailAddrPost" class="select w01"style="width: 130px;">
									<option value="" selected="selected">선택▼</option>
									<option value="lguplus.co.kr">lguplus.co.kr</option>
									<option value="nate.com">nate.com</option>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gamil.com">gamil.com</option>
									<option value="directly">직접입력</option>
							</select>
							<input type="text" autocomplete="off" id="eamilAddrPostText" name="eamilAddrPostText" class="input w01" style="width: 150px;"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:updateAdmin();"><span class="btn large focus">수정</span></a>
			<a href="javascript:history.back();"><span class="btn large">취소</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>