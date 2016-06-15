<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ attribute name="form" required="true" type="java.lang.String" description="要提交的分页表单的名字" %>
<%@ attribute name="pageBean" required="true" type="com.johnf.app.music.util.PageBean" description="分页实体对象" %>

<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>

<script type="text/javascript">
	function jumpPage(index) {
		var curPage = parseInt('${pageBean.curPage}');	//获取当前页数
		var totalPage = parseInt('${pageBean.totalPage}');	//获取总页数
		var page;	//当前页
		if(index == 0) {	
			if(curPage == 1) {//已经是第1页，不用再发出请求
				return;
			}		
			page = 1;			
		} else if(index == 1) {//上一页
			if(curPage == 1) {//已经是第1页，没有上一页，不用再发出请求
				return;
			}
			page = curPage - 1;
		} else if(index == 2){	//下一页
			if(curPage == totalPage) {//已经是最后页，没有下一页，不用再发出请求
				return;
			}
			page = curPage + 1;
		} else if(index == 3) {	//尾页
			if(curPage == totalPage) {//已经是最后页，没有下一页，不用再发出请求
				return;
			}
			page = totalPage;
		}
		var $curPageNode = $("input[name='pageNo']");
		$curPageNode.val(page);
		document["${form}"].submit();
	}	
	
	$(function() {
		$("#page_btn_ul li").mouseover(function() {
			$(this).css("background-color", "#ccc");
		}).mouseout(function() {
			$(this).css("background-color", "#fff");
		});
	});
</script>

<input type="hidden" name="pageNo" value="${pageBean.curPage}"/>
<ul id="page_btn_ul" style="display: inline; list-style: none; font-size: 13px; height: 25px; line-height: 25px;">  		
	<li onclick="jumpPage(0);" style="display: inline; margin-right: 10px; padding: 2px 4px; border: 1px solid #A9CBEE; cursor: pointer;">首页</li>
	<li  onclick="jumpPage(1);" style="display: inline; margin-right: 10px; padding: 2px 4px; border: 1px solid #A9CBEE; cursor: pointer;">上一页</li>
	<li onclick="jumpPage(2);" style="display: inline;  margin-right: 10px; padding: 2px 4px; border: 1px solid #A9CBEE; cursor: pointer;">下一页</li>
	<li onclick="jumpPage(3);" style="display: inline; margin-right: 10px; padding: 2px 4px; border: 1px solid #A9CBEE; cursor: pointer;">尾页</li>	  				  		
</ul>
<span style="font-size: 12px;"> 当前&nbsp;${pageBean.curPage}/${pageBean.totalPage}页</span>