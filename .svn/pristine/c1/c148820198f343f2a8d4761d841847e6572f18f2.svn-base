<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<script type="text/javaScript">
var nonAutoBatchPath = '${nonAutoBatchPath}';

$(document).ready(function(){
	goSearch(1);
	checkboxClickEventHandler();
});
// 리스트 조회
function goSearch(page) {
	$("#page").val(page);

	$.ajax({
		url : "/admin/manage/fadeOutUserListAjax.do",
		type : "POST",
		data : $("#fadeOutForm").serialize(),
		dataType : "JSON"
	}).success(function (data) {
		console.log(data);
		
		var resultCode = data.resultCode;
		if(resultCode == "1001") {
			var html = '';
			var resultList = data.resultList;
			var totalCount = data.totalCount;
			var useYn = data.useYn;
			if(isNotEmpty(useYn) && useYn == "Y"){
				toggleOnOff(true);
			}else{
				toggleOnOff(false);
			}
			if(resultList.length > 0) {
				for(var i=0; i<resultList.length; i++) {
					html += '<tr>';
					html += '<td><input type="checkbox" value="'+resultList[i].fadeOutUserId+'" name="fadeOutCheckBox"></td>';
					html += '	<td>'+resultList[i].rnum+'</td>';
					html += '	<td>'+resultList[i].ctn+'</td>';
					html += '	<td>'+resultList[i].hash+'</td>';
					html += '	<td>'+resultList[i].regTime+'</td>';
					html += '</tr>';
				}
			} else {
					html += '<tr>';
					html += '	<td colspan="5"> 검색조건에 부합되는 데이터가 없습니다.</td>';
					html += '</tr>';
			}
			$("#paging").empty();
			$("#paging").append(data.paging);
			$("#resultList").empty();
			$("#resultList").append(html);
			$("#totCnt").text(totalCount);
		} else {
			
		}
	
	}).error(function (data) {
		console.log(data);
	});
}

function fadeOutEditForm() {
	location.href="/admin/manage/fadeOutUserEditForm.do";
}

function checkboxClickEventHandler() {
	$(document).on("click", "input:checkbox", function() {
		if($(this).attr("name") == 'allCheck') {
			if($(this).is(":checked")) {
				$("input:checkbox[name='fadeOutCheckBox']").attr("checked", true);
			} else {
				$("input:checkbox[name='fadeOutCheckBox']").attr("checked", false);
			}
		}
	});
}

function fadeOutUserSystemEditForm(){
	$.ajax({
		url : "/admin/manage/fadeOutUserSystemAjax.do",
		type : "POST",
		data : { useYn  : $("#useYn").val()},
		dataType : "JSON"
	}).success(function (data) {
		alert("성공하였습니다.");
		closeLayerPopup($('#onOffPopup'));
	}).error(function (data) {
		alert("실패하였습니다.");
	});
	
}
function deleteFadeOut(){
		var fadeOutCheckBoxSeqArray = $("input:checkbox[name='fadeOutCheckBox']:checked").map(function(){return $(this).val();}).get();
		if(fadeOutCheckBoxSeqArray.length == 0) {
			alert("선택 된 항목이 없습니다.")
			return;
		}
		if(confirm("정말로 삭제하시겠습니까?\n삭제 된 데이터는 복구되지 않습니다.")) {

			$.ajax({
				url : "/admin/manage/deleteFadeOutUserAjax.do",
				type : "POST",
				data : {
					fadeOutUserIdArray : fadeOutCheckBoxSeqArray.toString()
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
function toggleOnOff(onOff){
	   var html = '';
	      html += "<div id='button_1' class='group'  style='width: 280px;'>";
	   if(onOff) {
		   	  $("#useYn").val("Y");
	          html += "<a href='javascript:toggleOnOff(true);' class='btn large active' style='background: blue; color: white; font-weight: bold;' value='true'>사용자</a>&nbsp;";
	          html += "<a href='javascript:toggleOnOff(false);' class='btn large' value='false'>시스템</a>";
	   } else {
		   	  $("#useYn").val("N");
	          html += "<a href='javascript:toggleOnOff(true);' class='btn large' value='true'>사용자</a>";
	          html += "<a href='javascript:toggleOnOff(false);' class='btn large active' style='background: red; color: white; font-weight: bold;' value='false'>시스템</a>&nbsp;";
	   }
	   html += "</div>";
	   $("#onOffButton").empty();
	   $("#onOffButton").append(html);
	}
</script>
<!-- s: popup -->
<div class="popup_container" id="onOffPopup" style="display: none;">
   <div class="popup_inner w02">
      <div class="p_header">
         <h1>F/O 단위설정</h1>
         <a href="javascript:closeLayerPopup($('#onOffPopup'));" class="btn_close"><span class="hidden_obj">닫기</span></a>
      </div> 
      <div class="p_body">
         <div class="p_content">
            <div class="pop_info">&middot; F/O 단위</div>
            
            <div class="radio_group" id="onOffButton">
               <div id="button_1" class="group">
                  <a href="javascript:toggleOnOff(true);" class="btn large active" style="background: blue; color: white; font-weight: bold;">시스템단위</a>
                  <a href="javascript:toggleOnOff(false);" class="btn large">사용자단위</a>
               </div>
            </div>
            <!-- s: btn -->
            <div class="btn_wrap02">
               <a href="javascript:fadeOutUserSystemEditForm();"><span class="btn large focus">적용</span></a>
               <span onclick="closeLayerPopup($('#onOffPopup'));"class="btn large" id="btn_exitPopup">취소</span>
            </div>
            <!-- e: btn -->
         </div>
      </div>
   </div>
</div>

<!-- 내용-->
<div class="contents_wrap">
<input type="hidden" id="useYn" name="useYn" />
    <form id="fadeOutForm" name="fadeOutForm" method="POST" >
	    <input type="hidden" id="page" name="page" />
	    <div class="main_top">
	        <h2>
	        	F/O 테스트용 이용자 등록
	        	<a href="javascript:fadeOutEditForm();"><span class="rtl btn focus" style="width:80px;" ><img src="/admin/resources/common/images/icon_add01.png" alt=""> 등록</span></a>
	        	<a href="javascript:openLayerPopup($('#onOffPopup'));"><span class="rtl btn focus" style="width:80px;" ><img src="/admin/resources/common/images/icon_add01.png" alt=""> 서비스</span></a>
	      </h2>
	    </div>
	<!-- s: 검색-->
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table_search_type">
			<colgroup>
				<col width="15%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><div class="tit_search">검색</div></th>
					<td>
						<div class="input_wrap">
							<select id="searchType" name="searchType" class="select w01" style="width:130px;">
								<option value="CTN" selected="selected">전화번호</option>
								<option value="HASH">회원 ID</option>
							</select>
							<input type="text" class="input w02" id="searchText" name="searchText" onkeydown="if(event.keyCode==13) goSearch(1);"/>
							<a href="javascript:goSearch(1);"><span class="btn focus" style="width:90px;"><img src="/admin/resources/common/images/icon_search01.png"  alt=""/> 검색</span></a>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- e: table wrap-->
	<!-- e: 검색-->
	<!-- s: table top-->
	<div class="thead_wrap cboth">
		<div class="ltr">
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
	<div class="thead_wrap cboth">
		<div class="ltr">
			<a href="javascript:deleteFadeOut();"><span class="btn btn_w01"> 삭제</span></a>&nbsp;
		</div>
	</div>
	<!-- s: table wrap-->
	<div class="table_wrap">
		<table cellpadding="0" cellspacing="0" border="0" class="table simple table_list_type">
			<colgroup>
				<col width="10%"/>
				<col width="10%"/>
				<col width="20%"/>
				<col width="*"/>
				<col width="10%"/>
			</colgroup>
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck" id="allCheck" /></th>
					<th>No</th>
					<th>CTN</th>
					<th>HASH</th>
					<th>등록일시</th>
				</tr>
			</thead>
			<tbody id="resultList">
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
<div class="dimmed" style="display: none;"></div>
<!-- e: 내용-->
</body>
