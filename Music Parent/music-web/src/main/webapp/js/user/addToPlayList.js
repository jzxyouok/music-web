//添加歌曲到播放列表
function addToPlayList(obj) {
	//alert(obj);
	var itemArr = obj[0].lang.split(",");   				
	//获取当前选择的歌曲的编号
	var songId = itemArr[0];
	$("input[name='songToCollect']").val(songId);
	var songName = itemArr[1];
	var singerId = itemArr[2];
	var singerName = itemArr[3];
	//获取歌曲时长
	var duration = itemArr[4];
	var minute = parseInt(parseInt(duration) / 60);
	var second = parseInt(duration) % 60;
	var minuteStr = minute >= 10 ? minute+"" : "0" + minute;
	var secondStr = second >= 10 ? second+"" : "0" + second;
	var timeStr = minuteStr + ":" + secondStr;
							
	//播放列表ul
	var $ul = $("#g_playlist ul");
 	var str = "<li class='js-iparent z-sel'><div class='col col-1'><div class='playicn'></div></div>"
			+ "<div class='col col-2'>"+songName+"</div><div class='col col-3' lang='"+songId+"'><div class='icns'>"
			+ "<i title='删除' class='ico icn-del'>删除</i><i title='收藏' class='j-t ico ico-add'>收藏</i></div></div>"
			+ "<div class='col col-4'><span title='"+singerName+"'><a href='user/singer?id="+singerId+"' target='_blank' class=''>"+singerName+"</a></span></div>"
			+ "<div class='col col-5'>"+timeStr+"</div></li>";
	var $li = $(str);
	$li.mouseover(function() {
		$(this).addClass("z-hover1")
		   .find(".icns").show().end()
		   .siblings().removeClass("z-hover1");			
	}).mouseout(function() {
		$(this).removeClass("z-hover1")
			.find(".icns").hide();
	}).dblclick(function() {
		if(!$("#myPlayer")[0].paused) {//如果当前有歌曲在播放，则暂停该歌曲的播放
			window.parent.stopCurSong();
			$("#g_player .play .words").attr("lang", songId);//设置刚播放完的歌曲的id
			window.parent.prepareForPlay(songId);
		}				
		$("#g_player .play .name").text(songName);//设置歌曲名
		$("#g_player .play .by").text(singerName);//设置歌手名
		$("#g_player .play .totalTime").text(timeStr);//设置歌曲时长
		$("#g_player .play .curTime").text("00:00");//设置歌曲播放进度
		$("#g_player .play .words").attr("lang", songId);//设置歌曲播放进度 */
		//$("#myPlayer")[0].play();
	});
	//收藏播放列表中的歌曲到歌单
	$li.find(".ico-add").click(function() {					
		collectSong($(this)[0]);
	});
	//从播放列表中移除歌曲
	$li.find(".icn-del").click(function() {		
		$li.remove();
		$("#songCountInList").text(parseInt($("#songCountInList").text()) - 1);//更新播放列表中的歌曲数目
		$("#g_player .ctrl .icn-list").text($("#songCountInList").text());//更新播放列表歌曲数
	});
	
    $ul.append($li);   		             	
    $("#songCountInList").text(parseInt($("#songCountInList").text()) + 1);//更新播放列表中的歌曲数目
    $("#g_player .ctrl .icn-list").text($("#songCountInList").text());//更新播放列表歌曲数
    $ul.append($li);
}