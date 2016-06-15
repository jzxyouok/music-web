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
    
    <title>${vo.name} - 后台管理</title>
    
	<link rel="stylesheet" type="text/css" href="css/admin/singer.css">
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="js/common/layer/layer.js"></script>

	<script type="text/javascript">
		$(function() {
			//var d = null;
			/* 点击显示浮动登录框 */
   			$(".v-hd2 .add-album").bind("click",function(){
   				 //清空文本框的内容
   				 //$("#add-album-alert input[type='text'], #add-album-alert textarea").val("");
   				 //d = dialog({
   				 //	id: 'id-demo',
				 //   title: '添加专辑',
				 //  url: 'sys/sysAlbum_toAdd.action?albumForm.singerIds=${vo.id}',
				 //});
				 //d.show();

   				 //dialog = artDialog();
   				 //dialog.title("添加专辑");
   				 //dialog.lock(true);
   				 //dialog.content(document.getElementById("add-album-alert"));
   				 
				 layer.open({
				        type: 2,
				        title: '添加专辑',
				        maxmin: true,
				        shadeClose: true, //点击遮罩关闭层
				        area : ['800px' , '640px'],
				        content: 'sys/sysAlbum_toAdd.action?albumForm.singerIds=${vo.id}'			        	
				 });
   			});
   			
   			//点击取消，关闭新建表单悬浮框
   			/* $("#add-album-alert input[type='button']").click(function() {
   				dialog.close();
   			}); */
   			
   			//点击添加专辑提交按钮，发出请求
   			$("#add-album-alert input[type='submit']").click(function() {
   				/* $.post('', ); */
   			});
   			
   			//点击删除有专辑按钮，删除专辑
   			$(".album_ul li .delete").click(function(){
   				var $li = $(this).parent().parent();
   				//获取歌曲编号和歌曲名
   				var attr = $(this).attr("lang");
   				var albumId = attr.split(",")[0];
   				var name = attr.split(",")[1];
				if(!confirm("确定删除专辑\""+name+"\"?")) {
					return;
				}
				$.post('sys/sysAlbum_delete', {id:albumId}, function(data) {
					if(data == 'success') {//专辑移除成功
						alert("专辑删除成功!");
						$li.remove();
					}
				});
   			});
   			
   			//点击编辑专辑按钮，编辑专辑
   			$(".album_ul li .edit").click(function(){   				
   				var albumId = $(this).attr("lang");
				window.open("sys/sysAlbum_toUpdate?id="+albumId, "_self");
   			});
		});
		
		function submitt() {
			window.location.reload(); 
		}
	</script>
  </head>
  
  <body>
    <div class="content">
    	<div class="head">
			<img src="${vo.bigImg}" />
			<div class="mask">&nbsp;</div>
			<span>${vo.name}</span>
		</div>
		<div class="n-artdesc">
			<h3><i>&nbsp;</i>${vo.name}简介</h3>
			<p>${vo.description}</p>			
		</div>
		<div class="album_list">
			<div class="v-hd2">
				<a href="javascript:void(0);" class="tit"><i>&nbsp;</i>专辑</a>
				<div class="hd f-cb">					
					<a class="u-btn u-btn-crt f-ff2 add-album" href="javascript:void(0);">专辑</a>
				</div>
			</div>
	    	<ul class="album_ul">
	    	  <c:forEach items="${albumList}" var="album">
	          <li>
	             <div class="u-cover">
	             	<a style="height:26px; line-height:26px; display:inner-block;" href="sys/sysAlbum_view.action?id=${album.id}" class="c333" title="${album.name}">
	             		<img width="128" height="128" src="${album.image}">
	             	</a>             	           
	             </div>
	             <p class="mt0">
	                 <a style="height:26px; line-height:26px; display:inner-block;" href="sys/sysAlbum_view.action?id=${album.id}" class="c333" title="${album.name}">${album.name}</a><br>
	                 <span style="color:#666; display: block; margin-bottom: 5px;">${album.publishDate}</span>
	                 <%-- <a href="javascript:void(0);" class="edit c333" lang="${album.id}">编辑</a>&nbsp;&nbsp;
	                 <a href="javascript:void(0);" class="delete c333" lang="${album.id},${album.name}">删除</a>
	                 <img class="editImg" alt="编辑" title="编辑" lang="${album.albumId}" src="images/other/037.gif" style="cursor: pointer;" width="12" height="12">&nbsp;&nbsp;
					 <img class="delImg" alt="删除" title="删除" lang="${album.albumId},${album.albumName}"  src="images/other/010.gif" style="cursor: pointer;" width="12" height="12"> --%>
	             </p>
	          </li>
	          </c:forEach>
	          <c:if test="${fn:length(albumList) == 0}">
	          	<p>暂时没有专辑!</p>
	          </c:if>	                                                                                        								
			</ul>  
		</div>
    </div>
  </body>
</html>
