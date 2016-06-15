<%@ tag language="java" import="java.util.*" pageEncoding="UTF-8"%>

<style type="text/css">
	.g-btmbar {
	    bottom: 0;
	    height: 0;
	    left: 0;
	    position: fixed;
	    right: 0;
	    width: 100%;
	    z-index: 1002;
	}	
	.m-playbar .updn .left, .m-playbar .updn .right, .m-playbar .updn .btn, .m-playbar .bg, .m-playbar .btns a, .m-playbar .head .mask, 
	.m-playbar .icn, .m-playbar .ctrl, .m-playbar .tip, .m-vol .curr, .m-playbar .words .mv, .m-vol .barbg, .m-playbar .words .src{
	    background: url("images/other/playbar.png") no-repeat scroll 0 9999px rgba(0, 0, 0, 0);
	}
	.m-playbar .listhd, .m-playbar .listbd {
	    background: url("images/other/playlist_bg.png") no-repeat scroll 0 0 rgba(0, 0, 0, 0);
	}
	.m-playbar .list .close, .m-playbar .playicn, .m-playbar .ico {
	    background: url("images/other/playlist.png") no-repeat scroll 0 9999px rgba(0, 0, 0, 0);
	}
	.m-playbar .playicn {
	  background-position: -182px 0;
	  display: none;
	  height: 13px;
	  margin-top: 8px;
	  width: 10px;
	}
	.m-vol .curr {
	  background-position: -40px bottom;
	  bottom: 4px;
	  left: 0;
	  overflow: hidden;
	  top: auto;
	}
	.m-vol .barbg {
	  background-position: 0 -503px;
	  height: 113px;
	  left: 0;
	  position: absolute;
	  top: 0px;
	  width: 32px;
	}
	.m-playbar {
	    height: 53px;
	    left: 0;
	    margin: 0 auto;
	    position: absolute;
	    top: -53px;
	    width: 100%;
	}
	.m-playbar .hand {
	    cursor: pointer;
	    height: 20px;
	    position: absolute;
	    top: -10px;
	    width: 100%;
	}
	.m-playbar .bg {
	    background-position: 0 0;
	    background-repeat: repeat-x;
	    height: 53px;
	    margin-right: 67px;
	}
	.m-playbar .updn {
	    position: relative;
	    z-index: 11;
	}
	.m-playbar .updn .left {
	    background-position: 0 -380px;
	    height: 67px;
	    position: absolute;
	    right: 15px;
	    top: -14px;
	    width: 52px;
	}
	.m-playbar .updn .right {
	    background-position: -52px -393px;
	    height: 54px;
	    pointer-events: none;
	    position: absolute;
	    right: 0;
	    top: -1px;
	    width: 15px;
	}
	.m-playbar .updn .btn {
	    display: block;
	    height: 18px;
	    margin: 6px 0 0 17px;
	    width: 18px;
	}
	.m-playbar-lock .updn .btn {
	    background-position: -100px -380px;
	}
	.m-playbar-lock .updn .btn:hover {
	    background-position: -100px -400px;
	}
	.m-playbar-hide .updn .btn {
	    background-position: -120px -380px;
	}
	.m-playbar .wrap {
	    height: 47px;
	    left: 50%;
	    margin: 0 auto 0 -490px;
	    position: absolute;
	    top: 6px;
	    width: 980px;
	    z-index: 15;
	}
	.m-playbar .btns, .m-playbar .head, .m-playbar .play, .m-playbar .volum, .m-playbar .oper {
	    float: left;
	}
	.m-playbar .btns {
	    padding: 6px 0 0 6px;
	    width: 157px;
	}
	.m-playbar .btns a {
	    display: block;
	    float: left;
	    height: 28px;
	    margin-right: 8px;
	    margin-top: 5px;
	    text-indent: -9999px;
	    width: 28px;
	}
	.m-playbar .btns .prv {
	    background-position: 0 -130px;
	}
	.m-playbar .btns .prv:hover {
	    background-position: -30px -130px;
	}
	.m-playbar .btns .ply {
	    background-position: 0 -204px;
	    height: 36px;
	    margin-top: 0;
	    width: 36px;
	}
	.m-playbar .btns .ply:hover {
	    background-position: -40px -204px;
	}
	.m-playbar .btns .pas {
	    background-position: 0 -165px;
	}
	.m-playbar .btns .pas:hover {
	    background-position: -40px -165px;
	}
	.m-playbar .btns .nxt {
	    background-position: -80px -130px;
	}
	.m-playbar .btns .nxt:hover {
	    background-position: -110px -130px;
	}
	.m-playbar .head, .m-playbar .head img {
	    height: 34px;
	    width: 34px;
	}
	.m-playbar .head {
	    margin: 6px 15px 0 0;
	    position: relative;
	}
	.m-playbar .head .mask {
	    background-position: 0 -80px;
	    display: block;
	    height: 35px;
	    left: 0;
	    position: absolute;
	    top: 0;
	    width: 34px;
	}
	.m-playbar .play {
	    position: relative;
	    width: 570px;
	}
	.m-playbar .words {
	    color: #e8e8e8;
	    height: 28px;
	    line-height: 28px;
	    overflow: hidden;
	    text-shadow: 0 1px 0 #171717;
	    font-size: 13px;	    
	}
	.m-playbar .words .fc1 {
	    color: #e8e8e8;
	    text-decoration: none;
	}
	.m-playbar .words .fc1:hover {
		text-decoration: underline;
	}
	.m-playbar .words .mv {
	    background-position: 0 -57px;
	    height: 17px;
	    margin: 6px 0 0 3px;
	    width: 19px;
	}
	.m-playbar .words .mv:hover {
	    background-position: -20px -57px;
	}
	.m-playbar .words .name {
	    max-width: 300px;
	}
	.m-playbar .words .by {
	    color: #9b9b9b;
	    margin-left: 15px;
	    max-width: 220px;
	}
	.m-playbar .words .by a {
	    color: #9b9b9b;
	    text-decoration: none;
	}
	.m-playbar .words .by a:hover {
	    text-decoration: underline;
	}
	.m-playbar .words .src {
	    background-position: -110px -103px;
	    float: left;
	    height: 15px;
	    margin: 7px 0 0 13px;
	    width: 14px;
	}
	.m-playbar .words .src:hover {
	    background-position: -130px -103px;
	}
	.m-playbar .icn {
	    float: left;
	    height: 25px;
	    margin: 11px 2px 0 0;
	    text-indent: -9999px;
	    width: 25px;
	    background: url("images/other/playbar.png") no-repeat scroll 0 9999px rgba(0, 0, 0, 0);
	    
	}	
	.m-playbar .icn-zan, .m-playbar .icn-yizan {
	    background-position: -60px -502px;
	    margin-top: 12px;
	    width: 26px;
	}
	.m-playbar .icn-zan:hover {
	    background-position: -90px -502px;
	}
	.m-playbar .icn-yizan {
	    background-position: -60px -532px;
	}
	.m-playbar .icn-yizan:hover {
	    background-position: -90px -532px;
	}
	.m-playbar .icn-add {
	    background-position: -88px -163px;
	}
	.m-playbar .icn-add:hover {
	    background-position: -88px -189px;
	}
	.m-playbar .icn-add-dis {
	    background-position: -88px -213px;
	}
	.m-playbar .icn-vol {
		width: 26px;
		height: 20px;
	    background-position: -2px -248px;
	    position: absolute;
	    top:0;
	    display: block;
	}
	.m-playbar .icn-vol:hover {
	    background-position: -31px -248px;
	}
	.m-playbar .icn-volno {
	    background-position: -104px -69px;
	}
	.m-playbar .icn-volno:hover {
	    background-position: -126px -69px;
	}
	.m-playbar .icn-shuffle {
		position: absolute;
	    top:0;
	    left: 40px;
	    background-position: -66px -248px;
	}
	.m-playbar .icn-shuffle:hover {
	    background-position: -93px -248px;
	}
	.m-playbar .icn-loop {
		display: block;
		width:25px;
		height: 25px;			
	    background-position: -3px -344px;
	    position: absolute;
	    top:0;
	    left: 40px;
	}
	.m-playbar .icn-loop:hover {
	    background-position: -33px -344px;
	}
	.m-playbar .icn-one {
	    background-position: -66px -344px;
	}
	.m-playbar .icn-one:hover {
	    background-position: -93px -344px;
	}
	.m-playbar .icn-list {
	    background-position: -42px -68px;
	    color: #666;
	    display: block;	   	   
	    width: 38px;
	    height: 25px;
	    position: absolute;
	    top:0;
	    text-decoration: none;
	    padding-left: 21px;
		text-align: center;		
		text-decoration: none;
		text-indent: 0;
		text-shadow: 0 1px 0 #080707;
		font-size: 13px;
		padding-top: 5px;
	}
	.m-playbar .icn-list:hover {
	    background-position: -42px -98px;
	    text-decoration: none;
	}
	.m-playbar .oper {
	    width: 60px;
	}
	.m-playbar .ctrl {
	    background-position: -147px -238px;
	    padding-left: 13px;
	    position: relative;
	    width: 118px;
	    z-index: 10;
	}
	.m-playbar .add {
	    float: left;
	    height: 36px;
	    width: 56px;
	    position: absolute;
	    top:0;
	    left: 70px;
	}
	.m-playbar .tip {
	    background-position: 0 -287px;
	    clear: both;
	    color: #fff;
	    height: 49px;
	    left: -65px;
	    line-height: 37px;
	    position: absolute;
	    text-align: center;
	    top: -51px;
	    width: 152px;
	}
	.m-playbar .tip-1 {
	    background-position: 0 -457px;
	    height: 39px;
	    left: 12px;
	    line-height: 34px;
	    top: -35px;
	    width: 81px;
	}
	.m-pbar {
		position: relative;	
	}
	.m-pbar .barbg {
		width: 456px;
		position: relative;
	}	
	.m-pbar .barbg, .m-pbar .cur, .m-pbar .rdy, .m-pbar .left {
	    background: url("images/other/statbar.png") no-repeat scroll 0 9999px rgba(0, 0, 0, 0);
	}	
	.m-pbar .btn, .m-vol .btn {
	    background: url("images/other/iconall.png") no-repeat scroll 0 0 rgba(0, 0, 0, 0);
	}
	.m-vol .btn {
	  background-position: -40px -250px;
	  cursor: pointer;
	  display: block;
	  height: 20px;
	  left: -5px;
	  position: absolute;
	  bottom: 21px;
	  width: 18px;
	}
	.m-pbar .barbg, .m-pbar .cur, .m-pbar .rdy {
	  background-position: right 0;
	  height: 9px;
	  padding-left: 0;
	  max-width: 456px;
	}
	.m-vol .vbg {
	  height: 93px;
	  left: 13px;
	  position: relative;
	  top: 13px;
	  width: 4px;
	}
	.m-vol .curr {
	  height: 93px;
	  left: 1px;
	  position: absolute;
	  bottom: 0px;
	  width: 4px;
	}
	.m-pbar .rdy {	  
	  background-position: left -30px;
	}
	.m-pbar .cur {
	    background-position: left -66px;
	    left: 0;
	    position: absolute;
	    top: 0;
	    width: 1%;
	}
	.m-pbar .time {
		position: absolute;
		top:-5px;
		right: 18px;
		color: #fff;
		font-size: 13px;		
	}
	.m-pbar .time em {
		font-style: normal;
	}
	.f-cb::after {
	    clear: both;
	    content: ".";
	    display: block;
	    height: 0;
	    visibility: hidden;
	}
	.f-pr {
	    position: relative;
	}
	.f-fl {
	    float: left;
	}
	.f-fr {
	    float: right;
	}

	/* 歌曲列表 */
	.m-playbar .list {
    bottom: 47px;
    height: 301px;
    left: 50%;
    margin-left: -493px;
    position: absolute;
    width: 986px;
}
.m-playbar .ico {
    height: 16px;
}
.m-playbar .listhd, .m-playbar .listbd {
    padding: 0 5px;
}
.m-playbar .listhd {
    background-position: 0 0;
    height: 41px;
    font-size: 14px;
}
.m-playbar .listhdc {
    height: 40px;
    position: relative;
}
.m-playbar .listhdc a {
	text-decoration: none;
}
.m-playbar .listhdc a:hover {
	text-decoration: underline;
}
.m-playbar .listhdc .lytit {
    color: #fff;
    font-size: 14px;
    height: 39px;
    left: 595px;
    line-height: 39px;
    position: absolute;
    text-align: center;
    top: -10px;
    width: 346px;
}
.m-playbar .listbd {
    background-position: -1014px 0;
    background-repeat: repeat-y;
    height: 260px;
    left: 0;
    overflow: hidden;
    position: absolute;
    top: 41px;
    width: 976px;
}
.m-playbar .imgbg {
    height: auto;
    left: 2px;
    opacity: 0.2;
    position: absolute;
    top: -1px;
    width: 980px;
    z-index: 1;
}
.m-playbar .msk {
    background: none repeat scroll 0 0 #121212;
    height: 260px;
    left: 2px;
    opacity: 0.5;
    position: absolute;
    top: 0;
    width: 558px;
    z-index: 2;
}
.m-playbar .listbd .bline {
    background: none repeat scroll 0 0 #000;
    height: 260px;
    left: 555px;
    opacity: 0.5;
    position: absolute;
    top: -1px;
    width: 6px;
    z-index: 2;
}
.m-playbar .listbd .bline-1 {
    left: auto;
    right: 2px;
}
.m-playbar .listbd .scrol {
    background: none repeat scroll 0 0 #868686;
    border: 1px solid #a6a6a6;
    border-radius: 5px;
    cursor: pointer;
    height: 100px;
    left: 0;
    opacity: 0.8;
    position: absolute;
    top: 0;
    width: 4px;
}
.m-playbar .listbd .scrol-1 {
    left: auto;
    right: 0;
}
.m-playbar .listbdc {
    height: 260px;
    left: 2px;
    overflow: hidden;
    position: absolute;
    top: 0;
    width: 553px;
    z-index: 4;
}
.m-playbar .listbdc ul {
    overflow: hidden;
    padding-left: 0;
    font-size: 13px;
}
.m-playbar .listlyric {
    height: 219px;
    margin: 21px 0 20px;
    overflow: hidden;
    position: absolute;
    right: 40px;
    top: 0;
    width: 354px;
    z-index: 4;
    font-size: 13px;
}
.m-playbar .listlyric p {
    color: #989898;
    height: auto !important;
    line-height: 32px;
    min-height: 32px;
    text-align: center;
    transition: color 0.7s linear 0s;
    word-wrap: break-word;
}
.m-playbar .listlyric p.z-sel {
    color: #fff;
    font-size: 14px;
    transition: color 0.7s linear 0s;
}
.m-playbar .listhdc h4 {
    color: #e2e2e2;
    font-size: 14px;
    height: 39px;
    left: 25px;
    line-height: 39px;
    position: absolute;
    top: -15px;
}
.m-playbar .listhdc .clear, .m-playbar .listhdc .addall {
    cursor: pointer;
    height: 15px;
    left: 490px;
    line-height: 15px;
    position: absolute;
    top: 12px;
}
.m-playbar .listhdc .addall {
    left: 398px;
}
.m-playbar .listhdc .line {
    border-left: 1px solid #000;
    border-right: 1px solid #2c2c2c;
    height: 15px;
    left: 477px;
    position: absolute;
    top: 13px;
}
.m-playbar .listhdc .ico {
    float: left;
    margin: 1px 6px 0 0;
}
.m-playbar .listhdc a {
    color: #ccc;
}
.m-playbar .listhdc a:hover {
    color: #e2e2e2;
}
.m-playbar .listhdc .close {
    background-position: -195px 9px;
    cursor: pointer;
    height: 30px;
    overflow: hidden;
    position: absolute;
    right: 8px;
    text-indent: -999px;
    top: 6px;
    width: 30px;
}
.m-playbar .listhdc .close:hover {
    background-position: -195px -21px;
}
.m-playbar .list ul {
    color: #ccc;
}
.m-playbar .list li {
    float: left;
    width: 100%;
}
.m-playbar .list li.js-dis * {
    color: #333;
}
.m-playbar .col {
    cursor: pointer;
    float: left;
    height: 28px;
    line-height: 28px;
    overflow: hidden;
    padding-left: 10px;
}
.m-playbar .col-2, .m-playbar .col-4 {
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.m-playbar .col-4 a {
	text-decoration: none;
}
.m-playbar .col-4 a:hover {
	text-decoration: underline;
}
.m-playbar .col-1 {
    width: 10px;
}
.m-playbar .col-2 {
    width: 260px;
}
.m-playbar .col-3 {
    width: 70px;
}
.m-playbar .col-4 {
    width: 70px;
}
.m-playbar .col-5 {
    color: #666;
    width: 35px;
}
.m-playbar .col-6 {
    padding-left: 6px;
    width: 37px;
}
.m-playbar .col a, .m-playbar .col a:hover {
    color: #9b9b9b;
}
.m-playbar .js-dis .col a:hover {
    color: #333;
}
.m-playbar .col .icns {
    display: none;
    float: right;
    height: 23px;
    width: 100px;
}
.m-playbar .col .ico {
    float: right;
    margin: 7px 0 0 10px;
    overflow: hidden;
    text-indent: -9999px;
}
.m-playbar .col .ico-src {
    background-position: -80px 0;
    margin-left: 0;
    width: 14px;
}
.m-playbar .col .ico-src:hover, .m-playbar .col a:hover .ico-src {
    background-position: -80px -20px;
}
.m-playbar .col .ico-src-dis, .m-playbar .col .ico-src-dis:hover {
    background-position: -100px 0;
    cursor: default;
}
.m-playbar .ico-add {
    background-position: -24px 0;
    width: 16px;
}
.m-playbar .ico-add:hover, .m-playbar a:hover .ico-add {
    background-position: -24px -20px;
}
.m-playbar .icn-del {
    background-position: -51px 0;
    width: 13px;
}
.m-playbar .icn-del:hover, .m-playbar a:hover .icn-del {
    background-position: -51px -20px;
}
/* 列表项选中与悬浮效果 */
.m-playbar .list li.z-sel {
    background-color: rgba(0, 0, 0, 0.3);
}
.m-playbar .list li.z-sel .playicn, .m-playbar .list li.z-hover .icns, .m-playbar .list li.z-hover1 .icns {
    display: none;
}
.m-playbar .list li.z-hover, .m-playbar .list li.z-hover1 {
    background-color: rgba(0, 0, 0, 0.4);
}
</style>

<script type="text/javascript" src="js/common/jquery-1.11.1.js"></script>
<script type="text/javascript" src="js/common/json2.js"></script>

<script type="text/javascript">
	var playModelClass = ["icn-one", "icn-shuffle", "icn-loop"];//单曲循环、随即播放、循环播放
	var modelIndex = 0;	//选中的循环模式，默认为单曲循环
	var time = 0;	//歌曲播放进度

	function trimStr(str){return str.replace(/(^\s*)|(\s*$)/g,"");}

	$(function() {
		/* 播放列表项悬浮效果设置 */
		$(".list .listbd ul li").mouseover(function() {
			$(this).addClass("z-hover1")
				   .find(".icns").show().end()
				   .siblings().removeClass("z-hover1");			
		}).mouseout(function() {
			$(this).removeClass("z-hover1");			
		});
		
		//点击清除歌曲播放列表
		$("#g_playlist .clear").click(function() {
			if($("#g_playlist li").size() > 0) {
				$("#g_playlist li").remove();
				$("#songCountInList").text(0);//更新播放列表中的歌曲数目
			}
		});
				
		//点击显示、隐藏播放列表
		$("#g_player .ctrl .icn-list").click(function() {
			if($("#g_playlist").is(":hidden")) {//如果当前为隐藏，则显示
				$("#g_playlist").show();
			} else {//否则，隐藏
				$("#g_playlist").hide();
			}
		});
		
		//点击隐藏播放列表
		$("#g_playlist .close").click(function() {
			$("#g_playlist").hide();
		});
		
		//点击播放/暂停歌曲播放
		$("#g_player .ply").click(function() {
			//获取当前选中的歌曲的id
			var songId = $("#g_player .play .words").attr("lang");
			if(!songId) {//尚未选中歌曲
				return;
			}
			
			var rate = $("#auto-id-L2nZMENxpqziCld4 .curr").height()/$("#auto-id-L2nZMENxpqziCld4").height();
			$("#myPlayer")[0].volume = rate==0 ? 0.3 : rate; 
				//0.5;//初始设置音量
			if($(this).hasClass("js-pause")) {//当前处于暂停状态，赞播放
				$(this).removeClass("js-pause").addClass("pas");				
				if(!$("#myPlayer").attr("src")) {//如果还未设置歌曲音频url,则请求获取歌曲url
					prepareForPlay(songId);	//为歌曲播放做准备
				} 
				$("#myPlayer")[0].play();
								
			} else {//当前处于播放状态，则暂停
				$(this).removeClass("pas").addClass("js-pause");
			
				$("#myPlayer")[0].pause();
			}
		});
		
		//点击播放上一首
		$("#g_player .prv").click(function() {
			stopCurSong();//当前歌曲播放完毕
        	prepareForPlay(null, 'prv');	//为歌曲播放做准备
        	$("#myPlayer")[0].play();
		});
		
		//点击播放下一首
		$("#g_player .nxt").click(function() {
			stopCurSong();//当前歌曲播放完毕
        	prepareForPlay(null, 'nxt');	//为歌曲播放做准备
        	$("#myPlayer")[0].play();
		});
		
		//点击显示音量控制框
		$(".ctrl .icn-vol").click(function(event) {
			if($("#auto-id-KqhQ3gFHiewgrsqV").css("visibility") == "hidden") {//如果当前处于隐藏状态，则显示
				$("#auto-id-KqhQ3gFHiewgrsqV").css("visibility", "visible");				
			} else {//如果当前处于显示状态，则隐藏
				$("#auto-id-KqhQ3gFHiewgrsqV").css("visibility", "hidden");
			}
			event.stopPropagation();
		});		
		
		//点击调整音量
		$("#auto-id-L2nZMENxpqziCld4").click(function(event) {
			var originalHeight = $("#auto-id-L2nZMENxpqziCld4 .curr").height();
			var ySpan = $("#auto-id-L2nZMENxpqziCld4").height() - (event.pageY - $("#auto-id-L2nZMENxpqziCld4").offset().top);
			if(ySpan < 0 || ySpan > $("#auto-id-L2nZMENxpqziCld4").height()) {
				return;
			}
			$("#auto-id-L2nZMENxpqziCld4 .curr").height(ySpan);//设置音量条高度
			
			$("#auto-id-L2nZMENxpqziCld4 .btn").css("bottom", "-="+(originalHeight-ySpan));//设置点位置
			
			$("#myPlayer")[0].volume = ySpan/$("#auto-id-L2nZMENxpqziCld4").height();//设置音量
		});
		
		//歌词区域滚动条
		var _y = 0;	//鼠标离控件左上角的相对位置
		var _move = false;	//移动标记
		/* 监听鼠标拖拽事件 ，并滚动tbody以及滚动条*/
		$("#auto-id-0xts4We5bwpGn8yQ").mousedown(function(e) {
			_move = true;
			_y = e.pageY;
		}).mousemove(function(e) {
			if(_move) {
				var maxScorllHeight = $("#auto-id-UIOkEkKZyP3Bz3LN").height() -  $("#auto-id-0xts4We5bwpGn8yQ").height();				
				var maxTbodyScrollHeight = $("#auto-id-UIOkEkKZyP3Bz3LN .inner").height() - $("#auto-id-UIOkEkKZyP3Bz3LN").height();
				var scrollMod = maxTbodyScrollHeight/maxScorllHeight;

				var y = e.pageY - _y;
				_y = e.pageY;
				var nextTop = parseInt($(this).css("top").substring(0,$(this).css("top").length-2)) + y;						
				if(nextTop < 0 || nextTop > maxScorllHeight) {
					return;
				}
				$(this).css("top",nextTop);
				$("#auto-id-UIOkEkKZyP3Bz3LN .inner").css("top","-=" + (scrollMod*y));						
			}
		}).mouseup(function(){
			_move = false;
		});
		
		
		//歌曲播放列表区域滚动条
		var _y_2 = 0;	//鼠标离控件左上角的相对位置
		var _move_2 = false;	//移动标记
		/* 监听鼠标拖拽事件 ，并滚动tbody以及滚动条*/		
		$("#auto-id-7TB9SbtwBI7roMHV").mousedown(function(e) {
			_move_2 = true;
			_y_2 = e.pageY;
		}).mousemove(function(e) {
			if(_move_2) {
				var maxScorllHeight = $(".listbdc").height() -  $("#auto-id-7TB9SbtwBI7roMHV .scrol").height();				
				var maxTbodyScrollHeight = $(".listbdc .f-cb").height() - $("#auto-id-7TB9SbtwBI7roMHV .scrol").height();
				var scrollMod = maxTbodyScrollHeight/maxScorllHeight;

				var y = e.pageY - _y_2;
				_y_2 = e.pageY;
				var nextTop = parseInt($(this).css("top").substring(0,$(this).css("top").length-2)) + y;						
				if(nextTop < 0 || nextTop > maxScorllHeight) {
					return;
				}
				$(this).css("top",nextTop);
				$(".listbdc .f-cb").css("top","-=" + (scrollMod*y));						
			}
		}).mouseup(function(){
			_move_2 = false;
		});		
		
		//音频进度滚动条
		$("#auto-id-U26nwTvw1wqLEUe2 .rdy,#auto-id-U26nwTvw1wqLEUe2 .cur").click(function(e) {			
			if($("#myPlayer").attr("src")) {
				var y = e.pageX - $(this).offset().left;
				var ratio = y / $("#auto-id-U26nwTvw1wqLEUe2 .rdy").width();
				$("#auto-id-U26nwTvw1wqLEUe2 .cur").width(ratio*100 + "%");
				$("#myPlayer")[0].currentTime = parseInt($("#myPlayer")[0].duration * ratio);//重新调整歌曲播放进度
				time = $("#myPlayer")[0].currentTime; 
			}
		});
				
		$("#myPlayer")[0].addEventListener("loadeddata", //歌曲一经完整的加载完毕
		        function() {					
					var audio = $("#myPlayer")[0];
	     	        interval = setInterval(function() {
		                time = audio.currentTime;
		                if(time < audio.duration) {
		                	timeChange(time, $("#g_player .play .curTime"), audio.duration);
		                	if(time == 0) {
		                		audio.play();
		                	}
		                } else {
		                	timeChange(time, $("#g_player .play .curTime"), audio.duration);
		                	if(modelIndex == 2) {
		                		stopCurSong();//当前歌曲播放完毕
		                		prepareForPlay(null, 'nxt');	//为歌曲播放做准备
		                	} else {
		                		stopCurSong();//当前歌曲播放完毕
		                		prepareForPlay();	//为歌曲播放做准备
		                	}		                			                	
		                	audio.play();
		                }
		            }, 1000);
	     	        
	     	        //更新歌曲播放次数
	     	        var song_src = $("#song_src").text();
	     	        if(!song_src) {
	     	        	song_src = $("#contentFrame").contents().find("#song_src").text();
	     	        }
	     	        if(song_src == 'listing') {//歌曲来自歌单
	     	        	var curId = $("#obj_id").text();
	     	        	if(!curId) {
	     	        		curId = $("#contentFrame").contents().find("#obj_id").text();
	     	        	}
	     	        	$.post('user/updateListingPlayCount', {listingId:curId});
	     	        } else if(song_src == 'song') {//来自歌曲
	     	        	var id = $("#g_player .play .words").attr("lang");
	     	        	$.post('user/updateSongPlayCount', {songId:id});	     	        	
	     	        } else if(song_src == 'album') {//来自专辑
	     	        	$.post('user/updateAlbumPlayCount', {albumId:$("#obj_id").text()});
	     	        } 
	     	      
		}, false);
		
		//切换播放模式
		$("#g_player .ctrl > a:eq(1)").click(function() {
			if(modelIndex == 0) {
				modelIndex = 1;
				$(this).removeClass(playModelClass[0]).addClass(playModelClass[1]);
				$(this).attr("title","随即播放");
			} else if(modelIndex == 1) {
				modelIndex = 2;
				$(this).addClass(playModelClass[2]);
				$(this).attr("title","循环");
			} else if(modelIndex == 2) {
				modelIndex = 0;
				$(this).removeClass(playModelClass[2]).addClass(playModelClass[0]);
				$(this).attr("title","单曲循环");
			}
		});
		
	});
	
	var interval ;

	//播放时间
	function timeChange(time, timePlace, duration) {//默认获取的时间是时间戳改成我们常见的时间格式		
	    //分钟
	    var minute = time / 60;
	    var minutes = parseInt(minute);
	    if (minutes < 10) {
	        minutes = "0" + minutes;
	    }
	    //秒
	    var second = time % 60;
	    seconds = parseInt(second);
	    if (seconds < 10) {
	        seconds = "0" + seconds;
	    }
	    var allTime = "" + minutes + "" + ":" + "" + seconds + "";
	    timePlace.text(allTime);
	    
	    //更新进度条
	    var rate = (time / parseFloat(duration)) * 100; 
	    $("#auto-id-U26nwTvw1wqLEUe2 .cur").width(rate + "%");
	}
	
	//当前歌曲播放完毕
	function stopCurSong() {
		clearInterval(interval);
		
		var player = $("#myPlayer")[0];
		if($("#myPlayer")[0].currentTime) {
			$("#myPlayer")[0].currentTime = 0;
		}
		$("#myPlayer")[0].pause();		
        time = 0;
        
        $("#auto-id-U26nwTvw1wqLEUe2 .cur").width("0%");
        
        $("#g_player .ply").removeClass("pas").addClass("js-pause");
        
        $("#g_player .play .name").text("");//清空歌曲名
		$("#g_player .play .by").text("");//清空歌手名
		$("#g_player .play .totalTime").text("00:00");//清空歌曲时长
		$("#g_player .play .curTime").text("00:00");//清空歌曲播放进度
//		$("#g_player .play .words").attr("lang", "");//清空歌曲播放进度
	}
	
	/* songId 歌曲id,songId不为空时，直接播放id对应的歌曲 ，否则，根据播放模式选择歌曲进行播放*/
	function prepareForPlay(curSongId, direc) {
		var songId;
		if(curSongId) {//直接播放当前歌曲
			songId = curSongId;			
		} else {//根据播放模式选择下一首歌曲进行播放
			songId = selectSongToPlay(direc);
		}
		$("#g_player .play .words").attr("lang", songId);
		
		if(!songId) {//当前播放列表中没有歌曲
			return;
		}
		
		$("#g_player .ply").removeClass("js-pause").addClass("pas");
		//设置歌曲名、时长等
		$("#g_playlist ul li").each(function() {
			var songId = $("#g_player .play .words").attr("lang");
			if(songId == $(this).find(".col-3").attr("lang")) {
				$(this).trigger("dblclick");												
				$(this).find(".playicn").show().end()
					   .siblings().find(".playicn").hide();
				return false;
			}
		});
		
		
		//加载歌词与音频
		$.post('song_loadSongRes.action', {id:songId}, function(data) {
			//var jsonObj = JSON.parse(data);
			var itemArr = data.split("@");
			var addr = itemArr[1];
			var lyric = itemArr[0];
			
			$("#myPlayer").attr("src", addr);
			
			//显示歌词
			if(lyric) {//如果存在歌词
				$(".listlyric p").remove();	//移除之前的歌词
				var lyricDiv = $(".listlyric .inner");
				var lineArr = lyric.split(";");
				for(var i in lineArr) {
					/* <p lang="202.61" class="j-item z-sel">重来回首已三生</p> */
					var line = trimStr(lineArr[i]);
					var parts = line.split("]");
					if(parts.length > 1 && (line.length-1 > parts[0].length) ) {
						lyricDiv.append("<p lang='"+parts[0].substr(1)+"' class='j-item'>"+parts[1]+"</p>");
					}
				}
			} else {
				
			}
			
		});
	}
		
	//选择歌曲进行播放
	function selectSongToPlay(direc) {
		var songId;
		if(modelIndex == 0) {//随即播放
    		songId = $("#g_player .play .words").attr("lang");//获取刚播放完的歌曲的id    		
    	} else if(modelIndex == 1) {//随即播放
    		var songNumInList = $(".listbdc li").size();
    		var num = Math.floor(Math.random()*songNumInList);
    		songId = $(".listbdc li:eq("+num+")").find(".col-3").attr("lang");    		
    		if(songId) {
    			$("#g_player .play .words").attr("lang", songId);
    		}
    	} else if(modelIndex == 2) {//循环播放
    		var prevSongId = $("#g_player .play .words").attr("lang");//上一首歌曲id
    		if(direc == 'nxt') {//下一首歌曲
    			$(".listbdc li").each(function() {
        			if($(this).find(".col-3").attr("lang") == prevSongId) {
        				songId = $(this).next().find(".col-3").attr("lang");
        				return false;
        			}	    			
        		});	
    		} else if(direc == 'prv') {
    			$(".listbdc li").each(function() {
        			if($(this).find(".col-3").attr("lang") == prevSongId) {
        				songId = $(this).prev().find(".col-3").attr("lang");
        				return false;
        			}	    			
        		});	
    		}
    		
    		if(songId) {
    			$("#g_player .play .words").attr("lang", songId);
    		}
    	}
		return songId;
	}
</script>

<div class="g-btmbar">
	<div style="top: -53px; visibility: visible;" class="m-playbar m-playbar-lock" id="auto-id-IReR3KdUIr8QaODV">
		<div class="updn">
			<div class="left f-fl"><a class="btn lock" href="javascript:void(0);"></a></div>
			<div class="right f-fl"></div>
		</div>
		
		<div class="bg"></div>
		
		<div title="展开播放条" class="hand" style="display: none;"></div>
		
		<div id="g_player" class="wrap">
			<audio  id="myPlayer" style="visibility: visible;"></audio>
			<div class="btns">
				<a title="上一首(ctrl+←)" class="prv" data-action="prev" href="javascript:void(0);">上一首</a>
				<a title="播放/暂停(p)" class="ply js-pause" data-action="play" href="javascript:void(0);">播放/暂停</a>
				<a title="下一首(ctrl+→)" class="nxt" data-action="next" href="javascript:void(0);">下一首</a>
			</div>
			<div class="play">
				<div class="j-flag words">
					<a title="" class="f-thide name fc1 f-fl" href="javascript:void(0);"></a>
					<span class="by f-thide f-fl"><span title=""><a href="/artist?id=9455" class=""></a></span></span>
					<!-- <a title="来自专辑" class="src" href="#/album?id=2639147&amp;_hash=songlist-27566178"></a> -->
				</div>
				<div class="m-pbar">
					<div class="j-flag barbg" id="auto-id-U26nwTvw1wqLEUe2">
						<div style="width: 100%;" class="j-flag rdy"></div>
						<div style="width: 0%;" class="j-flag cur">
							<span class="j-flag btn f-tdn f-alpha" id="auto-id-PbAICPn2MPPARL1H"></span>
						</div>
					</div>
					<span class="j-flag time"><em class="curTime">00:00</em> / <span class="totalTime">00:00</span></span>
				</div>
			</div>
			<!-- <div class="oper f-fl">
				<a title="收藏" class="icn icn-add" data-action="like" href="#">收藏</a>
			</div> -->
			<div class="ctrl f-fl f-pr">
				<div style="visibility:hidden; position: relative; top:-112px;" class="j-flag m-vol" id="auto-id-KqhQ3gFHiewgrsqV">
					<div class="j-t barbg"></div>
					<div class="j-t vbg" id="auto-id-L2nZMENxpqziCld4"><div class="curr" style="height: 27.9px;"></div>
						<span class="j-t btn f-alpha"></span>
					</div>
				</div>
				<a class="j-flag icn icn-vol" data-action="setvolume" href="javascript:void(0);">&nbsp;&nbsp;</a>
				<a title="单曲循环" class="j-flag icn icn-shuffle icn-one" data-action="setmode" href="javascript:void(0);">&nbsp;&nbsp;</a>
				<span class="add f-pr">
					<span style="display: none;" class="j-flag tip"></span>
					<a class="j-flag icn icn-list s-fc3" data-action="playlist" title="播放列表" href="javascript:void(0)">0</a>
				</span>
				<div style="display:none;" class="j-flag tip tip-1"></div>
			</div>
		</div>
		
		<div id="g_playlist" class="list" style="display: none;">
			<div class="listhd">
				<div class="listhdc">
				<h4 class="j-flag">播放列表(<span id="songCountInList">0</span>)</h4>
				<!-- <a data-action="likeall" class="addall" href="javascript:void(0);"><span class="ico ico-add"></span>收藏全部</a><span class="line"></span> -->
				<a class="clear j-flag" href="javascript:void(0);"><span class="ico icn-del"></span>清除</a>
				<p class="lytit f-ff0 f-thide j-flag"></p>
				<span data-action="close" class="close j-flag">关闭</span>
				</div>
			</div>
			<div class="listbd">
				<img src="http://music.163.com/api/img/blur/5504155208730509" class="imgbg j-flag" id="auto-id-FnpmrHAAIhOvud3c" style="top: -360px;">
				<div class="msk"></div>
				<div class="listbdc">
					<ul class="f-cb j-flag" style="position:relative; top: 0;">						
					</ul>					
					<div class="nocnt j-flag" style="display: none;">
						<i class="ico ico-face"></i> 你还没有添加任何歌曲<br>去首页<a class="f-tdu" href="/discover/">发现音乐</a>，或在<a class="f-tdu" href="/my/">我的音乐</a>收听自己收藏的歌单。
					</div>
				</div>
				<div class="bline j-flag" id="auto-id-7TB9SbtwBI7roMHV">
					<span class="scrol j-flag" style="height: 120.19px; display: block; top: 0px;"></span>
				</div>								
				<div class="listlyric j-flag" id="auto-id-UIOkEkKZyP3Bz3LN"> 
					<div class="inner" style="position:relative; top: 0;"></div>
				</div>
				<div class="bline bline-1 j-flag" id="auto-id-iGwySbOle9tlRwJw">
					<span class="scrol scrol-1 j-flag" id="auto-id-0xts4We5bwpGn8yQ" style="height: 60px; display: block; top: 0px;"></span>
				</div>
			</div>
		</div>
	</div>
</div>