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
    
    <title>${vo.name} <c:forEach items="${fn:split(vo.singerInfo, ' ')}" var="singer">
								${fn:split(singer, ',')[1]}
							</c:forEach> - 我的音乐</title>
   
	<link rel="stylesheet" type="text/css" href="css/user/album.css">
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
			
			//点击收藏按钮弹出收藏悬浮框
   			$("#m-song-list-module td .s-bg-12").click(function() {
   				//判断当前用户是否已经登录
				if($("#global_user_infobox").size() == 0) {//如果当前尚未登录，则弹出登录悬浮框
					$("#loginHref").trigger("click");
					return;
				}
   			
   				//获取当前选择的歌曲的编号
   				var id = $(this).parent().parent().attr("lang");
   				$("input[name='songToCollect']").val(id);
   				
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
   				var id = $(this)[0].lang.split(",")[0];   							
   	        	prepareForPlay(id);	//为歌曲播放做准备
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
		<!-- 左边部分 -->
		<div class="ui_left">
			<!-- 专辑介绍 -->
			<div class="m-info f-cb">
				<div class="cover f-fl">
					<img class="j-img" src="${vo.image}" width="177" height="177">
					<span class="msk"></span>
				</div>
				<div class="cnt f-fl">
					<div class="cntc">
						<div class="topblk">
							<div class="hd f-cb">
								<i class="f-fl u-icn u-icn-16">&nbsp;</i>
								<span class="f-fl title">${vo.name}</span>
							</div>
							<p class="intr">
								<span>歌手：</span>
								<c:forEach items="${fn:split(vo.singerInfo, ' ')}" var="singer">
									<a title="${fn:split(singer, ',')[1]}" href="singer_view.action?id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a>
								</c:forEach>
							</p>
							<p class="intr"><span>发行时间：</span>${vo.publishDate}</p>
							<p class="intr"><span>发行公司：</span>
							${vo.company==null ? 独立发行 : vo.company }
							</p>
						</div>
						<!-- 按钮 -->				
						<%-- <div class="btns">
							<a class="u-btn2 u-btn2-2 u-btni-addply" href="javascript:;"><i><em class="ply">&nbsp;</em>播放</i></a>
							<a title="添加到播放列表" class="u-btni u-btni-add gap" href="javascript:;"></a>
							<!-- <a href="javascript:;" class="u-btni u-btni-fav gap" id="toplist-fav"><i>收藏(55827)</i></a> -->
							<a class="u-btni u-btni-cmmt j-cmt" href="javascript:;"><i>评论(<span id="comment-count">${pageBean.totalRecords}</span>)</i></a>
						</div> --%>
					</div>
				</div>
			</div>
			<div class="n-albdesc">
				<h5>专辑介绍：</h5>
				<p class="f-brk">${vo.description}</p>
			</div>
			<!-- 歌曲列表 -->
			<div class="song_list">
				<div class="u-title u-title-1 f-cb">
					<span class="hd f-fl">包含歌曲列表</span>					
					<%-- <span class="sub f-fl" style="font-size: 18px;">${vo.songList.size()}首歌</span> --%>							
				</div>
				<%-- 歌曲来源 --%>
				<span id="song_src" style="display: none;">album</span>
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
								<span class="num">${status.count}</span>
								<span title="播放"  lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},
								${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},${song.duration}" 
									class="s-bg s-bg-11 playBtn">&nbsp;</span>
							</div>
						</td>
						<td class="second_td">
							<div class="f-cb" lang="${song.id}">
								<div class="tt">
									<div class="ttc ttc-1">
										<span class="txt">
											<a title="Play" href="song_view.action?id=${song.id}">${song.name}</a>
										</span>
									</div>
								</div>
								<div class="opt" style="display: none;">
									<span title="添加到播放列表"  lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},
								${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},${song.duration}" 
										class="u-icn u-icn-81">&nbsp;</span>
									<span class="s-bg s-bg-12" title="收藏">&nbsp;</span>
								</div>
							</div>
							</td>
							<td class="third_td"><myTag:duration duration="${song.duration}" /> </td>
							<td  class="fourth_td">
								<div class="text">
									<c:forEach items="${fn:split(vo.singerInfo, ' ')}" var="singer">
										<a title="${fn:split(singer, ',')[1]}" href="singer_view.action?id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a>
									</c:forEach>
								</div>
							</td>
							<td class="fifth_td">
							<div class="text">
								<a title="${vo.name}" href="album_view.action?id=${vo.id}" onclick="javascript:void(0); return false;" class="s-fc3">${vo.name}</a>
							</div>
						</td>
					</tr>
					</c:forEach>					
				</table>
				<!-- 添加到歌单标签 -->
				<myTag:addToPlaylist top="420" left="240" />
			</div>
			
			<!-- 评论列表 -->
			<myTag:remark id="${vo.id}" type="2" publishRemarkUrl="remark_publish.action" pageBean="${pageBean}" />
		</div>
		
		<!-- 右边部分 -->
		<div class="ui_right">			
			<h3 class="u-hd3">
				<span class="f-fl">Ta的其他热门专辑</span>
				<!-- <a class="more f-ff1 s-fc3" href="/artist/album?id=3681">全部&gt;</a> -->
			</h3>
			<ul class="m-rctlist f-cb">
				<c:forEach items="${otherAlbumList}" var="album">
				<li>
					<div class="cver u-cover u-cover-3">
						<a title="${vo.name}" href="album_view.action?id=${vo.id}">
							<img src="${vo.image}" width="50" height="50">
						</a>
					</div>
					<div class="info">
						<p class="f-thide"><a title="1701" href="album_view.action?id=${vo.id}" class="sname f-fs1 s-fc0">${vo.name}</a></p>
						<p class="s-fc3">${vo.publishDate}</p>
					</div>
				</li>
				</c:forEach>				
			</ul>
		</div>		
	</div>
	
	<!-- 底部 -->
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<!-- 播放控件 -->
	<myTag:playbar />
  </body>
</html>
