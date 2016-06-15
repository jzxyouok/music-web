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
    
    <title>数据字典列表</title>
    
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
			
			//点击删除数据字典
   			$(".fifth_td .delImg").click(function(){
   				var $tr = $(this).parent().parent();
   				var attr = $(this).attr("lang");
   				var dicId = attr.split(",")[0];
   				var name = attr.split(",")[1];
				if(!confirm("确定删除数据字典\""+name+"\"?")) {
					return;
				}
				$.post('sys/sysDic_delete.action', {id:dicId}, function(data) {
					if(data == 'success') {//数据字典移除成功
						alert("数据字典删除成功!");
						$tr.remove();
						$("#singerCount").val(parseInt($("#singerCount").val()) - 1);
					}
				});
   			});
   			
   			//点击编辑歌手按钮，编辑歌手
   			$(".fifth_td .editImg").click(function(){   				
   				var dicId = $(this).attr("lang");
				window.open("sys/sysDic_toUpdate?sysDicForm.id="+dicId, "_self");
   			});
		});
	</script>
  </head>
  
  <body>
    <div class="content">
    	<!-- 分页条 -->
		<form action="sys/sysDic_list.action" name="pageForm" method="post">
	    	<h2 class="tit">数据字典列表</h2>
	    	<!-- 数据字典列表 -->
	    	<div class="song-list">
	    		<div class="u-title u-title-1">
					<span class="key f-ff2">
						<select name="type">
							<option value="">请选择</option>
							<option value="SINGER_TYPE" <c:if test="${sysDicForm.type eq 'SINGER_TYPE'}">selected='selected'</c:if>>歌手类型</option>
							<option value="LISTING_STYLE_TYPE" <c:if test="${sysDicForm.type eq 'LISTING_STYLE_TYPE'}">selected='selected'</c:if>>歌单风格类型</option>
							<option value="LISTING_LANGUAGE_TYPE" <c:if test="${sysDicForm.type eq 'LISTING_LANGUAGE_TYPE'}">selected='selected'</c:if>>歌单语言类型</option>
						</select>
						<input type="submit" value="搜索">
					</span>				
				</div>
				<table class="m-table">
					<thead>
						<tr>
							<th class="first w1"><div class="wp">序号</div></th>
							<th><div class="wp">名称</div></th>
							<th class="w2"><div class="wp">值</div></th>
							<th class="w3"><div class="wp">类别</div></th>
							<th class="w4"><div class="wp">操作</div></th>
						</tr>
					</thead>
					<tbody id="m-song-list-module">
					<c:forEach items="${pageBean.dataList}" var="dic" varStatus="status">
					<tr class="ztag even">
						<td class="left first_td">${(pageBean.curPage-1)*pageBean.pageSize+status.count}</td>
						<td class="second_td">${dic.name}</td>
						<td class="third_td">${dic.value}</td>
						<td  class="fourth_td">
						<c:choose>
							<c:when test="${dic.type eq 'SINGER_TYPE'}">歌手类型</c:when>
							<c:when test="${dic.type eq 'LISTING_STYLE_TYPE'}">歌单风格类型</c:when>
							<c:when test="${dic.type eq 'LISTING_LANGUAGE_TYPE'}">歌单语言类型</c:when>
						</c:choose>
						</td>
						<td class="fifth_td">
							<%-- <a href="sys/toEditSinger?id=${singer.singerId}">编辑</a>
							<a href="javascript:void(0);">删除</a> --%>
							<img class="editImg" alt="编辑" title="编辑" lang="${dic.id}" src="images/other/037.gif" style="cursor: pointer;" width="12" height="12">&nbsp;&nbsp;
							<img class="delImg" alt="删除" title="删除" lang="${dic.id},${dic.name}"  src="images/other/010.gif" style="cursor: pointer;" width="12" height="12">
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