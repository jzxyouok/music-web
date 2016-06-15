<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath %>"></base>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>网站后台管理</title>
	
	<link  href="css/admin/index.css"  rel="stylesheet" type="text/css" />	
	<link rel="StyleSheet" href="js/common/dtree/dtree.css" type="text/css" />
	<script type="text/javascript" src="js/common/dtree/dtree.js"></script>
	<script charset="utf-8" src="js/common/jquery-1.11.1.js"></script>
	
	<script type="text/javascript">
		window.onload = function() {
			//iframe高度自适应
		    var oFrm = document.getElementById('contentFrame');
		    oFrm.onload = oFrm.onreadystatechange = function() {
		         if (this.readyState && this.readyState != 'complete') return;
		         else {
		         	var $topDiv = $("#container");//获取最外层div
		         	var $headerDiv = $("#header");//获取头部div
		         	var $frameDiv = $("#content");//获取iframe外的div
		
					//设置iframe的高度
		            $("#contentFrame").height($("#contentFrame").contents().find("body").height() + 30);
		            
		            //获取整个页面的高度
		            var height =  $headerDiv.height() +  $("#contentFrame").height();
		            //设置iframe外的div以及最外层div的高度		           
		            $frameDiv.height($("#contentFrame").height());
		            $topDiv.height(height);
		         }
		    };
		};
	</script>
</head>

<body>
<div id="container">
  <div id="header">&nbsp; 网站后台管理<span class="STYLE2">{管理中心}</span>
  	<span>
  		<span class="STYLE4"><a href="system/index.jsp">网站首页</a></span>
  		<span class="STYLE4"><a href="sys/sysUser_logout.action">安全退出</a></span>
  	</span>    
    <h4>当前管理员：${userInfo.account}</h4>
  </div>
  
  <div id="mainContent">
    <div id="sidebar">
		<script type="text/javascript">				
			d = new dTree('d');
	
			d.add(0,-1,'后台管理');
			d.add(1,0,'首页','system/index.jsp',null,'contentFrame');
			d.add(2,0,'用户管理');
			d.add(3,2,'用户列表','sys/sysUser_list.action',null,'contentFrame');
			d.add(4,0,'权限管理');
			d.add(5,4,'修改密码','system/user/updatePwd.jsp',null,'contentFrame');
			d.add(6,0,'评论管理');
			d.add(7,6,'歌曲评论','sys/sysRemark_list?remarkForm.type=1',null,'contentFrame');
			d.add(8,6,'专辑评论','sys/sysRemark_list?remarkForm.type=2',null,'contentFrame');
			d.add(9,6,'歌单评论','sys/sysRemark_list?remarkForm.type=3',null,'contentFrame');
			d.add(10,0,'歌单管理');
			d.add(11,10,'歌单列表','sys/sysSongListing_list',null,'contentFrame');
			d.add(12,0,'歌曲管理');
			d.add(13,12,'歌曲列表','sys/sysSong_list.action',null,'contentFrame');
			d.add(14,0,'专辑管理');
			d.add(15,14,'专辑列表','sys/sysAlbum_list.action',null,'contentFrame');
			d.add(16,0,'歌手管理');
			d.add(17,16,'添加歌手','sys/sysSinger_toAdd.action',null,'contentFrame');
			d.add(18,16,'歌手列表','sys/sysSinger_list.action',null,'contentFrame');
			d.add(19,0,'数据字典管理');
			d.add(20,19,'数据字典列表','sys/sysDic_list.action',null,'contentFrame');
			d.add(21,19,'添加数据字典','sys/sysDic_toAdd.action',null,'contentFrame');
			document.write(d);
			
		</script>
	</div>

    <div id="content">
      <iframe name="contentFrame" id="contentFrame" src="system/index.jsp" style="width: 1000px; min-height: 800px; border:none;">
		
	  </iframe>
    </div>
  </div>
</div>
</body>
</html>

