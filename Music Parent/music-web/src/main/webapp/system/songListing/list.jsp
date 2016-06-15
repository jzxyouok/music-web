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
    
    <title>歌单列表</title>
    	
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="css/user/listing.css"/>
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
	
	<style type="text/css">
		body {min-height: 700px;}
		.content { width: 920px; margin: 30px auto 0 auto; }
		h2.tit { text-align: center; }
		.f-fl {float:left;}
		.f-ff2 {float:right;}
		/* 列表 */
		.listings { width:900px;  margin-top: 40px;}
		.listings .u-title .hd {
			font-size:18px;
			font-weight: bold;
		}
		.listings .sub {
			margin-left: 10px;
			margin-top: 4px;
			font-size: 14px;
		}
		.listings .u-title {
			height: 30px;
			padding-bottom: 3px;
			border-bottom: 2px solid #C20C0C;
		}
		.listings .u-title select {
			height: 26px;			
		}
		.listings .u-title option {
			height: 22px;
			padding-top: 4px;
		}
		.listings .u-title span.key {
			margin-right: 20px; 
		}
		.listings .u-title input[type='text'] {
			height: 22px;
		}
		.listings .u-title input[type='button'] {
			height: 27px;
			cursor: pointer;
		}			
		.m-cvrlst li .dec a {
			display: inline-block;
    		height: 25px;
    		width:100px;
    		line-height: 25px;
			overflow: hidden;
		} 		
		.m-cvrlst li .dec .delete { 
			margin-top: -10px;
		}
		ul.m-cvrlst li a.delete {
		  background-color: #c10d0c;
		  border: 1px solid red;
		  border-radius: 3px;
		  color: #fff;
		  font-size: 13px;
		  line-height: 20px;		  		  
		  text-align: center;
		  vertical-align:text-top;
		  height:20px;
		  padding: 2px 6px;
		  width: 40px;
		}
		ul.m-cvrlst li a.delete:hover {
			background-color: #eb6120;
			text-decoration: none;
		}
		ul.m-cvrlst li a.c333 {
		    text-decoration: none;
		}
	</style>
  
  	<script type="text/javascript">
  		$(function() {
  			//点击删除有歌单按钮，删除歌单
   			$(".m-cvrlst li .delete").click(function(){
   				var $li = $(this).parent().parent();
   				//获取歌曲编号和歌曲名
   				var attr = $(this).attr("lang");
   				var id = attr.split(",")[0];
   				var name = attr.split(",")[1];
				if(!confirm("确定删除歌单\""+name+"\"?")) {
					return;
				}
				$.post('user/delPlaylist', {id:id}, function(data) {
					if(data == 'success') {//歌单移除成功
						alert("歌单删除成功!");
						$li.remove();
					}
				});
   			});
  		});
  	</script>
  </head>
  
  <body>
    <div class="content">
    	<h2 class="tit">歌单列表</h2>
    	<!-- 评论列表 -->
    	<div class="listings">
    		<div class="u-title u-title-1">
				<span class="hd f-fl">歌单</span>					
				<span class="sub f-fl" style="font-size: 16px; position: relative;top:-3px;">${pageBean.dataList.size()}个</span>
				
				<form action="admin/listing" method="post" name="pageForm">					
					<span class="key f-ff2"><input type="text" name="name" value="${name}" placeholder="输入歌单名"><input type="submit" value="搜索"></span>
				</form>
			</div>
			<ul class="m-cvrlst">
				<c:forEach items="${pageBean.dataList}" var="listing">				
				<li>
					<div class="u-cover u-cover-1">						
						<a class="msk" href="songListing_view.action?id=${listing.id}" title="${listing.name}" target="_blank">
							<img src="${listing.image}" width="140" height="140">
						</a>
						<div class="bottom">
							<span class="icon-headset"></span>
							<span class="nb">${listing.playCount}</span>
						</div>
					</div>
					<p class="dec">
						<a href="user/playlist?id=${listing.id}" class="tit s-fc0" title="${listing.name}" target="_blank">
						${listing.name}
						</a>						
						<%-- <a href="javascript:void(0);" class=delete title="${listing.name}">删除</a> --%>
						<a href="javascript:void(0);" class="delete c333" lang="${listing.id},${listing.name}">删除</a>
					</p>
				</li>
				</c:forEach>				
			</ul>
			
			<!-- 分页条 -->
			<div class="pagePlugin" style="width:500px; margin: 10px auto;">				
				<myTag:page form="pageForm" pageBean="${pageBean}" />
			</div>
		</div>
    </div>
  </body>
</html>