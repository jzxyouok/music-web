$(function() {
	/* 点击显示浮动登录框 */
	//var dialog = null;
	$("#loginHref").bind("click",function(){
		//清空文本框的内容及错误提示
		$("#boxy p.errorInfo").each(function() {
			$(this)[0].style.visibility = "hidden";
		});
		
		 //dialog = artDialog();
		 //dialog.title("登录");
		 //dialog.lock(true);
		 //dialog.content(document.getElementById("boxy"));
		 //$("#cancer").click(function (){
		//	dialog.close();
		 // });
		
		layer.open({
	        type: 1,
	        title: '登录',
	        maxmin: true,
	        shadeClose: true, //点击遮罩关闭层
	        area : ['450px' , '320px'],
	        content: $('#boxy')
		});
	});
	
	/* 导航栏高亮切换 */
	$("ul.ui_inline > li").hover(
	  function () {
	    $(this).addClass("isHover")
	    	   .siblings().removeClass("isHover");
	  },
	  function () {
	    $(this).removeClass("isHover");
	  }
	);
	
	/* 表单文本框样式 */
	$("input[name='account'], input[name='validateCode'], input[name='password']").focus(function () {
	    $(this)[0].style.border = "1px solid #FF9A66";
	});
	$("input[name='account'], input[name='validateCode'], input[name='password']").blur(function () {
	    $(this)[0].style.border = "1px solid #cccccc";
	});		
	
	/* 表单提交时进行输入验证 */
	$("#loginSubmit").click(function () {
		var account = $("input[name='account']").val();
		var password = $("input[name='password']").val();
		var validateCode = $("input[name='validateCode']").val();
	    if(account.length == 0) {	//如果用户名为空
	    	$("input[name='account']").trigger("focus");
	    	return false;
	    } else if(password.length == 0) {	//如果密码为空
	    	$("input[name='password']").trigger("focus");
	    	return false;
	    } else if(validateCode.length == 0) {	//如果验证码为空
	    	$("input[name='validateCode']").trigger("focus");
	    	return false;
	    } else {	//ajax进行验证
	    	$.post("user_login.action", {'account':account, 'password': password, 'validateCode':validateCode}, function(data) {	    		
    			if(data == 'code') {
    				$("#boxy p.errorInfo:eq(2)")[0].style.visibility = "visible";
    				$("#image").trigger("click");//更换验证码
    			} else if(data == 'other') {
    				$("#boxy p.errorInfo:eq(0)")[0].style.visibility = "visible";
    				//验证码正确，隐藏验证码错误提示
    				$("#boxy p.errorInfo:eq(2)")[0].style.visibility = "hidden";
    			} else if(data == 'success'){
    				 var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                     parent.layer.close(index);
    				//layer.close();
	    			//dialog.close();	    			
	    			location.reload();//刷新页面
	    			$("#boxy input[type='text'], #boxy input[type='password']").val("");
	    		}    			
	    	});
	    	return false;
	    }
	});				
	
	//点击显示/隐藏用户操作下拉列表
	$("#global_user_infobox").click(function() {
		var account = '${userInfo.account}';
		if(account != '') {//用户已经登录
			var $infoList = $("#g_subnav:hidden");
			if($infoList.size() > 0) {//当前处于隐藏状态，则显示
				$infoList.show();
			} else {
				$("#g_subnav").hide();
			}
		}
	});
	
});