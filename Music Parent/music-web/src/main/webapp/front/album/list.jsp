<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>新碟上架 - 我的音乐</title>
   	
   	<link rel="stylesheet" type="text/css" href="css/user/albumlist.css"/>
   	
   	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
   	<script type="text/javascript" src="js/user/index.js"></script>
   	
   	<script type="text/javascript">
   		$(function(){
   			//设置榜单项偶数行背景色换色
   			$(".new_song_rank li:even, .hot_song_rank li:even").each(function() {
   				$(this)[0].style.backgroundColor = '#ccc';
   			});
   			
   			$(".song_listing .s-fc3").click(function() {
   				var area = $(this).text();alert(area);
   				if(area != '全部') {
   					$("input[name='area']").val(area);
   				}
   				$("#pageForm").submit();
   			});
   			
   			//悬浮显示播放按钮
   			/* $(".u-cover").mouseover(function() {
   				var index = $(".u-cover").index($(this));
   				$(this).find(".icon-play").css("background-position", "0 -132px");
   			}).mouseout(function() {
   				$(this).find(".icon-play").css("background-position", "100px 10px");
   			}); */
   		});
   	</script>
  </head>
  
  <body>
    <!-- 导航栏 -->
    <div>
		<jsp:include page="../top.jsp"></jsp:include>
	</div>
	
	<div class="ui_layout">
		<!-- 热门新碟 -->
		<div class="hot_album">
			<div class="v-hd2">
				<a class="tit" href="album_list.action.jsp">热门新碟</a>					
			</div>
			<ul class="album_ul">
			  <c:forEach items="${hotAlbumList}" var="album">
	          <li>
	             <div class="u-cover">
	             	<a title="${album.name}" class="c333" href="album_view.action?id=${album.id}">
	             		<img src="${album.image}" width="128" height="128">
	             	</a>	             	              
					<!-- <a class="icon-play f-alpha" title="播放" href="javascript:;">&nbsp;</a> -->
	             </div>
	             <p class="mt5">
	                 <a title="${album.name}" class="c333" href="album_view.action?id=${album.id}" style="height:26px; line-height:26px; display:inner-block;">${album.name}</a><br/>
	                 <span style="color:#666;">${album.publishDate}</span>
	             </p>
	          </li>
	          </c:forEach>                                                                                                                                    						
			</ul>
		</div>
		
		<!-- 热门推荐 -->
		<div class="song_listing">
			<div class="v-hd2">
				<a class="tit" href="album_list.action">全部新碟</a>
				<div class="tab" style="margin-left: 140px; margin-top: 0px;">
					<a class="s-fc3" href="javascript:void(0);">全部</a>
					<span class="line">|</span>
					<a class="s-fc3" href="javascript:void(0);">华语</a>
					<span class="line">|</span>
					<a class="s-fc3" href="javascript:void(0);">欧美</a>
					<span class="line">|</span>
					<a class="s-fc3" href="javascript:void(0);">韩国</a>
					<span class="line">|</span>
					<a class="s-fc3" href="javascript:void(0);">日本</a>
				</div>
			</div>
			<ul class="album_ul">
			  <c:forEach items="${pageBean.dataList}" var="album">                
	          <li>
	             <div class="u-cover">
	             	<a title="${album.name}" class="c333" href="album_view.action?id=${album.id}">
	             		<img src="${album.image}" width="128" height="128">
	             	</a>	             	              
					<!-- <a class="icon-play f-alpha" title="播放" href="javascript:;">&nbsp;</a> -->
	             </div>
	             <p class="mt5">
	                 <a title="${album.name}" class="c333" href="album_view.action?id=${album.id}" style="height:26px; line-height:26px; display:inner-block;">${album.name}</a><br/>
	                 <span style="color:#666;">${album.publishDate}</span>
	             </p>
	          </li>
	          </c:forEach>	                                                                                                                                                                 								
			</ul>
			<!-- 分页条 -->
			<div class="pagePlugin" style="width:500px; margin: 10px auto; clear:both;">
				<form id="pageForm" name="pageForm" action="album_list.action" method="post">
					<input type="hidden" name="area" value="">				
					<myTag:page form="pageForm" pageBean="${pageBean}" />
				</form>
			</div>
		</div>	
	</div>
	
	<!-- 底部 -->
	<jsp:include page="../footer.jsp"></jsp:include>
  </body>
</html>