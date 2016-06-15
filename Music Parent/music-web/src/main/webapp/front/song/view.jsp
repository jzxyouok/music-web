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
    
    <title>${vo.name}</title>
    	
	<link rel="stylesheet" type="text/css" href="css/user/song.css">
	<link rel="stylesheet" type="text/css" href="css/user/btns.css">
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
   	
   	<script type="text/javascript">
   		$(function(){
   			$(".f-hide").hide();//初始隐藏
   			//设置歌词折叠、展开
   			$(".crl").click(function() {
   				var text = $(this).find("span").text();
   				if(text.indexOf('展开') >= 0) {//当前处于折叠状态
   					$(this).find("span").text("折叠");
   					$(".f-hide").show();
   					$(this).find("i").removeClass("u-icn-69");
   					$(this).find("i").addClass("u-icn-70");   					
   					
   				} else {//当前处于展开状态
   					$(this).find("span").text("展开");
   					$(".f-hide").hide();
   					$(this).find("i").removeClass("u-icn-70");
   					$(this).find("i").addClass("u-icn-69");
   				}
   				$(".ui_layout").height($(".ui_left").height());
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
			<div class="m-lycifo">
				<div class="f-cb">
					<%-- <div class="cvrwrap f-fl">
						<img class="j-img" src="${song.singerList.get(0).smallImg}" width="130" height="130">
					</div> --%>
					<div class="cnt f-fl">
						<div class="hd">
							<i class="u-icn u-icn-37">&nbsp;</i>
							<span class="f-ff2 title">${vo.name}</span>
						</div>
						<p class="des s-fc4">歌手：
							<c:forEach items="${fn:split(vo.singerInfo, ' ')}" var="singer">
								<span title="${fn:split(singer, ',')[1]}"><a title="${fn:split(singer, ',')[1]}" class="s-fc7" href="singer_view.action?id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a></span>
							</c:forEach>
						</p>
						<p class="des s-fc4">所属专辑：<a class="s-fc7" href="album_view.action?id=${fn:split(fn:split(vo.albumInfo, ' ')[0],',')[0]}">${fn:split(fn:split(vo.albumInfo, ' ')[0],',')[1]}</a></p>
						<div class="m-info">
							<!-- 按钮 -->				
							<div class="btns">
								<a class="u-btn2 u-btn2-2 u-btni-addply" href="javascript:;"><i><em class="ply">&nbsp;</em>播放</i></a>
								<a title="添加到播放列表" class="u-btni u-btni-add gap" href="javascript:;"></a>
								<a class="u-btni u-btni-cmmt j-cmt" href="javascript:;"><i>评论(<span id="comment-count">${pageBean.totalRecords}</span>)</i></a>
							</div>
						</div>
						<div class="lyricDiv">
						<c:forEach items="${lyric}" var="row" begin="0" end="13">
							${row}<br/>
						</c:forEach>
						
						<div class="f-hide" id="flag_more">
						<c:forEach items="${lyric}" var="row" begin="14">
							${row}<br/>
						</c:forEach>						
						</div>						
						</div>
						<div class="crl">
							<a class="s-fc7" href="javascript:void(0)" id="flag_ctrl"><span>展开</span><i class="u-icn u-icn-69">&nbsp;</i></a>
						</div>
					</div>
				</div>				
			</div>
			
			<!-- 评论列表 -->
			<myTag:remark id="${vo.id}" type="1" publishRemarkUrl="remark_publish.action" pageBean="${pageBean}" />
		</div>
		<!-- 右边部分 -->
		<div class="ui_right">
			<!-- 喜欢该歌单的人 -->
			<div class="u-hd">
				<h5 class="title">喜欢这首歌的人</h5>
				<ul class="m-piclist">
					<c:forEach items="${userList}" var="user">
					<li>
						<a href="user_view?id=${user.id}" title="${user.account}"><img src="${user.headImg}" width="50" height="50" /></a>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 底部 -->
	<jsp:include page="../footer.jsp"></jsp:include>
  </body>
</html>
