/**
 * 选择大于开始时间的日期格式
 * 如果开始时间为空，则提示；
 * @param {}
 *            id 	开始时间文本ID
 *            clew 	提示语
 */
function EndDatePicker(id,clew) {
	var conStartDate = document.getElementById(id).value;
	if(conStartDate=='') {
 		layerError(clew);
 		return;
 	}
	WdatePicker({minDate:conStartDate,isShowClear:false,readOnly:true});
}

/**
 * 判断指定名称的复选框是否被选中
 *
 * @param {}
 *            chname复选框名称
 */
function chkCheckCha(chname) {
	var obj = jQuery("[name='" + chname + "']");
	var isCheck = false;
	for (var i = 0; i < obj.length; i++) {
		if (obj[i].checked == true) {
			isCheck = true;
			break;
		}
	}
	return isCheck;
}

/**
 * 得到指定名称的复选框被选中个数
 *
 * @param {}
 *            chname
 * @return {}
 */
function checkChangedOnly(chname) {
	var obj = jQuery("[name='" + chname + "']");
	var count = 0;
	for (var i = 0; i < obj.length; i++) {
		if (obj[i].checked == true) {
			count++;
		}
	}
	return count;
}

/**
 * 得到指定名称的单个被选中的复选择框的值
 *
 * @param {}
 *            chname
 */
function getValueCheckOnly(chname) {
	var str = "";
	jQuery("[name='" + chname + "']:checked").each(function() {
					str += jQuery(this).val();
			});
	return str;
}

/**
 * 得到多个复选框的值
 *
 * @param {}
 *            chname
 */
function getCheckVals(chname) {
	var str = "";
	jQuery("[name='" + chname + "']:checked").each(function() {
					str += jQuery(this).val() + "@";
			});
	return str.substring(0, str.length - 1);
}

function getCheckHidden(chname,tagId){
   var strval = getCheckVals(chname);
   var arr = "";
   var temp = strval.split("@");
   for(var i = 0;i<temp.length;i++){
      var val = temp[i];
      var id = tagId+val;
      var tag = $("#"+id).val();
      arr+=tag+"@";  
   }
   return arr;
}

/**
 * 得到一些复选框的值 复选框的值中是否包含有","若无则用","将多个值组合 若有则先将值用","隔开再用","组合
 *
 * @param {}
 *            chname
 */
function getSomeChVals(chname) {
	var str = "";
	jQuery("[name='" + chname + "']:checked").each(function() {
				var temp = jQuery(this).val();
				if (temp.indexOf(",") == -1) {
					str += temp + ",";
				} else {
					var tempValue = temp.split(",");
					str += tempValue[0] + ",";
				}
			});
	return str.substring(0, str.length - 1);
}

function getAnyCheckValue(chname) {
	var str = getCheckVals(chname);
	var tstr = str.split("@");
	var result = "";
	for (var i = 0; i < tstr.length; i++) {
		var temp = tstr[i].split(",");
		result += temp[0] + ",";
	}
	return result.substring(0, result.length - 1);
}

/**
 * 得到指定名称的有多个值的多个复选框的值
 *
 * @param chname
 */
function getCheckValues(chname) {
	var str = "";
	var sids = "";
	var snames = "";
	jQuery("[name='checkbox']:checked").each(function() {
				var strval = jQuery(this).val();
				var temp = strval.split(",");
				var sid = temp[0];
				var sname = temp[1];
				sids += sid + ",";
				snames += sname + ", ";
			});
	str = sids.substring(0, sids.length - 1) + "|"
			+ snames.substring(0, snames.length - 2);
	return str;
}

/**
 * 判断复选框的状态
 *
 * @param {}
 *            chname
 */
function decideCheckState(chname) {
	var str = getCheckVals(chname);
	var tstr = str.split("@");
	var temp = "";
	for (var i = 0; i < tstr.length; i++) {
		var tval = tstr[i];
		var tem = tval.substring(tval.length - 1, tval.length);
		temp += tem;
	}
	return temp;
}
// 复选框的值是否全为0
function checkStringz(chname) {
	var regex = /^[0]*$/g;
	var source = decideCheckState(chname);
	return regex.test(source);
}
// 复选框的值是否全为1
function checkStringO(chname) {
	var regex = /^[1]*$/g;
	var source = decideCheckState(chname);
	return regex.test(source);
}

function decideStrallz(source) {
	var regex = /^[0]*$/g;
	return regex.test(source);
}
function decideStrallO(source) {
	var regex = /^[1]*$/g;
	return regex.test(source);
}
/**
 * 复选框全选v
 *
 * @param {}
 *            chname
 */
function checkboxAll(chname) {
	jQuery("[name='" + chname + "']").each(function() {
				jQuery(this).prop("checked", true);
			});
}

/**
 * 复选框反选
 *
 * @param {}
 *            chname
 */
function inverSelect(chname) {
	jQuery("[name='" + chname + "']").each(function() {
				if (jQuery(this).prop("checked")) {
					jQuery(this).prop("checked", false);
				} else {
					jQuery(this).prop("checked", true);
				}
			});
}

/**
 * 取消全选或反选
 *
 * @param {}
 *            chname
 */
function clearSelect(chname) {
	jQuery("[name='" + chname + "']").each(function() {
				jQuery(this).prop("checked", false);
			});
}

/**
 * 点击删除按钮时使用
 */
function dele(chname) {
	var b = chkCheckCha(chname);
	if (!b) {
		layerError("请选择要删除的记录");
		return false;
	} else if (confirm("删除后无法恢复，确定删除吗?")) {
		jQuery("[name='form1']").submit();
	} else {
		return false;
	}
}

/**
 * 校验时间格式
 *
 * @param {}
 *            timevale
 * @return {}
 */
function checkTime(timevale) {
	var regex = /^(([0-1][0-9])|([2][0-4]))(\:)[0-5][0-9](\:)[0-5][0-9]$/g;
	var b = regex.test(timevale);
	return b;
}

/**
 * 校验Ip地址格式
 *
 * @param {}
 *            ipvale
 */
function checkIp(ipvale) {
	var regex = /^([1-9]|[1-9]\d|1\d{2}|2[0-1]\d|22[0-3])(\.(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){3}$/;
	var b = regex.test(ipvale);
	return b;
}

/**
 * 是否是由字母或数字组成的字符串
 *
 * @param {}
 *            letVale
 */
function checkLetOrNum(letVale) {
	var regex = /^([a-zA-Z_]{1})([\w]*)$/g;
	var b = regex.test(letVale);
	return b;
}

/**
 * 取字符串的第index的字符
 *
 * @param {}
 *            source
 * @param {}
 *            index
 */
function interceptStr(source, index) {
	var temp = source.charAt(index);
	return parseInt(temp);
}

/**
 * 检查字符串中beindex位置到endindex位置之间是否全由targer组成
 *
 * @param {}
 *            source
 * @param {}
 *            targer
 * @param {}
 *            beindex
 * @param {}
 *            endindex
 */
function checkStr(source, targer, beindex, endindex) {
	var flag = false;
	for (var i = beindex; i <= endindex; i++) {
		var temp = source.charAt(i);
		if (targer == temp) {
			flag = true;
		}
	}
	return flag;
}

/**
 * 验证字符串中的某一段是否全为0
 *
 * @param {}
 *            source
 * @param {}
 *            begin
 * @param {}
 *            end
 * @return {}
 */
function checkString(source, begin, end) {
	var regex = /^[0]*$/g;
	var temp = source.substring(begin, end + 1);
	//layerError("###temp=="+temp);
	return regex.test(temp);
}

/**
 * 判断两个字符串是否想等 相等返回true否则返回false
 *
 * @param {}
 *            source
 * @param {}
 *            target
 */
function decideString(source, target) {
	return (source == target) ? true : false;
}

/**
 * 验证是否是整数或只有一位小数点的小数
 *
 * @param {}
 *            source
 * @return {}
 */
function checkFloat(source) {
	// var regex=/^[1-9]d*.d{1}|0.d{1}[1-9]d{1}$/g;
	var regex = /^[0-9]+\d*[\.\d]?\d{0,1}$/g;
	return regex.test(source);
}
/**
 * 验证是否两位数以内的正整数
 *
 * @param {}
 *            source
 * @return {}
 */
function checkTwoInt(source) {
	var regex = /^[1-9][0-9]?$/g;  //两位数以内的正整数
	return regex.test(source);
}
/**
 * 验证是否是两位小数的正实数
 *
 * @param {}
 *            source
 * @return {}
 */
function checkTowLenFloat(source) {
	var regex = /^[0-9]+(.[0-9]{2})?$/g;//只能输入有两位小数的正实数
	return regex.test(source);
}
/**
 * 验证是否是两位或一位小数的正实数
 *
 * @param {}
 *            source
 * @return {}
 */
function checkTowLenFloatt(source) {
	var regex = /^[0-9]+(.[0-9]{1,2})?$/g;//只能输入有两位小数的正实数
	return regex.test(source);
}
/**
 * 验证是否是整数或只有2位小数的数
 *
 * @param {}
 *            source
 */
function checkTowFloat(source) {
	var regex = /^[1-9]+\d*[\.\d]?\d{0,2}$/g;
	return regex.test(source);
}
/**
 * 验证是否有空格
 *
 * @param {}
 *            source
 */
function checkSpace(source) {
	var regex = /\s/g;
	return regex.test(source);
}

/**
 * 检查一个数是否是整数则位数在8以内
 *
 * @param {}
 *            source
 */
function checkIntLeng(source) {
	var regex = /^[1-9]{1}[0-9]{1,7}$/g;
	return regex.test(source);
}
/**
 * 检查一个数是否是正整数(>0)
 *
 * @param {}
 *            source
 */
function checkMaxZeroInt(source) {
	var regex = /^[1-9][0-9]*$/g;
	return regex.test(source);
}
/**
 * 检查一个数是否是整数则位数在2以内
 *
 * @param {}
 *            source
 */
function checkIntTwoLeng(source) {
	var regex = /^[1-9]{1}[0-9]{1,2}$/g;
	return regex.test(source);
}
/**
 * 验证正整数
 *
 * @param {}
 *            source
 */
function checkInt(source) {
	// var regex=/^[1-9]d*$/g
	var regex = /^[0-9]*[1-9][0-9]*$/g;
	return regex.test(source);
}

/**
 * 验证非负数
 *
 * @param {}
 *            source
 */
function checkNegative(source) {
	var regex=/^[1-9]\d*|0$/g;
	return regex.test(source);
}

/**
 * 验证是否是全字母
 * @param source
 * @returns
 */
function checkAllChar(source){
	var regex = /^[A-Za-z]+$/g;
	return regex.test(source);
}

/**
 * 验证城市区号
 * @param source
 * @returns
 */
function checkAreaCode(source){
	var regex = /^0[1-9]{2,3}$/g;
	return regex.test(source);
}


/**
 * 分割IP地址
 *
 * @param {}
 *            ipAddress
 */
function getIpNum(ipAddress) {
	var ip = ipAddress.split(".");
	var a = parseInt(ip[0]);
	var b = parseInt(ip[1]);
	var c = parseInt(ip[2]);
	var d = parseInt(ip[3]);
	var ipNum = a * 256 * 256 * 256 + b * 256 * 256 + c * 256 + d;
	return ipNum;
}

/**
 * 判断IP大小
 */
function decideIp(startIp, endIp) {
	var ip1 = getIpNum(startIp);
	var ip2 = getIpNum(endIp);
	return (ip2 > ip1) ? true : false;
}

/**
 * 验证是否全是空格
 *
 * @param {}
 *            source
 * @return {}
 */
function checkAllSpace(source) {
	var regex = /^\s+$/g
	return regex.test(source);
}

/*******************************************************************************
 * openWindow(url)函数：弹出窗口 * url：路径 * left:左边的距离 * top：上边的距离 * width：窗口宽度 *
 * height：窗口高度 * resize：yes时可调整窗口大小，no则不可调 *
 ******************************************************************************/
function openWindow(url,width, height, resize) {
	var mleft = (screen.width - width) / 2;
	var mtop = (screen.height - height) / 2;
	window.open(url,"","height=" + height + ",width=" + width
					+ ",location=no,menubar=no,resizable=" + resize
					+ ",scrollbars=yes,status=no,toolbar=no,left=" + mleft
					+ ",top=" + mtop + "");   
}
/**
 *
 * @param {} url
 * @param {} width
 * @param {} height
 */
function showNewWind(url,width,height){
	//layerError(url);
	var showresult = window.showModalDialog(url,window,"dialogWidth="+width+"px;dialogHeight="+height+"px;location=no;status=no;scroll=yes");
	return showresult;
}

/**
 *
 * @param {} url
 * @param {} width
 * @param {} height
 */
function showNewLessWind(url,width,height){
	//layerError(url);
	var showresult = window.showModelessDialog(url,window,"dialogWidth:"+width+"px;location=no;status:no;dialogHeight:"+height+"px");
	return showresult;
}

function decideLeve(source){
	var regex=/^[a-zA-Z]{1}$/g;
	return regex.test(source);
}

function openBlankWindow(url){
  openWindow(url,"650","400","yes");
}
/**
 * 时间变化
 * @param {} source
 * @param {} addval
 */
function dateToString(source,addval){
  var paddval = parseInt(addval);//增量(秒)
  var temp = source.split(":");
  var thrs = parseInt(temp[0])*3600;//小时化成秒
  var tmis = parseInt(temp[1])*60;//分钟化成秒;
  var tss = parseInt(temp[2]);//秒
  var totals = parseInt(thrs)+parseInt(tmis)+parseInt(tss)+parseInt(paddval);
  var result = timeTohhmmss(totals);
  return result;
}
/**
 * 由秒数转化成hh:mm:ss格式
 * @param {} seconds
 */
function timeTohhmmss(seconds){
	var hh;
	var mm;
	var ss;
	if(seconds==null || seconds<0){
	  return;
	}
	var pseconds = parseInt(seconds);
	//得到小时
	hh = pseconds/3600|0;
	pseconds = parseInt(pseconds)-parseInt(hh)*3600;
	if(parseInt(hh)<10){
		hh="0"+hh;
	}
	if(parseInt(hh)>=24){
		hh="00";
	}
	//得到分钟
	mm = parseInt(pseconds)/60|0;
	//得到秒
	ss = parseInt(pseconds)-parseInt(mm)*60;
	if(parseInt(mm)<10){
		mm = "0"+mm;
	}
	if(parseInt(ss)<10){
		ss = "0"+ss;
	}
	return hh+":"+mm+":"+ss;
}

/**
验证身份证号是否正确
**/
function isCardNo(num){
   if(isNaN(num)){
      layerError("输入的身份证号不是数字！");
      return false;
   }
   var len = num.length;
   if(len<15 || len>18){
      layerError("输入的身份证号码长度不正确定！应为15位或18位");
      return false;
   }   
   var re15 = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
   var re18 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
   var res = (re15.test(num) || re18.test(num));
   if(res==false){
      layerError("输入的身份证号格式不正确！");
      return false;
   }
   return res;
}

/**
* 判断字符串是否为空，若为空则返回true否则返回false 
* @param source
* @return true或者false 
**/
function isEmpty(source){
	
  if(typeof(source)== 'undefined') return true;
  
  var str = source.replace(/(^\s*)|(\s*$)/g,"");
  if(str=="" || str.toLowerCase()=="null" || str.length<=0){
     return true;
  }else{
     return false;
  }
}

/**
 * 验证是否为电话号码（座机）
 *
 * @param {}
 *            source
 */
function isTelephone(source) {
	var regex = /^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$/
	return regex.test(source);  //search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1
}
/**
 * 验证是否为手机号码（移动手机）
 *
 * @param {}
 *            source
 */
function isMobilePhone(source) {
	var regex = /^((\(\d{3}\))|(\d{3}\-))?1\d{10}/;
	return regex.test(source);
}
/**
 * 验证是否为电子邮箱
 *
 * @param {}
 *            source
 */
function isEmail(source) {
	var regex = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
	if(source.search(/^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/) != -1){
	   return true;
	}else{
	   layerError("电子邮箱格式不正确");
	   return false;
	}
}
/**
*
*验证是否为邮编
* @param
*      source
*/
function isZip(source){
    var regex=/^[1-9]\d{5}$/;
    return regex.test(source);
}
/**
*
*验证字符串是否是中文
*
**/
function isChines(source){
  var regex = /^[\u4E00-\u9FA5]+$/;
  return regex.test(source);
}

/**
  检查UKEY是否插上
**/
function psaok(){
   var servnum = $("#IID_SecureWeb_I_SerialNumber").val();
   if(isEmpty(servnum)){	    
	  $("#btnadd").prop("src","tools/noadd.png");
	  $("#btndelte").prop("src","tools/nodel.png");
	  $("#btnupdate").prop("src","tools/noupdate.png");
	  $("#WebacResult").text("请插入UKEY，在进行操作！");
   }else{ 
	  $("#btnadd").prop("src","tools/xz.png"); 
	  $("#btndelte").prop("src","tools/sc.png"); 
	  $("#btnupdate").prop("src","tools/xg.png");
	  $("#WebacResult").text("");
   }
}

/**
点击按钮时检查是否是使用了UKEY且是否插入了UKEY
**/
function checkUkey(){
   var servnum = $("#IID_SecureWeb_I_SerialNumber").val();
   var ukeyval = $("#hiddukey").val();
   if(ukeyval=="UKEY" && isEmpty(servnum)){
       return false;
   }
   return true;
}

/**
  当页面加载时也要检查是否是使用了UKEY且是否插入了UKEY
**/
function docmentOnlaod(){
   var servnum = $("#IID_SecureWeb_I_SerialNumber").val();
   var ukeyval = $("#hiddukey").val();
   if(ukeyval=="UKEY" && isEmpty(servnum)){//使用了ukey但没有插入ukey
      $("#btnadd").prop("src","tools/noadd.png");
	  $("#btndelte").prop("src","tools/nodel.png");
	  $("#btnupdate").prop("src","tools/noupdate.png");
	  $("#WebacResult").text("请插入UKEY，在进行操作！");
   }else{
      $("#btnadd").prop("src","tools/xz.png"); 
	  $("#btndelte").prop("src","tools/sc.png"); 
	  $("#btnupdate").prop("src","tools/xg.png");
	  $("#WebacResult").text("");
   }
}

/**
  不刷新更改面页
**/
function changeText(listids,val){
  try{
     var temp = listids.split("@");
     var len = temp.length;
     for(var i = 0;i<len;i++){
        var id = temp[i];
        $("#span"+id).text(val);
        $("#span"+id).prop("style","color:red");
     }
  }catch(e){}
}

/**
  生成指定位数的随机整数
**/
function getRandomNum(count){
	var arr = new Array;
	var reNum = "";
	for(var i=0;i<count;i++){
		arr[i] = parseInt(Math.random()*10);
		reNum += String(arr[i]);
	}
	return reNum;
}

/*
*判断包含关系
*string:原始字符串
*substr:子字符串
*isIgnoreCase:忽略大小写
*/


function jsContains(string,substr,isIgnoreCase)
{
if(isIgnoreCase)
{
string=string.toLowerCase();
substr=substr.toLowerCase();
}
var startChar=substr.substring(0,1);
var strLen=substr.length;
for(var j=0;j<string.length-strLen+1;j++)
{
if(string.charAt(j)==startChar)//如果匹配起始字符,开始查找
{
if(string.substring(j,j+strLen)==substr)//如果从j开始的字符与str匹配，那ok
{
return true;
}   
}
}
return false;
}

/**
 * 随机数UUID
 * @return
 */
function makeUUID() {
    var S4 = function () {
        return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
    };
    //return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
    return (S4() + S4() + S4() + S4() + S4() + S4() + S4() + S4());
}

$(document).ready(function () {
	var check = $(".adminlist td").parent().children("td").children("[type='checkbox']");
	check.parent().unbind("click");
});

$(".adminlist td").click(function () {
	var check = $(this).parent().children("td").children("[type='checkbox']");
	if(check.prop("checked") != "undefined") {
		if(check.prop("checked") == true) {
			check.prop("checked",false);
		} else {
			check.prop("checked",true);
		}
	}
}); 

/** 只能输入数字和小数点 */
 function clearNoNum(obj){   
 	 obj.value = obj.value.replace(/[^\d.]/g,"");  	//清除“数字”和“.”以外的字符  
	 obj.value = obj.value.replace(/^\./g,"");  	//验证第一个字符是数字而不是. 
	 obj.value = obj.value.replace(/\.{2,}/g,".");  //只保留第一个. 清除多余的.   
	 obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
 }
 
 /** 只能输入大于0的正整数 */
 function clearNotInt(obj) {
	obj.value = obj.value.replace(/^0/g,"");//不能以0开头
	obj.value = obj.value.replace(/[^\d]$/g,""); //只能输入数字
 }
 
 /** 只能输入大于等于0的正整数 */
 function clearNotIntZero(obj) {
	obj.value = obj.value.replace(/[^\d]$/g,""); //只能输入数字
 }
 
 /**
  * 提示弹出框，且自动消失
  * @param _domId 验证对象对应的dom id
  * @param _msg 消息内容
  * @return
  */
 function layerTips(_domId, _msg) {
	 $("#"+_domId).focus();
	 layer.tips(_msg, $("#"+_domId) , 2);
 }
 
 /**
  * 操作成功提示
  * @param _msg
  */
 function layerSucc(_msg) {
	 layer.msg(_msg,{icon:1,time:2});
 }
 
 /**
  * 操作异常或错误提示
  * @param _msg
  */
 function layerError(_msg) {
	 layer.msg(_msg);
 }
