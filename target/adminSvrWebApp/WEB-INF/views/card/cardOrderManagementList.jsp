<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>

<script type="text/javaScript">
var orderTableValueMap = new Map();
var cardInfoMap = new Map();
var cardNmInfoMap = new Map();
var serviceCategoryMap = new Map();

$(document).ready(function(){
	
	selectGrpCodeList("SERVICE_CATEGORY","serviceCategoryButtonArea");	
	
	//default AM Searche
	setServiceCategory("AM");
	
	$( "tr" ).hover(
		function() {
			$( this ).addClass( "rowhighlight" );}, 
		function() {
			$( this ).removeClass( "rowhighlight" );
		}
	);
	
	orderTableDoubleClickEvent();
	
	});
	
	
	function orderTableDoubleClickEvent (){
		$("#orderTable tr").off("dblclick");
		$("#orderTable tr").dblclick(function(event){

			event.preventDefault();
			if(confirm("해당 카드를 제거 하시겠습니까 ?")){
				  var tdArr = new Array();    // 배열 선언
				  var tr = $(this);
				  var td = tr.children();
				  td.each(function(i) {
						tdArr.push(td.eq(i).text());
				  });
				 if(tdArr[3] == 'Y'){
					  alert("고정 카드는 제거 할수 없습니다.")
				 }else{
					 $(this).remove();
					  alert("제거 되었습니다.");
				 }
			}
		});
	}
		
	

	function cardTableDoubleClickEvent (){
		$("#cardTable tr").dblclick(function(){
			if(confirm("해당 카드를 배치 하시겠습니까 ?")){
				var str = ""
				var tdArr = new Array();    // 배열 선언
				// 현재 클릭된 Row(<tr>)
				var tr = $(this);
				var td = tr.children();
				// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
				console.log("클릭한 Row의 모든 데이터 : " + tr.text());
				// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
				td.each(function(i) {
					tdArr.push(td.eq(i).text());
				});
				
				console.log("배열에 담긴 값 : " + tdArr);
				html = "";
				html += "<tr>";
				
				var  orderTableLastTr = $('#orderTable > tbody > tr');
				var orderTableTrtd = orderTableLastTr.children();
				var orderTableTdArr = new Array();    // 배열 선언
				
				orderTableTrtd.each(function(i) {
					if((i % 5) == 0){
						console.log("i count:",i);
						orderTableTdArr.push(orderTableTrtd.eq(i).text());
					}  
				});
				
				//console.log("###0 orderTableTdArr:",orderTableTdArr);
				var orderTableLastTr = $('#orderTable > tbody > tr:last');
				var orderTableLastTrtd = orderTableLastTr.children();
				var orderTableLastTdArr = new Array();    // 배열 선언
				console.log("클릭한 Row의 모든 데이터 : " + orderTableLastTrtd.text());
				
				// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
				orderTableLastTrtd.each(function(i) {
					orderTableLastTdArr.push(orderTableLastTrtd.eq(i).text());
				});
				
				//포함 여부 확인(card Nm)
				console.log("###orderTableTdArr:",orderTableTdArr);
				if(orderTableTdArr.includes(tdArr[1])){
					alert("해당 카드는 이미 포함 되어 있습니다.");
				}else{
					
					console.log("배열에 담긴 값 : " + orderTableTdArr);
					var cardSortNum=0;
					for(var i=1; i<=orderTableTdArr.length; i++){
						
						if(orderTableTdArr.includes(i.toString())){
							console.log("I:",i);
							continue;
						}else{
							cardSortNum =i;
							break;
						}
					}
					console.log("orderTableTdArr.length",orderTableTdArr.length);
					console.log("cardSortNum",cardSortNum);
					//if(cardSortNum == orderTableTdArr[orderTableTdArr.length-1]){
					if(cardSortNum == 0){	
						alert("최대 고정 카드 갯수가 초과 되었습니다.");
					}else{
						console.log("%%%%%%:cardNmInfoMap",cardNmInfoMap);
						html += "	<td>" + cardSortNum + "</td>";
						html += "	<td>" + tdArr[1] + "</td>"; //카드명
						html += "	<td>" + cardNmInfoMap.get(tdArr[1])+ "</td>"; //카드 ID
						html += "	<td>N</td>"; //고정 여부
						html += "<td><span class='btn small focus' onclick='moveUp(this)'>▲</span><span class='btn small' onclick='moveDown(this)'>▼</span></td>";
						html += "</tr>";
						
						//마지막 tr 영역 앞에 해당 카드 append
						$('#cardOrderList').find('tr:last').prev().after(html);
						
						$( "tr" ).hover(
								function() {
								$( this ).addClass( "rowhighlight" );
								}, function() {
								$( this ).removeClass( "rowhighlight" );
						});
						alert(tdArr[1]+ " 카드를 포함 시켰습니다..");	
					}
					
				}
			}
			orderTableDoubleClickEvent();
		});
	}
	
	
	function setServiceCategory(serviceCategory){
		$("#exposureYn").val("N");
		$("#serviceCategory").val(serviceCategory);
		$("#serviceTypeFlag").empty();
		$("#serviceTypeFlag").append("(" + serviceCategory +")");
		$("#serviceTypeOrderFlag").empty();
		$("#serviceTypeOrderFlag").append("(" + serviceCategory +")");
		
		
		goSearch(1);
		goCardOrderSearch();
		selectLastModiInfo();
	}
		
	function selectGrpCodeList(grpCodeNm,grpCodeListAreaId){
		$.ajax({
			url : "<c:url value='/system/code/selectDtlCodeList.do' />",
			type : "POST",
			data : {
				"grpCdNm" : grpCodeNm
			},
			async: false,
			dataType : "json"
		}).done(function (data) {
			
			var list = data.resultList;
			//var html ="<input type='radio' name='serviceCategory' id='serviceCategory'  value='ALL'/> <label for='serviceCategory'>전체</label>&nbsp;&nbsp;";
			var html ="";
			for (var i = 0; i < list.length ; i++) {	
				if(grpCodeNm =='SERVICE_CATEGORY'){
					if(list[i].cdVal !="ALL"){
						serviceCategoryMap.put(list[i].cdVal,list[i].dtlCdNm);
						//html += "<option value="+list[i].cdVal+">"+ list[i].dtlCdNm + " (" + list[i].codeDesc + ")" +"</option>";
						html += "<span class='btn btn_w01'><a href='javascript:setServiceCategory(\"" + list[i].cdVal+ "\");' class='link'>" + list[i].dtlCdNm +"</a></span>"; 
					}    
				}else{
					//Nothing
				}
			}
			$("#"+ grpCodeListAreaId).empty();
			$("#"+ grpCodeListAreaId).append(html);
			
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
	
	// 리스트 조회
	function goSearch(page) {
		
		$("#page").val(page);
		//$("#exposureYn").val("N");
		$.ajax({
			url : "<c:url value='/card/selectCardList.do'/>",
			data : $('#cardSearchForm').serialize(),
			dataType : 'json',
			async : false,
			type : "POST"
		}).done(function(data) {

			var html = '';
			var list = data.resultList;

			if (list.length == 0) {
				html += "	<tr><th colspan='2'>조회된 결과가 없습니다.</td></tr>";
			} else {
				for (var i = 0; i < list.length; i++) {
					html += "<tr>";
					html += "	<td title='더블 클릭시 카드 배치 가능'>" + list[i].rnum + "</td>";
					html += "	<td title='더블 클릭시 카드 배치 가능'>" + list[i].cardNm + "</td>"; //제목
					html += "</tr>";
					
					cardInfoMap.put(list[i].cardId,list[i].cardNm);
					cardNmInfoMap.put(list[i].cardNm,list[i].cardId);
				}
			}
			$("#paging").empty();
			$("#paging").append(data.paging);
			$("#cardList").empty();
			$("#cardList").append(html);
			
			cardTableDoubleClickEvent();
			
			$( "tr" ).hover(
					function() {
					$( this ).addClass( "rowhighlight" );
					}, function() {
					$( this ).removeClass( "rowhighlight" );
			});
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

	//리스트 조회
	function goCardOrderSearch() {
		$("#exposureYn").val("Y");
		$.ajax({
			url : "<c:url value='/card/selectCardOrderList.do'/>",
			data : $('#cardSearchForm').serialize(),
			dataType : 'json',
			async : false,
			type : "POST"
		}).done(
		function(data) {

			var html = '';
			var list = data.resultList;

			if (list.length == 0) {
				html += "	<tr><th colspan='5'>조회된 결과가 없습니다.</td></tr>";
			} else {
				for (var i = 0; i < list.length; i++) {
					
					//orderTableValueMap.put(list[i].cardNm,list[i].cardSortNum);
					
					orderTableValueMap = new Map();
					orderTableValueMap.put(list[i].cardId,list[i].cardSortNum);
					
					html += "<tr title='더블 클릭시 카드 제거 가능'>";
					html += "	<td>" + list[i].cardSortNum
							+ "</td>";
					html += "	<td>" + list[i].cardNm + "</td>"; 
					html += "	<td>" + list[i].cardId + "</td>"; 
					var fixYn = list[i].fixYn;
					html += "	<td>" + list[i].fixYn + "</td>"; 
					if (fixYn == "N") {
						html += "<td><span class='btn small focus' onclick='moveUp(this)'>▲</span><span class='btn small' onclick='moveDown(this)'>▼</span></td>";
					} else {
						html += "<td></td>";
					}
					html += "</tr>";
				}
			}

			$("#cardOrderList").empty();
			$("#cardOrderList").append(html);
			
			//orderTableDoubleClickEvent();
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
	
	//리스트 조회
	function selectLastModiInfo() {
		
		$.ajax({
			url : "<c:url value='/card/selectLastModiInfo.do'/>",
			dataType : 'json',
			async : false,
			type : "POST"
		}).done(
		function(data) {

			var html = '';
			var lastUpdateInfo = data.lastUpdateInfo;

			if (lastUpdateInfo.mngrId !=null && lastUpdateInfo.mngrId.length > 0) {
				html += "	<div>최종 수정자 " + lastUpdateInfo.regDt  +" " + lastUpdateInfo.grpNm + " " + lastUpdateInfo.mngrId + " 수정</div>";
			} else {
				html += "	<div>수정 정보 없음</div>";
			}
			
			$("#modiInfoArea").empty();
			$("#modiInfoArea").append(html);

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
	
	
	//검색 조건 초기화
	function resetCardOrder() {
		if(confirm("서비스 카드를 배치를 초기화 하시겠습니까 ?")){
			goCardOrderSearch();
		}
	}
	
	//카드 순서 업데이트
	function updateCardOrder(){
		if(confirm("서비스 카드를 배치를 저장 하시겠습니까 ?")){
			var updateCardOrderTr =  $('#orderTable > tbody > tr');
			
			var updateCardOrderTrtd = updateCardOrderTr.children();
			  updateCardOrderTrtd.each(function(i) {
				if((i % 5) == 0){
					console.log("i count:",i);
					console.log("i updateCardOrderTrtd.eq(i+1).text():",updateCardOrderTrtd.eq(i+1).text());
					orderTableValueMap.put(updateCardOrderTrtd.eq(i+2).text(), updateCardOrderTrtd.eq(i).text());
				}  
			});
			 
			
			console.log("orderTableValueMap:",orderTableValueMap);
			console.log("orderTableValueMap toString:",orderTableValueMap.values().toString());
			
			console.log("orderTableValueMap keys:",orderTableValueMap.keys());
			console.log("orderTableValueMap toString:",orderTableValueMap.values().toString()); 
		
			$.ajax({
					url : "<c:url value='/card/updateCardOrder.do'/>",
					data :  { 
							//cardOrderListMap :  orderTableValueMap.values().toString(),
							cardOrderKeyList :  orderTableValueMap.keys().toString(),
							cardOrderValueList :  orderTableValueMap.values().toString(),
							serviceCategory : $("#serviceCategory").val()
					},
					dataType : 'json',
					
					type : "POST"
				}).done(function(data) {

					var result = data.result;
					if(result == 'Y'){ 
						alert(" 서비스 카드 순서 배치 정보가 수정 되었습니다.");
						location.href="<c:url value='/card/cardOrderManagementList.do' />";
					}else{
						alert("서비스 카드 순서 배치 수정에 실패하였습니다.");
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

	function moveUp(el) {
		var $tr = $(el).parent().parent(); // 클릭한 버튼이 속한 tr 요소
		
		if ($tr.index() != 0 &&  $tr.index() != 1) {
			$tr.find("td:eq(0)").text($tr.prev().before().index()+1);
			var $prevTr = $tr.prev();
			$prevTr.find("td:eq(0)").text($tr.prev().before().index()+2);
			$tr.prev().before($tr); // 현재 tr 의 이전 tr 앞에 선택한 tr 넣기	
		}
	}

	function moveDown(el) {
		var $tr = $(el).parent().parent(); // 클릭한 버튼이 속한 tr 요소
		
		//OSE
		if ($tr.index() < $("#orderTable tr").length - 3) {
			var $nextTr = $tr.next();
			$tr.next().after($tr); // 현재 tr 의 다음 tr 뒤에 선택한 tr 넣기
			$tr.find("td:eq(0)").text($tr.next().after().index());
			
			$nextTr.find("td:eq(0)").text($tr.next().after().index() -1);
			
		}
	}
	
	
</script>
<form id="cardSearchForm" name="cardSearchForm" method="POST" >
	<input type="hidden" id="page" name="page" />
	<input type="hidden" id="pageRowCount"        name="pageRowCount"       value="20"/>
	<input type="hidden" id="exposureYn"          name="exposureYn"       value=""/>
	<input type="hidden" id="serviceCategory"          name="serviceCategory"       value=""/>
</form>
<!-- 내용-->
<div class="contents_wrap">
	<div class="main_top">
		<h2>카드덱 관리 > 서비스 배치 관리</h2>
	</div>
	<div class="tree_wrap cboth">
		<div class="ltr tree_box">
			<div class="tree_inner">
				<!-- s: table wrap-->
				<div class="main_top" align='center'>
					<h2>서비스 카드 리스트<h2 id="serviceTypeFlag"></h2></h2>
				</div>
				<div class="thead_wrap cboth">
					<div id="serviceCategoryButtonArea" class="lrt">
						
					</div>
				</div>
				<div class="table_wrap">
					<table id="cardTable" cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
						<colgroup>
							<col width="20%"/>
							<col width="*%"/>
						</colgroup>
						<thead>
							<tr>
								<th>No</th>
								<th>카드명</th>
							</tr>
						</thead>
						<tbody id="cardList">
						</tbody>
					</table>
				</div>
				<!-- e: table wrap-->
				
				<!-- s: 페이징 -->
				<div id="paging" class="paging">
				</div>
				<!-- e: 페이징 -->	
			</div>
		</div>
		<!--버튼 영역 -->
		<div class="rtl tree_box">
			<!-- s: table wrap-->
			<div class="table_wrap">
				<div class="main_top" align='center'>
					<h2>서비스 카드 순서 배치<h2 id="serviceTypeOrderFlag"></h2></h2>
				</div>
				<table  id="orderTable" cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="25%"/>
						<col width="15%"/>
						<col width="10%"/>
					</colgroup>
					<thead>
						<tr>
							<th>카드순서</th>
							<th>카드명</th>
							<th>카드ID</th>
							<th>고정여부</th>
							<th class="last"></th>
						</tr>
					</thead>
					<tbody id="cardOrderList"> 
					</tbody>
				</table>
			</div>
			<!-- e: table wrap-->
			<!-- s: btn wrap 양쪽 정렬-->
			<div class="thead_wrap cboth">
				<div class="rtl">
					<span class="btn btn_w01"><a href="javascript:resetCardOrder();">초기화</a></span>
					<span class="btn btn_w01"><a href="javascript:updateCardOrder();">저장하기</a></span>
				</div>
			</div>
			<div class="thead_wrap cboth">
				<div id = "modiInfoArea" class="rtl">
					
					
				</div>
			</div>
			<!-- e: btn wrap-->
		</div>
	</div>
</div>
