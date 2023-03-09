<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<body>
	<!-- s: body container -->
	<div id="body_container" style="height: 1000px;">
		<!-- s: main content -->
		<div class="main_content">
		
			<div class="main_title">
				<h3 class="tit">사용자 관리 > 사용자 조회</h3>
				<!-- s: location -->
				<div class="location_wrap">
					<p><a href="#">검색 조건</a></p>
				</div>
			</div>
			<!-- s: 테이블 상단 -->
			<table  border="1">
				<colgroup>
					<col width="16%"/>
					<col width="34%"/>
					<col width="16%"/>
					<col width="34%"/>
				</colgroup>
				<tbody>
					<!-- [Fortify] Cross-Site Scripting: Reflected -->
					<tr>
						<th >기간</th>
						<td colspan="3"><c:out value='${startDate}'/> ~ <c:out value='${endDate}'/></td>
					</tr>
					<tr>
						<th >CTN</th>
						<td style="mso-number-format:'\@'"colspan="3"><c:out value='${deviceCtn}'/></td>
					</tr>
					<tr>
						<th >MEMB ID</th>
						<td style="mso-number-format:'\@'" colspan="3"><c:out value='${membId}'/></td>
					</tr>
					<tr>
						<th >MEMB NO(Subs NO)</th>
						<td style="mso-number-format:'\@'" colspan="3"><c:out value='${membNo}'/></td>
					</tr>
					
					<tr>
						<th >가입 상품명</th>
						<c:choose>
								<c:when test="${feeType eq 'ALL'}">
									<td colspan="3">ALL</td>
								</c:when>
								<c:when test="${feeType eq '01'}">
									<td colspan="3">월정액요금제2</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">월정액요금제1</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th>서비스 가입</th>
						<c:choose>
								<c:when test="${newRejoinYn eq 'Y'}">
									<td colspan="3">재가입</td>
								</c:when>
								<c:when test="${newRejoinYn eq 'N'}">
									<td colspan="3">신규가입</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">ALL</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th>이용상태</th>
						<c:choose>
								<c:when test="${useStatus eq 'A'}">
									<td colspan="3">정상</td>
								</c:when>
								<c:when test="${useStatus eq 'S'}">
									<td colspan="3" >일시정지</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">ALL</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<%-- <tr>
						<th>Push</th>
						<td colspan="3">${devicePushConStatus}</td>
					</tr> --%>
				</tbody>
			</table>
			
			<br><br>
			<div class="thead_wrap">
				<div>
					<span>TOTAL : ${totalCount}</span>
				</div> 
			</div>
			<!-- e: 테이블 상단 -->
			<!-- s: table list -->
			<div class="table_list_type01">
				<table cellpadding="0" cellspacing="0"  border="1">
					<tbody>
						<tr>
							<td>NO</td>
							<td>구분</td>
							<td>MEMB NO</td>
							<td>MEMB ID</td>
							<td>가입일</td>
							<td>최근 로그인</td>
							<td>가입 상품</td>
							<td>가입 상품명</td>
							<td>CTN</td>
							<td>이용상태</td>
							<td>Push 연결 상태</td>
							<td>서비스 가입</td>
						</tr>
						<c:forEach var="item" items="${resultList}" varStatus="i">
							<tr>
								<td>${item.rnum}</td>
								<td>${item.useYn}</td>
								<td  style="mso-number-format:'\@'">${item.membNo}</td>
								<td  style="mso-number-format:'\@'">${item.membId}</td>
								<td>${item.joinDt}</td>
								<td>${item.latestLoginDt}</td>
								<td>${item.productNm}</td>
								<c:choose>
									<c:when test="${productExplain eq '01'}">
										<td>월정액요금제2</td>
									</c:when>
									<c:otherwise>
										<td>월정액요금제1</td>
									</c:otherwise>
								</c:choose>
								<td style="mso-number-format:'\@'">${item.deviceCtn}</td>
								<td>${item.useStatus}</td>
								<c:if test="${item.devicePushConStatus == 'Y'}" >
									<td>연결</td>
								</c:if>
								<c:if test="${item.devicePushConStatus == 'N'}" >
									<td>비연결</td>
								</c:if>
								<td>${item.newRejoinYn}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<!-- e: table list -->
		</div>
		<!-- e: body container -->
	</div>
</body>