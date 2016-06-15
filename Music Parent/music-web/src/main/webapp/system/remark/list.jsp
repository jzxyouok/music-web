<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="myTag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>
    	<c:choose>
			<c:when test="${remarkForm.type=='1'}"><!-- 歌曲评论 -->
				歌曲
			</c:when>
			<c:when test="${remarkForm.type=='2'}"><!-- 专辑评论 -->
				专辑
			</c:when>
			<c:when test="${remarkForm.type=='3'}"><!-- 歌单评论 -->
				歌单
			</c:when>
		</c:choose>
    	评论列表
    </title>
    
	<link rel="stylesheet" type="text/css" href="css/admin/comment.css">

	<style type="text/css">
		/* 评论审核 */
		.critic {
			float:left;
			margin-left: 10px;	
		}
		.critic span {
			width:60px;
			cursor: pointer;
			padding: 3px 3px;
			background-color: #aaa;
			border-radius:5px;	
			color: #fff;
		}
		.critic span:hover {
			background-color: #ccc;
		}
	</style>
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>

	<script type="text/javascript">
		$(function() {
			//表格隔行换色
			$("tbody tr:even").css("background-color", "#fff");
			
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
			
			//点击审核评论
			$("span.critic > span").click(function() {
				//获取当前评论在评论列表中的下标
				var index = $("span.critic").index($(this).parent());
				//获取当前评论对应的span
				var $span = $("span.critic:eq('"+index+"')");
				
				//审核评论
				var typeV = $(this).attr("lang");
				var idV = $span.attr("lang");
				$.post('admin/checkAlbumRemark', {type:typeV, id: idV}, function(data){
					if(data == 'success') {//审核完成
						$span.find("span").remove();	//移除审核按钮
						if(typeV == 2) {//审核结果为审核通过							
							$span.text("审核通过");
						} else if(typeV == 3) {//审核结果为审核未通过
							$span.text("审核未通过");
						}
					}
				});
			});
			
			//点击删除评论按钮，删除评论
   			$(".sixth_td .delImg").click(function(){
   				var $tr = $(this).parent().parent();
   				//获取评论编号
   				var remarkId = $(this).attr("lang");
				if(!confirm("确定删除评论?")) {
					return;
				}
				$.post('sys/sysRemark_delete.action', {id:remarkId}, function(data) {
					if(data == 'success') {//评论移除成功
						alert("评论删除成功!");
						$tr.remove();
						$("#remarkCount").val(parseInt($("#remarkCount").val()) - 1);
					}
				});
   			});
   			
   			//改变下拉框的值，表单提交
   			$("#remarkForm select").change(function() {
   				$("#remarkForm").submit();
   			});
		});
	</script>
  </head>
  
  <body>
    <div class="content">
    	<h2 class="tit">
    	<c:choose>
			<c:when test="${remarkForm.type=='1'}"><!-- 歌曲评论 -->歌曲</c:when>
			<c:when test="${remarkForm.type=='2'}"><!-- 专辑评论 -->专辑</c:when>
			<c:when test="${remarkForm.type=='3'}"><!-- 歌单评论 -->歌单</c:when>
		</c:choose>评论列表
		</h2>
    	<form action="sys/sysRemark_list.action?remarkForm.type=${remarkForm.type}" method="post" id="remarkForm">
    	<!-- 评论列表 -->
    	<div class="comment-list">
    		<div class="u-title u-title-1">
				<span class="hd f-fl">评论</span>					
				<span class="sub f-fl" style="font-size: 18px;" id="remarkCount">${fn:length(pageBean.dataList)}条</span>
				<select class="f-ff2" name="status">
					<option value="0" <c:if test="${remarkForm.status=='0'}">selected='selected'</c:if>>只显示未审核评论</option>
					<option value="1" <c:if test="${remarkForm.status=='1'}">selected='selected'</c:if>>显示所有评论</option>
				</select>
			</div>
			<table class="m-table">
				<thead>
					<tr>
						<th><div class="wp">用户</div></th>
						<th class="w2">
							<div class="wp">
								<c:choose>
									<c:when test="${remarkForm.type=='1'}"><!-- 歌曲评论 -->
										歌曲
									</c:when>
									<c:when test="${remarkForm.type=='2'}"><!-- 专辑评论 -->
										专辑
									</c:when>
									<c:when test="${remarkForm.type=='3'}"><!-- 歌单评论 -->
										歌单
									</c:when>
								</c:choose>
							</div>
						</th>
						<th class="w3"><div class="wp">评论</div></th>
						<th class="w4"><div class="wp">时间</div></th>
						<th class="w4"><div class="wp">操作</div></th>
					</tr>
				</thead>
				<tbody id="m-song-list-module">
				<c:forEach items="${pageBean.dataList}" var="remark">
				<tr class="ztag even">
					<td class="second_td">${remark.userPo.account}</td>
					<td class="third_td">
						<c:choose>
							<c:when test="${remarkForm.type=='1'}"><!-- 歌曲评论 -->
								${remark.songPo.name}
							</c:when>
							<c:when test="${remarkForm.type=='2'}"><!-- 专辑评论 -->
								${remark.albumPo.name}
							</c:when>
							<c:when test="${remarkForm.type=='3'}"><!-- 歌单评论 -->
								${remark.songListingPo.name}
							</c:when>
						</c:choose>
					</td>
					<td  class="fourth_td">						
						<span class="comment">${remark.content}</span>
					</td>
					<td class="fifth_td">${remark.time == null ? '' : remark.time}</td>
					<td class="sixth_td">					
						<c:choose>
							<c:when test="${remark.status==1}"><!-- 尚未审核 -->
								<span class="critic" lang="${remark.id}"><span class="criticPass" lang="2">审核通过</span>&nbsp;&nbsp;<span id="criticNotPass" lang="3">审核不通过</span></span>	
							</c:when>
							<c:when test="${remark.status==2}"><!-- 审核已通过 -->
								<span class="critic">审核已通过</span>
							</c:when>
							<c:when test="${remark.status==3}"><!-- 审核未通过-->
								<span class="critic">审核未通过</span>
							</c:when>
						</c:choose>
						<img class="delImg" alt="删除" title="删除" lang="${remark.id}"  src="images/other/010.gif" style="cursor: pointer;" width="12" height="12">
						<!-- <a href="javascript:void(0);">删除</a> -->
					</td>
				</tr>
				</c:forEach>				
				</tbody>
			</table>
			<!-- 分页条 -->
			<div class="pagePlugin" style="width:500px; margin: 10px auto;">				
				<myTag:page form="pageForm" pageBean="${pageBean}" />
			</div>
    	</div>
    	</form>
    </div>
  </body>
</html>
