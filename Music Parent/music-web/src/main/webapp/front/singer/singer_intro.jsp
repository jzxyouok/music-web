<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>歌手简介</title>
    
	<style type="text/css">		
		.n-artdesc h3 i {
		    background: none repeat scroll 0 0 #c10d0c;
		    height: 14px;
		    margin-right: 7px;
		    width: 1px;
		}
		div.n-artdesc p, table.album_list {
			font-size: 13px;
			color: #666;
			line-height: 20px;
			text-indent: 2em;
		}		
	</style>
  </head>
  
  <body>
    <div class="content">
		<div class="n-artdesc">
			<h3><i>&nbsp;</i>${singer.singerName}简介</h3>
			<p>${singer.description}</p>		
			<h3><i>&nbsp;</i>音乐专辑</h3>
			<table class="album_list">
				<c:forEach items="${albumList}" var="album">								
				<tr>
					<td>${album.albumName}</td><td>${album.publishDate.toString().substring(0,10)}</td>
				</tr>
				</c:forEach>		
			</table>
		</div>
    </div>
  </body>
</html>
