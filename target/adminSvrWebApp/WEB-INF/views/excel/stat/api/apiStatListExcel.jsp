<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<body>
	<!-- s: body container -->
	<div id="body_container" style="height: 1000px;">
		<!-- s: main content -->
		<div class="main_content">
		
			<div class="main_title">
				<h3 class="tit">서비스 통계 > API 이력 조회</h3>
				<!-- s: location -->
				<div class="location_wrap">
					<p><a href="#">검색 조건</a></p>
				</div>
			</div>
			<!-- s: 테이블 상단 -->
			<table class="table simple table_write_type" border="1">
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
						<td colspan="3"><c:out value='${reqCtn}'/></td>
					</tr>
					<tr>
						<th >MEMB ID</th>
						<td colspan="3"><c:out value='${membId}'/></td>
					</tr>
					<tr>
						<th >MEMB NO</th>
						<td colspan="3"><c:out value='${membId}'/></td>
					</tr>
					
					
					<tr>
						<th >API 이름</th>
						<c:choose>
								<c:when test="${apiNm eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${apiNm}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th >Device Type</th>
						<c:choose>
								<c:when test="${deviceType eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${deviceType}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th>처리 결과</th>
						<c:choose>
								<c:when test="${resultStatus eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:when test="${resultStatus eq '2S000000'}">
									<td colspan="3">성공</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">실패</td>
								</c:otherwise>
						</c:choose>
					</tr>
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
			<div class="table_list_type01" >
				<table cellpadding="0" cellspacing="0" border="1">
					<tbody>
						<tr>
							<td>No</td>
							<td>사용자 ID</td>
							<td>사용자 No</td>
							<td>APP Type</td>
							<td>CTN</td>
							<td>Device Type</td>
							<td>세션 ID</td>
							<td>API 이름</td>
							<td>API 설명</td>
							<td>결과 코드</td>
							<td>요청시각</td>
							<td>처리 시간(ms)</td>
							<td>서버</td>
						</tr>
						<c:forEach var="item" items="${resultList}" varStatus="i">
							<tr>
								<td>${item.rnum}</td>
								<td style="mso-number-format:'\@'">${item.membId}</td>
								<td style="mso-number-format:'\@'">${item.membNo}</td>
								<td>${item.reqAppType}</td>
								<td style="mso-number-format:'\@'">${item.reqCtn}</td>
								<td>${item.deviceType}</td>
								<td>${item.sessionId}</td>
								<td>${item.apiNm}</td>
								<td>${item.apiDesc}</td>
								<td>${item.resultStatus}</td>
								<td>${item.processDt}</td>
								<td>${item.elapsedTime}</td>
								<td>${item.wasInfo}</td>
								<%-- <c:if test="${item.resultStatus == '2S000000'}" >
									<td>성공</td>
								</c:if>
								<c:if test="${item.pushConnectionYn != '2S000000'}" >
									<td>실패</td>
								</c:if> --%>
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