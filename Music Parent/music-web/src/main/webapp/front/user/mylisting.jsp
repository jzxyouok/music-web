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
    
    <title>我创建的歌单</title>
    	
	<link rel="stylesheet" type="text/css" href="css/user/mylisting.css">
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
	
   	<link rel="stylesheet" type="text/css" href="js/common/artDialog-5.0.3/skins/default.css" />
    <script src="js/common/artDialog-5.0.3/artDialog.min.js"></script>
        
   	<script type="text/javascript">
   		var op;		//删除歌单还是取消收藏
   		$(function(){
   			//点击标题进行伸缩
   			$(".n-minelst h4 .rtitle").click(function() {
   				var index = $(".n-minelst h4 .rtitle").index($(this));	//获取下标
   				var $ul = $(".n-minelst .detail_list:eq(" + index + ")");
   				if($ul.is(":visible")) {//如果当前可见，则折叠
   					$ul.hide();
   					$(this).parent().parent().addClass("n-minelst-hide");
   				} else {
   					$ul.show();
   					$(this).parent().parent().removeClass("n-minelst-hide");
   				}
   			});
   			
   			/* 点击显示浮动新建歌单框 */
   			$(".n-minelst:eq(0) h4 a").bind("click",function(){
   				 //清空文本框的内容
   				 $(".zcls:eq(1) input[type='text']").val("");
   				   				 
   				 $(".zcls:eq(1)").parent().show();
   			});
   			
   			//鼠标经过歌单项时，显示编辑、删除按钮;鼠标移出时，隐藏编辑、删除按钮
   			$(".n-minelst li").mouseover(function() {
   				$(this).find(".oper").show();		//显示编辑、删除按钮
   			}).mouseout(function() {
   				$(this).find(".oper").hide();		//隐藏编辑、删除按钮
   			});
   			
   			var listingName;
   			$(".n-minelst li").each(function() {
   				listingName = $(this).attr("lang").split(",")[1];
   				if(listingName == '我喜欢的音乐') {
   					alert('okkk');
   					$(this).unbind("mouseover");
   					$(this).unbind("mouseout");
   					return false;
   				}
   			});
   			
   			//点击新建按钮，新建歌单
   			$("#auto-id-1DbQenLOcXpWJDPX").click(function() {
   				var listingName = $("input[name='listingName']").val();
   				if(listingName == '') {//歌单名为空，不能添加
   					$(".auto-1429023496255 .u-err").attr("visibility", "visible");
   					return;
   				}
   				$.post('songListing_justAdd.action', {'name':listingName}, function(data) {
   					$(".auto-1429023496255").hide();
   					if(data == 'success') {//歌单创建成功,添加到当前列表中
   						alert("歌单新建成功");
   						window.location.reload();
   					} else {
   						alert("歌单新建成功");
   					}
   				});
   			});
   			
   			//初始选中第一个歌单
   			$(".detail_list:eq(0) li:eq(0)").addClass("selected");
   			
   			//歌单列表项的点击事件
   			$(".detail_list li").click(function() {
   				var listingId = $(this).attr("lang").split(",")[0];
   				$("#contentFrame").attr("src", "songListing_viewForUser.action?id="+listingId);
   				$(".detail_list li").removeClass("selected");
   				$(this).addClass("selected");
   			});
   			
   			//点击显示删除歌单按钮
   			$(".detail_list li .u-icn-11").click(function() {
   				var index = $(".detail_list").index($(this).parent().parent().parent());
   				if(index == 0) {//删除自己创建的歌单
   					op = "delete";
   				} else {//取消歌单收藏
   					op = "cancel";
   				}
   				$(".zcls:eq(2)").parent().show();
   			});
   			
   			//点击确定删除按钮，删除歌单
   			$(".zcnt:eq(2) .btn a:eq(0)").click(function() {
   				var listingId = $(".detail_list .selected").attr("lang").split(",")[0];
   				if(op == 'delete') {//删除歌单
	   				$.post('songListing_delete.action', {'id':listingId}, function(data) {
	   					$(".auto-14290234912123").hide();
	   					if(data == 'success') {//歌单删除成功,从当前列表中移除
	   						alert("歌单删除成功");
	   						
	   						//window.location.reload();
	   						window.open("user_mylisting.action", "_top");
	   					} else {
	   						alert("歌单删除失败");
	   					}
	   				});
   				} else {//取消歌单收藏
   					$.post('songListing_cacelCollect.action', {'listingId':listingId}, function(data) {
   						$(".auto-14290234912123").hide();
	   					if(data == 'success') {
	   						alert("歌单取消收藏成功");
	   						
	   						//window.location.reload();
	   						window.open("user_mylisting.action", "_top");
	   					} else {
	   						alert("歌单取消收藏失败");
	   					}
	   				});
   				}
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
		<div class="ui_left" style="position: relative;">
			<!-- 我创建的歌单 -->
			<div class="n-minelst">
				<!-- 标题 -->
				<h4 class="f-ff1">
					<a class="u-btn u-btn-crt f-ff2" href="javascript:void(0);">新建</a>
					<span class="rtitle"><i class="tri tri1">&nbsp;</i>创建的歌单(<span class="j-flag">${fn:length(listingCreated)}</span>)</span>
				</h4>
				<!-- 歌单列表 -->
				<ul class="detail_list">
					<c:forEach items="${listingCreated}" var="listing">
					<li class="${listingSel.id==listing.id ? selected : ''}" lang="${listing.id},${listing.name}">
						<div class="item f-cb">
							<div class="left f-fl">
								<a class="avatar" >
									<img alt="${listing.name}" src="${listing.image}" width="40" height="40">
								</a>
							</div>
							<div class="right f-fl">
								<p class="name">
									<a title="${listing.name}" class="s-fc0" href="javascript:void(0);" >${listing.name}</a>
								</p>
								<p class="num">${listing.songsInListing}首</p>
							</div>							
						</div>
						<span style="display: none;" class="oper">
							<a class="u-icn u-icn-10 editPlaylistHref" target="contentFrame" href="songListing_toUpdate?songListingForm.id=${listing.id}" title="编辑">&nbsp;</a>
							<a class="u-icn u-icn-11" href="javascript:void(0);" title="删除" data-action="delete">&nbsp;</a>
						</span>
					</li>
					</c:forEach>
				</ul>
			</div>
			<!-- 我收藏的歌单 -->
			<div class="n-minelst">
				<!-- 标题 -->
				<h4 class="f-ff1">
					<span class="rtitle"><i class="tri tri1">&nbsp;</i>收藏的歌单(<span class="j-flag">${fn:length(listingCollected)}</span>)</span>
				</h4>
				<!-- 歌单列表 -->
				<ul class="detail_list">
					<c:forEach items="${listingCollected}" var="listing">
					<li class="" lang="${listing.id},${listing.name}">
						<div class="item f-cb">
							<div class="left f-fl">
								<a class="avatar" >
									<img alt="/${listing.name}" src="${listing.image}" width="40" height="40">
								</a>
							</div>
							<div class="right f-fl">
								<p class="name">
									<a title="${listing.name}" class="s-fc0" href="javascript:void(0);" >${listing.name}</a>
								</p>
								<p class="num">${listing.songsInListing}首</p>
							</div>							
						</div>
						<span style="display: none;" class="oper">							
							<a class="u-icn u-icn-11" href="javascript:void(0);" title="删除" data-action="delete">&nbsp;</a>
						</span>
					</li>
					</c:forEach>					
				</ul>
			</div>
			
			<myTag:addToPlaylist left="270" top="150"></myTag:addToPlaylist>			
		</div>
		<!-- 右边部分 -->
		<div class="ui_right">
			<iframe id="contentFrame" name="contentFrame" width="725" height="660" style="border:none;" src="songListing_viewForUser.action?id=${listingCreated[0].id}"></iframe>
		</div>
	</div>
	
	<!-- 底部 -->
	<jsp:include page="../footer.jsp"></jsp:include>
	
	<!-- 播放控件 -->
	<myTag:playbar />
  </body>
</html>