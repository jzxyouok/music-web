<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改密码</title>
    	
	<style type="text/css">
		.content {
			width:500px;
			margin: 50px auto 0 auto;
		}
		.from_table tr {
			min-height: 30px;			
			display: block;
			margin-top: 20px;			
		}
		.from_table td {
			min-width: 100px;
		}
		.from_table input {
			line-height: 28px;
			font-size: 14px;
		}
		.from_table input[type='submit'] {
			font-size: 14px;
			font-weight: bold;
			border: none;
			padding: 10px 20px;
			color: #fff;
			background-color: #7DCBFD;
			cursor: pointer;
		}
		a.next {
			color: #000;
			text-decoration: none;
		}
		a.next:hover {
			text-decoration: underline;
		}
	</style>   
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
               	
    <script type="text/javascript">  
	    function refresh() {  
	        //IE存在缓存,需要new Date()实现更换路径的作用  
	        document.getElementById("image").src="sys/code.action?"+new Date();  
	    } 
	    
	    $(function() {
			//表单验证
			$("input[type='button']").click(function() {
				if($("input[name='newPwd']").val() != $("input[name='pwdAgain']").val()) {//前后密码不一致
					alert("前后密码不一致,请重新输入!");
					return;
				}
				
				//提交密码更新
				$.post('sys/sysUser_updatePwd.action', $("#pwdForm").serialize(), function(data) {
					if(data == 'code') {//验证码输入错误
						alert("验证码输入错误");
						$("#image").trigger("click");
					} else if(data == 'access') {//原密码输入错误
						alert("原密码输入错误");
						$("#image").trigger("click");
					} else if(data == 'success') {//密码更新成功
						alert("密码更新成功");
					} else {
						$("#image").trigger("click");
					}
	
					//情况文本输入框的内容
					$("input[type='password'],input[name='code']").val("");								
				});
			});
		}); 
	 </script>
  </head>
  
  <body>
    <div class="content">
    	<form id="pwdForm">
    		<input type="hidden" name="id" value="${userInfo.id}" />
    		<input type="hidden" name="account" value="${userInfo.account}" />
    		<input type="hidden" name="sex" value="${userInfo.sex}" />
    		<input type="hidden" name="headImg" value="${userInfo.headImg}" />
			<input type="hidden" name="description" value="${userInfo.description}" />
    		<input type="hidden" name="isValid" value="${userInfo.isValid}" />
    		<table class="from_table">
    			<tr>
    				<td>原密码:</td><td><input name="password" type="password" required="required"></td>
    			</tr>
    			<tr>
    				<td>新密码:</td><td><input name="newPwd" type="password" required="required"></td>
    			</tr>
    			<tr>
    				<td>确认密码:</td><td><input type="password" name="pwdAgain" required="required"></td>
    			</tr>
    			<tr>
    				<td>验证码:</td>
    				<td>
    					<input type="text" name="code" required="required">
    					<img id="image" src="sys/code.action" alt="验证码" onclick="refresh()" style="position:relative; top:10px;" width="80px"  height="30px"/>
                		<a href="javascript:refresh()" class="next" title="看不清楚，请点击更换一张图片">换一张</a>
                	</td>
    			</tr>
    			<tr>
    				<td colspan="2"><input type="button" value="保存修改"></td>
    			</tr>
    		</table>
    	</form>
    </div>
  </body>
</html>
