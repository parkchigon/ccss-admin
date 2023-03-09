<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
var adminRollId;
var updateTargetId;

$(document).ready(function(){
	getAdminRole();
	goSearch(1);
	checkboxClickEventHandler();
});

//미입력 항목 alert
function alertMessageSource(elId){
	//[Fortify] Cross-Site Scripting: Reflected
	alert("<c:out value='비밀번호를 입력하세요.'/>");
}

function confirmPassword() {
	if(formValidationCheck(['passWd'])) {
		
		$.ajax({
			url : "<c:url value='/admin/checkAdminPwd.do' />",
			type : "POST",
			data : {
				 mngrId : $("#mngrId").val(),
				 passWd : AES_Encode($("#passWd").val()),
				 updateTargetId : updateTargetId
			},
			dataType : "json"
		}).done(function (data) {
			if (data.result == "N") {
				alert("본인 인증에 실패 하였습니다");
			} else if (data.result == "Y") {
				$(".dimmed").hide();
				$("#confirmPassWordPopup").hide();
				alert("본인 인증 확인이 완료되었습니다.");
				//location.href=data.redirectURL;
				
				var form = document.createElement("form");
				input = document.createElement("input");
				input1 = document.createElement("input");
				input2 = document.createElement("input");
				form.action =  data.redirectURL;
				form.method = "post"
				input.type = "hidden";
				input1.type = "hidden";
				input2.type = "hidden";
				input.name = "mngrId";
				input1.name = "id";
				input2.name = "pwd";
				input.value = updateTargetId;
				input1.value = data.id;
				input2.value = data.pwd;
				form.appendChild(input);
				form.appendChild(input1);
				form.appendChild(input2);
				document.body.appendChild(form);
				form.submit();

				} else {
					alert("서버 내부 오류");
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
	}

	function goSearch(page) {
		var upLevel = "<c:out value='${USER_INFO.mngrLevel.toUpperCase()}'/>";
		if ($("#searchType").val() == "" && $("#searchValue").val().length > 0) {
			alert("검색 조건을 선택하세요");
		}

		$("#page").val(page);
		$.ajax({
					url : "<c:url value='/admin/selectAdminList.do'/>",
					data : $('#adminSearchForm').serialize(),
					dataType : 'json',
					type : "POST"
		}).done(function(data) {

			if (data.searchType) {
				console.log("sType:", data.searchType);
				$("#searchType").val(data.searchType);
			}
			if (data.searchValue) {
				console.log("searchValue:", data.searchValue);
				$("#searchValue").val(data.searchValue);
			}

			var html = '';
			var list = data.resultList;
			var totalResult = data.totalCount;
			var superAdmin = data.supserAdminVO;

			//Super Admin Area
			html += "<tr>";
			html += "<td class='rowhighlight'></td>";
			html += "<td class='rowhighlight'>"
					+ superAdmin.mngrLevelNm + "</td>";

			if (upLevel == "TOP") {
				html += "	<td class='rowhighlight'><a href='javascript:adminUpdateForm(\""
						+ superAdmin.mngrId
						+ "\");' class='link'>"
						+ superAdmin.mngrNm + "</td>";
			} else {
				if (superAdmin.mngrLevel.toUpperCase() == "TOP") {
					html += "<td class='rowhighlight'>"
							+ superAdmin.mngrNm + "</td>";
				} else {
					html += "	<td class='rowhighlight'><a href='javascript:adminUpdateForm(\""
							+ superAdmin.mngrId
							+ "\");' class='link'>"
							+ superAdmin.mngrNm + "</td>";
				}
			}
			html += "	<td class='rowhighlight'>"
					+ superAdmin.mngrId + "</td>";

			if (superAdmin.lastLoginDt == null
					|| superAdmin.lastLoginDt == "null") {

				html += "	<td class='rowhighlight'>"
						+ "최근 접속 이력 없음" + "</td>";
			} else {
				html += "	<td class='rowhighlight'>"
						+ superAdmin.lastLoginDt + "</td>";
			}
			html += "	<td class='rowhighlight'>"
					+ superAdmin.emailAddr + "</td>";
			html += "	<td class='rowhighlight'>"
					+ superAdmin.clphNo + "</td>";

			if (superAdmin.mngrLevel.toUpperCase() != "TOP"
					&& upLevel == "TOP") {
				var accStatus = superAdmin.accountStatus;
				if (accStatus == "1") {
					html += " <td class='rowhighlight'>"
							+ "활성화" + "</td>";
				} else if (accStatus == "2" || accStatus == "5") {
					html += " <td class='rowhighlight'>"
							+ "계정잠김" + "</td>";
				} else if (accStatus == "3") {
					html += " <td class='rowhighlight'>"
							+ "비활성화" + "</td>";
				} else if (accStatus == "4") {
					html += " <td class='rowhighlight'>"
							+ "비밀번호<br>잠김" + "</td>";
				} else {
					html += "<td class='rowhighlight'></td>";
				}
			} else {
				html += "<td class='rowhighlight'></td>";
			}

			//html += "<td class='rowhighlight'></td>";

			if (superAdmin.mngrLevel.toUpperCase() != "TOP"
					&& upLevel == "TOP") {
				html += "<td class='rowhighlight'><input type='checkbox' value=" +superAdmin.mngrId+" name='adminCheckBox'></td>";
			} else {
				html += "<td class='rowhighlight'></td>";
			}
			html += "</tr>";

			for (var i = 0; i < list.length; i++) {
				html += "<tr>";
				html += "	<td>" + list[i].rnum + "</td>";

				html += "	<td>" + list[i].mngrLevelNm + "</td>";

				if (upLevel == "TOP") {
					html += "	<td><a href='javascript:adminUpdateForm(\""
							+ list[i].mngrId
							+ "\");' class='link'>"
							+ list[i].mngrNm + "</td>";
				} else {
					if (list[i].mngrLevel.toUpperCase() == "TOP") {
						html += '<td>' + list[i].mngrNm
								+ '</td>';
					} else {
						html += "	<td><a href='javascript:adminUpdateForm(\""
								+ list[i].mngrId
								+ "\");' class='link'>"
								+ list[i].mngrNm + "</td>";
					}
				}
				html += "	<td>" + list[i].mngrId + "</td>";

				if (list[i].lastLoginDt == null
						|| list[i].lastLoginDt == "null") {

					html += "	<td>" + "최근 접속 이력 없음" + "</td>";
				} else {
					html += "	<td>" + list[i].lastLoginDt
							+ "</td>";
				}
				html += "	<td>" + list[i].emailAddr + "</td>";
				html += "	<td>" + list[i].clphNo + "</td>";

				if (list[i].mngrLevel.toUpperCase() != "TOP"
						&& (upLevel == "TOP" || upLevel == adminRollId)) {
					var accStatus = list[i].accountStatus;
					if (accStatus == "1") {
						html += " <td>" + "활성화" + "</td>";
					} else if (accStatus == "2"
							|| accStatus == "5") {
						html += " <td>" + "계정잠김" + "</td>";
					} else if (accStatus == "3") {
						html += " <td>" + "비활성화" + "</td>";
					} else if (accStatus == "4") {
						html += " <td>" + "비밀번호<br>잠김"
								+ "</td>";
					} else {
						html += '<td></td>';
					}
				} else {
					html += '<td></td>';
				}

				//html += "<td><a href='javascript:sendTmpPassWd(\""+list[i].mngrId+"\");'><span class='btn btn_w01'>전송</span></a></td>";

				if (list[i].mngrLevel.toUpperCase() != "TOP"
						&& (upLevel == "TOP")
						|| upLevel == adminRollId) {
					html += '<td><input type="checkbox" value="'+list[i].mngrId+'" name="adminCheckBox"></td>';
				} else {
					html += '<td> </td>';
				}
				html += "</tr>";
			}

			$("#paging").empty();
			$("#paging").append(data.paging);
			$("#adminList").empty();
			$("#adminList").append(html);
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
	function adminInsertForm() {

		// [Fortify] Cross-Site Scripting: Reflected
		var userId = "<c:out value='${USER_INFO.mngrId}'/>";
		var mngrLevel = "<c:out value='${USER_INFO.mngrLevel}'/>";
		
		$.ajax({
			url : "<c:url value='/admin/checkAdminRoleId.do' />",
			type : "POST",
			data : {
				 mngrId : userId,
				 mngrLevel : mngrLevel,
				 action : "INSERT"
			
			},
			dataType : "json"
		}).done(function (data) {
			if (data.result == "N") {
				alert("최고 관리자 및 관리자만 신규 Admin 사용자 계정 생성이 가능 합니다.");
			} else if (data.result == "Y") {
				location.href=data.redirectURL;
			} else {
				alert("서버 내부 오류");
			}
		}).error(
				
			function(request, status, error) {
					if (request.status == 401) {
						alert("해당 권한이 없습니다.");
					} else {
						console.log("서버 내부 오류 발생", "code:" + request.status+ "\n" + "message:" + request.responseText+ "\n" + "error:" + error);
						if(request.status ==200){
							location.href = "<c:url value='/login/loginView.do' />";
						}
					}
			});

	}

	// 수정 화면
	function adminUpdateForm(mngrId) {
		// [Fortify] Cross-Site Scripting: Reflected
		var userId = "<c:out value='${USER_INFO.mngrId}'/>";
		var mngrLevel = "<c:out value='${USER_INFO.mngrLevel}'/>";
		
		updateTargetId = mngrId;

		$.ajax({
			url : "<c:url value='/admin/checkAdminRoleId.do' />",
			type : "POST",
			data : {
				mngrId : userId,
				//mngrId : "ose",
				mngrLevel : mngrLevel,
				updateTargetId : updateTargetId,
				action : "UPDATE"
			},
			dataType : "json"
		}).done(function(data) {
			if (data.result == "N") {
				alert(data.sayMessage);
			} else if (data.result == "Y") {
				$("#mngrId").val(data.mngrId);
				$(".dimmed").show();
				$("#confirmPassWordPopup").show();
			} else {
				alert("서버 내부 오류");
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

	function checkboxClickEventHandler() {
		$(document).on(
				"click",
				"input:checkbox",
				function() {
					if ($(this).attr("name") == 'allCheck') {
						if ($(this).is(":checked")) {
							$("input:checkbox[name='adminCheckBox']").attr(
									"checked", true);
						} else {
							$("input:checkbox[name='adminCheckBox']").attr(
									"checked", false);
						}
					}
				});
	}

	function getAdminRole() {
		var upLevel = "<c:out value='${USER_INFO.mngrLevel.toUpperCase()}'/>";
		$.ajax({
			url : "<c:url value='/admin/checkAdminRole.do' />",
			type : "POST",
			data : {},
			dataType : "json"
		}).done(function(data) {
			adminRollId = data.result.mngrGrpId;

			if (upLevel != adminRollId) {
				$("#entrustRole").hide();
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

	function sendTmpPassWd(mngrId) {

		// [Fortify] Cross-Site Scripting: Reflected
		var userId = "<c:out value='${USER_INFO.mngrId}'/>";
		var mngrLevel = "<c:out value='${USER_INFO.mngrLevel}'/>";

		if (mngrLevel == 'TOP' || mngrLevel == adminRollId) {
			if (confirm("정말로 임시 비밀번호를 전송하시겠습니까 ?")) {

				$
						.ajax({
							url : "<c:url value='/admin/sendTmpPassWd.do' />",
							type : "POST",
							data : {
								"mngrId" : mngrId
							},
							dataType : "json"
						})
						.done(
								function(data) {
									var resultCode = data.result;
									if (resultCode == "Y") {
										alert("임시 비밀 번호가 정상적으로 전송되었습니다.");
										//location.reload(true);
									} else if (resultCode == "NU") {
										alert("해당 Admin 사용자 정보가 없습니다.");
									} else if (resultCode == "R") {
										alert("임시 비밀 번호 전송 중 오류가 발생하였습니다.\n 다시 시도 하여 주시기 바랍니다.");
									} else {
										alert("임시 비밀 번호 전송 중 오류가 발생하였습니다.");
									}
								}).error(
								function(request, status, error) {
									//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
									if (request.status == 401) {
										alert("해당 권한이 없습니다.");
									} else {
										console.log("서버 내부 오류 발생", "code:"
												+ request.status + "\n"
												+ "message:"
												+ request.responseText + "\n"
												+ "error:" + error);
										if(request.status ==200){
											location.href = "<c:url value='/login/loginView.do' />";
										}
									}
								});
			}
		} else {
			alert("임시 비밀 번호 전송 권한이 없습니다.");
			return;
		}
	}

	function entrustRole() {
		// [Fortify] Cross-Site Scripting: Reflected
		var userId = "<c:out value='${USER_INFO.mngrId}'/>";
		var mngrLevel = "<c:out value='${USER_INFO.mngrLevel}'/>";
		
		var mngrIdArray = $("input:checkbox[name='adminCheckBox']:checked")
				.map(function() {
					return $(this).val();
				}).get();

		if (mngrIdArray.length == 0) {
			alert("선택 된 사용자가 없습니다.");
			return;
		} else if (mngrIdArray.length > 1) {
			alert("권한 위임은 1명만 가능 합니다.");
			return;
		} else if (userId == mngrIdArray[0]) {
			alert("현재 사용자가 선택 되었습니다.");
			return;
		} else {

		}

		// [Fortify] Cross-Site Scripting: Reflected
		var userId = "<c:out value='${USER_INFO.mngrId}'/>";
		var mngrLevel = "<c:out value='${USER_INFO.mngrLevel}'/>";
			
		updateTargetId = mngrId;

		$.ajax({
					url : "<c:url value='/admin/checkAdminRoleId.do' />",
					type : "POST",
					data : {
						mngrId : userId,
						mngrLevel : mngrLevel,
						action : "ENTRUST"
					},
					dataType : "json"
				})
				.done(
						function(data) {
							if (data.result == "N") {
								alert(data.sayMessage);
							} else if (data.result == "Y") {
								if (confirm("정말로 권한을 위임 하시겠습니까?")) {
									$
											.ajax(
													{
														url : "<c:url value='/admin/entrustRoleAdmin.do' />",
														type : "POST",
														data : {
															mngrIdArray : mngrIdArray
																	.toString(),
															mngrId : data.mngrId
														},
														dataType : "json"
													})
											.done(
													function(data) {
														var resultCode = data.result;
														if (resultCode == "Y") {
															alert("정상적으로 권한이 위임 되었습니다.\n자동 로그아웃 처리 됩니다.");
															excuteLogout();

														} else {
															alert("권한 위임 중 오류가 발생하였습니다.");
														}
													})
											.error(
													function(request, status,
															error) {
														//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
														if (request.status == 401) {
															alert("해당 권한이 없습니다.");
														} else {
															console
																	.log(
																			"서버 내부 오류 발생",
																			"code:"
																					+ request.status
																					+ "\n"
																					+ "message:"
																					+ request.responseText
																					+ "\n"
																					+ "error:"
																					+ error);
															if(request.status ==200){
																location.href = "<c:url value='/login/loginView.do' />";
															}
														}
													});
								}

							} else {
								alert("서버 내부 오류");
							}
						}).error(
						function(request, status, error) {
							if (request.status == 401) {
								alert("해당 권한이 없습니다.");
							} else {
								console.log("서버 내부 오류 발생", "code:"
										+ request.status + "\n" + "message:"
										+ request.responseText + "\n"
										+ "error:" + error);
								if(request.status ==200){
									location.href = "<c:url value='/login/loginView.do' />";
								}
							}
						});

	}

	function deleteAdmin() {
		var mngrIdArray = $("input:checkbox[name='adminCheckBox']:checked")
				.map(function() {
					return $(this).val();
				}).get();
		if (mngrIdArray.length == 0) {
			alert("선택 된 사용자가 없습니다.");
			return;
		}
		// [Fortify] Cross-Site Scripting: Reflected
		var userId = "<c:out value='${USER_INFO.mngrId}'/>";
		var mngrLevel = "<c:out value='${USER_INFO.mngrLevel}'/>";

		$.ajax({
					url : "<c:url value='/admin/checkAdminRoleId.do' />",
					type : "POST",
					data : {
						mngrId : userId,
						mngrLevel : mngrLevel,
						action : "DELETE"
					},
					dataType : "json"
				})
				.done(
						function(data) {
							if (data.result == "N") {
								alert(data.sayMessage);
							} else if (data.result == "Y") {

								if (confirm("정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

									$
											.ajax(
													{
														url : "<c:url value='/admin/deleteAdminAjax.do' />",
														type : "POST",
														data : {
															mngrIdArray : mngrIdArray
																	.toString()
														},
														dataType : "json"
													})
											.done(function(data) {
												var resultCode = data.result;
												if (resultCode == "Y") {
													alert("삭제 되었습니다.");
													location.reload(true);
												} else {
													alert("삭제 중 오류가 발생하였습니다.");
												}

											})
											.error(
													function(request, status,
															error) {
														//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
														if (request.status == 401) {
															alert("해당 권한이 없습니다.");
														} else {
															console
																	.log(
																			"서버 내부 오류 발생",
																			"code:"
																					+ request.status
																					+ "\n"
																					+ "message:"
																					+ request.responseText
																					+ "\n"
																					+ "error:"
																					+ error);
															if(request.status ==200){
																location.href = "<c:url value='/login/loginView.do' />";
															}
														}
													});
								}

							} else {
								alert("서버 내부 오류");
							}
						}).error(
						function(request, status, error) {
							if (request.status == 401) {
								alert("해당 권한이 없습니다.");
							} else {
								console.log("서버 내부 오류 발생", "code:"
										+ request.status + "\n" + "message:"
										+ request.responseText + "\n"
										+ "error:" + error);
								if(request.status ==200){
									location.href = "<c:url value='/login/loginView.do' />";
								}
							}
						});
	}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="adminSearchForm" name="adminSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	
	<div class="main_top">
		<h2>Admin 관리 > 운영자 리스트 조회</h2>
	</div>
	
	
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<div class="tit_table">검색 조건</div>
		</div>
	</div>
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="15%"/>
				<col width="15%"/>
				<col width="*%"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">선택</div></th>
					<td colspan="1">
						<!-- <div class="input_wrap"> -->
							<select id="searchType" name="searchType" class="select w01"style="width: 130px;">
								<option value="" selected="selected">전체</option>
								<option value="CTN">전화번호</option>
								<option value="ID">회원 ID</option>
								<option value="NAME">회원명</option>
							</select> <!-- <input type="text" class="input w02" id="searchValue" name="searchValue" onkeydown="if(event.keyCode==13) goSearch(1);" /> <a href="javascript:goSearch(1);"><span class="btn focus" style="width: 90px;">
								<img src="/admin/resources/common/images/icon_search01.png" alt="" />조회</span></a> -->
					<!-- 	</div> -->
					</td>
					<td colspan="1">
						 <input type="text" class="input w02" id="searchValue" name="searchValue" onkeydown="if(event.keyCode==13) goSearch(1);" /> <a href="javascript:goSearch(1);"><span class="btn focus" style="width: 90px;">
								<img src="/admin/resources/common/images/icon_search01.png" alt="" />조회</span></a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
		<!-- e: table wrap-->
	<!-- e: 검색-->

	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<div class="tit_table">운영자 리스트</div>
		</div>
		<div class="rtl">
			<a id="entrustRole" href="javascript:entrustRole();"><span class="btn btn_w01"> 관리자 권한 위임</span></a>&nbsp;
			<a href="javascript:deleteAdmin();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
	</div>
	<!-- e: table top-->
	
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="*%"/>
				<col width="15%"/>
				<col width="10%"/>
				<!-- <col width="15%"/> -->
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th>No</th>
					<th>권한</th>
					<th>이름</th>
					<th>ID</th>
					<th>최근접속일</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>계정<br>상태</th>
					<!-- <th>비밀번호전송</th> -->
					<th class="last">선택</th>
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
	<div class="thead_wrap cboth">
		<div class="rtl">
			<span class="btn btn_w01"><a href="javascript:adminInsertForm();">새 계정 생성</a></span>
		</div>
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
							<!-- [Fortify] Cross-Site Scripting: Reflected -->
							<input type="text" class="input w01" placeholder="ID" id="mngrId" name="mngrId" onkeydown="if(event.keyCode==13) confirmPassword();" value="<c:out value='${USER_INFO.mngrId}'/>" disabled="disabled"/>
							<input type="password" class="input w01" placeholder="PASSWORD" onkeydown="if(event.keyCode==13) confirmPassword();" id="passWd" name="passWd" style="margin-top: 5px"/>
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




