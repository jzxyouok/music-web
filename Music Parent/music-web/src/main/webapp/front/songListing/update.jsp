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
    
    <title>歌单编辑</title>
    	
	<link rel="stylesheet" type="text/css" href="css/user/playlist_edit.css">
 	
 	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
 
 	<script type="text/javascript">
 		$(function() {
 			//点击显示标签选择框
 	 		$("#selectTagHref").click(function() { 			
 	 			$(".auto-1429423418132").show();
 	 		});
 			
 			//点击关闭标签选择框
 			$("#auto-id-TRNVWQIAvFP71OAQ").click(function() {
 				$(".auto-1429423418132").hide();
 			});
 			
 			//点击保存并关闭按钮，保存选中的标签
 			$("#auto-id-ziI5mlotOGFRD4gI .lybtc a").click(function() {
 				//保存风格标签
 				var styleArr = [];
 				var styleNameArr = [];
 				$(".tagtyp:eq(0) .f-cb li .u-icn-31").each(function() {
 					if($(this).is(":visible")) {//如果被选中，则记录下相应的值 						
 						styleNameArr.push($(this).siblings().text());
 						styleArr.push($(this).siblings().attr("lang"));
 					}
 				});	
 				 				
 				//保存语言标签
 				var languageArr = [];
 				var languageNameArr = [];
 				$(".tagtyp:eq(1) .f-cb li .u-icn-31").each(function() {
 					if($(this).is(":visible")) {//如果被选中，则记录下相应的值
 						languageNameArr.push($(this).siblings().text());
 						languageArr.push($(this).siblings().attr("lang"));
 					}
 				});	
 				
 				//设置隐藏域的内容
 				$("input[name='style']").val(styleArr);
 				$("input[name='language']").val(languageArr);
 				
 				//情况之前的标签，并添加新的标签
 				$(".formDiv .tags span").remove();
 				var tagArr = styleNameArr.concat(languageNameArr);
 				for(var i in tagArr) {
 					var str = "<span class='j-flag'>"
 							+ "<a href='javascript:void(0)' class='u-tag u-tag-1'>"
 							+ "<i>" + tagArr[i] + "<em>×</em></i></a>"
 							+ "</span>&nbsp;";
 					$(".formDiv .tags").append($(str)); 					
 				} 				
 				
 				$(".auto-1429423418132").hide();	//隐藏悬浮框	
 			});
 			
 			var totalTag = 0;//目前选中的标签的数目
 			//点击选中标签，显示选中转台图标
 			$(".tagtyp .f-cb li").click(function() {
 				var size = $(this).find(".u-icn-31:hidden").size();
 				if(size > 0 && totalTag < 3) {//当前处于隐藏状态且标签数小于3，则显示
 					$(this).find(".u-icn-31").show();
 					totalTag += 1;
 				} else if(size > 0) {//如果标签数已达到3个，则无法再添加
 					alert("标签数不能够超过3个！");
 				} else if(size == 0) {//当前处于显示状态，则隐藏
 					$(this).find(".u-icn-31").hide();
 					totalTag -= 1;
 				} 				
 			});
 		});
 	</script>
  </head>
  
  <body>
    <div class="content">
    	<p class="title">
    		<a href="songListing_view.action?id=${listing.id}">${listing.name}</a>&nbsp;&gt;&nbsp;<span>编辑歌单</span>
    	</p>
    	<hr/>
    	<form action="songListing_editListing.action" method="post">
    		<input type="hidden" name="style">
    		<input type="hidden" name="language">
    		<input type="hidden" name="version" value="${listing.version}">
    		<input type="hidden" name="id" value="${listing.id}">
    		<div class="formDiv">
    			<div class="f-fl left">
    				<div style="width: 99%; height: 10%;">
	    				<label>歌单名:</label><input type="text" name="name" value="${listing.name}" required="required"><br/>
	    			</div>
	    			<div style="width: 99%; height: 60%">
	  					<span style="float: left;">标签：</span>
						<div class="f-cb tags" style="float: left; margin-left:35px; width:99%;">
							<c:forEach items="${listing.styleList}" var="curStyle">
							<span class="j-flag">
								<a href="javascript:void(0)" class="u-tag u-tag-1" ><i>${curStyle.dicPo.name}</i></a>
							</span>&nbsp;
							</c:forEach>
							<c:forEach items="${listing.languageList}" var="curLanguage">
							<span class="j-flag">
								<a href="javascript:void(0)" class="u-tag u-tag-1" ><i>${curLanguage.dicPo.name}</i></a>
							</span>&nbsp;
							</c:forEach>
						</div>
						<div>
							<a id="selectTagHref" class="cho s-fc7" href="javascript:void(0)" data-action="select">选择标签</a>
						</div>
					</div>
					<div style="width: 99%; height: 30%;">
	    				<label>介&nbsp;绍:</label>
	    				<textarea name="description" rows="3" cols="100" maxlength="140" placeholder="请输入少于140个字">${listing.description}</textarea><br/>
    				</div>
    				<input type="submit" value="保存">
    				<input type="reset" value="取消">
    			</div>
    			<div class="f-ff2 right">
    				<img src="${listing.image}" title="点击下面的按钮更换图片" width="100" height="100">
					<input type="file" name="image" style="width: 140px;">    				    				
    			</div>
    		</div>
    	</form>    	
    	
    	<!-- 选择标签悬浮框 -->
    	<div class="auto-1429423418132 m-layer z-show" style="top: 58.5px; left: 55px; display: none;">
    		<div class="zbar" id="auto-id-NqQ4NcGD3Pyx9Q0E">
    			<div class="zttl">选择标签</div>
    		</div>
    		<div class="zcnt">
    		<div id="auto-id-ziI5mlotOGFRD4gI">
    		<div class="lyct lyct-1 f-cb f-pr" style="height:420px;">
			<div class="m-seltags">
				<h4 style="font-size: 13px;">选择合适的标签，最多可选3个</h4>
				<div class="tagtyp f-cb">
				<h5>风格：</h5>
				<div class="taglst">
				<ul class="f-cb">
					<c:forEach items="${styleList}" var="curStyle">
					<li data-name="${curStyle.value}">
						<a class="u-btn2 u-btn2-1 u-btn2-sm" href="javascript:void(0)" lang="${curStyle.value}">${curStyle.name}</a>
						<i class="u-icn u-icn-31"></i>
					</li>
					</c:forEach>
				</ul>
				</div>
				</div>
				
				<div class="tagtyp f-cb">
				<h5>语言：</h5>
				<div class="taglst">
				<ul class="f-cb">
					<c:forEach items="${languageList}" var="curLanguage">
					<li data-name="${curLanguage.value}">
						<a class="u-btn2 u-btn2-1 u-btn2-sm" href="javascript:void(0)" lang="${curLanguage.value}">${curLanguage.name}</a>
						<i class="u-icn u-icn-31"></i>
					</li>
					</c:forEach>
				</ul>
				</div>
				</div>
			</div>
			
			<div class="alert f-hide" style="font-size: 13px; margin-top: 20px; color:#aaa; display: none;" id="m-tags-err">标签最多不能超过<strong class="s-fc6">3</strong>个</div>
			</div>
			<div class="lybt" style="position: relative; top:30px; text-align: center;">
				<div class="lybtc">
					<a class="u-btn2 u-btn2-2" href="javascript:void(0)" data-name="save">保存并关闭</a>
				</div>
			</div>
		</div>
		</div>
		<span title="关闭窗体" class="zcls" id="auto-id-TRNVWQIAvFP71OAQ">×</span>
		</div>
    </div>
  </body>
</html>
