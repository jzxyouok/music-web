<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>热歌榜</title>
    	
	<link rel="stylesheet" type="text/css" href="css/user/ranking.css">

	<style type="text/css">
		body {
			background-color: #F5F5F5;
		}		
		/* 主体部分 */
		.ui_layout {
			width:1000px;
			min-height:1400px;
			margin:0 auto;
			padding-top: 20px;
			padding-right:5px;
			background-color: #FFFFFF;
			border: 1px solid #ccc;
		}
		.ui_left {
			width:240px;
			min-height:140px;
			float:left;			
			padding-top: 0;
		}		
		.ui_right {
			width:730px;
			min-height:140px;
			float:right;
			padding:5px;
			background-color:#ffffff;
			border-left: 1px solid #ccc;
		}
		.rank_nav {
			padding-left: 0;
		}
		.rank_nav li {
			list-style: none;
			padding: 10px 20px;
			cursor: pointer;
			background-color: #eee;
		}
		.rank_nav li.selected {
			background-color: #ccc;			
		}
		.rank_nav li a {
			text-decoration:none;			
			font-size: 14px;
			color: #000;
			position: relative;
			top: -10px;
			padding-right: 110px;
			padding-top: 20px;
			padding-bottom: 10px; 
		}
	</style>

	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="js/user/addToPlayList_2.js"></script>	
	<script type="text/javascript">
		$(function() {
			//表格隔行换色
			$("tbody tr:even").css("background-color", "#f1f1f1");
			
			//鼠标经过行换色
			$("tbody tr").mouseover(function() {
				$(this).css("background-color", "#ccc");
				$(this).find(".second_td .opt").show();//显示添加、收藏按钮
			}).mouseout(function() {
				var index = $("tbody tr").index($(this));
				if(index % 2 == 0) {
					$(this).css("background-color", "#f1f1f1");							
				} else {
					$(this).css("background-color", "#fff");
				}
				$(this).find(".second_td .opt").hide();//隐藏添加、收藏按钮
			});
			
			//点击收藏按钮弹出收藏悬浮框
   			$("#m-song-module td .s-bg-12").click(function() {
   				//判断当前用户是否已经登录
				if('${userInfo==null}' == 'true') {//如果当前尚未登录，则弹出登录悬浮框
					parent.$("#loginHref").trigger("click");
					return;
				}
   			
   				//获取当前选择的歌曲的编号
   				var songId = $(this).parent().parent().attr("lang");   				
   				//$("input[name='songToCollect']").val(songId);
   				var $songIdHidden = $(".content").find("input[name='songIdHidden']");
   				if($songIdHidden.size() == 0) {
   					$songIdHidden = $("<input name='songIdHidden' type='hidden' value='"+songId+"'>");
   					$(".content").append($songIdHidden);
   				} else {
   					$songIdHidden.val(songId);
   				}
   				
   				//ajax加载用户创建的歌单列表
   				var $ul = $(".auto-1429023468669 ul");
   				var $liList = $ul.find("li");
   				if($liList.size() > 0) {//如果已经加载了歌单列表，则不移除之前的歌单项
   					$liList.remove();
   				}
   				
   				$.post('songListing_loadListing.action', {}, function(data) {
   					var jsonArr = JSON.parse(data); 	
   					for(var i in jsonArr) {
   						var jsonObj = jsonArr[i];	 							 						
   		             	var str = '<li lang="' + jsonObj.id + '"><div class="item"><div class="left">'
							+'<a target="_blank" class="avatar" href="javascript:void(0)">'
							+'<img src="' + jsonObj.image + '" alt=""></a>'
							+'</div><p class="name"><a target="_blank" href="javascript:void(0)">'+ jsonObj.name +'</a></p>'
							+'<p class="s-fc3">'+ jsonObj.songsInListing +'首</p></div></li>';
						var $li = parent.$(str);
						//为li添加点击事件
						$li.click(function() {
							var songId = $("input[name='songIdHidden']").val();//获取要收藏的歌曲的编号
							var listingId = $(this).attr("lang");				//获取歌单编号
							//ajax添加歌单歌曲项
							$.post('songListing_addSongToListing', {'songId':songId, 'id':listingId}, function(data) {
								$(".zcls:eq(0)").parent().hide();//关闭弹窗
								if(data == 'success') {//歌曲收藏成功
									alert("收藏成功");								
								} else {
									alert("收藏失败");
								}								
							});							
						});							

   		             	$ul.append($li); 						
   					}
   				});
   				$(".zcls:eq(0)").parent().show();   				
   			});
   			
   			//点击添加到播放列表按钮添加到播放列表			
   			$("#m-song-list-module tr .u-icn-81").click(function() {   				
   				addToPlayList($(this));	
   			});
   			
   			//点击播放歌曲
   			$("#m-song-list-module tr .s-bg-11").click(function() {
   				addToPlayList($(this));
   				window.parent.stopCurSong();//当前歌曲播放完毕
   				var itemArr = $(this)[0].lang.split(",");
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
   				   							
   	        	window.parent.prepareForPlay(songId);	//为歌曲播放做准备
   	        	
   	        	$("#g_player .play .name", window.parent.document).text(songName);//设置歌曲名
				$("#g_player .play .by", window.parent.document).text(singerName);//设置歌手名
				$("#g_player .play .totalTime", window.parent.document).text(timeStr);//设置歌曲时长
				$("#g_player .play .curTime", window.parent.document).text("00:00");//设置歌曲播放进度
				$("#g_player .play .words", window.parent.document).attr("lang", songId);//设置歌曲播放进度 */
   	        	
   	        	$("#myPlayer", window.parent.document)[0].play();
   			});
		});
	</script>
  	<script type="text/javascript">
   		$(function(){
   			//设置榜单项偶数行背景色换色
   			$(".rank_nav li").click(function() {
   				$(this).addClass("selected")   					   
   					   .siblings().removeClass("selected");
   			});   			
   			
   			
   			/* 跳转至指定排行榜页面  */
			var type = '${type}';
			if (type == 'new' ) {
				//$("#frame").attr("src", "user/new_ranking.jsp");//设置iframe的src
				//$(".rank_nav li:eq(0)").trigger("click");
				$(".rank_nav li:eq(0)").addClass("selected")
						.siblings().removeClass("selected");
			} else if (type == 'hot' ) {
				//$("#frame").attr("src", "user/hot_ranking.jsp");//设置iframe的src
				//$(".rank_nav li:eq(1)").trigger("click");
				$(".rank_nav li:eq(1)").addClass("selected")
					.siblings().removeClass("selected");
			}
						
   		});
   	</script>
  </head>
  
  <body>
  	<!-- 导航栏 -->
    <div>
		<jsp:include page="../top.jsp"></jsp:include>
	</div>
  	
    <div class="content">
    	<!-- 中间部分 -->
		<div class="ui_layout">
			<!-- 左边部分 -->
			<div class="ui_left">
				<h3 style="margin-left:20px;">榜单</h3>
				<ul class="rank_nav">
					<li class="selected">
						<img alt="新歌榜" src="images/other/6047313953046304.jpg" width="40" height="40">	
						<a href="song_ranking.action?type=new" target="_self">新歌榜</a>
					</li>
					<li>
						<img alt="热歌榜" src="images/other/5901078906483408.jpg" width="40" height="40">
						<a href="song_ranking.action?type=hot" target="_self">热歌榜</a>
					</li>
				</ul>	
			</div>
			<!-- 右边部分 -->
			<div class="ui_right">
				<div class="frameDiv">
					<!-- 歌曲列表 -->
					<div class="song_list">
						<div class="u-title u-title-1 f-cb">
							<span class="hd f-fl">歌曲列表</span>					
							<span class="sub f-fl" style="font-size: 16px;">${songList.size()}首歌</span>
							<!-- <span class="more f-ff2">播放：<strong class="s-fc6 j-play-count">9805</strong>次</span>				 -->	
						</div>
						<table class="m-table" id="m-song-module">
							<thead>
								<tr>
									<th class="first w1"><div class="wp">&nbsp;</div></th>
									<th><div class="wp">歌曲标题</div></th>
									<th class="w2"><div class="wp">时长</div></th>
									<th class="w3"><div class="wp">歌手</div></th>
								</tr>
							</thead>
							<tbody id="m-song-list-module">
							<c:forEach items="${songList}" var="song" varStatus="status">
							<tr class="ztag even">
								<td class="left first_td">
									<div class="hd" style="position: relative;">								
										<span class="num">${status.index+1}</span>
										<span title="播放"  lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},${song.duration}" 
											class="s-bg s-bg-11 playBtn" style="position: absolute; left: 20px;">&nbsp;</span>
									</div>
								</td>
								<td class="second_td">
									<div class="f-cb"  lang="${song.id}">
										<div class="tt">
											<div class="ttc ttc-1">
												<span class="txt">
													<a title="${song.name}" href="song_view.action?id=${song.id}" target="_top">${song.name}</a>
												</span>
											</div>
										</div>
										<div class="opt" style="display: none;">
											<span title="添加到播放列表"  lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},${song.duration}" 
												class="u-icn u-icn-81">&nbsp;</span>
											<span class="s-bg s-bg-12" title="收藏">&nbsp;</span>
										</div>
									</div>
								</td>
								<td class="third_td"><myTag:duration duration="${song.duration}"/> </td>
								<td  class="fourth_td">
									<div class="text">
										<c:forEach items="${fn:split(song.singerInfo, ' ')}" var="singer">
											<a title="${fn:split(singer, ',')[1]}" href="singer_view.action?id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a>
										</c:forEach>
									</div>
								</td>				
							</tr>
							</c:forEach>
							</tbody>
						</table>
						<!-- 添加到歌单标签 -->
						<myTag:addToPlaylist top="220" left="100" />
					</div>
				</div>
			</div>
		</div>
    </div>
    
    <!-- 底部 -->
	<div style="position: relative; top:-40px;">
	<jsp:include page="../footer.jsp"></jsp:include>
	</div>
	
	<!-- 播放控件 -->
	<myTag:playbar />
  </body>
</html>
