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
    
    <title>编辑数据字典信息</title>
    
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
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
   			<h2>编辑数据字典信息</h2>
   		</div>   		
   		<div class="content">
   			<form action="sys/sysDic_update.action" method="post">
   				<input type="hidden" name="id" value="${vo.id}">
    			<input type="hidden" name="version" value="${vo.version}">
   				<table class="addAlbumTable">
   					<tr>
   						<td>数据字典类型：</td> 
   						<td>
   						<select name="type">
							<option value="">请选择</option>
							<option value="SINGER_TYPE" <c:if test="${vo.type eq 'SINGER_TYPE'}">selected='selected'</c:if>>歌手类型</option>
							<option value="LISTING_STYLE_TYPE" <c:if test="${vo.type eq 'LISTING_STYLE_TYPE'}">selected='selected'</c:if>>歌单风格类型</option>
							<option value="LISTING_LANGUAGE_TYPE" <c:if test="${vo.type eq 'LISTING_LANGUAGE_TYPE'}">selected='selected'</c:if>>歌单语言类型</option>
						</select>
						</td>
   					</tr>
   					<tr>
   						<td >名称：</td> <td><input type="text" name="name"  value="${vo.name}" required="required" maxlength="40"></td>
   					</tr>
   					<tr>
   						<td >值：</td> <td><input type="text" name="value"  value="${vo.value}" required="required" maxlength="40"></td>
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