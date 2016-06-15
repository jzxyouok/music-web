<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>搜索到的歌手</title>

	<style type="text/css">
		/* 热门歌手列表 */
		.m-cvrlst {
			padding-left: 0;
			padding-top: 0;
			padding-bottom: 20px;
		}
		.m-cvrlst li {
			list-style: none;
			display: inline-block;
			margin-left: 7px;
			margin-top: 20px;
		}
		.m-cvrlst p {
			font-size: 13px;
			margin-top: 4px;
		}
		.m-cvrlst p a {
			text-decoration: none;
			color: #333;
		}
		.m-cvrlst p a:hover {
			text-decoration: underline;
		}
	</style>	
  	
  	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
   	
   	<script type="text/javascript">
   		$(function(){
   			//设置搜索页面的统计信息
   			$("#m-search .snote b", window.parent.document).text('${pageBean.dataList.size()}');//设置搜索到的歌手的数目
   			$("#m-search .snote span", window.parent.document).text('个歌手');//设置搜索的类型
   			
   			//保存搜索关键字
   			$("#searchKeySpan").val($("input[name='searchKey']", window.parent.document).val());
   		});
   	</script>
  </head>
  
  <body>
    <div class="content">
    	<ul id="m-artist-box" class="m-cvrlst">
    		<c:forEach items="${pageBean.dataList}" var="singer">
			<li>
				<div class="head">							
					<a class="msk" href="singer_view.action?id=${singer.id}" title="${singer.name}的音乐" target="_top">
						<img src="${singer.smallImg}" width="130" height="130" />
					</a>
				</div>
				<p>
					<a title="${singer.name}的音乐" href="singer_view.action?id=${singer.id}"  target="_top">${singer.name}</a>
				</p>
			</li>
			</c:forEach>			
		</ul>
		<!-- 分页条 -->
		<div class="pagePlugin" style="width:500px; margin: 10px auto;">
			<form action="songListing_toSearch.action?key=${key}" method="post" name="pageForm">
				<!-- <input id="searchKeySpan" name="skey" type="hidden" >		 -->		
				<myTag:page form="pageForm" pageBean="${pageBean}" />
			</form>
		</div>
    </div>
  </body>
</html>
