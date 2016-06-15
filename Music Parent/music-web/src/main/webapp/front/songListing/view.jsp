<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>${vo.name} - 我的音乐</title>
    	
	<link rel="stylesheet" type="text/css" href="css/user/playlist.css">
	<link rel="stylesheet" type="text/css" href="css/user/btns.css">

	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="js/user/addToPlayList.js"></script>
	
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
			
			//点击收藏歌单
   			$("#toplist-fav").click(function() {
   				//判断当前用户是否已经登录
				if($("#global_user_infobox").size() == 0) {//如果当前尚未登录，则弹出登录悬浮框
					$("#loginHref").trigger("click");
					return;
				}
   				
   				 $.post('songListing_collect.action', {listingId:'${vo.id}'}, function(data) {
   					 if(data) {//歌单收藏成功   						 
   						 alert("歌单收藏成功");
   					 } else {
   						alert("歌单收藏失败");		 
   					 }  					 
   				 });
   			});
   			   			
   			//点击收藏按钮弹出收藏悬浮框
   			$("#m-song-list-module td .s-bg-12").click(function() {
   				//判断当前用户是否已经登录
				if($("#global_user_infobox").size() == 0) {//如果当前尚未登录，则弹出登录悬浮框
					$("#loginHref").trigger("click");
					return;
				}
   			
   				//获取当前选择的歌曲的编号
   				var songId = $(this).parent().parent().attr("lang");
   				$("input[name='songToCollect']").val(songId);
   				
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
						var $li = $(str);
						//为li添加点击事件
						$li.click(function() {
							var songId = $("input[name='songToCollect']").val();//获取要收藏的歌曲的编号
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
   			$("#m-song-list-module td .u-icn-81").click(function() {
   				addToPlayList($(this));	
   			});
   			
   			//点击播放歌曲
   			$("#m-song-list-module td .s-bg-11").click(function() {
   				addToPlayList($(this));
   				stopCurSong();//当前歌曲播放完毕
   				var songId = $(this)[0].lang.split(",")[0];   							
   	        	prepareForPlay(songId);	//为歌曲播放做准备
   	        	$("#myPlayer")[0].play();
   			});
		});
	</script>
  </head>
  
  <body>
    <!-- 导航栏 -->
    <div>
		<jsp:include page="../top.jsp"></jsp:include>
	</div>
	
	<!-- 中间部分 -->
	<div class="ui_layout">
		<!-- 左边 -->
		<div class="ui_left">
			<!-- 歌单信息 -->
		<div class="list_info">
			<img class="f-fl" width="208" height="208" style="border:1px solid #ccc; padding: 2px;" 
				alt="${vo.name}" src="${vo.image}">
			<div class="detail f-ff2">
				<!-- 标题 -->
				<div class="title">
					<i class="f-fl u-icn u-icn-13">&nbsp;</i>
					<div class="tit">
						<h3 class="f-fl f-brk">${vo.name}</h3>
					</div>
				</div>
				<!-- 创建用户 -->
				<div class="user">
					<a href="user/user?id=${vo.userPo.id}" class="face" target="_top">
						<img width="35" height="35" src="${vo.userPo.headImg}">
					</a>
					<span class="name">
						<a class="s-fc7" href="user_view.action?id=${vo.userPo.id}" target="_top">${vo.userPo.account}</a>
					</span>
					<span class="time">${vo.createDate}&nbsp;创建</span>
				</div>
				<!-- 按钮 -->				
				<div class="btns">
					<!-- <a class="u-btn2 u-btn2-2 u-btni-addply" href="javascript:;"><i><em class="ply">&nbsp;</em>播放</i></a>
					<a title="添加到播放列表" class="u-btni u-btni-add gap" href="javascript:;"></a> -->
					<a href="javascript:;" class="u-btni u-btni-fav gap" id="toplist-fav"><i>收藏</i></a>
					<a class="u-btni u-btni-cmmt j-cmt" href="javascript:;"><i>评论(<span id="comment-count">${pageBean.totalRecords}</span>)</i></a>
				</div>
				<p class="intr"><b>介绍：</b>${vo.description}</p>
			</div>
		</div>
		<!-- 歌曲列表 -->
		<div class="song_list">
			<div class="u-title u-title-1 f-cb">
				<span class="hd f-fl">歌曲列表</span>					
				<span class="sub f-fl">${songList.size()}首歌</span>
				<span class="more f-ff2">播放：<strong class="s-fc6 j-play-count">${vo.playCount}</strong>次</span>					
			</div>
			<%-- 歌曲来源 --%>
			<span id="song_src" style="display: none;">listing</span>
			<span id="obj_id" style="display: none;">${vo.id}</span>
			<table class="m-table" id="m-song-module">
				<thead>
					<tr>
						<th class="first w1"><div class="wp">&nbsp;</div></th>
						<th><div class="wp">歌曲标题</div></th>
						<th class="w2"><div class="wp">时长</div></th>
						<th class="w3"><div class="wp">歌手</div></th>
						<th class="w4"><div class="wp">专辑</div></th>
					</tr>
				</thead>
				<tbody id="m-song-list-module">
				<c:forEach items="${songList}" var="song" varStatus="status">
				<tr class="ztag even">
					<td class="left first_td">
						<div class="hd">								
							<span class="num">${status.index+1}</span>
							<span title="播放" lang="${song.id},${song.name},,${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},
								${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},${song.duration}" 
								class="s-bg s-bg-11 playBtn">&nbsp;</span>
						</div>
					</td>
					<td class="second_td">
						<div class="f-cb" lang="${song.id}">
							<div class="tt">
								<div class="ttc ttc-1">
									<span class="txt">
										<a title="Play" href="song_view.action?id=${song.id}" target="_top">${song.name}</a>
									</span>
								</div>
							</div>
							<div class="opt" style="display: none;">
								<span title="添加到播放列表" lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},
								${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},${song.duration}" 
									class="u-icn u-icn-81">&nbsp;</span>
								<span class="s-bg s-bg-12" title="收藏">&nbsp;</span>
							</div>
						</div>
						</td>
						<td class="third_td"><myTag:duration duration="${song.duration}" /> </td>
						<td  class="fourth_td">
							<div class="text">
								<c:forEach items="${fn:split(song.singerInfo, ' ')}" var="singer">
									<a title="${fn:split(singer, ',')[1]}" href="singer_view.action?id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a>
								</c:forEach>
							</div>
						</td>
						<td class="fifth_td">
						<div class="text">						
							<a title="${fn:split(fn:split(song.albumInfo, ' ')[0],',')[0]}" href="album_view.action?id=${fn:split(fn:split(song.albumInfo, ' ')[0],',')[0]}" class="s-fc3" target="_top">${fn:split(fn:split(song.albumInfo, ' ')[0],',')[1]}</a>
						</div>
					</td>
				</tr>
				</c:forEach>						
				</tbody>
			</table>
			<!-- 添加到歌单标签 -->
			<myTag:addToPlaylist top="220" left="100" />
		</div>
			
		<!-- 评论列表 -->
		<myTag:remark id="${vo.id}" type="3" publishRemarkUrl="remark_publish.action" pageBean="${pageBean}" />	
		</div>
		
		<!-- 右边 -->
		<div class="ui_right f-ff2">
			<!-- 喜欢该歌单的人 -->
			<div class="u-hd">
				<h5 class="title">喜欢这个歌单的人</h5>
				<ul class="m-piclist">
					<c:forEach items="${userList}" var="user">
					<li>
						<a href="user_view.action?id=${user.id}"><img src="${user.headImg}" width="50" height="50"/></a>
					</li>
					</c:forEach>					
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 底部 -->
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<!-- 播放控件 -->
	<myTag:playbar />
  </body>
</html>
