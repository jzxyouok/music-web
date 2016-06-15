<%@ tag language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="top" required="true" type="java.lang.Integer" description="控件距父标签上方的距离" %>
<%@ attribute name="left" required="true" type="java.lang.Integer" description="控件距父标签左边的距离" %>

<style type="text/css">
	div.m-layer {
		position: relative;
	}
	div.m-layer .zbar, div.m-layer .zcls {
    	background: url("images/other/layer.png") no-repeat scroll 0 9999px rgba(0, 0, 0, 0);
	}
	div.m-layer-w2 {
	    width: 480px;
	}
	.m-favgd .tit {
	  background: none repeat scroll 0 0 #e6e6e6;
	  cursor: pointer;
	  padding: 10px 0 10px 35px;
	}
	div.m-layer .zbar {
		  background: none repeat scroll 0 0 #2d2d2d;
		  border-bottom: 1px solid #191919;
		  border-radius: 4px 4px 0 0;
		  position: relative;
		  z-index: 10;
	}
	div.m-layer .zttl {
	  background-position: 50% 0;
	  border-radius: 3px 3px 0 0;
	  color: #fff;
	  font-size: 14px;
	  font-weight: bold;
	  height: 38px;
	  line-height: 38px;
	  margin: 0;
	  padding-left: 18px;
	}
	div.m-layer .zbar, div.m-layer .zttl {
		  -moz-user-select: none;
		  cursor: move;
	}
	.auto-1429023468669 .zbar {
		  background: none repeat scroll 0 0 #8098e7;
		  border-bottom: 1px solid #aaa;
		  line-height: 30px;
	}
	div.m-layer .zbar, div.m-layer .zttl {
		  -moz-user-select: none;
		  cursor: move;
	}
	.m-favgd .u-icn-33 {
	  margin-right: 10px;
	}
	.zcnt .u-icn-33 {
	  background: url("images/other/icon.png") no-repeat scroll 0 9999px rgba(0, 0, 0, 0);
	  background-position: 0 -495px;
	  height: 36px;
	  width: 35px;
	}
	.auto-1429023468669 .zttl {
		  margin-right: 20px;
		  text-align: left;
	}
	div.m-layer div.zcnt {
	  -moz-border-bottom-colors: none;
	  -moz-border-left-colors: none;
	  -moz-border-right-colors: none;
	  -moz-border-top-colors: none;
	  background: none repeat scroll 0 0 #fff;
	  border-color: #878787;
	  border-image: none;
	  border-radius: 0 0 4px 4px;
	  border-style: solid;
	  border-width: 0 1px 1px;
	  padding: 0;
	}
	.auto-1429023468669 .zcnt {
	  padding: 10px 5px;
	}
	div.m-layer .lyct {
    padding: 40px 0;
	}
	div.m-layer .lyct-1 {
	    padding: 0;
	}
	div.m-layer .lybt {
	    border-top: 1px solid #c6c6c6;
	}
	div.m-layer .lybtc {
	    background: none repeat scroll 0 0 #f7f7f7;
	    border: 1px solid #fff;
	    border-radius: 0 0 4px 4px;
	    height: 32px;
	    line-height: 32px;
	    padding: 8px 20px;
	    text-align: center;
	}
	div.m-layer .lybt .u-btn2 {
	    margin: 0 10px;
	}
	div.m-layer .lybt .back {
	    float: right;
	}
	div.m-layer .lybtn {
	    margin-top: 30px;
	}
	div.m-layer .lybtn a, div.m-layer .lsbtn a {
	    margin: 0 10px;
	}
	div.m-layer .mesg {
	    margin-top: 15px;
	}
	div.m-layer .msg1 {
	    line-height: 20px;
	    margin-bottom: 10px;
	    margin-top: 12px;
	}
	div.m-layer .zcls {
	    background-position: 0 -95px;
	    cursor: pointer;
	    height: 10px;
	    overflow: hidden;
	    position: absolute;
	    right: 20px;
	    text-indent: -9999px;
	    top: 16px;
	    width: 10px;
	    z-index: 20;
	}
	div.m-layer .alert {
	    background: none repeat scroll 0 0 #ffeaea;
	    border: 1px solid #f7afaf;
	    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
	    color: #666;
	    height: 30px;
	    left: 50%;
	    line-height: 30px;
	    margin: -15px 0 0 -135px;
	    position: absolute;
	    text-align: center;
	    top: 50%;
	    width: 270px;
	}
	div.m-layer .lsbtn {
	    background-color: #f7f7f7;
	    border-radius: 0 0 4px 4px;
	    border-top: 1px solid #c6c6c6;
	    padding: 10px 0;
	}	
	.zcnt .u-icn {
	    display: inline-block;
	    overflow: hidden;
	    vertical-align: middle;
	}	
	.m-favgd ul {
		padding-left: 0;
		font-size: 14px;
	}
	.m-favgd ul .item {
	    padding-left: 50px;
	}
	.m-favgd ul li {
		list-style: none;
		padding-left: 20px;
		margin-top: 0;
		cursor: pointer;
	}
	.m-favgd ul li:hover {
		background-color: #f2f2f2;
	}
	.m-favgd ul a {
	  color: #333;
	  text-decoration: none;
	}
	.m-favgd ul .left {
	    display: inline;
	    float: left;
	    margin-left: -50px;
	    overflow: hidden;
	    width: 40px;
	}
	.m-favgd ul .avatar {
	    display: block;
	    height: 40px;
	    width: 40px;
	}
	.m-favgd ul .avatar img {
	    height: 40px;
	    width: 40px;
	}
	.m-favgd ul a:hover {
	    text-decoration: none;
	}
	.m-favgd ul p {
	    word-wrap: break-word;
	}
	.m-favgd ul .name {
	    margin-bottom: 8px;
	    margin-top: 2px;
	}
	.m-crgd {
	    margin-left: 30px;
	    text-align: left;
	}
	.m-crgd .u-txt {
	    vertical-align: middle;
	    width: 330px;
	}
	.m-crgd .tip {
	    margin: 8px 0 20px 48px;
	}
	.m-crgd .btn, .m-crgd .u-err {
	    margin-left: 48px;
	}
	.m-crgd .u-btn2-1 {
	    margin-left: 20px;
	}
	.m-fdback {
	    padding: 0 40px;
	}
	.m-fdback .u-txtwrap {
	    margin-top: 5px;
	}
	.m-fdback .area {
	    height: 100px;
	}
	.m-fdback .contact {
	    height: 60px;
	}
	.s-fc3, a.s-fc3:hover {
	  color: #666;
	}
	.m-crgd .u-txt {
	  vertical-align: middle;
	  width: 330px;
	}
	.u-txt {
	  border: 1px solid #cdcdcd;
	  border-radius: 2px;
	  height: 19px;
	  line-height: 19px;
	  margin: 0;
	  padding: 5px 6px 6px;
	}
	.u-txt {
	  background: url("images/other/area.png") repeat-x scroll 0 0 rgba(0, 0, 0, 0);
	}
	
	.m-crgd .u-btn2-1 {
	  margin-left: 20px;
	}
	
	div.m-layer .u-btn2, div.m-layer .u-btn2:hover {
	  text-decoration: none;
	  background-color: #3685D0;
	}
	div.m-layer .u-btn2 {
	  padding: 0 5px 0 0;
	  white-space: nowrap;
	}
	div.m-layer .u-btn2, div.m-layer .u-btn2 i {
	  cursor: pointer;
	  display: inline-block;
	  height: 31px;
	  line-height: 31px;
	  overflow: hidden;
	  text-align: center;
	  vertical-align: top;
	  font-style: normal;
	}
	div.m-layer .u-btn2-2 {
	  background-color: #4D96DA;
	  color: #fff;
	  padding: 3px 20px;
	  border-radius: 4px;
	}
	div.m-layer .u-btn2-1 { 
	  color: #333;
	  background-color: #F1F1F1;
	}
	div.m-layer .u-btn2-1:hover {
		background-color: #E1E1E1;
	}
</style>

<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>

<script type="text/javascript">
	$(function() {
		//控制控件距页面上方的距离
		$("#controllerDiv").css({position: "absolute", left: "${left}px", top: "${top}px"}); 
		
		//点击关闭窗口
		$(".zcls").click(function() {
			$(this).parent().hide();
		});				
		
		//点击添加新歌单，弹出歌单添加悬浮窗口
		$(".auto-1429023468669 .tit i").click(function() {			
			$(".zcls:eq(0)").parent().hide();//关闭父窗口
			$(".zcls:eq(1)").parent().show();			
		});
		
		//点击取消按钮，关闭新建歌单悬浮框
		$("#auto-id-pGK5Regebv2VeyTP").click(function() {
			$(".auto-1429023496255").hide();
		});
		
		//点击取消按钮，关闭删除歌单确认框
		$("#closeForDelete").click(function() {
			$(".auto-14290234912123").hide();
		});		
		
		//定义悬浮窗的移动事件
		/* var x,y;
		var isMoving = true;
		$("#controllerDiv .zttl").mousedown(function(e) {
			x = e.pageX;
			y = e.pageY;
			isMoving = true;
		}).mousemove(function(e) {
			if(!isMoving) {
				return;
			}
			var tmpX = e.pageX;
			var tmpY = e.pageY;
			var xSpan = tmpX - x;
			var ySpan = tmpY - y;
			//$(this).parent().offset({left:"+="+xSpan, right:"+="+ySpan});
			$("this").parent().css({left:"-="+xSpan, top:"-="+ySpan});
			
			x = tmpX;
			y = tmpY;
		}).mouseup(function(e) {
			isMoving = false;
		}); */
	});
</script>

<div id="controllerDiv">
	<div class="auto-1429023468669 m-layer z-show m-layer-w2" style="z-index: 300; width:480px; display: none;">
		<div class="zbar" id="auto-id-RAPuMeFyg6wN2TOH">
			<div class="zttl">添加到歌单</div>
		</div>
		<div class="zcnt">
			<div class="lyct lyct-1 m-favgd">
				<div class="tit" id="auto-id-EnpsgzmTMlsZc9Pc">
					<i class="u-icn u-icn-33"></i>新歌单
				</div>
				<div class="j-flag" id="auto-id-aKU4H4AU9gzATzxb">
					<ul id="listingUl">
						<!-- <li>
							<div class="item">
								<div class="left">
									<a target="_blank" class="avatar" href="javascript:void(0)">
										<img src="http://p3.music.126.net/eUKHATpn2FPe-016p5Agqw==/2917004348593269.jpg?param=40y40" alt=""></a>
								</div>
								<p class="name"><a target="_blank" href="javascript:void(0)">我喜欢的音乐</a></p>
								<p class="s-fc3">14首</p>
							</div>
						</li> -->					
					</ul>
				</div>
			</div>
		</div>
		<span title="关闭窗体" class="zcls" id="auto-id-ftFcE5pNeW9yTl3g">×</span>
	</div>
	
	<div class="auto-1429023496255 m-layer z-show m-layer-w2" style="font-size:14px; z-index:310; display: none;">
		<div class="zbar" id="auto-id-sFyEXuQHHpZSkIzQ">
			<div class="zttl">新建歌单</div>
		</div>
		<div class="zcnt">
			<div class="lyct m-crgd" id="auto-id-16WHP0r53BGJkPPs">
				<input type="hidden" name="songToCollect">
				<p>歌单名：<input type="text" class="u-txt" name="listingName" id="auto-id-R42HTWdrQDgPngv1"></p>
				<div class="u-err" style="visibility: hidden;"><i class="u-icn u-icn-25"></i>歌单名不能为空</div>
				<p class="tip s-fc4">可通过“收藏”将音乐添加到新歌单中</p>
				<div class="btn">
					<a class="u-btn2 u-btn2-2" href="javascript:;" id="auto-id-1DbQenLOcXpWJDPX"><i>新 建</i></a>
					<a class="u-btn2 u-btn2-2 u-btn2-1" href="javascript:;" id="auto-id-pGK5Regebv2VeyTP"><i>取 消</i></a>
				</div>
			</div>
		</div>
		<span title="关闭窗体" class="zcls" id="auto-id-qE19ZVM5gbQ4vul3">×</span>
	</div>
	
	<!-- 删除歌单提示 -->
	<div class="auto-14290234912123 m-layer z-show m-layer-w2" style="font-size:14px; z-index:310; display: none;">
		<div class="zbar">
			<div class="zttl">提示</div>
		</div>
		<div class="zcnt">
			<div class="lyct m-crgd">
				<input type="hidden" name="songListingToDelete">
				<p class="tip s-fc4" style="text-align: center; position: relative; left: -40px;">确定删除歌单?</p>
				<div class="btn" style="font-size: 13px; text-align: center; position: relative; left: -40px;">
					<a class="u-btn2 u-btn2-2" href="javascript:;"><i>确定</i></a>
					<a id="closeForDelete" class="u-btn2 u-btn2-2 u-btn2-1" href="javascript:;"><i>取 消</i></a>
				</div>
			</div>
		</div>
		<span title="关闭窗体" class="zcls">×</span>
	</div>
</div>