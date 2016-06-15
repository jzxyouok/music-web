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
    
    <title>${vo.name} - 后台管理</title>
    
	<link rel="stylesheet" type="text/css" href="css/admin/album.css">
	
	<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="js/common/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="js/common/layer/layer.js"></script>

	<script type="text/javascript">
	$(function() {
		//表格隔行换色
		$(".m-table tbody tr:even").css("background-color", "#f1f1f1");
		
		//鼠标经过行换色
		$(".m-table tbody tr").mouseover(function() {
			$(this).css("background-color", "#ccc");
		}).mouseout(function() {
			var index = $(".m-table tbody tr").index($(this));
			if(index % 2 == 0) {
				$(this).css("background-color", "#f1f1f1");							
			} else {
				$(this).css("background-color", "#fff");
			}
		});
		
		/* 点击显示浮动添加歌曲框 */
		$(".cnt .hd a").bind("click",function(){
			 //清空文本框的内容
			 $("#addSongAlertDialog input[type='text'], #addSongAlertDialog textarea").val("");
			
			 /* dialog = artDialog();
			 dialog.title("添加歌曲到专辑");
			 dialog.lock(true);
			 dialog.content(document.getElementById("addSongAlertDialog")); */
			 
			 layer.open({
			        type: 1,
			        title: '添加歌曲到专辑',
			        maxmin: true,
			        shadeClose: true, //点击遮罩关闭层
			        area : ['650px' , '540px'],
			        content: $('#addSongAlertDialog')
			 });
		});
		
		/* 点击显示浮动选择歌手框 */
		$("#singer").bind("click",function(){
			 layer.open({
			        type: 2,
			        title: '选择歌曲歌手',
			        maxmin: false,
			        shadeClose: true, //点击遮罩关闭层
			        area : ['650px' , '540px'],
			        content: 'sys/sysSinger_listToSelect',
			        btn: ['确定', '关闭'],
			    	yes: function(index){ //或者使用btn1
			    		var singerInfo = 
			    			layer.getChildFrame("body").find("input[name='selectDesigns']:checked").val();
			    		if(!$("#singer").val()) {
			    			$("#singer").val(singerInfo.split(",")[1]);	
			    		} else {
			    			//如果已经添加了歌手，则新添加的附加在后面
			    			$("#singer").val($("#singer").val()+" " +singerInfo.split(",")[1]);
			    		}
			    		if(!$("#addSongAlertDialog input[name='singerInfo']").val()) {
			    			$("#addSongAlertDialog input[name='singerInfo']").val(singerInfo.split(",")[0]);	
			    		} else {
			    			//如果已经添加了歌手，则新添加的附加在后面
			    			$("#addSongAlertDialog input[name='singerInfo']").val($("#addSongAlertDialog input[name='singer']").val()+","+singerInfo.split(",")[0]);
			    		}			    		
			    		
			    		layer.close(index);
			        },cancel: function(index){ //或者使用btn2
			        }
			 });
		});
		
		//点击取消，关闭新建表单悬浮框
		$("#addSongAlertDialog input[type='button']").click(function() {
			//dialog.close();
		});
		
		//点击从专辑中移除歌曲   			
		$(".sixth_td .delImg").click(function() {
			if(confirm("确认删除该专辑？")) {
				var $tr = $(this).parent().parent();
				var id = $(this).attr("lang");
				//移除歌曲
				$.post("sys/sysSong_delete", {id:id}, function(data) {
					if(data == 'success') {//歌曲移除成功
						alert("歌曲移除成功");
						$tr.remove();
						$("#songCount").text(parseInt($("#songCount").text()) - 1);
					}
				});
			}
		});
	});		
	</script>
  </head>
  
  <body>
    <!-- 左边部分 -->
	<div class="ui_left">
		<!-- 专辑介绍 -->
		<div class="m-info f-cb">
			<div class="cover f-fl">
				<img class="j-img" src="${vo.image}" width="177" height="177">
				<span class="msk"></span>
			</div>
			<div class="cnt f-fl">
				<div class="cntc">
					<div class="topblk">
						<div class="hd f-cb">
							<i class="f-fl u-icn u-icn-16">&nbsp;</i>
							<span class="f-fl title">${vo.name}</span>
							<a class="u-btn u-btn-crt f-ff2" href="javascript:void(0);">歌曲</a>
						</div>
						<p class="intr">
							<span>歌手：</span>
							<c:forEach items="${fn:split(vo.singerInfo, ' ')}" var="singer">
								<a title="${fn:split(singer, ',')[1]}" href="sys/sysSinger_view.action?singerForm.id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a>
							</c:forEach>													
						</p>
						<p class="intr"><span>发行时间：</span>${vo.publishDate.substring(0,10)}</p>
						<p class="intr"><span>发行公司：</span>
						${vo.company == null ? 独立发行 : vo.company }
						</p>
					</div>					
				</div>
			</div>
		</div>
		<div class="n-albdesc">
			<h5>专辑介绍：</h5>
			<p class="f-brk">${vo.description}</p>
		</div>
		<!-- 歌曲列表 -->
		<div class="song_list">
			<div class="u-title u-title-1 f-cb">
				<span class="hd f-fl">包含歌曲列表</span>					
				<span class="sub f-fl" style="font-size: 18px;" id="songCount">${songList.size()}首歌</span>							
			</div>
			<table class="m-table" id="m-song-module">
				<thead>
					<tr>
						<th class="first w1"><div class="wp">序号</div></th>
						<th><div class="wp">歌曲标题</div></th>
						<th class="w2"><div class="wp">时长</div></th>
						<th class="w3"><div class="wp">歌手</div></th>
						<!-- <th class="w4"><div class="wp">专辑</div></th> -->
						<th class="w4"><div class="wp">操作</div></th>
					</tr>
				</thead>
				<tbody id="m-song-list-module">
				<c:forEach items="${songList}" var="song" varStatus="status">
				<tr class="ztag even">
					<td class="left first_td">
						<div class="hd">								
							<span class="num">${status.count}</span>
						</div>
					</td>
					<td class="second_td">
						<div class="f-cb">
							<div class="tt">
								<div class="ttc ttc-1">
									<span class="txt">
										<a title="${song.name}" href="sys/sysSong_view?id=${song.id}">${song.name}</a>
									</span>
								</div>
							</div>							
						</div>
					</td>
					<td class="third_td"><myTag:duration duration="${song.duration}"></myTag:duration></td>
					<td  class="fourth_td">
						<div class="text">
							<c:forEach items="${fn:split(song.singerInfo, ' ')}" var="singer">
								<a title="${fn:split(singer, ',')[1]}" href="sys/sysSinger_view.action?singerForm.id=${fn:split(singer, ',')[0]}">${fn:split(singer, ',')[1]}</a>
							</c:forEach>
						</div>
					</td>
					<%-- <td class="fifth_td">
						<div class="text">
						<c:forEach items="${fn:split(song.albumInfo, ' ')}" var="album">
							${fn:split(album, ',')[1]}
						</c:forEach>
						</div>
					</td> --%>
					<td class="sixth_td">
						<img class="delImg" alt="删除" title="删除" lang="${song.id}"  src="images/other/010.gif" style="cursor: pointer;" width="12" height="12">
					</td>
				</tr>
				</c:forEach>			
				</tbody>
			</table>
		</div>
		
		<!-- 添加歌曲弹出框 -->
		<div id="addSongAlertDialog" style="display: none;padding-left:50px;">
			<form action="sys/addSong.action" method="post" enctype="multipart/form-data">
				<input type="hidden" name="albumInfo" value="${vo.id}">
   				<table class="addAlbumTable">
   					<tr>
   						<td >歌曲名：</td> <td><input type="text" name="name" maxlength="25" required="required"/></td>
   					</tr>
   					<tr>
   						<td >歌手：</td> 
   						<td>
   							<input type="text" id="singer" maxlength="80" required="required" readonly="readonly"/>
   							<input type="hidden" name="singerInfo" maxlength="200" required="required" />
   						</td>
   					</tr>
   					<!-- <tr>
   						<td >语言：</td> <td><input type="text" name="language" maxlength="40" required="required"></td>
   					</tr> -->				    					    			    			   					
   					<tr>
   						<td >时长：</td> <td><input type="text" name="duration" placeholder="时长(单位为秒)" required="required"></td>
   					</tr>   					   					
   					<tr>
   						<td >上传音频文件：</td><td><input type="file" name="big" required="required" /></td>
   					</tr>
   					<tr>
   						<td >上传歌词文件：</td><td><input type="file" name="small" required="required"/></td>
   					</tr>
   					<tr>
   						<td>歌曲描述：</td>
   						<td>&nbsp;</td>     						
   					</tr>
   					<tr>
   						<td colspan="2">
   						<textarea name="description" cols="50" rows="5" maxlength="100"></textarea>
   						</td>
   					</tr>
   					<tr>
   						<td colspan="2">
   							<input class="btn redBt" type="submit" value="确认添加" />
   							<input class="btn redBt" type="button" value="取消" />
   						</td>
   					</tr>
   				</table>
   			</form>		
		</div>
	</div>
  </body>
</html>
