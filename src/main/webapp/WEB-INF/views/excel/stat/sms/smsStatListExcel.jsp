<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<body>
	<!-- s: body container -->
	<div id="body_container" style="height: 1000px;">
		<!-- s: main content -->
		<div class="main_content">
		
			<div class="main_title">
				<h3 class="tit">서비스 통계 > SMS 전송 이력 조회</h3>
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
						<th >수신번호</th>
						<td colspan="3"><c:out value='${reqCtn}'/></td>
					</tr>
					<tr>
						<th >MSG ID</th>
						<td colspan="3"><c:out value='${membId}'/></td>
					</tr>
					<tr>
						<th>처리 상태</th>
						<c:choose>
								<c:when test="${msgStatus eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${msgStatus}</td>
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
							<td>MSG ID</td>
							<td>처리<br>상태</td>
							<td>제목</td>
							<td>내용</td>
							<!-- <td>메세지타입</th> -->
							<td>수신자</th>
							<!-- <td>전송타입</th> -->
							<td>전송시간</th>
							<!-- <td>발신번호</th> -->
							<td>재전송<br>횟수</th>
							<td>등록일</th>
							<td>서버</th>
						</tr>
						<c:forEach var="item" items="${resultList}" varStatus="i">
							<tr>
								<td>${item.rnum}</td>
								<td>${item.msgId}</td>
								<td>${item.msgStatus}</td>
								<td>${item.msgTitle}</td>
								<td>${item.msgCont}</td>
								<%-- <td>${item.msgType}</td> --%>
								<td style="mso-number-format:'\@'">${item.recvPhoneNo}</td>
								<%-- <td>${item.sendType}</td> --%>
								<td>${item.sendDt}</td>
								<%-- <td>${item.orgNo}</td> --%>
								<td style="mso-number-format:'\@'">${item.sendTryCnt}</td>
								<td>${item.regDt}</td>
								<td>${item.wasInfo}</td>
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