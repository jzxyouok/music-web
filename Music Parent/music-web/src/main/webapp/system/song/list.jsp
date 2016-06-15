<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>歌曲列表</title>
    
	<link rel="stylesheet" type="text/css" href="css/admin/songlist.css">
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>

	<script type="text/javascript">
		$(function() {
			//表格隔行换色
			$(".m-table  tbody tr:even").css("background-color", "#fff");
   			
   			//点击编辑歌曲按钮，编辑歌曲
   			$(".fifth_td .editImg").click(function(){
   				//获取歌曲编号和歌曲名
   				var $tr = $(this).parent().parent();
   				var attr = $tr.attr("lang");
   				var id = attr.split(",")[0];
				window.open("sys/sysSong_toUpdate?id="+id, "_self");
   			});
		});
	</script>
  </head>
  
  <body>
    <div class="content">    	
    	<h2 class="tit">歌曲列表</h2>
    	<!-- 歌曲列表 -->
    	<form action="admin/songlist" method="post" name="songForm">
	    	<div class="song-list">
	    		<div class="u-title u-title-1">
					<span class="hd f-fl">歌曲</span>					
					<span class="sub f-fl"><span id="songCount">${pageBean.totalRecords}</span>首</span>
					<span class="key f-ff2"><input type="text" name="name" placeholder="歌曲名" value="${key}"><input type="submit" value="搜索"></span>
				</div>
				<table class="m-table">
					<thead>
						<tr>
							<!-- <th class="first w1"><div class="wp">ID</div></th> -->
							<th><div class="wp">歌手</div></th>
							<th class="w2"><div class="wp">歌名</div></th>
							<th class="w3"><div class="wp">专辑</div></th>
							<th class="w4"><div class="wp">操作</div></th>
						</tr>
					</thead>
					<tbody id="m-song-list-module">
					<c:forEach items="${pageBean.dataList}" var="song">	
					<tr class="ztag even" lang="${song.id},${song.name}">
						<%-- <td class="left first_td">${song.id}</td> --%>
						<td class="second_td">
							<c:forEach items="${fn:split(song.singerInfo, ' ')}" var="singer">
								<a title="${fn:split(singer, ',')[1]}" href="sys/sysSinger_view.action?id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a>
							</c:forEach>
						</td>
						<td class="third_td">
							<a title="${song.name}" href="sys/sysSong_view.action?id=${song.id}" >${song.name}</a>
						</td>
						<td  class="fourth_td">
							<c:forEach items="${fn:split(song.albumInfo, ' ')}" var="album">
								<a title="${fn:split(album, ',')[1]}" href="sys/sysAlbum_view.action?id=${fn:split(album, ',')[0]}">《${fn:split(album, ',')[1]}》</a>
							</c:forEach>
						</td>				
						<td class="fifth_td">
							<img class="editImg" alt="编辑" src="images/other/037.gif" style="cursor: pointer;" width="12" height="12">&nbsp;&nbsp;
							<!-- <img class="delImg" alt="删除" src="images/other/010.gif" style="cursor: pointer;" width="12" height="12"> -->
						</td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
				<!-- 分页条 -->
				<div class="pagePlugin" style="width:500px; margin: 10px auto;">				
					<myTag:page form="songForm" pageBean="${pageBean}" />
				</div>
	    	</div>
	    </form>
    	    	
    </div>
  </body>
</html>