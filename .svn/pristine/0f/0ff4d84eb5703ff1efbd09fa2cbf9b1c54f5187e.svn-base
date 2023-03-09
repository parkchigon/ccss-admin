<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<body>
	<!-- s: body container -->
	<div id="body_container" style="height: 1000px;">
		<!-- s: main content -->
		<div class="main_content">
		
			<div class="main_title">
				<h3 class="tit">서비스 통계 > 통합 서비스 통계 조회</h3>
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
						<th >추출 기간</th>
						<c:choose>
								<c:when test="${serviceStatVO.searchType eq 'day'}">
									<td colspan="3">${serviceStatVO.startDate} ~ ${serviceStatVO.endDate}</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${serviceStatVO.startDateHour}  ~ ${serviceStatVO.endDateHour}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					 <tr>
						<th >서비스 구분</th>
						<c:choose>
								<c:when test="${serviceStatVO.svcType eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${serviceStatVO.svcType}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th >가입 상태 구분</th>
						<c:choose>
								<c:when test="${serviceStatVO.joinStatus eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${serviceStatVO.joinStatus}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th >성별</th>
						<c:choose>
								<c:when test="${serviceStatVO.gender eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${serviceStatVO.gender}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th >연령대</th>
						<c:choose>
								<c:when test="${serviceStatVO.age eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${serviceStatVO.age}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th >가입상품명</th>
						<c:choose>
								<c:when test="${serviceStatVO.product eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${serviceStatVO.product}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th >선택1.서비스</th>
						<c:choose>
								<c:when test="${serviceStatVO.statSvc eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${serviceStatVO.statSvc}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th >선택2.APP</th>
						<c:choose>
								<c:when test="${serviceStatVO.statApp eq 'ALL'}">
									<td colspan="3">전체</td>
								</c:when>
								<c:otherwise>
									<td colspan="3">${serviceStatVO.statApp}</td>
								</c:otherwise>
						</c:choose>
					</tr>
					<tr>
						<th >선택3.통계명(통)</th>
							<td colspan="3">
							<c:forEach var="item" items="${serviceStatVO.statCat1List}" varStatus="i">
								${item}<br>
							</c:forEach>
							</td>
						<!--statCat1List  -->
						
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
							<td>기간</td>
							<td>서비스<br>구분</td>
							<td>가입상품명<br>Type</td>
							<td>가입상태</td>
							<td>성별</td>
							<td>연령</td>
							<td>서비스</td>
							<td>App</td>
							<td>통계명</td>
							<td>상세</td>
							<td>Count</td>
						</tr>
						<c:forEach var="item" items="${resultList}" varStatus="i">
							<tr>
								<td>${item.rnum}</td>
								<td>${item.statDt}</td>
								<td>${item.svcType}</td>
								<td>${item.product}</td>
								<td>${item.joinStatus}</td>
								<td>${item.gender}</td>
								<td>${item.age}</td>
								<td>${item.statSvc}</td>
								<td>${item.statApp}</td>
								<td>${item.statCat1}</td>
								<td>${item.statItem}</td>
								<td>${item.statVal}</td>
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