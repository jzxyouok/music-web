<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<title>在线音乐网站-网站管理平台</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<style type="text/css">
		body {width: 100%; margin: 0; padding: 0; background-color: #002779;}
		.form { width:460px; margin: 100px auto 0 auto; position: relative;}
		table { border-collapse: collapse; border-spacing: 0; height:100%; width:100%; border:none; font-size: 13px;}	
		td.right { text-align: right; width: 100px; }
		tr { min-height: 23px; }
		tr.white { background-color: #fff; height: 30px; }
		tr.white input[type='text'], tr.white input[type='password'] { 
			height: 21px; margin-top: 15px; min-width: 140px;
			position: relative; top: -5px;
		}
		table input[type='submit'],table input[type='reset'] {
			width: 100px; height: 30px; margin-top: 30px; cursor: pointer;
			margin-right: 10px; margin-bottom: 40px;
		}
		.error {
			position: absolute; bottom: 70px; right: 130px; color: #ff0000; font-size: 13px;
		}
	</style>
	
  	<script type="text/javascript">  
	    function refresh() {  
	        //IE存在缓存,需要new Date()实现更换路径的作用  
	        document.getElementById("image").src="sys/code.action?t="+new Date();
	    }  
	</script>	
</head>

<body>
	<s:form cssStyle="form" class="form"  method="post" action="sys/sysUser_login.action">
		<table>
	  		<tbody>
	  			<tr>
	    			<td><img src="images/other/login_1.jpg"  height="23" width="190"  style="position: relative; top:11px;"></td>
	        		<td>&nbsp;</td>
	        	</tr>
	      		<tr>
	          		<td colspan="2"><img src="images/other/login_2.jpg" height="142" width="460"  style="position: relative; top:5px;"></td>
	        	</tr>      
	      		<tr class="white"> 
	                <td class="right"><span>用户名：</span></td>
	                <td> 
	                    <input name="account" size="13" type="text" tabindex="1" maxlength="15" required="required" >
	                </td>
	             </tr>
	             <tr class="white">
	             	<td class="right"><span>密码：</span></td>
	               <td> 
	                 <input name="password" size="13" tabindex="1" type="password" maxlength="15" required="required">
	               </td>
	             </tr>
				 <tr class="white">
	                <td class="right"><span>验证码：</span></td>
	                <td>
	                  <input name="validateCode" size="13" tabindex="1" type="text" maxlength="4" required="required">
					  <img id="image" src="sys/code.action" alt="验证码" onClick="refresh()" style=" width:60x; height:20px;">
	                  <a class="STYLE1" href="javascript:refresh()" title="看不清楚，请点击更换一张图片">换一张 </a>
	                </td>
	             </tr>
	             <tr class="white">
	                <td>&nbsp; </td>
	                <td>
	                  <input type="submit" height="16"  width="70" value="登录">&nbsp;&nbsp;
	                  <input type="reset" value="重置"  width="70" height="16">
	                </td>
	             </tr>            
			</tbody>
		</table>
		<s:actionerror cssClass="error" />		
	</s:form>
</body>
</html>