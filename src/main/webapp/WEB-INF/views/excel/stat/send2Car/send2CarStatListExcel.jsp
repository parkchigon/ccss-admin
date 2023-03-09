<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<body>
	<!-- s: body container -->
	<div id="body_container" style="height: 1000px;">
		<!-- s: main content -->
		<div class="main_content">
		
			<div class="main_title">
				<h3 class="tit">서비스 통계 > Send2Car 이력 조회</h3>
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
					<tr>
						<th >기간</th>
						<!-- [Fortify] Cross-Site Scripting: Reflected -->
						<td colspan="3"><c:out value='${startDate}'/> ~ <c:out value='${endDate}'/></td>
					</tr>
					<tr>
						<th >MEMB ID</th>
						<!-- [Fortify] Cross-Site Scripting: Reflected -->
						<td colspan="3"><c:out value='${membId}'/></td>
					</tr>
					<tr>
						<th >사용유무</th>
						<c:choose>
								<c:when test="${useYn eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${useYn}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					
					<tr>
						<th >Device CTN</th>
						<!-- [Fortify] Cross-Site Scripting: Reflected -->
						<td colspan="3"><c:out value='${deviceCtn}'/></td>
					</tr>
					<tr>
						<th >Mgrapp Login Id</th>
						<%-- <td colspan="3">${mgrappLoginId}</td> --%>
						<!-- [Fortify] Cross-Site Scripting: Reflected -->
						<td colspan="3"><c:out value='${mgrappCtn}'/></td>
					</tr>
					<tr>
						<th >서비스 타입</th>
						<c:choose>
								<c:when test="${serviceType eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${serviceType}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th >Push 전송 여부</th>
						<c:choose>
								<c:when test="${sendStatus eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${sendStatus}</td>
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
							<td>Memb Id</td>
							<td>Mgrapp Id</td>
							<td>Mgrapp CTN</td>
							<td>Device CTN</td>
							<td>Send2Car Id</td>
							<td>Scheule Id</td>
							<td>Sevice Type</td>
							<td>Send Staus</td>
							<td>목적지명</td>
							<td>목적지주소</td>
							<td>목적지경도</td>
							<td>목적지위도</td>
							<td>사용유무</td>
							<td>도착희망시간</td>
							<td>예상소요시간</td>
							<td>예약형태</td>
							<td>등록일</td>
							<td>처리서버</td>
						</tr>
						<c:forEach var="item" items="${resultList}" varStatus="i">
							<tr>
								<td>${item.rnum}</td>
								<td style="mso-number-format:'\@'">${item.membId}</td>
								<td style="mso-number-format:'\@'">${item.mgrappId}</td>
								<%-- <td style="mso-number-format:'\@'">${item.mgrappLoginId}</td> --%>
								<td style="mso-number-format:'\@'">${item.mgrappCtn}</td>
								<td style="mso-number-format:'\@'">${item.deviceCtn}</td>
								<td style="mso-number-format:'\@'">${item.sendToCarId}</td>
								<td style="mso-number-format:'\@'">${item.scheduleId}</td>
								
								<td>${item.serviceType}</td>
								<td>${item.sendStatus}</td>
								
								<td>${item.targetNm}</td>
								<td>${item.targetAddress}</td>
								<td>${item.targetLonx}</td>
								<td>${item.targetLaty}</td>
								<c:if test="${item.useYn == 'Y'}" >
									<td>사용</td>
								</c:if>
								<c:if test="${item.useYn !='Y'}" >
									<td>미사용</td>
								</c:if>
								<td>${item.arrivHopeTime}</td> <!--도착 희망  -->
								<td>${item.estTime}</td>
								<td>${item.rsvType}</td>
								<td>${item.regDt}</td>
								<td>${item.hostNm}</td>
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