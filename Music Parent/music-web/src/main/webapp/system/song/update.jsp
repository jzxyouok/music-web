<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>更新歌曲</title>
   	
   	<style type="text/css">
   		.content {
   			width: 500px;
   			margin: 0 auto;
   		}
   		.addAlbumTable tr {
			height: 50px;
			line-height: 50px;
			font-size: 13px;
		}
   		/* 添加歌曲弹出框 */		
		.addSongDiv input[type='text'], .addSongDiv input[type='file'] {
			height: 24px;
			width: 200px;
		} 
		/* 按钮 */
		.addSongDiv .btn {
		    background-color: #eb6120;
		    border: medium none;
		    border-radius: 3px;
		    color: white;
		    cursor: pointer;
		    height: 28px;
		    width: 100px;    
		}
		.addSongDiv .redBt {
		    background-color: #eb6120;
		    border-radius: 3px;
		    color: #fff;
		    height: 30px;
		    padding: 6px 12px;
		    text-decoration: none;
		}
		.addSongDiv .redBt:hover {
		    background-color: #fe7600;
		}   		
   	</style>	
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>

  </head>
  
  <body>
	<div class="content">	
		<h4>歌曲编辑</h4>
				
		<!-- 更新歌曲表单 -->
		<div id="addSongDiv">
			<form action="sys/sysSong_update" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${vo.id}">
				<input type="hidden" name="version" value="${vo.version}">
				<input type="hidden" name="audio" value="${vo.audio}">
				<input type="hidden" name="lyric" value="${vo.lyric}">
   				<table class="addAlbumTable">
   					<tr>
   						<td >歌曲名：</td> <td><input type="text" name="name" maxlength="25" value="${vo.name}" required="required"/><br/></td>   						
   					</tr>
   					<tr>
   						<td >歌手：</td>
   						<td>
   							<%-- <input type="text" name="singer" maxlength="25" max="200" value='${singerIdStr}' required="required"/><br/> --%>
   							<c:forEach items="${fn:split(vo.singerInfo, ' ')}" var="singer">
								${fn:split(singer, ',')[1]}&nbsp;
							</c:forEach>
   						</td>
   					</tr>
   					<tr>
   						<td >时长：</td> <td><input type="text" name="duration" value="${vo.duration}" placeholder="时长(单位为秒)" required="required"><br/></td>
   					</tr>   					   					
   					<tr>
   						<td >上传音频文件：</td><td><input type="file" name="big" value="${vo.audio}" /><br/></td>
   					</tr>
   					<tr>
   						<td >上传歌词文件：</td><td><input type="file" name="small" value="${vo.lyric}" /><br/></td>
   					</tr>
   					<tr>
   						<td>歌曲描述：</td>
   						<td>&nbsp;</td>     						
   					</tr>
   					<tr>
   						<td colspan="2">
   						<textarea name="description" cols="50" rows="5" maxlength="100">${vo.description}</textarea><br/>
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
   							<input class="btn redBt" type="submit" value="更新" />
   							<input class="btn redBt" type="button" value="取消" onclick="window.history.go(-1)"/>
   						</td>
   					</tr>
   				</table>
   			</form>		
		</div>
	</div>
  </body>
</html>