<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">

	<style type="text/css">
		.footer {
			width: 100%;
			height:60px;			
			background: none repeat scroll 0% 0% #E4E4E4;
			padding-top:30px;
			padding-left:16px;  margin:60px 0 0 -8px;
			clear:both;
		}
		.ui_copyright {
			width: 1000px;
			margin:0 auto;
			font-size:13px;
			color:#666;
		}
		.ui_copyright p {
			width:500px;
			margin:0 auto;
		}
	</style>
  </head>
  
  <body>
    <div class="footer">
       	<div class="ui_copyright">       		
           	<p>
           		<br/>
                <span>Copyright © 2014–2015 我的音乐.</span>
                <span>All Rights Reserved</span>              		
            </p>
        </div>
    </div>
  </body>
</html>
