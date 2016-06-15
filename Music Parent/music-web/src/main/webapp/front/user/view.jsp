<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
    
    <title>${vo.account}的个人主页</title>
    		
	<link rel="stylesheet" type="text/css" href="css/user/user.css"/>
  </head>
  
  <body>
    <!-- 导航栏 -->
    <div>
		<jsp:include page="../top.jsp"></jsp:include>
	</div>
	
	<!-- 中间部分 -->
	<div class="ui_layout">
		<!-- 个人信息 -->
		<dl id="head-box" class="m-proifo f-cb">
			<dt id="ava" class="f-fl">
				<img src="${vo.headImg}" width="180" height="180">
			</dt>
			<dd>
			<div class="name f-fl">
				<h2 class="f-fl f-cb"><span class="tit f-ff2 s-fc0">${vo.account}</span></h2>		
			</div>		
			<div class="inf">个人介绍：${vo.description}</div>			
			</dd>
		</dl>
		
		<!-- 我创建的歌单 -->
		<div class="song_listing">
			<div class="v-hd2">
				<span class="tit">我创建的歌单（${fn:length(listingCreated)}）</span>				
			</div>
			<ul class="m-cvrlst f-cb">
				<c:forEach items="${listingCreated}" var="listing">				
				<li>
					<div class="u-cover u-cover-1">						
						<a class="msk" href="songListing_view.action?id=${listing.id}" title="${listing.name}">
							<img src="${listing.image}"  width="140" height="140">
						</a>
						<div class="bottom">
							<a href="javascript:;" title="播放" class="icon-play f-fr"></a>
							<span class="icon-headset"></span>
							<span class="nb">${listing.playCount}</span>
						</div>
					</div>
					<p class="dec">
						<a  href="songListing_view.action?id=${listing.id}" class="tit s-fc0" title="${listing.name}">
						${listing.name}
						</a>
					</p>					
				</li>
				</c:forEach>				
			</ul>
		</div>
		<!-- 我收藏的歌单 -->
		<div class="song_listing">
			<div class="v-hd2">
				<span class="tit">我收藏的歌单（${fn:length(listingCollected)}）</span>				
			</div>
			<ul class="m-cvrlst f-cb">				
				<c:forEach items="${listingCollected}" var="listing">				
				<li>
					<div class="u-cover u-cover-1">						
						<a class="msk" href="songListing_view?id=${listing.id}" title="${listing.name}">
							<img src="${listing.image}" width="140" height="140">
						</a>
						<div class="bottom">
							<a href="javascript:;" title="播放" class="icon-play f-fr"></a>
							<span class="icon-headset"></span>
							<span class="nb">${listing.playCount}</span>
						</div>
					</div>
					<p class="dec">
						<a  href="songListing_view?id=${listing.id}" class="tit s-fc0" title="${listing.name}">
						${listing.name}
						</a>
					</p>					
				</li>
				</c:forEach>				
			</ul>
		</div>
	</div>
	
	<!-- 底部 -->
	<jsp:include page="../footer.jsp"></jsp:include>
  </body>
</html>
