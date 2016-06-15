<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">    
    
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="js/user/addToPlayList_2.js"></script>   	
	<link rel="stylesheet" type="text/css" href="css/user/btns.css">
	
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
   				var $songIdHidden = $(".song_list").find("input[name='songIdHidden']");
   				if($songIdHidden.size() == 0) {
   					$songIdHidden = $("<input name='songIdHidden' type='hidden' value='"+songId+"'>");
   					$(".song_list").append($songIdHidden);
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
							$.post('songListing_addSongToListing', {'songId':songId, 'listingId':listingId}, function(data) {
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
	
	<style type="text/css">
		/* 歌曲列表 */
		body {
			width: 630px;
		}
		.song_list {
			width: 630px;
			margin-top:25px;
		}
		.song_list .sub, #comment-box .sub {
			margin-left: 10px;
			margin-top: 4px;
			font-size: 13px;
		}		
		.m-table {
			width: 630px;
			border-collapse: collapse;
			margin-top: 20px;
		}
		.m-table td {
			min-width: 70px;
		}
		.m-table tr {
			height:30px;
		}
		.f-cb .opt {
			float: right;
			margin-top: -15px;
		}
		.f-cb .opt span {
			width:20px;
			display: inline-block;
			cursor: pointer;
		}
		#m-song-list-module td {
			padding-left: 5px;
			font-size: 14px;
			color:#333;
		}
		#m-song-list-module td.first_td {
			width:70px;
		}
		#m-song-list-module td.second_td {
			width:210px;
		}
		#m-song-list-module td.third_td {
			width:70px;
		}
		#m-song-list-module td.fourth_td {
			width:120px;
		}
		#m-song-list-module a {
			text-decoration: none;
			color:#333;
		}
		#m-song-list-module a:hover {
			text-decoration: underline;
		}
		.s-bg {
		    background: url("images/other/index.png") no-repeat scroll 0 9999px rgba(0, 0, 0, 0);
		}
		.s-bg-11 {
		    background-position: -267px -268px;
		}
		.s-bg-11:hover {
		    background-position: -267px -288px;
		}
		.s-bg-12 {
		    background-position: -297px -268px;
		}
		.s-bg-12:hover {
		    background-position: -297px -288px;
		}
		.u-icn{
		    background: url("images/other/icon.png") no-repeat scroll 0 9999px rgba(0, 0, 0, 0);
		}
		.u-icn-81 {
		    background-position: 0 -700px;
		    height: 13px;
		    width: 13px;
		}
		.ztag .left .playBtn {
			width:20px;
			display: inline-block;
			margin-left: 20px;
			cursor: pointer;
		}
	</style>
  </head>
  
  <body>
    <!-- 歌曲列表 -->
	<div class="song_list">
		<!-- 按钮 -->				
		<!-- <div class="btns">
			<a class="u-btn2 u-btn2-2 u-btni-addply" href="javascript:;"><i><em class="ply">&nbsp;</em>播放热门50</i></a>
			<a title="添加到播放列表" class="u-btni u-btni-add gap" href="javascript:;"></a>
		</div> -->
		<%-- 歌曲来源 --%>
		<span id="song_src" style="display: none;">song</span>
		<table class="m-table" id="m-song-module">			
			<tbody id="m-song-list-module">
			<c:forEach items="${songList}" var="song" varStatus="status">
			<tr class="ztag even">
				<td class="left first_td">
					<div class="hd">								
						<span class="num">${status.count}</span>
						<span title="播放"  lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},,${song.duration}" 
							class="s-bg s-bg-11 playBtn">&nbsp;</span>
					</div>
				</td>
				<td class="second_td">
					<div class="f-cb" lang="${song.id}">
						<div class="tt">
							<div class="ttc ttc-1">
								<span class="txt">
									<a title="${song.name}" href="song_view.action?id=${song.id}" target="_blank">${song.name}</a>
								</span>
							</div>
						</div>
						<div class="opt" style="display: none;">
							<span title="添加到播放列表"  lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},,${song.duration}" 
								class="u-icn u-icn-81">&nbsp;</span>
							<span class="s-bg s-bg-12" title="收藏">&nbsp;</span>
						</div>
					</div>
					</td>
					<td class="third_td"><myTag:duration duration="${song.duration}" /></td>
					<td  class="fourth_td">
						<div class="text">
							<c:forEach items="${fn:split(song.albumInfo, ' ')}" var="album">
								<span title="${fn:split(album, ',')[1]}"><a title="${fn:split(album, ',')[1]}" class="s-fc3" href="album_view.action?id=${fn:split(album, ',')[0]}">${fn:split(album, ',')[1]}</a></span>
							</c:forEach>
						</div>
					</td>				
			</tr>
			</c:forEach>						
			</tbody>
		</table>
		<!-- 添加到歌单标签 -->
		<myTag:addToPlaylist top="50" left="100" />
	</div>
		
  </body>
</html>
