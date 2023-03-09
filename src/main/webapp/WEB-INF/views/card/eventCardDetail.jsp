<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javascript" src="<c:url value="/resources/common/ckeditor/ckeditor.js" />"></script>
<script type="text/javaScript">

$(document).ready(function(){
	
	$("input:radio[name=eventCardType][value=" + '<c:out value="${eventCardVO.eventCardType}"/>' + "]").attr("checked","checked");

	<c:if test="${eventCardVO.eventCardType == '02'}">
		$("#cardIdView").hide();
		$("#promotionImgView").show();
		$("#eventCardUrl").val('<c:out value="${eventCardVO.eventCardUrl}"/>;<c:out value="${eventCardVO.eventCardUrlPm}"/>');
	</c:if>
	<c:if test="${eventCardVO.eventCardType != '02'}">
		$("#cardIdView").show();
		$("#promotionImgView").hide();
		$("#eventCardUrl").val('<c:out value="${eventCardVO.eventCardUrl}"/>');
	</c:if>
	
});


function historyBack(){
		//history.back();
	location.href="<c:url value='/card/eventCardList.do'/>";
}

</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="eventCardDetailForm" name="eventCardDetailForm">
	<input type="hidden" id="eventCardId" name="eventCardId" value="${eventCardVO.eventCardId}" />
		<div class="main_top">
			<h2>카드덱관리 > 이벤트 카드 관리 > 이벤트 카드 상세 정보</h2>
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
						<th class="last">이벤트카드 유형 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="radio" name="eventCardType" value="00" disabled /> 신규서비스
							<input type="radio" style="margin-left:15px" name="eventCardType" value="01" disabled /> 기존서비스
							<input type="radio" style="margin-left:15px" name="eventCardType" value="02" disabled /> 프로모션
						</td>
					</tr>
					<tr>
						<th class="last"><div class="tit_search">노출 시작 일시<span class="imp">*</span></div></th>
						<td colspan="1" class="last">
							<div id="datepicker1_group" class="group">
								<fmt:parseDate value="${eventCardVO.spostDate}" var='spostDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 300px;" id="spostDate" name="spostDate" value="<fmt:formatDate value="${spostDate}" pattern="yyyy-mm-dd"/>" readonly />
								<a class="btn btn-gray"><i class="icon-calendar"></i></a>
				
								<div id="datepicker1" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
								<div class="head">
									<div class="prev"><i class="icon-chevron-left"></i></div>
									<div class="title"></div>
										<div class="next"><i class="icon-chevron-right"></i></div>
				 					</div>
									<table class="body">
									<tr>
									<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
										</tr>
									</table>
								</div>
							</div>
						</td>
						<th  class="last"><div class="tit_search">노출 종료 일시<span class="imp">*</span></div></th>
							<td colspan="1" class="last">
							<div id="datepicker2_group" class="group">
								<fmt:parseDate value="${eventCardVO.epostDate}" var='epostDate' pattern="yyyymmdd"/>
								<input type="text" class="input" style="width: 300px;" id="epostDate" name="epostDate" value="<fmt:formatDate value="${epostDate}" pattern="yyyy-mm-dd"/>" readonly />
								<a class="btn btn-gray"><i class="icon-calendar"></i></a>
				
								<div id="datepicker2" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
								<div class="head">
									<div class="prev"><i class="icon-chevron-left"></i></div>
									<div class="title"></div>
										<div class="next"><i class="icon-chevron-right"></i></div>
				 					</div>
									<table class="body">
									<tr>
									<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
										</tr>
									</table>
								</div>
							</div>
					</tr>
					<tr>
						<th class="last" >URL<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="eventCardUrl" name = "eventCardUrl"   value=""  class="input w01" readonly/>
						</td>
					</tr>
					<tr>
						<th class="last" >카드 이미지<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<img src="${eventCardVO.eventCardUrl}" style='display: inline;'>
						</td>
					</tr>
					<tr id="promotionImgView">
						<th class="last" >프로모션 이미지<span class="imp">*</span></th>
						<td colspan="3" class="last">
							<img src="${eventCardVO.eventCardUrlPm}" style='display: inline;'>
						</td>
					</tr>
					<tr id="cardIdView">
						<th class="last">서비스카드 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text"  autocomplete="off" id="cardNm" name="cardNm" value="${eventCardVO.cardNm}"  class="input w01" style="width: 300px;" readonly/>
							<input type="hidden" name="cardId" id="cardId" value="${eventCardVO.cardId}"/>
						</td>
					</tr>
					<tr>
						<th class="last" >등록자 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="regDt" name = "regDt" value="${eventCardVO.regId}" class="input w01" readonly/>
						</td>
					</tr>
					<tr>
						<th class="last" >등록일 <span class="imp">*</span></th>
						<td colspan="3" class="last">
							<input type="text" autocomplete="off" id="regDt" name = "regDt" value="${eventCardVO.regDt}" class="input w01" readonly/>
						</td>
					</tr>				
				</tbody>
			</table>
		</div>
		<!-- e: table wrap-->
	
	
		<!-- s: 버튼-->
		<div class="btn_wrap02">
			<a href="javascript:historyBack();"><span class="btn large">목록</span></a>
		</div>
		<!-- e: 버튼-->
	</form>
</div>
