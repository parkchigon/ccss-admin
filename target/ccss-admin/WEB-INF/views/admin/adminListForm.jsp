<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
$(document).ready(function(){
	goSearch(1);
	checkboxClickEventHandler();
});

//미입력 항목 alert
function alertMessageSource(elId){
	alert("비밀번호를 입력하세요.");
}
function confirmPassword() {
	if(formValidationCheck(['adminPw'])) {
		var password = $.trim('${USER_INFO.adminPwEnc}');
		if(password == $.trim(AES_Encode($("#adminPw").val()))) {
			alert("본인 인증 확인이 완료되었습니다.");
			$(".dimmed").hide();
			$("#confirmPassWordPopup").hide();
			location.href="<c:url value='/admin/adminUpdateForm.do?adminSeq='/>"+$("#adminSeq").val();
		} else {
			alert("비밀번호가 일치하지 않습니다.");
		}		
	}
}

// 리스트 조회
function goSearch(page) {
	$("#page").val(page);
	$.ajax({
		url :"<c:url value='/admin/selectAdminList.do'/>"
		,data : $('#adminSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
			
		for (var i = 0; i < list.length ; i++) {					
			html += "<tr>";
			if(list[i].adminLevel.toUpperCase() != "TOP" && "${USER_INFO.adminLevel.toUpperCase()}" == "TOP"){
				html += '<td><input type="checkbox" value="'+list[i].adminSeq+'" name="adminCheckBox"></td>';
			}else{
				html += '<td></td>';
			}
			html += "	<td>" + list[i].rnum + "</td>";
			if(list[i].useYn == "Y") {
				html += "<td>사용</td>";
			} else {
				html += "<td>미사용</td>";
			}
			html += "	<td>" + list[i].adminLevelNm + "</td>";
			html += "	<td>" + list[i].adminId + "</td>";
			if("${USER_INFO.adminLevel.toUpperCase()}" == "TOP"){
				html += "	<td><a href='javascript:adminUpdateForm(\"" + list[i].adminSeq + "\");' class='link'>" + list[i].adminName + "</td>";
			}else{
				if(list[i].adminLevel.toUpperCase() == "TOP"){
					html += '<td>'+list[i].adminName+'</td>';
				}else{
					html += "	<td><a href='javascript:adminUpdateForm(\"" + list[i].adminSeq + "\");' class='link'>" + list[i].adminName + "</td>";
				}
			}
			html += "	<td>" + list[i].adminMobileNum + "</td>";
			html += "	<td>" + list[i].joinDate + "</td>";
			html += "	<td>" + list[i].updateDate + "</td>";
			html +="</tr>";
		}

		$("#paging").empty();
		$("#paging").append(data.paging);
		
		$("#adminList").empty();
		$("#adminList").append(html);
		
		$("#totCnt").text(totalResult);
	});
}


// 등록 화면
function adminInsertForm() {
	location.href="<c:url value='/admin/adminInsertForm.do' />";
}

// 수정 화면
function adminUpdateForm(adminSeq) {
	$("#adminSeq").val(adminSeq);
	$(".dimmed").show();
	$("#confirmPassWordPopup").show();
	
}

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='adminCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='adminCheckBox']").attr("checked", false);
			}
		}
	});
}


function deleteAdmin(){
	var adminCheckBoxSeqArray = $("input:checkbox[name='adminCheckBox']:checked").map(function(){return $(this).val();}).get();
	if(adminCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	if(confirm("정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "<c:url value='/admin/deleteAdminAjax.do' />",
			type : "POST",
			data : {
				adminSeqArray : adminCheckBoxSeqArray.toString()
			},
			dataType : "json"
		}).done(function (data) {
			var resultCode = data.resultCode;
			if(resultCode == "1001") {
				alert("삭제 되었습니다.");
				location.reload(true);
			} else {
				alert("삭제 중 오류가 발생하였습니다.");				
			}
		
		}).error(function(data){
			alert("삭제 중 오류가 발생하였습니다.");				
		});
	}
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="adminSearchForm" name="adminSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="adminSeq" name="adminSeq" />
	<div class="main_top">
		<h2>운영자 관리</h2>
	</div>
	
	
	<!-- e: table wrap-->
	<!-- e: 검색-->
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<a href="javascript:deleteAdmin();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:adminInsertForm();">운영자 등록</a></span>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="3%"/>
				<col width="5%"/>
				<col width="10%"/>
				<col width="*"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck" id="allCheck" /></th>
					<th>No</th>
					<th>사용여부</th>
					<th>권한</th>
					<th>ID</th>
					<th>이름</th>
					<th>휴대폰번호</th>
					<th>등록일시</th>
					<th class="last">수정일시</th>
				</tr>
			</thead>
			<tbody id="adminList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>


<body class="jui">
	<!-- s: popup -->
	<div class="dimmed" style="display: none;"></div>
	<div class="popup_container" id="confirmPassWordPopup" style="display: none;">
		<div class="popup_inner w01" style="width: 300px">
			<div class="p_header">
				<h1>사용자 본인 인증 확인</h1>
				<a href="javascript:$('#confirmPassWordPopup').hide(); $('.dimmed').hide();" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
			</div> 
			<div class="p_body">
				<div class="p_content">
					<div class="detail">
						<div class="user">
							<input type="text" class="input w01" placeholder="ID" id="adminId" name="adminId" onkeydown="if(event.keyCode==13) confirmPassword();" value="${USER_INFO.adminId}" disabled="disabled"/>
							<input type="password" class="input w01" placeholder="PASSWORD" onkeydown="if(event.keyCode==13) confirmPassword();" id="adminPw" name="adminPw" style="margin-top: 5px"/>
						</div>
					</div>
					<!-- s: btn -->
					<div class="btn_wrap02" style="padding-top: 10px">
						<span class="btn large focus" onclick="javascript:confirmPassword();">확인</span>
					</div>
					<!-- e: btn -->

				</div>
			</div>
		</div>
	</div>
	<!-- e: popup -->
</body>




