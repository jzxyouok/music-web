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
    
    <title>编辑专辑信息</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script charset="utf-8" src="js/common/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="js/common/My97DatePicker/WdatePicker.js"></script>
	
	<style type="text/css">		
		/* 整体框架css  */
		.all{
			width: 100%;
			height: 860px;
		}
		/* 标题css  */
		.title{
			width: 100%;
			height: 40px;
		}
		.title h2{
			width:90%;
			height: 40px;
			float: left;
			text-align:center;
		}
		
		/* content css  */
		.content{
			width:90%;
			float: left;
			margin-left: 30px;
		}
		.content table {
			margin: 0px auto;
		}
		/*表格的每一行*/
		.content table tr{
			height: 50px;			
		}
		.content table td {		
			min-width: 150px;
			max-width: 720px;
		}
		.content table input[type='text'] {
			width: 200px;
		}
		.content table input[type='radio'] {
			position: relative;
			top: 8px;
		}
		.content .submit{
			cursor: pointer;
			border:none;
			border-radius:3px;
			background-color: #eb6120;
			color: white;
			height: 28px;
		}
		.redBt {
			text-decoration:none;
			color:#fff;
			height:30px;
			padding: 6px 12px;
			border-radius:3px;
			background-color:#EB6120;
		}
		.redBt:hover {
			background-color:#FE7600;
		}
		
		/*提示文字样式*/
		.span{
			font-family: "微软雅黑";
			font-size: 12px;
			color: red;
		}
		.content input, .content select, .content option {
			font-size: 13px;
			height: 30px;
		}
		.content select {
			width: 100px;
		}
		.content otpion {
			width: 80px;
			height: 25px;
			padding-top: 5px;
		}
		.content textarea {
			font-size: 13px;
		}
	</style>

  </head>
  
  <body>
   	<div class="all">
   		<div class="title">
   			<h2>编辑专辑信息</h2>
   		</div>   		
   		<div class="content">
   			<form action="sys/updateAlbum.action" method="post" enctype="multipart/form-data">
   				<input type="hidden" name="id" value="${vo.id}">
    			<input type="hidden" name="version" value="${vo.version}">
   				<input type="hidden" name="image" value="${vo.image}">
   				<table class="addAlbumTable">
   					<tr>
   						<td >专辑名：</td> <td><input type="text" name="name" value="${vo.name}" size="40px" maxlength="25" required="required"/></td>
   					</tr>
   					<%-- <tr>
   						<td >歌手：</td> <td><input type="text" name="singer"  value="${singerIdStr}" size="40px" maxlength="200" required="required"/></td>
   					</tr> --%>
   					<tr>
   						<td >发行时间：</td> <td><input class="Wdate" type="text" name="publishDate"  value="${vo.publishDate}" onClick="WdatePicker({lang:'zh-tw'})" placeholder="点我选择日期" required="required"></td>
   					</tr>
   					<tr>
   						<td >发行公司：</td> <td><input type="text" name="company" value="${vo.company}" maxlength="40"></td>
   					</tr>				    					    			    			
   					<tr>
   						<td >地区：</td>
   						<td>
   							<select name="area">
   								<option value="华语">华语</option>
   								<option value="欧美">欧美</option>
   								<option value="韩国">韩国</option>    							
   								<option value="日本">日本</option>
   							</select>    
   						</td>
   					</tr>			    					    			    		   					    				
   					<tr>
   						<td >替换图片：</td> 
   						<td>
   							<img alt="${vo.name}" src="${vo.image}" height="50" width="50" />
   							<input type="file" name="big" placeholder="130*130尺寸" />
   						</td>
   					</tr>   					
   					<tr>
   						<td>专辑介绍：</td>
   						<td>&nbsp;</td>     						
   					</tr>
   					<tr>
   						<td colspan="2">
   						<textarea name="description" cols="80" rows="6" maxlength="1000">${vo.description}</textarea>
   						</td>
   					</tr>
   					<tr>
   						<td >是否可用：</td> 
   						<td>
   							<input type="radio" name="isValid" value="1" <c:if test="${vo.isValid=='1'}">checked='checked'</c:if>>启用
   							<input type="radio" name="isValid" value="0" <c:if test="${vo.isValid=='0'}">checked='checked'</c:if>>停用
   						</td>
   					</tr>
   					<tr>
   						<td colspan="2">
   							<input class="submit redBt" type="submit" value="确认修改" />
   							<input class="submit redBt" type="button" value="返回" onclick="window.history.back(-1);"/>
   						</td>
   					</tr>
   				</table>
   			</form>
   			
   		</div>
   	</div>
  </body>
</html>