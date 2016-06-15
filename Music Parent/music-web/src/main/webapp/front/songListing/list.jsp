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
    
    <title>全部歌单</title>
   	
   	<link rel="stylesheet" type="text/css" href="css/user/listing.css"/>
   	   	
   	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
   	
   	<script type="text/javascript">
   		$(function() {
   			//设置歌单的显示与隐藏事件
   			$(".selectCateSpan").click(function(event) {
   				var size = $(".listing_filter_div:visible").size();
   				if(size == 0) {//当前为隐藏，则显示
   					$(".listing_filter_div").show();
   				} else {//当前为显示，则隐藏
   					$(".listing_filter_div").hide();
   				}
   				return false;//阻止事件冒泡
   			});
   			//点击，隐藏
   			$(".ui_layout").click(function() {   
   				var size = $(".listing_filter_div:visible").size();
   				if(size == 1) {//当前为显示，则隐藏
   					$(".listing_filter_div").hide();
   				}
   			});
   			
   			//排序规则点击事件
   			$(".song_listing .order a").click(function() {
   				$(this).addClass("selected")
   					   .siblings().removeClass("selected");   				
   			});
   			
   			//初始选中排序规则
   			$(".song_listing .order a").each(function() {
   				if($(this).attr("lang") == '${songListingForm.orderBy}') {
   					$(this).addClass("selected")
					   	   .siblings().removeClass("selected");
   					return false;
   				}
   			});
   			//初始设置
   			if('${songListingForm.style==null}' == 'false') {
   				$(".v-hd2 .tit").text('${songListingForm.style}');
   				$(".listing_filter_div dl:eq(1) a").each(function() {
   					if($(this).text() == '${songListingForm.style}') {
   						$(this).css({"background-color":"#aaa", "color":"#fff", "padding":"4px 2px"});
   						return false;
   					}
   				});
   			}
			if('${songListingForm.language==null}' == 'false') {
				$(".v-hd2 .tit").text('${songListingForm.language}');
				$(".listing_filter_div dl:eq(0) a").each(function() {
   					if($(this).text() == '${songListingForm.language}') {
   						$(this).css({"background-color":"#aaa", "color":"#fff", "padding":"4px 2px"});
   						return false;
   					}
   				});
   			}   			
   		});
   	</script>
  </head>
  
  <body>
    <!-- 导航栏 -->
    <div>
		<jsp:include page="../top.jsp"></jsp:include>
	</div>
	
	<div class="ui_layout">
		<!-- 歌单列表 -->
		<div class="song_listing">
			<div class="v-hd2">
				<span class="tit">全部</span>
				<span class="selectCateSpan">选择分类<em class="u-icn u-icn-38">&nbsp;&nbsp;</em></span>
				<span class="order">					
					<a class="hot selected" href="songListing_list.action?songListingForm.orderBy=hot&songListingForm.style=${songListingForm.style}&songListingForm.language=${songListingForm.language}" lang="hot">热门</a>
					<a class="new" href="songListingForm.orderBy=new&songListingForm.style=${songListingForm.style}&songListingForm.language=${songListingForm.language}" lang="new">最新</a>
				</span>
			</div>
			<!-- 单过滤div -->
			<div class="listing_filter_div" style="display: none;">
				<div class="arror_div">&nbsp;</div>			
				<h3><a href="songListing_list.action" class="title"><em>全部风格</em></a></h3>
				<hr style="color:#f1f1f1;"/>
				<dl class="f-cb">
					<dt><i class="u-icn u-icn-71"></i>语种</dt>
					<dd>
					<c:forEach items="${languageList}" var="lan">
					<a class="s-fc1 " href="songListing_list.action?songListingForm.language=${lan.value}&songListingForm.style=${songListingForm.style}">${lan.name}</a><span class="line">|</span>
					</c:forEach>					
					</dd>
				</dl>
				<dl class="f-cb">
					<dt><i class="u-icn u-icn-6"></i>风格</dt>
					<dd>
					<c:forEach items="${styleList}" var="style">
					<a class="s-fc1 " href="songListing_list.action?songListingForm.style=${style.value}">${style.name}</a><span class="line">|</span>
					</c:forEach>					
					</dd>
				</dl>				
			</div>
			<ul class="m-cvrlst">	
				<c:forEach items="${pageBean.dataList}" var="playlist">						
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
			
			<form action="songListing_list.action" method="post" name="pageForm">
				<input type="hidden" name="orderBy" value="${songListingForm.orderBy}">
				<input type="hidden" name="language" value="${songListingForm.language}">
				<input type="hidden" name="style" value="${songListingForm.style}">
			</form>
			<!-- 分页条 -->
			<div class="pagePlugin" style="width:500px; margin: 10px auto;">				
				<myTag:page form="pageForm" pageBean="${pageBean}" />
			</div>
		</div>	
	</div>
	
	<!-- 底部 -->
	<jsp:include page="../footer.jsp"></jsp:include>
  </body>
</html>
