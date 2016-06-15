<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<base href="<%=basePath%>">
    	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />    
    	  	
        <link rel="stylesheet" type="text/css" href="css/user/top.css"/>        
        
        <script type="text/javascript" src="js/common/layer/layer.js"></script>
        <script src="js/user/nav.js"></script>
        
        <script type="text/javascript">  
		    function refresh() {  
		        //IE存在缓存,需要new Date()实现更换路径的作用  
		        document.getElementById("image").src="code?"+new Date();
		    }  
		    
		    /* 注销 */
			function logout() {
				$.post("user_logout.action", function() {
					location.reload();//刷新页面
				});//注销
			}
		</script>  
    </head>

    <body>
    	<div class="nav">
	    	<div class="ui_plugins">
	            <a class="logo" title="我的音乐网" href="#">
	                <img width="54px" height="55px" alt="我的音乐网" src="images/other/logo.png" />                
	            </a>
	            <div class="ui_nav_menu">
	                <ul class="ui_inline">
	                    <li class="isDisabled"><a href="indexAction.action">推荐</a></li>
	                    <li><a href="song_ranking.action">排行榜</a></li>
	                    <li><a href="songListing_list.action">歌单</a></li>
	                    <li><a href="singer_list.action">歌手</a></li>
	                    <li><a href="album_list.action">专辑</a></li>
	                </ul>
	            </div>
	            <div class="ui_nav_right">
	                <div class="ui_t_search">
	                    <form id="gForm" action="songListing_toSearch.action" method="post">
	                        <input id="key" class="search_text" autocomplete="off" placeholder="单曲/歌手/专辑/歌单" value="" name="key" maxlength="40" size="40"/>                       
	                        <label class="search_button">
	                        	<span></span>
	                           <input class="search_button" type="submit" value=""/>
	                        </label>
	                    </form>
	                </div>
	                <c:choose>
	                	<c:when test="${userInfo == null}">
		                	<div id="global_check_login" class="ui_login">
			                    <img class="ui_dHead" width="30px" height="30px" src="images/other/default_head.png"/>
			                    <a id="loginHref" href="javascript:void(0);">登录</a><span>&nbsp;|</span>
			                    <a id="registerHref" href="front/user/register.jsp">注册</a>
			                </div>
		                </c:when>
		                <c:otherwise>
			                <div id="global_user_infobox" class="ui_login" style="cursor: pointer;">
								<img width="30" height="30" src="${sessionScope.userInfo.headImg}" alt="" class="ui_dHead">
								<span>${sessionScope.userInfo.account}</span>								
							</div>
							<div id="g_subnav" class="m-tlist m-tlist-lged" style="display: none;">
								<ul class="f-cb">
									<li><a href="user_info.action?userForm.id=${sessionScope.userInfo.id}" class="itm-1">我的主页</a></li>
									<li><a href="user_mylisting.action" class="itm-2">我的音乐</a></li>
									<li><a href="javascript:logout();" class="itm-3">退出</a></li>
								</ul>
							</div>
						</c:otherwise>
	                </c:choose>	                       			
	            </div>
	         </div>    
	     </div>
	     
	     <!-- 登录悬浮框 -->
	     <div class='boxy' style="display:none;" id="boxy">
             <form id='jvForm' method='post' action='user_login.action' target='loginframe' onsubmit='return checkInfo();' style="padding-top: 10px;padding-left: 30px;">
                <input id='username' name='account' type='text' style='color:#666666' placeholder="用户名" maxlength="20" />
                <div style="width:100%; height:10px;">&nbsp;</div>
                <p class="errorInfo">账号或密码错误!</p>    
                <input id='password' type='password' class='input1' name='password' maxlength="16" placeholder="登录密码"/>
                <p class="errorInfo">&nbsp;</p>
                <input id='validateCode' name='validateCode' type='text' maxlength="4" style='color:#666666' placeholder="输入验证码" />                 
                <img id="image" src="code" alt="验证码" onclick="refresh()" style="position:relative; top:-3px;" width="80px"  height="30px"/>
                <a href="javascript:refresh()" class="next" title="看不清楚，请点击更换一张图片">换一张</a>  
                <p class="errorInfo">验证码错误!</p>
                <div class='boxy-div2'>                     
                    <input id="loginSubmit" type='submit' class='btn1' value='登&nbsp;&nbsp;录'/>
                    <a class="register" href="front/user/register.jsp">免费注册</a>
                </div>
             </form>
        </div>
    </body>
</html>
