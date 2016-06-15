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
    
    <title>专辑列表</title>
    
	<link rel="stylesheet" type="text/css" href="css/admin/songlist.css">
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>

	<script type="text/javascript">
		$(function() {
			//表格隔行换色
			$("tbody tr:even").css("background-color", "#fff");
			
			//鼠标经过行换色
			$("tbody tr").mouseover(function() {
				$(this).css("background-color", "#ccc");
				$(this).find(".second_td .opt").show();//显示添加、收藏按钮
			}).mouseout(function() {
				var index = $("tbody tr").index($(this));
				if(index % 2 == 0) {
					$(this).css("background-color", "#fff");							
				} else {
					$(this).css("background-color", "#f1f1f1");
				}
				$(this).find(".second_td .opt").hide();//隐藏添加、收藏按钮
			});		
			
   			//点击编辑专辑按钮，编辑专辑
   			$(".fifth_td .editImg").click(function(){   				
   				var albumId = $(this).attr("lang");
				window.open("sys/sysAlbum_toUpdate.action?id="+albumId, "_self");
   			});
		});
	</script>
  </head>
  
  <body>
    <div class="content">
    	<!-- 分页条 -->
		<form action="sys/sysAlbum_list.action" name="pageForm" method="post">
	    	<h2 class="tit">专辑列表</h2>
	    	<!-- 歌手列表 -->
	    	<div class="song-list">
	    		<div class="u-title u-title-1">
					<span class="hd f-fl">专辑</span>					
					<span class="sub f-fl" id="singerCount" style="font-size: 18px;">${pageBean.totalRecords}</span>				
					<span class="key f-ff2">
						<input type="text" name="name" placeholder="专辑名" value="${albumForm.name}">
						<input type="submit" value="搜索">
					</span>				
				</div>
				<table class="m-table">
					<thead>
						<tr>
							<th class="first w1"><div class="wp">序号</div></th>
							<th class="w2"><div class="wp">歌手</div></th>
							<th class="w3"><div class="wp">专辑</div></th>
							<th class="w4"><div class="wp">发行时间</div></th>
							<th class="w4"><div class="wp">状态</div></th>
							<th class="w4"><div class="wp">操作</div></th>
						</tr>
					</thead>
					<tbody id="m-song-list-module">
					<c:forEach items="${pageBean.dataList}" var="album" varStatus="status">
					<tr class="ztag even">
						<td class="left first_td">${status.count}</td>
						<td class="second_td">
							<c:forEach items="${fn:split(album.singerInfo, ' ')}" var="singer">
								<a title="${fn:split(singer, ',')[1]}" href="sys/sysSinger_view.action?id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a>
							</c:forEach>
						</td>
						<td class="third_td">
							<a title="${album.name}" href="sys/sysAlbum_view.action?id=${album.id}">《${album.name}》</a>
						</td>
						<td  class="fourth_td">${album.publishDate}</td>
						<td  class="fourth_td">
							<c:if test="${album.isValid=='1'}">启用</c:if>
							<c:if test="${album.isValid=='0'}"><font style="color: red;">停用</font></c:if>
						</td>
						<td class="fifth_td">
							<img class="editImg" alt="编辑" title="编辑" lang="${album.id}" 
								src="images/other/037.gif" style="cursor: pointer;" width="12" height="12">
						</td>
					</tr>
					</c:forEach>					
					</tbody>
				</table>
				
				<!-- 分页条 -->
				<div class="pagePlugin" style="width:500px; margin: 10px auto;">				
					<myTag:page form="pageForm" pageBean="${pageBean}" />
				</div>				
	    	</div>
    	</form>
    </div>
  </body>
</html>