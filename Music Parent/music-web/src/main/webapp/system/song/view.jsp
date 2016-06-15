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
    
    <title>${song.name}</title>
    	
	<link rel="stylesheet" type="text/css" href="css/user/song.css">
	
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
   			});
   		});
   	</script>
  </head>
  
  <body>
	<div class="content" style="margin: 0 150px;">
		<!-- 左边部分 -->
		<div class="ui_left" style="min-height: 600px;">
			<div class="m-lycifo">
				<div class="f-cb">
					<div class="cvrwrap f-fl">
						<img class="j-img" src="${fn:split((fn:split(vo.singerInfo, ' '))[0], ',')[2]}" width="130" height="130">
					</div>
					<div class="cnt f-fl">
						<div class="hd">
							<i class="u-icn u-icn-37">&nbsp;</i>
							<span class="f-ff2 title">${vo.name}</span>
						</div>
						<p class="des s-fc4">歌手：
							<c:forEach items="${fn:split(vo.singerInfo, ' ')}" var="singer">
								<a title="${fn:split(singer, ',')[1]}" href="sys/sysSinger_view?id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a>
							</c:forEach>
						</p>
						<p class="des s-fc4">
						所属专辑：
						<c:forEach items="${fn:split(vo.albumInfo, ' ')}" var="album">
							<a class="s-fc7" title="${fn:split(album, ',')[1]}" href="sys/sysAlbum_view?id=${fn:split(album, ',')[0]}">${fn:split(album, ',')[1]}</a>
						</c:forEach>
						</p>						
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
		</div>
		
	</div>
  </body>
</html>