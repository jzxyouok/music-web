<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>${vo.name} - 我的音乐</title>
    
	<link rel="stylesheet" type="text/css" href="css/user/singer.css">
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
	
   	<script type="text/javascript">
   		$(function(){
   			//设置榜单项偶数行背景色换色
   			$(".m-tabs li").click(function() {
   				$(this).find("a").addClass("z-slt").end()
   					   .siblings().find("a").removeClass("z-slt");
   			}); 
   		});
   	</script>
  </head>
  
  <body>
    <!-- 导航栏 -->
    <div>
		<jsp:include page="../top.jsp"></jsp:include>
	</div>
	
	<!-- 内容 -->
	<div class="ui_layout">
		<!-- 左侧部分 -->
		<div class="ui_left">
			<div class="head">
				<img src="${vo.bigImg}" />
				<div class="mask">&nbsp;</div>
				<span>${vo.name}</span>
			</div>
			<div class="content">
				<div class="inner_nav">
					<ul class="m-tabs f-cb" id="m_tabs">
						<li class="fst"><a class="z-slt" href="singer_songList.action?id=${vo.id}" target="contentFrame"><em>热门50单曲</em></a></li>
						<li><a href="singer_albumList.action?id=${vo.id}" target="contentFrame"><em>所有专辑</em></a></li>
						<li><a href="singer_intro.action?id=${vo.id}" target="contentFrame"><em>歌手介绍</em></a></li>
					</ul>
				</div>
				<div class="frameDiv">
					<iframe id="contentFrame" width="640" height="1100" style="border: none;" src="singer_songList.action?id=${vo.id}" name="contentFrame"></iframe>
				</div>				
			</div>
		</div>
		<!-- 右侧部分 -->
		<div class="ui_right">
			<!-- 相似的歌手 -->
			<div class="u-hd">
				<h5 class="title">相似的歌手</h5>
				<ul class="m-piclist">
					<c:forEach items="${singerList}" var="singer">
					<li>
						<a href="singer_view.action?id=${singer.id}"><img  title="${singer.name}" src="${singer.smallImg}" width="50" height="50" /></a>
						<a href="singer_view.action?id=${singer.id}"><span style="height:18px; overflow: hidden;" title="${singer.name}">${singer.name}</span></a>
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
