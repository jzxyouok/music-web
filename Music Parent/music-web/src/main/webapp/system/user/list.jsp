<%@ page language="java" import="com.johnf.app.music.util.PageBean" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>

<!DOCTYPE HTML>
<html>
  <head>
  	<base href="<%=basePath%>">
    <title>用户列表</title>
	  
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
	<style type="text/css">
		.del{ cursor:pointer;}
		.yf{ width:724px; margin:auto;}
		a:link {
			color: #000000;
			text-decoration: none;
			font-family:Arial, Helvetica, sans-serif;
		}
		a:hover {
			color: #FF6633;
			text-decoration: underline;
		}
		a:visited {
			text-decoration: none;
		}
		a:active {
			text-decoration: none;
		
		}
		.even{ background-color:#CCCCCC;}
		.odd{ background-color:#DBEAF9;}
		table.user_table {border-collapse:collapse; border-collapse:collapse; border:0; width:724px; margin: 10px auto;}
		table.user_table td {text-align: center;}
		thead{background-color:#66a9bc;}
		.STYLE7 {font-family: "Times New Roman", Times, serif; font-size: 15px;}
		.STYLE8 {color: #00000}
		
		.user_table th {
		    border-bottom: 1px solid #ccc;
		    border-right: 1px solid #ccc;
		    font-weight: normal;
		}
	</style>
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>

	<script type="text/javascript">
		$(function(){
			//表格隔行换色
			$("tbody tr:even").css("background-color", "#fff");
			$("tbody tr:odd").css("background-color", "#f1f1f1");
			//鼠标经过行换色
			$("tbody tr").mouseover(function() {
				$(this).css("background-color", "#ccc");
				$(this).find(".second_td .opt").show();//显示添加、收藏按钮
			}).mouseout(function() {
				var index = $("tbody tr").index($(this));
				if(index % 2 == 0) {
					$(this).css("background-color", "#fff");							
				} else {
					$(this).css("background-color", "#f1f1f1");
				}
				$(this).find(".second_td .opt").hide();//隐藏添加、收藏按钮
			});
			
			//点击删除用户按钮，删除用户
   			$(".user_table tr .delImg").click(function(){
   				var $tr = $(this).parent().parent();
   				var attr = $(this).attr("lang");
   				var userId = attr.split(",")[0];
   				var name = attr.split(",")[1];
				if(!confirm("确定删除用户\""+name+"\"?")) {
					return;
				}
				$.post('sys/sysUser_delete', {id:userId}, function(data) {
					if(data == 'success') {//用户移除成功
						alert("用户删除成功!");
						$tr.remove();
					}
				});
   			});	
		});
	</script>
  </head>
  
  <body>    
  	<form action="sys/sysUser_list.action" name="showuser" method="post">
	  <div class="yf">
	    <h2>用户列表</h2>
        <p>          
          <label for="id">用户ID</label><input type="text" name="id" value="${userForm.id}" style="width:140px; height:27px;">
          <label for="account">用户账号</label><input type="text" name="account" value="${userForm.account}" style="width:140px; height:27px;">
          <input name="submit" type="submit" style="height:26px; cursor: pointer;"  value="搜索"/>
        </p>
        <br/>
	  </div>	
	
  	  <div style="margin:auto; width:800px;">
		<myTag:page form="showuser" pageBean="${pageBean}" />
	  </div>
   </form>
	  
	  <table class="user_table" style="border-top: 2px solid #c20c0c;">
	   	<thead>
	    <tr style="background-color: #ddd;">
	      <th style="width:127px; height:47px"><div class="STYLE7">序号</div></th>
	      <th style="width:96px"><div class="STYLE7">用户头像</div></th>
	      <th style="width:206px"><div class="STYLE7">用户名</div></th>
	      <th style="width:267px"><div class="STYLE7">操作</div></th>
	    </tr>
		</thead>
		<tbody>
			<c:forEach items="${pageBean.dataList}" var="user" varStatus="status">
			<tr class="even">
		      <td style="height:50px;"><div>${status.count}</div></td>
		      <td><div><img src="${user.headImg}" width="50" height="50"></div></td>
		      <td><a href="user/user?id=${user.id}" target="_blank">${user.account}</a></td>
		      <td>
			    	<%-- <a href="admin/deletUser?userId=${user.userId }" onclick="return confirm('确认删除?');" class="STYLE8" target="_blank">删除</a> --%>
			    	<img class="delImg" alt="删除" title="删除" lang="${user.id},${user.account}"  src="images/other/010.gif" style="cursor: pointer;" width="12" height="12">
			   </td>
		    </tr>
		    </c:forEach>		    
		</tbody>	     
	  </table>  	  
  
  </body>
</html>
