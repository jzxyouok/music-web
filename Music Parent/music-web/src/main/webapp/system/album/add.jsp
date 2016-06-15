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
    
    <title>添加专辑</title>
    
	<link rel="stylesheet" href="css/uploadify.css" type="text/css"></link>
	<style type="text/css">		
		/* 整体框架css  */
		.all{
			width: 100%;
			height: 560px;
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
			height: 21px;
		}
		.content select {
			width: 100px;
		}
		.content otpion {
			width: 80px;
			height: 21px;
			padding-top: 5px;
		}
		.content textarea {
			font-size: 13px;
		}
	</style>

	<script charset="utf-8" src="js/common/jquery-1.11.1.js"></script>
	<script type="text/javascript" src="js/common/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="js/common/swfobject.js"></script>
	<script type="text/javascript" src="js/common/tender.js"></script>
    <script type="text/javascript" src="js/common/jquery.uploadify.v2.1.4.js"></script>
	<script type="text/javascript">
		$(function() {
			//添加专辑
			$("#btnadd").click(function() {
				if(validateForm()) {
					$.post('sys/addAlbumAjax.action',$("#albumForm").serialize(),function(data){
						if(data == 'success') {
							//专辑添加成功,重新加载页面
							parent.location.reload();
						}
					});		
				}
			});
			
			//取消添加
			$("#btncancel").click(function() {
				//当你在iframe页面关闭自身时
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
			});
		});
		
		$(function(){
			//图片上传
			$("#uploadify").uploadify({
                'uploader'       : 'js/common/uploadify.swf', //是组件自带的flash，用于打开选取本地文件的按钮 
                'script'         : 'sys/upload_albumImg.action;jsessionid=<%=session.getId()%>',//处理上传的路径URL(处理firefox兼容问题加上sessionid)
                'cancelImg'      : 'images/other/uploadify-cancel.png',//取消上传文件的按钮图片，就是个叉叉
                'folder'         : 'attachments',//上传文件的目录
                'fileDataName'   : 'fileupload',//和input的name属性值保持一致就好
                'queueID'        : 'fileQueue',
                'queueSizeLimit' : 1, //限制在一次队列中的次数（可选定几个文件）。默认值= 999
                //'simUploadLimit' : 1,//多文件上传时，同时上传文件数目限制(一次可传几个文件)。默认值1
                'auto'           : false,//是否选取文件后自动上传
                'multi'          : true,//是否支持多文件上传       
                'sizeLimit'      : 99999999999,//限制上传文件的大小
                'buttonText'     : 'Browse',//按钮上的文字
                'method'         : 'POST',  
                'displayData'    : 'percentage',//有speed和percentage两种，一个显示速度，一个显示完成百分比 
                'fileDesc'       : '支持格式:jpg/gif/jpeg/png/bmp.', //如果配置了以下的'fileExt'属性，那么这个属性是必须的 
                'fileExt'        : '*.jpg;*.gif;*.jpeg;*.png;*.bmp',//允许的格式
                'onComplete'     : function (event, queueID, fileObj, result, data){
					                	var index = result.indexOf(":");
										if(-1 != index){
											var fileName = result.substring(0,result.indexOf(":"));
						                 	$("#result").append('<li><font color="blue">'+fileName+'</font></li>');
						                 	
						                	var urlPic = result.substring(result.indexOf(":")+1);
						                	var url = $("#picsUrl").val();
						                	var allUrl = '';
						                	if(!isEmpty(url)){
						                		allUrl = url+","+urlPic;
						                	} else {
						                		allUrl = urlPic;
						                	}
						                	$("#picsUrl").val(allUrl);
										} else {
											$("#result").html(result);
										}
					                 },
               'onError'        : function(event, queueID, fileObj,errorObj){
					                	 $("#result").html(errorObj.type + "Error:" + errorObj.info);
					               	   }
            });
			
		});
		
		//图片上传
		function showResult(){//删除显示的上传成功结果
	        $("#result").html("");
	    }
	    function uploadFile(){//上传文件
	        $('#uploadify').uploadifyUpload();
	    }
	    function clearFile(){//清空所有上传队列
	        $('#uploadify').uploadifyClearQueue();
	    }
	    function cleanResult(){
	       $("#result").html("");
	    }
		
		function validateForm() {
			var name = $("#name").val();
			var publishDate = $("#publishDate").val();
			var company = $("#company").val();
			var area = $("#area").val();
			var picsUrl = $("#picsUrl").val();
			
			if(!name) {
				alert("专辑名不能为空！");
				return false;
			}
			if(!publishDate) {
				alert("发行时间不能为空！");
				return false;
			}
			if(!company) {
				alert("唱片公司不能为空！");
				return false;
			}
			if(!area) {
				alert("地区不能为空！");
				return false;
			}
			if(!picsUrl) {
				alert("专辑图片不能为空！");
				return false;
			}
			
			return true;
		}
	</script>
  </head>
  
  <body>
   	<div class="all">
   		<div class="title">
   			<h2>添加专辑</h2>
   		</div>   		
   		<div class="content">
	   		<!-- 添加专辑弹出框 -->
	    	<div id="add-album-alert">
		    	<form id="albumForm" action="sys/addAlbumAjax.action" method="post" enctype="multipart/form-data">
		    		<input type="hidden" name="singerIds" value="${albumForm.singerIds}" />
					<table class="addAlbumTable">
						<tr>
							<td >专辑名：</td> <td><input type="text" id="name" name="name" size="40px" maxlength="25" required="required" /></td>
						</tr>					
						<tr>
							<td >发行时间：</td> <td><input class="Wdate" type="text" id="publishDate" name="publishDate" onClick="WdatePicker({lang:'zh-tw'})" placeholder="点我选择日期" required="required"></td>
						</tr>
						<tr>
							<td >发行公司：</td> <td><input type="text" id="company" name="company" maxlength="40"></td>
						</tr>				    					    			    			
						<tr>
							<td >地区：</td>
							<td>
								<select name="area" id="area">
									<option value="华语">华语</option>
									<option value="欧美">欧美</option>
									<option value="韩国">韩国</option>    							
									<option value="日本">日本</option>
									<option value="其他">其他</option>
								</select>    
							</td>
						</tr>    					
						<tr>
							<td >上传图片：</td> 
							<td>
								<div id="fileQueue"></div>
								<input type="file" id="uploadify" name="fileupload" required="required" />
								<br>
								<ul id="result"></ul>
								<input type="hidden" name="image" id="picsUrl">
								<br>
								<!--显示结果-->
								<p>
									<a href="javascript:uploadFile()">开始上传</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="javascript:clearFile()">取消所有上传</a>
								</p>
							</td>
						</tr>
						<tr>
							<td>专辑介绍：</td>
							<td>&nbsp;</td>     						
						</tr>
						<tr>
							<td colspan="2">
							<textarea name="description" id="description" cols="80" rows="6" maxlength="500" placeholder="请输入不多于500个字"></textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input id="btnadd" class="submit redBt" type="button" value="添加" />
								<input id="btncancel" class="submit redBt" type="button" value="取消" />
							</td>
						</tr>
					</table>
				</form>
			</div>
   		</div>
   	</div>
  </body>
</html>