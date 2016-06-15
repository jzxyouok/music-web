<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>搜索结果 - 我的音乐</title>
    	
	<link rel="stylesheet" type="text/css" href="css/user/search.css">
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
   	
   	<script type="text/javascript">
   		$(function(){
   			//设置榜单项偶数行背景色换色
   			$(".m-tabs li").click(function() {
   				$(this).find("a").addClass("z-slt").end()
   					   .siblings().find("a").removeClass("z-slt");
   			});
   			
   			//点击搜索提交表单 
   			$(".pgsrch a").click(function() {
   				$(".pgsrch form").submit();
   			});
   		});
   	</script>
  </head>
  
  <body>
    <!-- 导航栏 -->
    <div>
		<jsp:include page="top.jsp"></jsp:include>
	</div>
	
	<!-- 中间 -->
	<div class="ui_layout">
		<div class="pgsrch f-pr j-suggest" style="position: relative;">
			<form action="songListing_toSearch.action" method="post">
				<input type="text" value="${key}" name="key" class="srch" maxlength="30" >
				<a title="搜索" class="btn" href="javascript:void(0)">&nbsp;</a>
			</form>						
		</div>
		<div id="m-search">
			<div class="snote">搜索“${key}”，找到 <b class="s-fc6"></b> <span></span></div>
			<ul class="m-tabs" id="m_tabs">
				<li class="fst"><a class="z-slt" href="song_list.action?songForm.key=${key}" target="contentFrame2"><em>单曲</em></a></li>
				<li><a href="singer_listForSearch.action?singerForm.key=${key}" target="contentFrame2"><em>歌手</em></a></li>
				<li><a href="album_listForSearch.action?albumForm.key=${key}" target="contentFrame2"><em>专辑</em></a></li>
				<li><a href="songListing_listForSearch.action?songListingForm.key=${key}" target="contentFrame2"><em>歌单</em></a></li>
			</ul>
			
			<div id="result_frame">
				<iframe id="contentFrame" src="song_list.action?songForm.key=${key}" width="920" height="700" style="border: none" name="contentFrame2"></iframe>
			</div>
		</div>
	</div>
	
	<!-- 底部 -->
	<jsp:include page="footer.jsp"></jsp:include>
	
	<!-- 播放控件 -->
	<myTag:playbar />
  </body>
</html>
