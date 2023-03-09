<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
$(document).ready(function(){
	// 데이터 피커 생성
	compareDatePicker({
		startDatePickerGroupId: "datepicker1_group",
		startDatePickerId: "datepicker1",
		endDatePickerGroupId: "datepicker2_group",
		endDatePickerId: "datepicker2",
	});
	
	goSearch(1,"Y");

	checkboxClickEventHandler();
});

// 리스트 조회
function goSearch(page, fixYn) {
	if(isEmpty(page)){
		page = $("#page").val();
	}
	if(isEmpty(fixYn)){
		fixYn = "N";
	}
	$("#fixYn").val(fixYn);
	$("#page").val(page);
	if(fixYn=="Y"){
		$("#page").val("1");
	}
	$.ajax({
		url : "<c:url value='/board/noticeListAjax.do'/>"
		,data : $('#noticeSearchForm').serialize()
		,dataType : 'json'
		,type : "POST"
	}).done(function(data) {
		var html = '';
		var list = data.resultList;
		var totalResult = data.totalCount;
		console.log(totalResult+"/"+fixYn);
		if(totalResult > 0) {
			
			var gridList = new Array();
			var tableList = new Array();
			var count = list[0].rnum;
			for(var i=0; i<list.length;i++){
				if(list[i].dndColor == "imp" && list[i].opt3 == "Y"){
					list[i].rnum = count;
					gridList.push(list[i]);
					count++;
				}else{
					tableList.push(list[i]);
					
				}
				
			}
			if(fixYn == "Y"){
				$("#noticeList1").empty();
				jui.ready([ "grid.table" ], function(table) {
				    moveTable1 = table("#moveTable1", {
				        fields: [ "rnum" ,"title" ,"boardId" ,"opt3" ,"strUseYn" , "postDate" , "insertDate", "dndColor","updateDate"],
				        data: gridList,
				        moveRow: true,
				        event: {
				            move: function(row, e) {
				            	console.log(row.data.dndColor);
				            	console.log(e);
				            	if(isNotEmpty(row.data.dndColor)){
				            		return true;
				            	}else{
				            		return false;
				            	}
				            },
				            moveend: function(row, e) {
				                console.log("Completed.");
				            }
				        }
				    });
				});
				
			}else{
				$("#noticeList2").empty();
			}
			
			for(var i=0; i<tableList.length;i++){
				html += '<tr>';
				html += '<td><input type="checkbox" value="'+list[i].boardId+'" name="boardCheckBox2"></td>';
				html += '<td>'+count+'</td>'; 
				html += '<td class="left"><a href="javascript:noticeDetail(\''+tableList[i].boardId+'\');" class="link">'+tableList[i].title+'</a></td>'; 
				html += '<td>'+tableList[i].opt3+'</td>'; 
				html += '<td>'+tableList[i].strUseYn+'</td>'; 
				html += '<td>'+tableList[i].postDate+'</td>'; 
				html += '<td>'+tableList[i].insertDate+'</td>'; 
				html += '<td>'+tableList[i].updateDate+'</td>'; 
				html += '</tr>';
				count++;
			}
		} else {
			if(fixYn == "Y"){
				$("#noticeList1").empty();
			}else{
				$("#noticeList2").empty();
			}
			
			html += "<tr>"
			html += "	<td colspan='8'> 검색조건에 부합되는 데이터가 없습니다.</td>";
			html += "</tr>"
		}
		

		$("#paging").empty();
		$("#paging").append(data.paging);
		
		if(fixYn == "Y"){
			$("#noticeList1").append(html);
			goSearch(page, "N");
		} else {
			$("#noticeList2").append(html);
			$("#totCnt").text(totalResult);
		}	
			
	});
}

// 등록 화면
function noticeEditForm() {
	location.href="<c:url value='/board/noticeEditForm.do'/>";
}

// 상세 화면
function noticeDetail(boardId) {
	location.href="<c:url value='/board/noticeDetail.do?boardId='/>"+boardId;
}

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck1') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='boardCheckBox1']").attr("checked", true);
			} else {
				$("input:checkbox[name='boardCheckBox1']").attr("checked", false);
			}
		}else if($(this).attr("name") == 'allCheck2') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='boardCheckBox2']").attr("checked", true);
			} else {
				$("input:checkbox[name='boardCheckBox2']").attr("checked", false);
			}
		}
	});
}


function deleteBoard(number){
	var boardCheckBoxSeqArray = $("input:checkbox[name='boardCheckBox"+number+"']:checked").map(function(){return $(this).val();}).get();
	if(boardCheckBoxSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	if(confirm("정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

		$.ajax({
			url : "<c:url value='/board/deleteBoardAjax.do'/>",
			type : "POST",
			data : {
				boardIdArray : boardCheckBoxSeqArray.toString()
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
function orderSave() {
	 var length = $("input[name=boardSeq1]").length;
	 var length2 = $("input[name=boardSeq2]").length;
	 var jsonList = [];
	 for(var i = 0; i < length; i++) {
		 var jsonObj = {};
		 jsonObj["boardId"] = $("input[name=boardSeq1]").eq(i).val();
		 jsonObj["opt2"] = i+1;
		 jsonList.push(jsonObj);
	 }
	 var page = $("#page").val();
	 var pageRowCount = $("#pageRowCount").val();
	 for(var i = 0; i < length2; i++) {
		 var jsonObj = {};
		 jsonObj["boardId"] = $("input[name=boardSeq2]").eq(i).val();
		 jsonObj["opt2"] = ((page - 1) * pageRowCount)+i+1;
		 jsonList.push(jsonObj);
	 }
	 console.log(jsonList);
	 $.ajax({
        contentType: "application/json",
        url : "<c:url value='/board/noticeOrderNoEditAjax.do'/>",
        data : JSON.stringify(jsonList),
        dataType : "json",
        type : "POST",
        success : function(data) {
        	var resultCode = data.resultCode;
    		if(resultCode == "1001") {
    			goSearch('','Y');
    			alert("저장 되었습니다.");
    		}
        },
        error:function(req, txt) {
            alert("오류가 발생했습니다.");
        },
        complete: function() {
            hideLoading();
        }
    });
}
</script>
<!-- 내용-->
<div class="contents_wrap">
	<form id="noticeSearchForm" name="noticeSearchForm" method="POST" >
	<input type="hidden" id="boardIdArr" name="boardIdArr" />
	<input type="hidden" id="page" name="page" value="1" />
	<input type="hidden" id="boardMstId" name="boardMstId" value="${boardMstVO.boardMstId}"/>
	<input type="hidden" id="fixYn" name="fixYn" />
	
	<div class="main_top">
		<h2>
			공지사항 관리
			<a href="javascript:noticeEditForm();"><span class="rtl btn focus" style="width:80px;" ><img src="<c:url value='/resources/common/images/icon_add01.png'/>" alt=""> 등록</span></a>
		</h2>
		
	</div>
	
	<!-- s: 검색-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
			<colgroup>
				<col width="10%"/>
				<col width="10%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">기간</div></th>
					<td>
						<select id="searchDateDiv" name="searchDateDiv" class="select w01" style="width:130px;">
							<option value="INSERTDATE" selected="selected">등록일</option>
							<option value="POSTDATE">게시일</option>
						</select>
					</td>
					<td>
						<div id="datepicker1_group" class="group">
							<input type="text" class="input" style="width: 157px;" id="startDate" name="startDate" maxlength="8" readonly />
							<a class="btn btn-gray"><i class="icon-calendar"></i></a>
							<div id="datepicker1" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
								<div class="head">
									<div class="prev">
										<i class="icon-chevron-left"></i>
									</div>
									<div class="title"></div>
									<div class="next">
										<i class="icon-chevron-right"></i>
									</div>
								</div>
								<table class="body">
									<tr>
										<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
									</tr>
								</table>
							</div>
						</div>
						<div id="datepicker2_group" class="group">
							<input type="text" class="input" style="width: 157px;" id="endDate" name="endDate" maxlength="8" readonly />
							<a class="btn btn-gray"><i class="icon-calendar"></i></a>
							<div id="datepicker2" class="datepicker" style="display: none; position: absolute; z-index: 999; margin-left: 1px; margin-top: 1px;">
								<div class="head">
									<div class="prev">
										<i class="icon-chevron-left"></i>
									</div>
									<div class="title"></div>
									<div class="next">
										<i class="icon-chevron-right"></i>
									</div>
								</div>
								<table class="body">
									<tr>
										<th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th>
									</tr>
								</table>
							</div>
						</div>
						<a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'MONTH', 1);"><span class="btn">1개월</span></a>
			            <a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'YEAR', 1);"><span class="btn">1년</span></a>
			            <a href="javascript:getCurrentDateAfter('startDate', 'endDate', 'ALL', 1);"><span class="btn">전체</span></a>
					</td>
				</tr>
				<tr>	
					<th><div class="tit_search">사용여부</div></th>
					<td colspan="2">
						<select id="useYn" name="useYn" class="select w01" style="width:130px;">
							<option value="" selected="selected">전체</option>
							<option value="Y">사용</option>
							<option value="N">미사용</option>
						</select>
					</td>
				</tr>
				<!-- 삭제
				<tr>
					<th><div class="tit_search">사용여부</div></th>
					<td colspan="3">
						<input type="checkbox" name="useYn" id="useYn" value="Y" /> <label for="useYn">사용중인 공지사항만 보기</label>
					</td>
				</tr>
				<tr>
				 -->
				 <tr>
					<th><div class="tit_search">검색</div></th>
					<td>
						<select id="searchType" name="searchType" class="select w01" style="width:130px;">
							<option value="TITLE" selected="selected">제목</option>
							<option value="CONTENT">내용</option>
						</select>
					</td>
					<td>
						<div class="input_wrap">
							<input type="text" class="input w01" id="title" name="title" style="width: 700px;" onkeydown="if(event.keyCode==13) goSearch(1,'Y');" />
							<a href="javascript:goSearch(1,'Y');"><span class="btn focus" style="width:90px;"><img src="<c:url value='/resources/common/images/icon_search01.png'/>"  alt=""/> 검색</span></a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	<!-- e: 검색-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<a href="javascript:deleteBoard(1);"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
		</div>
	</div>
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table  id="moveTable1" cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="5%"/>
				<col width="*"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck1" id="allCheck1" /></th>
					<th>No</th>
					<th>공지제목</th>
					<th>상단고정</th>
					<th>사용여부</th>
					<th>게시일시</th>
					<th>등록일시</th>
					<th>수정일시</th>
				</tr>
			</thead>
			<tbody id="noticeList1">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<a href="javascript:deleteBoard(2);"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
		<div class="rtl">
			<!-- <a href="javascript:boardListExcel();"><span class="btn btn_w01"><img src="/resources/common/images/icon_excel.png" alt=""/> 엑셀 다운로드</span></a> -->
			<select id="pageRowCount" name="pageRowCount" class="select w01" style="width:130px;" onchange="javascript:goSearch(1,'N');">
				<option value="20" selected="selected">20개씩 보기</option>
				<option value="50" >50개씩 보기</option>
				<option value="100" >100개씩 보기</option>
			</select>
		</div>
	</div>
	<!-- e: table top-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="5%"/>
				<col width="5%"/>
				<col width="*"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck2" id="allCheck2" /></th>
					<th>No</th>
					<th>공지제목</th>
					<th>상단고정</th>
					<th>사용여부</th>
					<th>게시일시</th>
					<th>등록일시</th>
					<th>수정일시</th>
				</tr>
			</thead>
			<tbody id="noticeList2">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<!-- e: 페이징 -->
	<!-- s: 하단 저장 초기화 -->
	<div class="center">
		<a href="javascript:orderSave();"><span class="btn focus" style="width:90px;">저장</span></a>
		<a href="javascript:goSearch('','Y');"><span class="btn" style="width:90px;">초기화</span></a>
	</div>
	<!-- e: 하단 저장 초기화 -->
	
	</form>
<!-- e: 내용-->
</div>
<script data-jui="#moveTable1" data-tpl="row" type="text/template">
	<tr class="<!= dndColor !>">
		<td><input type='checkbox' value='<!= boardId !>' name='boardCheckBox1'></td>;
		<td ><!= rnum !></td>
		<td  class='left'><a href='javascript:noticeDetail("<!= boardId !>");' class='link'>  <!= title !> </a></td>
		<td ><!= opt3 !></td>
		<td ><!= strUseYn !></td>
		<td ><!= postDate !></td>
		<td ><!= insertDate !></td>	
		<td ><!= updateDate !></td>		
		<input type='hidden' id='boardId_<!= rnum !>' name='boardSeq1' value='<!= boardId !>' />
	</tr>
</script>

