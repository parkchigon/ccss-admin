<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javascript">
$(document).ready(function() {
	goSearch(1);
	checkboxClickEvent();
	// 데이터 피커 생성
	compareDatePicker({
		startDatePickerGroupId: "datepicker1_group",
		startDatePickerId: "datepicker1",
		endDatePickerGroupId: "datepicker2_group",
		endDatePickerId: "datepicker2",
	})
});

function checkboxClickEvent() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='maintenanceNotice']").attr("checked", true);
			} else {
				$("input:checkbox[name='maintenanceNotice']").attr("checked", false);
			}
		} else if($(this).attr("name") == 'maintenanceNotice') {
			if($(this).is(":checked")) {
				if($("input:checkbox[name='maintenanceNotice']").length == $("input:checkbox[name='maintenanceNotice']:checked").length) {
					$("#allCheck").attr("checked", true);
				}
			} else {
				if($("input:checkbox[name='maintenanceNotice']").length != $("input:checkbox[name='maintenanceNotice']:checked").length) {
					$("#allCheck").attr("checked", false);
				}
			}
		}
	});
}

function goSearch(page) {
	
	$("#page").val(page);
	$.ajax({
		url : "/admin/manage/maintenanceListAjax.do"
		,data : $("#maintenanceListSeach").serialize()
		,dataType : 'json'
		,type : "POST"
		,success : function(response) {
			var resultCode = response.resultCode;
			
			if(resultCode = "1001") {
				$("#totCnt").text(response.totalCount);
				
				var html = '';
				var resultList = response.resultList;
				
				$("#paging").append(response.paging);
				if(response.totalCount == 0) {
					html += "<tr>"
					html += "	<td colspan='5'> 데이터가 없습니다.</td>";
					html += "</tr>"
				} else {
					for(var i=0; i<resultList.length; i++) {
						html += '<tr>';
						html += '	<td><input type="checkbox" value="'+resultList[i].seqMaintenanceNoticeId+'" name="maintenanceNotice"></td>';
// 						html += '	<td>'+resultList[i].rnum+'</td>';
// 						if(resultList[i].noticeType == "MAINTENANCE") {
// 							html += '<td>작업 공지</td>';
// 						} else {
// 							html += '<td>장애 공지</td>';
// 						}
						html += '	<td class="left">'+resultList[i].content+'</td>';
						
						if(resultList[i].useYn == "Y") {
							html += '<td>사용</td>';
						} else {
							html += '<td>미사용</td>';
						}
						
						html += '	<td>'+resultList[i].startDtime+'</td>';
						html += '	<td>'+resultList[i].insertDate+'</td>';
						html += '</tr>';
					}
				}
				$("#noticeList").empty();
				$("#noticeList").append(html);
			}
		}
		
	}).error(function(data) {
		alert("서비스 종료 공지 리스트 조회중 에러가 발생하였습니다.");
	});
}

function maintenanceNoticeEdit(seq) {
	location.href = "/admin/manage/fadeOutEditForm.do?seqMaintenanceNoticeId="+seq;
}

function deleteMaintenanceNotice() {
	
	var maintenanceNoticeSeqArray = $("input:checkbox[name='maintenanceNotice']:checked").map(function(){return $(this).val();}).get();
	
	console.log(maintenanceNoticeSeqArray)
	if(maintenanceNoticeSeqArray.length == 0) {
		alert("선택 된 항목이 없습니다.")
		return;
	}
	
	if(confirm("정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {
	
		$.ajaxSettings.traditional = true;
		$.ajax({
			url : "/admin/manage/deleteMaintenanceNoticeAjax.do",
			type: "POST",
			data : {
				seqMaintenanceNoticeIdArray : maintenanceNoticeSeqArray 
			},
			success : function(response) {
				var resultCode = response.resultCode;
				
				if(resultCode = "1001") {
					alert("서비스 종료 공지가 삭제되었습니다.");
					$("#allCheck").attr("checked", false);
					goSearch(1);
				} else {
					alert("서비스 종료 공지 삭제중 에러가 발생하였습니다.");
				}
			}
		}).error(function(data) {
			alert("서비스 종료 공지 삭제중 에러가 발생하였습니다.");
		});
	}
}

</script>
<div class="contents_wrap">
	<div class="main_top">
		<h2>
			서비스 종료 공지
	        	<a href="javascript:maintenanceNoticeEdit();"><span class="rtl btn focus" style="width:80px;" ><img src="/admin/resources/common/images/icon_add01.png" alt=""> 등록</span></a>
		</h2>
		
	</div>
	<!-- s: 검색-->
	<!-- s: table wrap-->
	<form id="maintenanceListSeach" name="maintenanceListSeach">
		<input type="hidden" name="page" id="page" value="1"/>
		<input type="hidden" name="noticeType" id="noticeType" value="FADEOUT"/>
	<!-- e: table wrap-->
	<!-- e: 검색-->
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
			<a href="javascript:deleteMaintenanceNotice();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
			<span class="count" ><strong>Total : <span id="totCnt"></span></strong></span>
		</div>
		<div class="rtl">
			<select id="pageRowCount" name="pageRowCount" class="select w01" style="width:130px;" onchange="javascript:goSearch(1);">
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
				<col width="*"/>
				<col width="7%"/>
				<col width="20%"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck" id="allCheck" /></th>
					<th>내용</th>
					<th>사용여부</th>
					<th>서비스종료일</th>
					<th>등록일시</th>
				</tr>
			</thead>
			<tbody id="noticeList">
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	
	<!-- s: 페이징 -->
	<div id="paging" class="paging">
	</div>
	<!-- e: 페이징 -->
	</form>
<!-- e: 내용-->
</div>