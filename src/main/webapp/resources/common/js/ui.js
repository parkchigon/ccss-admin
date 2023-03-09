
// s: document.ready
$(document).ready(function(){
	popLocate(".popup_container");
	openGnb(); //GNB
	openLnb();
	slickBanner(); // 배너관리
});
// e: document.ready

/* s: funciton
--------------------------------------------------------- */

//s: GNB
function openGnb(){
	$(".tit_gnb").mouseenter(function() {
		if ($(this).attr("class") != "on") {
			$(".sub_wrap").hide();
			$(this).next().show();
			$(".menu_wrap li a").removeClass("on");
			$(this).addClass("on");
		}
	});
	$(".menu_wrap").mouseleave(function() {
		$(".menu_wrap li ul").hide();
		//$(".tit_gnb").removeClass("on");
		$(".sub_wrap li").removeClass("on");
	});
	
	$(".tit_gnb").click(function(){
		$(".tit_gnb").removeClass("on");
		$(this).addClass("on");
	});
}

function openLnb(){
	
	$(".tit_lnb").click(function(e){
		$(".tit_lnb").removeClass("on");
		$(this).addClass("on");
		e.preventDefault();
		
		if($(this).hasClass("on")==true){
			$(".depth03").removeClass("on");
			$(this).next().addClass("on");
			$(this).next().children("li a").addClass("on");
		}
	});
}
//e: GNB

function chkGnbFn(){
	$(".gnb_wrap li a").each(function(idx){
		if($(this).text().length > 10){
			$(this).parent().addClass("l2");
		}
	});
}	

// s: popup
// loaction
function popLocate(target){
	var tagLength = $(target).length;
	var bodyHeight = $("body").height();
	
	for(var i=0; i<=tagLength; i++){
		var popHeight = $(target).eq(i).height();
		var marginTop = -parseInt(popHeight/2);

		if(bodyHeight > popHeight){
			$(target).eq(i).css({"margin-top":marginTop+"px"});
		}else{
			$(target).eq(i).css({
				"margin-top":0,
				"top":0
			});
		}
	}
}
// popup on
function popOn(){
	$(".dimmed").show();
	$(".popup_container").show();
}
// popup off
function popOff(){
	$(".dimmed").hide();
	$(".popup_container").hide();
}
// e: popup

// 배너관리
function slickBanner(){
	$('.banner_contents ul').slick({
		infinite: true,
		centerMode: true,
		slidesToShow: 3,
		slidesToScroll: 1
	});
}
