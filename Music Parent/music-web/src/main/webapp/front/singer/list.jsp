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
    
    <title>推荐歌手 - 我的音乐</title>
   	
	<link rel="stylesheet" type="text/css" href="css/user/singerlist.css">	

	<style type="text/css">
		.n-ltlst {
		    position: relative;
		    top:10px;
		    left:0px;
		    padding-left: 0px;
		    width: 760px;
		    height: 50px;
		    clear: both;		    
		}
		.n-ltlst li {
		    display: inline;
		    float: left;
		    font-size: 14px;
		    margin-left: 3px;
		    position: relative;
		    left: 0px;
		}
		.n-ltlst li a {
		    float: left;
		    line-height: 24px;
		    text-align: center;
		    width: 21px;
    		color: #333;
    		text-decoration: none;
		}
		.n-ltlst li a:hover {
			text-decoration: none;
		}
		.n-ltlst li .ch {
		    height: 24px;
		    width: 45px;
		}
		.n-ltlst li a.z-slt, .n-ltlst li a.z-slt:hover {
		    background: none repeat scroll 0 0 #c20c0c;
		    border-radius: 2px;
		    color: #fff;
		}
		.left_nav li {
			list-style: none;
		}
	</style>
 
 	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
   	
   	<script type="text/javascript">
   		$(function(){
   			//选中当前歌手类别
   			$(".blk li a").each(function() {
   				var href = $(this).attr("href");
   				var idStr = href.substr(href.indexOf("=")+1);
   				if(idStr == '${singerForm.category}') {
   					$(this).css("color", "#ff0000");
   					return false;
   				}   				
   			});
   			
   			//选中首字母缩写
   			if('${singerForm.abbr}' != '') {
   				$("#initial-selector li a").each(function() {   				
   	   				if($(this).text() == '${singerForm.abbr}') {
   	   					$(this).addClass("z-slt");
   	   					return false;
   	   				}   				
   	   			});	
   			} else {
   				$("#initial-selector li:eq(0) a").addClass("z-slt");
   			}  			
   		});
   	</script>
  </head>
  
  <body>
    <!-- 导航栏 -->
    <div>
		<jsp:include page="../top.jsp"></jsp:include>
	</div>
	
	<!-- 中间 -->
	<div class="ui_layout">
		<!-- 中间的左边部分 -->
		<div class="ui_left">
			<div id="singer-cat-left_nav" class="g-wrap4 n-sgernav">
			<div class="blk">
				<ul class="left_nav f-cb">
			<c:forEach items="${singerTypeList}" var="type" varStatus="status">
				<c:if test="${type.value == null}">
				<li><h3 class="tit">${type.name}</h3></li>				
				</c:if>
				<c:if test="${type.value != null}">
				<li><a class="cat-flag" href="singer_list.action?singerForm.category=${type.value}">${type.name}</a>
				</c:if>
				<%-- <c:if test="${type.value == null}">
					<c:if test="${status.index == 0}">
						<div class="blk">
							<h3 class="tit">${type.name}</h3>
							<ul class="left_nav f-cb">
							</ul>
						</div>
					</c:if>
					<c:if test="${status.index != 0}">
						<div class="blk">
							<h3 class="tit">${type.name}</h3>
							<ul class="left_nav f-cb">
							</ul>
						</div>
					</c:if>
				</c:if>
				<c:if test="${type.value != null}">
				<li><a class="cat-flag" href="singer_list.action?singerForm.category=${type.value}">${type.name}</a>
				</c:if> --%>
			</c:forEach>
			</ul>
			</div>
		</div>
		
		<!-- 中间的右边部分 -->
		<div class="ui_right" style="position: absolute; top:80px; left: 320px;">
			<div class="hot_singer">
				<div class="v-hd2">
					<div><a href="singer_list.action?singerForm.category=${singerForm.category}&singerForm.abbr=${singerForm.abbr}" class="tit">${cateName==null ? '热门歌手' : cateName}</a></div>
					<ul id="initial-selector" class="n-ltlst f-cb" >
						<li>
						<a class="ch f-fs0" href="singer_list.action?singerForm.abbr=&singerForm.category=${singerForm.category}">热门</a>
						</li>
						<c:forEach items="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z" var="s">
						<li>
						<a class="ch f-fs0" href="singer_list.action?singerForm.abbr=${s}&singerForm.category=${singerForm.category}">${s}</a>
						</li>
						</c:forEach>
					</ul>
				</div>
				<ul id="m-artist-box" class="m-cvrlst" style="clear:both;width:99%;">
					<c:forEach items="${singerList}" var="singer" begin="0" end="11">
					<li>
						<div class="head">							
							<a class="msk" href="singer_view.action?singerForm.id=${singer.id}" title="${singer.name}的音乐">
								<img src="${singer.smallImg}" width="130" height="130" />
							</a>
						</div>
						<p>
							<a title="${singer.name}的音乐" href="singer_view.action?singerForm.id=${singer.id}">${singer.name}</a>
						</p>
					</li>
					</c:forEach>					
				</ul>
				<ul class="others">
					<c:forEach items="${singerList}" var="singer" begin="11">
						<li><a title="${singer.name}的音乐" href="singer_view.action?singerForm.id=${singer.id}">${singer.name}</a></li>
					</c:forEach>					
				</ul>
			</div>
		</div>
	</div>
	</div>
	
	<!-- 底部 -->
	<jsp:include page="../footer.jsp"></jsp:include>
  </body>
</html>
