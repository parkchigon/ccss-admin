$(document).ready(function(){
});

/**
 * &lt;&gt;등의 태그를 html 태그로 변환
 * @param content
 * @returns
 */
function safeTagToHtmlTag(content) {
	var result = content.replace(/&gt;/gi, ">");
	result = result.replace(/&lt;/gi, "<");
	result = result.replace(/&quot;/gi, "\"");
    result = result.replace(/&amp;/gi, "&");
    result = result.replace(/&#039;/gi, "'");
    
    return result;
}

/**
 * Ajax 트랜잭션 시작시 로딩 이미지 표시
 * jquerySelector : 로딩 이미지를 올릴 부모 divId
 * @param jquerySelector
 */
var loadingParentSelector;
function showloading(jquerySelector) {
	loadingParentSelector = jquerySelector;
	$(loadingParentSelector).oLoader({
	    wholeWindow: true, //makes the loader fit the window size
	    lockOverflow: true, //disable scrollbar on body
		   
	    backgroundColor: "#000",
	    fadeInTime: 300,
	    fadeLevel: 0.4,
	    image: "/resources/common/js/lib/jquery/images/loader1.gif"  
	});
}

/**
 * 로딩 이미지를 제거한다.
 */
function hideLoading() {
	$(loadingParentSelector).oLoader("hide");
}

/**
 * type : daily=년월일(기본값), month=년월, yearly=년
 * groupId : 데이트 피커의 div 그룹id
 * id : 데이트 피커의 ID
 * format : 선택시 input에 출력될 날짜형식, 기본값(yyyy-MM-dd)
 * @param attrs
 */
function datePicker(attrs) {
	var type = isNotEmpty(attrs.type) ? attrs.type : "daily";
	var groupId = attrs.datePickerGroupId;
	var id = attrs.datePickerId;
	var format = isNotEmpty(attrs.format) ? attrs.format : "yyyy-MM-dd";
	var obj = eval(id);
	var baseTitleFormat = isNotEmpty(attrs.titleFormat) ? attrs.titleFormat : "yyyy년 MM월";
	var maxDate = attrs.maxDate;
	jui.ready(["ui.datepicker"], function(datepicker) {
		obj = datepicker("#" + id, {
			type: type,
	        titleFormat: baseTitleFormat,
	        format: format,
	        event: {
	            select: function(date, e) {
	                $("#" + groupId).find("input").val(this.getFormat(format));
	                $("#" + groupId).find("a").click();
	            },
	            prev: function(e) {
	            	if(attrs.prevFunction) {
	            		attrs.prevFunction();
	            	}
	            },
	            next: function(e) {
	            	if(attrs.nextFunction) {
	            		attrs.nextFunction();
	            	}
	            },
	            tpl: {
	            	date: $("#tpl_date").html()
	            }
	        }
	    });
		
	    $("#" + groupId).find("a").on("click", function(e) {
	        var $r = $(obj.root);

	        if($r.css("display") == "none") {
	            $r.show();
	        } else {
	            $r.hide();
	        }
	    });
	});
}

// 시작날짜~종료날짜 min/max설정
function compareDatePicker(attrs) {
	var type = isNotEmpty(attrs.type) ? attrs.type : "daily";
	var startGroupId = attrs.startDatePickerGroupId;
	var startId = attrs.startDatePickerId;
	var endGroupId = attrs.endDatePickerGroupId;
	var endId = attrs.endDatePickerId;
	var format = isNotEmpty(attrs.format) ? attrs.format : "yyyy-MM-dd";
	var baseTitleFormat = isNotEmpty(attrs.titleFormat) ? attrs.titleFormat : "yyyy년 MM월";
	var startObj = eval(startId);
	var endObj = eval(endId);
	
	jui.ready(["ui.datepicker"], function(datepicker) {
		startObj = datepicker("#" + startId, {
			type: type,
	        titleFormat: baseTitleFormat,
	        format: format,
	        event: {
	            select: function(date, e) {
	                $("#" + startGroupId).find("input").val(this.getFormat(format));
	                $("#" + startGroupId).find("a").click();
	                endObj.setOption('minDate', new Date(date));
	                endObj.reload();
	            },
	            prev: function(e) {
	            	if(attrs.prevFunction) {
	            		attrs.prevFunction();
	            	}
	            },
	            next: function(e) {
	            	if(attrs.nextFunction) {
	            		attrs.nextFunction();
	            	}
	            }
	        }
	    });
		
		
	    $("#" + startGroupId).find("a").on("click", function(e) {
	        var $r = $(startObj.root);

	        if($r.css("display") == "none") {
	            $r.show();
	        } else {
	            $r.hide();
	        }
	    });
	    
	    endObj = datepicker("#" + endId, {
			type: type,
	        titleFormat: "yyyy년 MM월",
	        format: format,
	        event: {
	            select: function(date, e) {
	                $("#" + endGroupId).find("input").val(this.getFormat(format));
	                $("#" + endGroupId).find("a").click();
	                startObj.setOption('maxDate', new Date(date));
	                startObj.reload();
	            },
	            prev: function(e) {
	            	if(attrs.prevFunction) {
	            		attrs.prevFunction();
	            	}
	            },
	            next: function(e) {
	            	if(attrs.nextFunction) {
	            		attrs.nextFunction();
	            	}
	            }
	        }
	    });
		
	    $("#" + endGroupId).find("a").on("click", function(e) {
	        var $r = $(endObj.root);

	        if($r.css("display") == "none") {
	            $r.show();
	        } else {
	            $r.hide();
	        }
	    });
	});
}

// 로그아웃 처리
function excuteLogout() {
	location.href="/admin/login/excuteLogout.do";
}

// 메뉴 이동
// 가입자관리 > 운영자관리
function adminListForm() {
	location.href="/admin/adminListForm.do";
}

// 게시판 > 공지사항관리
function noticeList() {
	location.href="/board/noticeList.do";
}

// 포인트 관리 -> 접속요율기본설정
function pointRateBasicSettingForm() {
  location.href="/point/pointRateBasicSettingForm.do";
}

//포인트 관리 -> 접속요율추가설정
function pointRateAddSettingForm() {
  location.href="/point/pointRateAddSettingForm.do";
}

function getCurrentDate(dateLength) {
	var now = new Date();
	var baseDateLength = 10;
	if(dateLength != undefined){
		baseDateLength = dateLength;
	}
	var dateFormat = now.toISOString().substr(0,baseDateLength);

	return dateFormat;
}


function getCurrentDateAfter(startDateId, endDateId, dateDiv, date, dateLength) {
	var baseDateLength = 10;
	var fullEndDate = $("#" + endDateId).val();
	
	if(dateLength != undefined || ($("#" + endDateId).val() == "" && dateDiv != "ALL")) {
		fullEndDate = getCurrentDate(baseDateLength);
		if(dateLength != undefined){
			baseDateLength = dateLength;
		}
		$("#" + endDateId).val(getCurrentDate(baseDateLength));
	}
	
	var dateArr = fullEndDate.split("-");
	var endDate = new Date(dateArr[0], dateArr[1]-1, dateArr[2]);
	
	if(dateDiv == "DAY") {
		endDate.setDate(endDate.getDate() - date);
	} else if(dateDiv == "MONTH") {
		endDate.setMonth(endDate.getMonth() - date);
	} else if(dateDiv == "YEAR") {
		endDate.setFullYear(endDate.getFullYear() - date);
	} else {
		$("#" + startDateId).val('');
		$("#" + endDateId).val('');
		return;
	}
	
	var dateFormat = endDate.toISOString().substr(0,baseDateLength);
	$("#" + startDateId).val(dateFormat);
}


function formValidationCheck(valCheck){
	for(var i in valCheck){
		if(textBoxValCheck(valCheck[i])){
			alertMessageSource(valCheck[i]);
			focusInputTextBox(valCheck[i]);
			return false;
		}
	}
	return true;
	
}

function textBoxValCheck(id){
	var idVal = $.trim($('#' + id).val());
	if(idVal== null || idVal == ""){
		return true;
	}else{
		return false;
	}
}

function focusInputTextBox(id){
	$('#' + id).val("");
	$('#' + id).focus();	
}

function fnNumberCheck(obj) {
    if(obj.value.indexOf(",")){
    	obj.value=obj.value.replace(/,/g, '');
    }
    
    if (/[^0-9]/g.test(obj.value))  {
        //alert("숫자만 입력 가능합니다.");  
        obj.focus();
        obj.value = obj.value.replace(/[^0-9]/gi,'');
        return false;
    }        
}

function isTelNum(val) {
//	var regExp = /[^-0-9]/;
	if(/^[0-9]{2,3}[0-9]{3,4}[0-9]{4}$/.test(val)==false) {
		alert("전화번호 형식으로 입력해주세요.");
		return false;
	} 
	return true;
	
}

//이메일 체크
function isEmail(val){
	if(/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i.test(val) == false) {
		alert("이메일 형식으로 입력해주세요.");
		return false;
	}
	return true;
}

//숫자키만 입력
function onlyNumberInput(){
	if(event.keyCode == 9 || event.keyCode == 8 || event.keyCode == 46 || (event.keyCode >= 48 && event.keyCode <= 57)  || ( event.keyCode >=96 && event.keyCode <= 105 )) {
        return true;
    } else {
        event.returnValue = false;
    }
}


function isNotEmpty(_str) {
	obj = String(_str);

	if(obj == null || obj == undefined || obj == "null" || obj == "undefined" || obj == "") return false;

	else return true;
}

/**
 * value 널 또는 공백 체크
 * true : null 또는 공백
 * false : 유효한 문자열
 * 
 * @param objId
 * @return
 */
function isEmpty(_str) {
	obj = String(_str);

	if(obj == null || obj == undefined || obj == "null" || obj == "undefined" || obj == "") return true;

	else return false;
}

function getFormData(form){ //form을 JSON으로 바꾸기
    var unindexed_array = form.serializeArray();
    var param = {};

    $(unindexed_array).each(function(i, v) {
        param[v.name] = v.value;
    });
    return JSON.stringify(param);
}


//숫자 콤마 추가
function addComma(data_value) {
	return data_value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 숫자 콤마 제거
function removeComma(data_value){
    return parseInt(data_value.replace(/,/g,""));
}

/**
 * 공통 팝업
 */
function commonPopup(url, popupName, options) {
	var highOptions = "";
	if(options != null && options != ''){
		highOptions = options;
	}else{
		highOptions = "scrollbars=yes, location=no";
	}
	childPopUp = window.open(url, '_blank', highOptions);
}


function exitPopup(){
	window.close();
}

function openLayerPopup(target) {
	$(".dimmed").show();
	target.show();
}

function closeLayerPopup(target) {
	$(".dimmed").hide();
	target.hide();
}

function AES_Decode(base64_text)
{
	GibberishAES.size(128);	
	return GibberishAES.aesDecrypt(base64_text, "abcdefghijklmnopabcdefghijklmnop");
}

function AES_Encode(plain_text)
{
	GibberishAES.size(128);	
	return GibberishAES.aesEncrypt(plain_text, "abcdefghijklmnop");
}

// 전화번호 하이픈 추가
function phoneFormat(num) {
	var formatNum = '';
	if(num.length==11){
		formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
	} else if(num.length==8){
		formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');
	} else {
		if(num.indexOf('02')==0){
			formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
        }else{
        	formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
        }
	}
    return formatNum;
}

// 통계 PointcolumnChart 생성
function makePointColumnChart(divId,title,inNames,data){
	$(divId).empty();
	var chart = jui.include("chart.builder");
	var names = inNames;
	
	chart(divId, {
	    axis : {
	        x : {
	            type : "block",
	            domain : "key",
	            line : true
	        },
	        y : {
	            type : "range",
	            domain : function(d) { 
	            	return [0,d.value ]; },
	            step : 8,
	            line : true,
	            //orient : "right"
	        },
	        data : data
	    },
	    brush : {
	        type : "column",
	        size : 50,
	        /*colors : function(index, value, targetIndex) {
	            return '#BDBDBD';
	        },*/
	        target : "value",
	    },
	    widget : [
	    	{ type : "title", text : title },
	        { type : "tooltip",
	    		format : function(data, k) {
		            return {
		            	key: data['key'] + ":",
		                value: data[k] + " 포인트"
		            }
		        }
	    	},
	    	{ type : "legend",
		        format : function(k) {
		            return names[k];
		        } }
	    ]
	});
}

//datePicker 시작일 종료일 validation 시작
function checkDatePickerStartEnd(){
	var endYear = $("#endDate").val().substr(0,4);
	var startYear = $("#startDate").val().substr(0,4);
	var endMonth = $("#endDate").val().substr(5,2)*1;
	var startMonth = $("#startDate").val().substr(5,2)*1;
	var endDay = $("#endDate").val().substr(8,2)*1;
	var startDay = $("#startDate").val().substr(8,2)*1;
	
	if(endYear < startYear){
		alert("종료날짜가 시작날짜 보다 빠른 날짜로 설정되었습니다.");
		return false;
	} else if( endYear == startYear && endMonth < startMonth ){
		alert("종료날짜가 시작날짜 보다 빠른 날짜로 설정되었습니다.");
		return false;
	} else if( endMonth == startMonth && endDay < startDay ){
		alert("종료날짜가 시작날짜 보다 빠른 날짜로 설정되었습니다.");
		return false;
	}
	
	return true;
}


//통계용 datePicker 시작일 종료일 validation 끝
function checkDatePickerStartEndForStats(){
	if($("#searchDateDiv").val() == "DAY"){
		var startDateVar = new Date($("#startDate").val());
		var endDateVar = new Date($("#endDate").val());
		var gapDayOfVar = (endDateVar - startDateVar)/86400000; //일수
		if(gapDayOfVar > 365){
			alert("최대 365일까지 설정 가능합니다.");
			return false;
		} else {
			return true;
		}
	} else if($("#searchDateDiv").val() == "MONTH"){
		var endYear = $("#endDate").val().substr(0,4);
		var startYear = $("#startDate").val().substr(0,4);
		var endMonth = $("#endDate").val().substr(5,2)*1;
		var startMonth = $("#startDate").val().substr(5,2)*1;
		var gapMonthOfVar = ((endYear - startYear)*12) + (endMonth - startMonth);
		if(gapMonthOfVar > 24){
			alert("최대 24개월까지 설정 가능합니다.");
			return false;
		} else {
			return true;
		}
	} else if($("#searchDateDiv").val() == "YEAR"){
		if($("#endDate").val()-$("#startDate").val() > 10){
			alert("최대 10년까지 설정 가능합니다.");
			return false;
		} else {
			return true;
		}
	} else {
		return false;
	}
}

// 한글포함 문자열 길이
function getTextLength(str) {
    var len = 0;
    for (var i = 0; i < str.length; i++) {
        if (escape(str.charAt(i)).length == 6) {
            len++;
        }
        len++;
    }
    return len;
}

//통계 StatcolumnChart 생성
function makeStatColumnChart(divId,title,inNames,data){
	$(divId).empty();
	var chart = jui.include("chart.builder");
	var names = inNames;
	chart(divId, {
	    axis : {
	        x : {
	            type : "block",
	            domain : "key",
	            /*format: function(d) {
	                return d.substring(5,10);
	            },*/
	            line : true
	        },
	        y : {
	            type : "range",
	            domain : function(d) { 
	            	return [0,d.value ]; },
	            step : 8,
	            line : true,
	            //orient : "right"
	        },
	        data : data
	    },
	    brush : {
	        type : "column",
	        size : 50,
	        /*colors : function(index, value, targetIndex) {
	            return '#BDBDBD';
	        },*/
	        target : "value",
	    },
	    widget : [
	        /*{ type : "scroll" },*/
	    	{ type : "title", text : title },
	        { type : "tooltip",
	    		format : function(data, k) {
		            return {
		            	key: data['key'] + ":",
		                value: data[k]
		            }
		        }
	    	},
	    	{ type : "legend",
		        format : function(k) {
		            return names[k];
		        } }
	    ]
	});
}

//통계용 ajaxloading
function statsAjaxLoading(){
	$("#chartDiv").prepend('<img alt="" id="viewLoading" src="/resources/common/images/loading.gif">');
	
	$('#viewLoading').hide();

	// ajax 실행 및 완료시 'Loading 이미지'의 동작을 컨트롤하자.
	$('#viewLoading')
	.ajaxStart(function()
	{

		$(this).show();
		//$(this).fadeIn(500);
	})
	.ajaxStop(function()
	{
		$(this).hide();
		//$(this).fadeOut(500);
	});
}


Date.prototype.YYYYMMDDHHMMSS = function () {
    var yyyy = this.getFullYear().toString();
    var MM = pad(this.getMonth() + 1,2);
    var dd = pad(this.getDate(), 2);
    var hh = pad(this.getHours(), 2);
    var mm = pad(this.getMinutes(), 2)
    var ss = pad(this.getSeconds(), 2)

    return yyyy + MM + dd+  hh + mm + ss;
};

function pad(number, length) {
    var str = '' + number;
    while (str.length < length) {
        str = '0' + str;
    }
    return str;
}



//이스케이프 함수
function escapeHtml(value){
	if (value != null && value != "") { 
		/* 세미콜론(;)은 일단 제거
	   	return value.replace(/;/g, "&#59;").replace(/\\/g, "&#92;").replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\"/g, "&quot;").replace(/ /g, "&nbsp;").replace(/\'/g, "&apos;"); */
		return value.replace(/\\/g, "&#92;").replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\"/g, "&quot;").replace(/ /g, "&nbsp;").replace(/\'/g, "&apos;"); 
  }else{
  	return value;
  }
}


//역이스케이프 함수
function unescapeHtmlValue(value){
	if (value != null && value != "") { 
		/* 세미콜론(;)은 일단 제거
		return value.replace(/&#59;/g, ";").replace(/&#92;/g, "\\").replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, "\"").replace(/&nbsp;/g, " ").replace(/&apos;/g, "\'"); */ 
		return value.replace(/&#92;/g, "\\").replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, "\"").replace(/&nbsp;/g, " ").replace(/&apos;/g, "\'"); 
	}else{
		return value;
	}
}


//Query String 형태의 URL 에서 파라미터를 꺼내 오는 함수
var getUrlParameter = function getUrlParameter(sParam) {
  var sPageURL = decodeURIComponent(window.location.search.substring(1)),
      sURLVariables = sPageURL.split('&'),
      sParameterName,
      i;

  for (i = 0; i < sURLVariables.length; i++) {
      sParameterName = sURLVariables[i].split('=');

      if (sParameterName[0] === sParam) {
          return sParameterName[1] === undefined ? true : sParameterName[1];
      }
  }
}


//글자수 입력 제한 설정(text박스 id, 제한 길이)
function setTextLengthLimit(elementId, checkByte) {
	$(elementId).on('input', function() {
		var totalByte = 0;
		var message = $(this).val();
	    var limitMessageLength = '';

	    for(var i =0; i < message.length; i++) {
	    	totalByte += charByteSize(message.charAt(i));
	        
	    	if(totalByte == checkByte - 3){
	        	limitMessageLength = i;
	        }
	    	if(totalByte == checkByte - 2){
	        	limitMessageLength = i;
	        }
	    	if(totalByte == checkByte - 1){
	        	limitMessageLength = i;
	        }
	        if(totalByte == checkByte){
	        	limitMessageLength = i;
	        }
	     }

	     if(totalByte > checkByte) {
	    	 $(elementId).val(message.substring(0, limitMessageLength));
		 }
	});
}

function charByteSize(ch) {
	if (ch == null || ch.length == 0) {
		return 0;
	}

	var charCode = ch.charCodeAt(0);

	if (charCode <= 0x00007F) {
		return 1;
	} else if (charCode <= 0x0007FF) {
		return 2;
	} else if (charCode <= 0x00FFFF) {
		return 3;
	} else {
		return 4;
	}
}

function getCurrentDateAfter(startDateId, endDateId, dateDiv, date, dateLength) {
	var baseDateLength = 10;
	var fullEndDate = $("#" + endDateId).val();
	
	if(dateLength != undefined || ($("#" + endDateId).val() == "" && dateDiv != "ALL")) {
		fullEndDate = getCurrentDate(baseDateLength);
		if(dateLength != undefined){
			baseDateLength = dateLength;
		}
		$("#" + endDateId).val(getCurrentDate(baseDateLength));
	}
	
	var dateArr = fullEndDate.split("-");
	var endDate = new Date(dateArr[0], dateArr[1]-1, dateArr[2]);
	
	if(dateDiv == "DAY") {
		endDate.setDate(endDate.getDate() - date);
	} else if(dateDiv == "MONTH") {
		endDate.setMonth(endDate.getMonth() - date);
	} else if(dateDiv == "YEAR") {
		endDate.setFullYear(endDate.getFullYear() - date);
	} else {
		$("#" + startDateId).val('');
		$("#" + endDateId).val('');
		return;
	}
	
	var dateFormat = endDate.toISOString().substr(0,baseDateLength);
	$("#" + startDateId).val(dateFormat);
}

function setAddDayDate(startDate, addDay, setTarget) {
	var dateArr = startDate.split("-");
	
	var newDate = new Date(dateArr[0], dateArr[1]-1, dateArr[2]);
	newDate.setDate(newDate.getDate() + addDay);
	
	var newDateString = pad(newDate.getFullYear())+'-'+pad(newDate.getMonth()+1)+'-'+pad(newDate.getDate());

	$(setTarget).val(newDateString);
	
	return newDateString;
}

function pad(num){
	return (num < 10 ? '0' : '') + num;
}

function getCurrentDateSingle(dateType, setTarget) {
	var currentDate = new Date();
	var newDate = new Date();
	var newDateString = ""
	if(dateType == "DAY") {
		newDate.setDate(currentDate.getDate()-1);
		newDateString = pad(newDate.getFullYear())+'-'+pad(newDate.getMonth()+1)+'-'+pad(newDate.getDate());
	} else if(dateType == "WEEK") {
		newDate.setDate(currentDate.getDate()-7);
		newDateString = pad(newDate.getFullYear())+'-'+pad(newDate.getMonth()+1)+'-'+pad(newDate.getDate());
		setAddDayDate(newDateString, 6, "#endDate");
	} else if(dateType == "MONTH") {
		newDateString = pad(newDate.getFullYear())+'-'+pad(newDate.getMonth()+1);
	} else if(dateType == "YEAR") {
		newDateString = pad(newDate.getFullYear());
	}		
	
	$("#startDate").val(newDateString);
	
	return newDateString;
}