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
    
	<style type="text/css">
		ul.album_ul {			
			padding-left: 0px;
		}
		ul.album_ul li {
			display: inline;
		    float: left;
		    height: 190px;
		    padding:0;		   
		    overflow: hidden;
		    text-align: left;
		    width: 134px;
			margin-right: 20px;
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
   		});
   	</script>
  </head>
  
  <body>
    <div class="album_list">
    	<ul class="album_ul">
    	  <c:forEach items="${albumList}" var="album">    	      	  
          <li>
             <div class="u-cover">
             	<a title="${album.name}" class="c333" href="album_view.action?id=${album.id}" style="height:26px; line-height:26px; display:inner-block;" target="_top">
             		<img src="${album.image}" width="128" height="128">
             	</a>             	           
				<!-- <a class="icon-play f-alpha" title="播放" href="javascript:;">&nbsp;</a> -->
             </div>
             <p class="mt5">
                 <a title="${album.name}" class="c333" href="album_view.action?id=${album.id}" style="height:26px; line-height:26px; display:inner-block;" target="_top">${album.name}</a><br/>
                 <span style="color:#666;">${album.publishDate}</span>
             </p>
          </li>
          </c:forEach>                                                                                                            									
		</ul>
    </div>
  </body>
</html>
