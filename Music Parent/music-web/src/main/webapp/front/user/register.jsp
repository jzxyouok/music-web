<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>注册</title>
	
	<link rel="stylesheet" type="text/css" href="css/user/register.css"/>
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
	
	<script type="text/javascript" src="js/user/register.js"></script>
</head>

<body>
	<!-- 导航栏 -->
    <div>
		<jsp:include page="../top.jsp"></jsp:include>
	</div>
	
	<div class="formDiv">
		<table>	
			<tr>
				<td style="width:153px; height:54px"><span class="STYLE2">请输入用户名:</span></td>
				<td><input type="text" name="account" maxlength="20" /></td>
			</tr>	
			<tr>
				<td style="height:48px"><span class="STYLE2">请输入密码:</span></td>
				<td><input type="password" name="password" maxlength="16"/></td>
			</tr>
			<tr>
				<td style="height:47px"><span class="STYLE2">确认输入密码:</span></td>
				<td><input type="password" name="pwdAgain" maxlength="16" /></td>
			</tr>
			<tr>
				<td style="width:153px; height:54px"><span class="STYLE2">性别:</span></td>
				<td>
					<input type="radio" name="sex" value="1" checked="checked">男
					<input type="radio" name="sex" value="0">女
				</td>
			</tr>
			<tr>
				<td style="height:47px"><span class="STYLE2">请输入验证码:</span></td>
				<td ><input type="text" name="validateCode" maxlength="4">
				  <img id="image2" src="admin/code" onclick="refresh2();"  alt="验证码" />
				  &nbsp;&nbsp;<span class="STYLE3" onclick="refresh2();" style="cursor: pointer;">换一张</span>
				</td>
			</tr>
			<tr>
				<td style="height:69px" colspan="2" ><input type="button" value="注&nbsp;册"/></td>
			</tr>			
		  </table>
	</div>
				
	<!-- 底部 -->
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>
