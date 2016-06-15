<%@ tag language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="publishRemarkUrl" required="true" type="java.lang.String" description="发表的评论提交到的url" %>
<%@ attribute name="type" required="true" type="java.lang.String" description="评论类型" %>
<%@ attribute name="id" required="true" type="java.lang.String" description="要发表评论的对象的id" %>
<%@ attribute name="pageBean" required="true" type="com.johnf.app.music.util.PageBean" description="评论列表封装对象" %>

<style type="text/css">
	/* 评论 */
	#comment-box {
		width: 670px;
		clear:both;
		position: relative;
		top:40px;	
	}
	.publish_comment_box {
		margin-top: 10px;
		height: 100px;
	}
	.publish_comment_box .head {
		width:51px;
		float: left;
	}
	.publish_comment_box .comment_area {
		width:590px;
		float: left;
		margin-left: 20px;	
	}
	.publish_comment_box .comment_area textarea {
		width:590px;
		font-size:14px;
		margin-bottom: 10px;
	}
	.comment_area .publishDiv {
		float: right;
	}
	.publishBtn {
		padding: 5px 8px;
		color: #fff;
		background-color: #2878C8;
		cursor: pointer;
		border-radius:6px;
	}
		
	/* 评论列表 */
	.comment-list {
		min-height: 270px;	
		width: 100%;
	}
	.comment-list .list-hd {
		font-weight: bold;
		font-size: 14px;
		position: relative;
		top: 20px;
		border-bottom: 1px solid #ccc;
		padding-bottom: 8px;
	}
	#comment-box .u-title .hd {
		font-size:22px;
		font-weight: bold;
	}
	#comment-box .sub {
		margin-left: 10px;
		margin-top: 4px;
		font-size: 13px;
	}
	#comment-box .u-title {
		height: 30px;
		border-bottom: 2px solid #C20C0C;
	}
	.detail_ul {
		margin-top:25px;
		padding-left: 0;
	}
	.detail_ul li {
		list-style: none;
		min-height: 80px;
		padding: 10px 0;
		border-bottom: 1px dashed #ccc;
	}
	.detail_ul .img_div {
		width:52px;
		height: 80px;
		padding-top: 5px;
	}
	.comment_detail {
		width:600px;
	}
	.comment_detail .user {
		 color: #0c73c2;
		 font-size: 13px;
		 text-decoration: none;
		 margin-left: 10px;
	}
	.comment_detail .user:hover {
		text-decoration: underline;
	}
	.comment_detail .content {
		width:400px;
		position: relative;
		top:-7px;
		left: 10px;
		font-size: 13px;
	}
	.comment_detail span.f-fl {
		font-size: 13px;
		margin-top: 4px;
	} 
	.comment_detail .top {
		height:40px;
		margin-top: 5px;
	}
	.comment_detail .time {
		width:100%;
		margin-left: 9px;
		font-size:13px;
		color:#333;
	}
</style>

<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>

<script type="text/javascript">
	$(function() {
		//点击发表评论按钮发表评论
		$("#publishBtn").click(function() {
			//判断当前用户是否已经登录
			if($("#global_user_infobox").size() == 0) {//如果当前尚未登录，则弹出登录悬浮框
				$("#loginHref").trigger("click");
				return;
			}
			//ajax提交评论内容
			$.post('${publishRemarkUrl}', {projectId:'${id}', type:'${type}', content:$("#remarkContent").val()}, function(data){
				if(data == 'success') {//评论发表成功
					$("#remarkContent").val("");//清空输入框的内容
					alert("您的评论发表成功！可能要过一段时间后才会显示在页面上。");				
				} else {//评论发表失败
					alert("评论发表失败！请稍后重试");
				}
			});
		});
		
	});
</script>

<!-- 评论列表 -->
<div id="comment-box">
	<div class="u-title u-title-1 f-cb">
		<span class="hd f-fl">评论</span>					
		<span class="sub f-fl">共${pageBean.totalRecords}条评论</span>									
	</div>
	<!-- 发表评论idv -->
	<div class="publish_comment_box">
		<div class="head">
			<img src="images/user/default_avatar.jpg" width="50" height="50"/>
		</div>
		<div class="comment_area">
			<textarea id="remarkContent" maxlength="140" placeholder="评论"></textarea>
			<div class="publishDiv">
				<span>140</span>&nbsp;&nbsp;<span id="publishBtn" class="publishBtn" style="cursor: pointer;">评论</span>
			</div>
		</div>
	</div>
	<!-- 评论列表 -->
	<div class="comment-list">
		<div class="list-hd">
			<span>最新评论(${pageBean.totalRecords}条)</span>													
		</div>
		<ul class="detail_ul">
			<c:forEach items="${pageBean.dataList}" var="remark">
			<li>
				<div class="img_div f-fl">														
					<a href="user_myinfo.action?userForm.id=${remark.userPo.id}"><img class="f-fl" width="50" height="50" src="${remark.userPo.headImg}"/></a>
				</div>
				<div class="comment_detail f-fl">
					<div class="top">
						<a href="user_myinfo.action?userForm.id=${remark.userPo.id}" class="user f-fl">${remark.userPo.account}</a><span class="f-fl">:</span>
						<p class="content f-fl">${remark.content}</p>
					</div>
					<div class="time f-fl">
						<span>${remark.time}</span>
					</div>
				</div>
			</li>
			</c:forEach>			
		</ul>
		<!-- 分页条 -->
		<div class="pagePlugin" style="width:500px; margin: 10px auto;">				
			<my:page form="pageForm" pageBean="${pageBean}" />
		</div>
	</div>
</div>