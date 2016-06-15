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
    
    <title>歌手列表</title>
    
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
			
			//点击删除有歌手按钮，删除歌手
   			$(".fifth_td .delImg").click(function(){
   				var $tr = $(this).parent().parent();
   				//获取歌手编号和歌手名
   				var attr = $(this).attr("lang");
   				var singerId = attr.split(",")[0];
   				var name = attr.split(",")[1];
				if(!confirm("确定删除歌手\""+name+"\"?")) {
					return;
				}
				$.post('sys/sysSinger_delete', {id:singerId}, function(data) {
					if(data == 'success') {//歌手移除成功
						alert("歌手删除成功!");
						$tr.remove();
						$("#singerCount").val(parseInt($("#singerCount").val()) - 1);
					}
				});
   			});
   			
   			//点击编辑歌手按钮，编辑歌手
   			$(".fifth_td .editImg").click(function(){   				
   				var singerId = $(this).attr("lang");
				window.open("sys/sysSinger_toUpdate?singerForm.id="+singerId, "_self");
   			});
   			   			
		});
	</script>
  </head>
  
  <body>
    <div class="content" style="width:610px;">
    	<!-- 分页条 -->
		<form action="sys/sysSinger_listToSelect" name="pageForm" method="post">
	    	<h2 class="tit">歌手列表</h2>
	    	<!-- 歌手列表 -->
	    	<div class="song-list" style="width:600px;">
	    		<div class="u-title u-title-1">
					<span class="hd f-fl">歌手</span>					
					<span class="sub f-fl" id="singerCount" style="font-size: 18px;">${pageBean.totalRecords}</span>				
					<span class="key f-ff2">
						<input type="text" name="name" placeholder="歌手名" value="${singerForm.name}">
						<input type="submit" value="搜索">
					</span>				
				</div>
				<table class="m-table" style="width:600px;">
					<thead>
						<tr>
							<th class="first w1">&nbsp;</th>
							<th class="first w1"><div class="wp">序号</div></th>
							<th><div class="wp">头像</div></th>
							<th class="w2"><div class="wp">歌手名</div></th>
							<th class="w3"><div class="wp">歌手类别</div></th>
						</tr>
					</thead>
					<tbody id="m-song-list-module">
					<c:forEach items="${pageBean.dataList}" var="singer" varStatus="status">
					<tr class="ztag even">
						<td class="left first_td">
							<input type="checkbox" name="selectDesigns" value="${singer.id},${singer.name}"/>
						</td>
						<td class="left first_td">${status.count}</td>
						<td class="second_td">
							<a title="${singer.name}" href="sys/sysSinger_view?singerForm.id=${singer.id}">
								<img alt="${singer.name}" src="${singer.smallImg}" width="35" height="35">
							</a>
						</td>
						<td class="third_td">
							<a title="${singer.name}" href="sys/sysSinger_view?singerForm.id=${singer.id}">${singer.name}</a>
						</td>
						<td  class="fourth_td">${singer.type}</td>
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