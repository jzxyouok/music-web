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
    
    <title>搜索到的歌单</title>
    	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
	
	<script type="text/javascript">
		$(function() {
			//表格隔行换色
			$("tbody tr:even").css("background-color", "#f1f1f1");
			
			//鼠标经过行换色
			$("tbody tr").mouseover(function() {
				$(this).css("background-color", "#ccc");
				$(this).find(".third_td .opt").show();//显示添加、收藏按钮
			}).mouseout(function() {
				var index = $("tbody tr").index($(this));
				if(index % 2 == 0) {
					$(this).css("background-color", "#f1f1f1");							
				} else {
					$(this).css("background-color", "#fff");
				}
				$(this).find(".third_td .opt").hide();//隐藏添加、收藏按钮
			});
		});
	</script>
	
	<style type="text/css">
		/* 歌曲列表 */
		.song_list {
			width: 912px;
			margin-top:25px;
		}
		.song_list .sub, #comment-box .sub {
			margin-left: 10px;
			margin-top: 4px;
			font-size: 13px;
		}		
		.m-table {
			width: 910px;
			border-collapse: collapse;
		}
		.m-table td {
			min-width: 70px;
		}
		.m-table tr {
			height:60px;
		}
		.f-cb .opt {
			float: right;
			margin-top: -15px;
		}
		.f-cb .opt span {
			width:20px;
			display: inline-block;
			cursor: pointer;
		}
		#m-song-list-module td {
			padding-left: 5px;
			font-size: 14px;
			color:#333;			
		}
		#m-song-list-module td.first_td {
			width:30px;
		}
		#m-song-list-module td.second_td {
			width:70px;
			padding-top: 3px;					
		}
		#m-song-list-module td.third_td {
			width:290px;
		}
		#m-song-list-module td.fourth_td {
			width:50px;
		}
		#m-song-list-module td.fifth_td {
			width:200px;
		}
		#m-song-list-module a {
			text-decoration: none;
			color:#333;
		}
		#m-song-list-module a:hover {
			text-decoration: underline;
		}
		.s-bg {
		    background: url("images/other/index.png") no-repeat scroll 0 9999px rgba(0, 0, 0, 0);
		}
		.s-bg-11 {
		    background-position: -267px -268px;
		}
		.s-bg-11:hover {
		    background-position: -267px -288px;
		}
		.s-bg-12 {
		    background-position: -297px -268px;
		}
		.s-bg-12:hover {
		    background-position: -297px -288px;
		}
		.u-icn{
		    background: url("images/other/icon.png") no-repeat scroll 0 9999px rgba(0, 0, 0, 0);
		}
		.u-icn-81 {
		    background-position: 0 -700px;
		    height: 13px;
		    width: 13px;
		}
		.ztag .left .playBtn {
			width:20px;
			display: inline-block;
			margin-left: 25px;
			cursor: pointer;
		}
	</style>
  
  	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
   	
   	<script type="text/javascript">
   		$(function(){
   			//设置搜索页面的统计信息
   			$("#m-search .snote b", window.parent.document).text('${pageBean.dataList.size()}');//设置搜索到的歌曲的数目
   			$("#m-search .snote span", window.parent.document).text('个歌单');//设置搜索的类型
   			
   			//保存搜索关键字
   			$("#searchKeySpan").val('${key}');
   		});
   	</script>
  </head>
  
  <body>
    <!-- 歌曲列表 -->
	<div class="song_list">
		<table class="m-table" id="m-song-module">			
			<tbody id="m-song-list-module">
			<c:forEach items="${pageBean.dataList}" var="listing">
			<tr class="ztag even">
				<td class="left first_td">
					<div class="hd">								
						<span title="播放" class="s-bg s-bg-11 playBtn">&nbsp;</span>
					</div>
				</td>
				<td class="second_td">					
					<a title="${listing.name}" href="songListing_view.action?id=${listing.id}" target="_top">
						<img src="${listing.image}" width="50" height="50">
					</a>
				</td>
				<td class="third_td">
					<div class="f-cb">
						<div class="tt">
							<div class="ttc ttc-1">
								<span class="txt">
									<a title="${listing.name}" href="songListing_view.action?id=${listing.id}"  target="_top">${listing.name}</a>
								</span>
							</div>
						</div>
						<!-- <div class="opt" style="display: none;">
							<span title="添加到播放列表" class="u-icn u-icn-81">&nbsp;</span>
							<span class="s-bg s-bg-12" title="收藏">&nbsp;</span>
						</div> -->
					</div>
					</td>
					<td  class="fourth_td">${listing.songsInListing}首</td>
					<td  class="fifth_td">by&nbsp;<a href="user_view.action?id=${listing.userPo.id}" target="_top">${listing.userPo.account}</a></td>
					<td  class="sixth_td">收藏：&nbsp;${listing.listingCollected}</td>
					<td  class="sixth_td">收听：&nbsp;${listing.playCount}</td>					
			</tr>
			</c:forEach>			
			</tbody>
		</table>
		<!-- 分页条 -->
		<div class="pagePlugin" style="width:500px; margin: 10px auto;">			
			<form action="songListing_toSearch.action?key=${key}" method="post" name="pageForm">
				<!-- <input id="searchKeySpan" name="skey" type="hidden" > -->
				<myTag:page form="pageForm" pageBean="${pageBean}" />
			</form>
		</div>
	</div>
  </body>
</html>
