<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- s: popup -->
<div class="popup_container" id="userInfoPopup" style="display: none;">
	<div class="popup_inner w01"><!-- w01: 가로사이즈 660px, w02: 가로사이즈 440px,-->
		<div class="p_header">
			<h1>사용자 상세 정보</h1>
			<a href="javascript:closeLayerPopup($('#userInfoPopup'));" class="btn_close"><span class="hidden_obj">팝업닫기</span></a>
		</div> 
		<div class="p_body">
			<div class="p_content">

				<!-- s: table top-->
				<div class="thead_wrap cboth">
					<div class="ltr">
						<span id="userCtn"></span>님 상세 정보입니다.
					</div>
				</div>
				<!-- e: table top-->
				
				<!-- s: table wrap-->				
				<div class="table_wrap">
					<table class="table simple table_write_type">
						<colgroup>
							<col width="25%"/>
							<col width="75%"/>
						</colgroup>
						<tbody>
							<tr>
								<th>히든앱 버전정보</th>
								<td>
									<span id="haVer"></span>
								</td>
							</tr>
							<tr>
								<th>Android OS 버전정보</th>
								<td>
									<span id="osInfo"></span>
								</td>
							</tr>
							<tr>
								<th>단말기 모델명</th>
								<td>
									<span id="model"></span>
								</td>
							</tr>
							<tr>
								<th>네트워크 정보</th>
								<td>
									<span id="nwInfo"></span>
								</td>
							</tr>
							<tr>
								<th>푸시 키 등록시간</th>
								<td>
									<span id="pushRegDate"></span>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- e: table wrap-->
			
				<!-- s: btn -->
				<div class="btn_wrap02">
					<span class="btn large" onclick="closeLayerPopup($('#userInfoPopup'));">확인</span>
				</div>
				<!-- e: btn -->
			</div>
		</div>
	</div>
</div>
<!-- e: popup -->