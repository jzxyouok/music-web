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
    
    <title>搜索到的专辑</title>
    	
	<style type="text/css">
		ul.album_ul {			
			padding-left: 0px;
		}
	    ul.album_ul li {
			display: inline;
		    float: left;
		    height: 198px;
		    padding:0;		   
		    overflow: hidden;
		    text-align: left;
		    width: 134px;
			margin-right: 45px;
			margin-bottom: 20px;
		}
		ul.album_ul li a.c333 {
			color:#333;
			text-decoration: none;
		}
		ul.album_ul li a.c333:hover {
			text-decoration: underline;
		}
		.mt5 {
			margin-top:5px;
		}
		.mt10 {
			margin-top:10px;
		}
		p.mt10 a {
			font-size: 14px;
		}
		.u-cover img {
			padding:2px;
			border:1px solid #aaa;
			cursor: pointer;
		}
		.u-cover .icon-play {
		    background: url("images/other/iconall.png") no-repeat scroll 0 0 rgba(0, 0, 0, 0);
		}		
		.u-cover .icon-play {
		    display: inline-block;
		}
		.u-cover {
			position: relative;
		}
		.u-cover .icon-play {
		    background-position:100px 10px;
		    bottom: 15px;
		    height: 35px;
		    position: absolute;
		    right: 10px;
		    width: 25px;
		    text-decoration: none;
		}
	</style>

	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
   	
   	<script type="text/javascript">
   		$(function(){
   			//悬浮显示播放按钮
   			$(".u-cover").mouseover(function() {
   				var index = $(".u-cover").index($(this));
   				$(this).find(".icon-play").css("background-position", "0 -132px");
   			}).mouseout(function() {
   				$(this).find(".icon-play").css("background-position", "100px 10px");
   			});
 	  			
   			//设置搜索页面的统计信息
   			$("#m-search .snote b", window.parent.document).text('${pageBean.dataList.size()}');//设置搜索到的专辑的数目
   			$("#m-search .snote span", window.parent.document).text('张专辑');//设置搜索的类型
   			
   			//保存搜索关键字
   			$("#searchKeySpan").val($("input[name='searchKey']", window.parent.document).val());
   		});
   	</script>
 
  </head>
  
  <body>
    <div class="album_list">
    	<ul class="album_ul" style="min-height: 200px;">
    	  <c:forEach items="${pageBean.dataList}" var="album">                              
          <li>
             <div class="u-cover">
             	<a title="${album.name}" class="c333" href="album_view.action?id=${album.id}" style="height:26px; line-height:26px; display:inner-block;" target="_top">
             		<img src="${album.image}" width="128" height="128">
             	</a>             	           
				<!-- <a class="icon-play f-alpha" title="播放" href="javascript:;">&nbsp;</a> -->
             </div>
             <p class="mt5">
                <a title="${album.name}" class="c333" href="album_view.action?id=${album.id}" style="height:26px; line-height:26px; display:inner-block;" target="_top">${album.name}</a><br/>
                <c:forEach items="${fn:split(album.singerInfo, ' ')}" var="singer">
					<a title="${fn:split(singer, ',')[1]}" href="singer_view.action?id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a>
				</c:forEach>
             </p>
          </li>
          </c:forEach>                								
		</ul>
		<!-- 分页条 -->
		<div class="pagePlugin" style="width:100%; margin: 10px auto;">			
			<form action="songListing_toSearch.action" method="post" name="pageForm">
				<!-- <input id="searchKeySpan" name="skey" type="hidden" > -->
				<myTag:page form="pageForm" pageBean="${pageBean}" />
			</form>
		</div>
    </div>
  </body>
</html>
