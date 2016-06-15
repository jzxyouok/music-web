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
    
    <title>我的音乐</title>
   	
   	<link rel="stylesheet" type="text/css" href="css/user/index.css"/>
   	
   	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
   	<script type="text/javascript" src="js/user/index.js"></script>
   	<script type="text/javascript" src="js/user/addToPlayList.js"></script>
   	
   	<script type="text/javascript">
   		//收藏歌曲到歌单
   		function collectSong(obj) {
   		//判断当前用户是否已经登录
			if($("#global_user_infobox").size() == 0) {//如果当前尚未登录，则弹出登录悬浮框
				$("#loginHref").trigger("click");
				return;
			}
				
				//获取当前选择的歌曲的编号
				var songId = $(obj).parent().parent().attr("lang");
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
						var id = $(this).attr("lang");				//获取歌单编号
						//ajax添加歌单歌曲项
						$.post('songListing_addSongToListing', {'songId':songId, 'id':id}, function(data) {
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
   		}
   	
   		$(function(){
   			//设置榜单项偶数行背景色换色
   			$(".new_song_rank li:even, .hot_song_rank li:even").each(function() {
   				$(this)[0].style.backgroundColor = '#ccc';
   			});
   			
   			//点击新建按钮，新建歌单
   			$("#auto-id-1DbQenLOcXpWJDPX").click(function() {
   				var name = $("input[name='listingName']").val();
   				if(name == '') {//歌单名为空，不能添加
   					$(".auto-1429023496255 .u-err").attr("visibility", "visible");
   					return;
   				}
   				$.post('songListing_addListing.action', {'id':$("input[name='songToCollect']").val(), 'name':name}, function(data) {
   					if(data == 'success') {//歌单创建成功，歌曲已被收藏到歌单中
   						$(".auto-1429023496255").hide();		
   						alert("收藏成功");
   					}
   				});
   			});
   			
   			//点击收藏按钮弹出收藏悬浮框
   			$(".ranks li .s-bg-12").click(function() {
   				collectSong($(this)[0]);	
   			});
   			
   			//点击添加到播放列表按钮添加到播放列表
   			$(".ranks li .u-icn-81").click(function() {
   				addToPlayList($(this));	
   			});
   			
   			//点击播放歌曲
   			$(".ranks li .s-bg-11").click(function() {
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
		<jsp:include page="top.jsp"></jsp:include>
	</div>
	
	<div class="ui_layout">
		<!-- 中间的左边部分 -->
		<div class="ui_left">
			<!-- 热门推荐 -->
			<div class="song_listing">
				<div class="v-hd2">
					<a class="tit" href="user/listing">热门推荐</a>
					<div class="tab">
						<a class="s-fc3" href="user/listing?style=流行">流行</a>
						<span class="line">|</span>
						<a class="s-fc3" href="user/listing?style=摇滚">摇滚</a>
						<span class="line">|</span>
						<a class="s-fc3" href="user/listing?style=民谣">民谣</a>
						<span class="line">|</span>
						<a class="s-fc3" href="user/listing?style=电子">电子</a>
						<span class="line">|</span>
						<a class="s-fc3" href="user/listing?style=爵士">爵士</a>
					</div>
					<span class="more"><a class="s-fc3" href="user/listing">更多</a><i class="s-bg s-bg-6">&nbsp;</i></span>
				</div>
				<ul class="m-cvrlst f-cb">
					<c:forEach items="${songListing}" var="playlist">
					<li>
						<div class="u-cover u-cover-1">							
							<a class="msk" href="songListing_view.action?id=${playlist.id}" title="${playlist.name}">
								<img src="${playlist.image}" width="140" height="140">
							</a>
							<div class="bottom">
								<!-- <a href="javascript:;" title="播放" class="icon-play f-fr"></a> -->
								<span class="icon-headset"></span>
								<span class="nb">${playlist.playCount}</span>
							</div>
						</div>
						<p class="dec">
							<a href="songListing_view.action?id=${playlist.id}" class="tit s-fc0" title="${playlist.name}">
							${playlist.name}
							</a>
						</p>
					</li>
					</c:forEach>					
				</ul>
			</div>	
			
			<!-- 新碟上架 -->
			<div class="new_album">
				<div class="v-hd2">
					<a class="tit" href="album_list.action">新碟上架</a>					
					<span class="more"><a class="s-fc3" href="album_list.action" target="_blank">更多</a><i class="s-bg s-bg-6">&nbsp;</i></span>
				</div>
				<div class="listM">                    	
                     <div class="even_move" id="menu_box_movie">
                         <div class="even_left"><b class="orientation disable"></b></div>
                         <div class="even_right"><b class="orientation"></b></div>
                         <div class="even_center">
                             <ul id="menu_box_movie_inner">
                                <c:forEach items="${albumList}" var="album">                           
                               	<li>
                                  <div class="roomTypeBox" style="width:120px; height:110px; overflow:hidden; margin:0 auto;">
                                    <a title="${album.name }" href="album_view?id=${album.id}">
                                        <img alt="${album.name}" src="${album.image}" height="100" width="100">
                                    </a>
                                  </div>
                                  <p class="mt10">
                                      <a title="${album.name}" class="c333" href="album_view?id=${album.id}" style="height:26px; line-height:26px; display:inner-block;">${album.name}</a><br/>
                                      <%-- <c:forEach items="${album.singerInfo}" var="singer">
                                      <a title="${singer.name}" class="c333" href="user/singer?id=${singer.id}" style="height:26px; line-height:26px; display:inner-block;">${singer.name}</a>
                                      </c:forEach> --%>
                                  </p>
                               </li>
                               </c:forEach>                                                                                                                                                                      								
							</ul>
                         </div>
                     </div>							
                 </div>
			</div>
					
			<!-- 榜单 -->
			<div class="ranking" style="position: relative;">
				<div class="v-hd2">
					<a class="tit" href="song_ranking.action?type=hot">榜单</a>					
					<!-- <span class="more"><a class="s-fc3" href="user/rankings">更多</a><i class="s-bg s-bg-6">&nbsp;</i></span> -->
				</div>
				<div class="ranks">
					<!-- 新歌榜 -->
					<div class="new_song_rank">
						<div class="top">
							<div class="u-cover">
								<a title="新歌榜" class="msk" href="song_ranking.action?type=new">
									<img  class="j-img" src="images/other/6047313953046304.jpg">
								</a>
							</div>
							<div class="tit">
								<a class="title" title="新歌榜" href="song_ranking.action?type=new">新歌榜</a>
								<div class="btn">
									<!-- <a title="播放" class="s-bg s-bg-9" href="javascript:;">&nbsp;</a> -->
									<!-- <a title="收藏"class="s-bg s-bg-10" href="javascript:;">&nbsp;</a> -->
								</div>
							</div>
						</div>
						<div class="rank_list">
							<ul class="rank_item">
								<c:forEach items="${newSongList}" var="song" varStatus="status">
								<li onmouseout="this.className=''" onmouseover="this.className='z-hvr'"  lang="${song.id}">
									<span class="no">${status.index+1}</span>
									<a title="${song.name}" class="nm s-fc0 f-thide" href="song_view.action?id=${song.id}">${song.name}</a>
									<div class="oper">
										<a title="播放" class="s-bg s-bg-11" lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},${song.duration}" href="javascript:void(0);" href="javascript:void(0);"></a>
										<a title="添加到播放列表" class="u-icn u-icn-81"  lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},${song.duration}" href="javascript:void(0);"></a>
										<a title="收藏" class="s-bg s-bg-12" href="javascript:void(0);"></a>
									</div>
								</li>
								</c:forEach>
							</ul>
						</div>
						<div class="more"><a class="s-fc0" href="song_ranking.action?type=new">查看全部&gt;</a></div>						
					</div>
					
					<!-- 热歌榜 -->
					<div class="hot_song_rank">
						<div class="top">
							<div class="u-cover">
								<a title="热歌榜" class="msk" href="song_ranking.action?type=hot">
									<img  class="j-img" src="images/other/5901078906483408.jpg">
								</a>
							</div>
							<div class="tit">
								<a class="title" title="热榜" href="song_ranking.action?type=hot">热歌榜</a>
								<div class="btn">
									<!-- <a title="播放" class="s-bg s-bg-9 f-tdn" href="javascript:;">&nbsp;</a> -->
									<!-- <a title="收藏" class="s-bg s-bg-10" href="javascript:;">&nbsp;</a> -->
								</div>
							</div>
						</div>
						<div class="rank_list">
							<ul class="rank_item">
								<c:forEach items="${hotSongList}" var="song" varStatus="status">								
								<li onmouseout="this.className=''" onmouseover="this.className='z-hvr'" lang="${song.id}">
									<span class="no">${status.index+1}</span>
									<a title="${song.name}" class="nm s-fc0 f-thide" href="user/song?id=${song.id}">${song.name}</a>
									<div class="oper">
										<a title="播放" class="s-bg s-bg-11" lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},${song.duration}" href="javascript:void(0);" href="javascript:void(0);"></a>
										<a title="添加到播放列表" class="u-icn u-icn-81"  lang="${song.id},${song.name},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[0]},${fn:split(fn:split(song.singerInfo, ' ')[0], ',')[1]},${song.duration}" href="javascript:void(0);"></a>
										<a title="收藏" class="s-bg s-bg-12" href="javascript:void(0);"></a>
									</div>
								</li>
								</c:forEach>
							</ul>
						</div>
						<div class="more"><a class="s-fc0" href="song_ranking.action?type=hot">查看全部&gt;</a></div>						
					</div>
				
					<!-- 添加到歌单标签 -->
					<myTag:addToPlaylist top="220" left="100" />
				</div>				
			</div>
		</div>
		
		<!-- 中间的右边部分 -->
		<div class="ui_right">
			<div class="hot_singer">
				<h4 class="title">推荐歌手</h4>
				<ul class="singer_list">
					<c:forEach items="${singerList}" var="singer">				
					<li>
						<div class="head">
							<a href="singer_view.action?id=${singer.id}"><img src="${singer.smallImg}" class="j-img" style="width: 60px; height: 60px;"></a>
						</div>
						<div class="info">							
							<a href="singer_view.action?id=${singer.id}"><span class="">${singer.name}</span></a><br/>
							<%-- <p class="f-thide s-fc3">${singer.dicName}</p> --%>							
						</div>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 底部 -->
	<div style="position: relative; top:-40px;">
	<jsp:include page="footer.jsp"></jsp:include>
	</div>
	
	<!-- 播放控件 -->
	<myTag:playbar />
  </body>
</html>
