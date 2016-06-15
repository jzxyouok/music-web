/**
 * 首页js
 */
$(function() {
	/* 上/下一部影片 */
	var curPage = 1;	//当前处于第几页，默认为第1页
	var maxPage = Math.ceil($("div.even_center li").size()/5);	//最大页数
	var li_width = $("div.even_center").width() - 20;
	/* 为下一页添加事件 */
	$("div.even_right b").click(function() {
		if(!$("#menu_box_movie_inner").is(":animated")) {						
			if(curPage + 1 <= maxPage) {	//还未处于最后一页，则转向下一页						
				curPage = curPage + 1;
				$("#menu_box_movie_inner").animate({ marginLeft : '-='+li_width}, 600);
				if(curPage == maxPage) {	//当前处于最后一页，无法再向右翻页
					$("div.even_right b").addClass("disable");
				}
				if($("div.even_left b").hasClass("disable")) {//当前处于第2页后之后的页码，可以向左翻页
					$("div.even_left b").removeClass("disable");
				}
			}					
		}					
	});
	/* 为上一页添加事件 */
	$("div.even_left b").click(function() {
		if(!$("#menu_box_movie_inner").is(":animated")) {
			if(curPage - 1 >= 1) {	//还未到达第一页,则向左翻页
				curPage = curPage - 1;							
				$("#menu_box_movie_inner").animate({ marginLeft : '+='+li_width}, 600);
				if(curPage == 1) {	//已经到达第1页，无法继续向前翻页
					$("div.even_left b").addClass("disable");
				}
				if($("div.even_right b").hasClass("disable")) {//可以向右翻页
					$("div.even_right b").removeClass("disable");
				}
			}	
		}					
	});
});