<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>首页</title>
    
	<style type="text/css">
		body {width:900px;}
		h2.til {text-align: center; margin-top: 50px;}
		.STYLE1 {
			color: #0099FF;
			font-size: 18px;
		}
		.zb{ width:990px; height:110px; margin:auto;}
		table.table {
			width: 576px; height:291px; border:1px solid #ccc; border-collapse:collapse;
			margin: 50px auto 0 auto;
		}
		table.table td {
			border:1px solid #ccc;
			text-align: center;
		}
		p.cop {text-align: center; margin-top: 50px;}
	</style>

  </head>
  
  <body>
    <div class="zb">
 	  <h2 class="til">我的音乐网站后台</h2>
      <table class="table">
        <tr>
          <td style="width:153px">服务器类型</td>
          <td style="width:407px;">Tomcat7.0</td>
        </tr>
        <tr>
          <td><div>SQL版本</div></td>
          <td><div>sql2005</div></td>
        </tr>
        <tr>
          <td>系统开发</td>
          <td>XXX</td>
        </tr>
      </table>
	  <p class="cop">Copyright © 2014–2015 我的音乐. All Rights Reserved</p>	
	</div>
  </body>
</html>
