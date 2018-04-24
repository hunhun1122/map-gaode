<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("basePath",basePath);
%>
<!DOCTYPE html>
<html class="ie">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<title>微信蓝牙设备</title>
<meta name="viewport"
	content="width=320.1,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no">

<link rel="stylesheet"
	href="http://res.wx.qq.com/open/libs/weui/0.4.0/weui.min.css">
<script src="http://libs.baidu.com/jquery/2.0.0/jquery.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.1.0.js"> </script>
</head>
<body ontouchstart>

	<!--标题行-->
	<h2
		style="color: white; background-color: green; text-align: center; background-position: center;">蓝牙设备</h2>


	<div class="page">
		<div class="bd spacing">
			<div class="weui_cells weui_cells_form">

				<div class="weui_cell">
					<div class="weui_cell_hd">
						<label class="weui_label" style="width: auto;">当前设备:&nbsp</label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<label id="lbdeviceid" class="weui_label" style="width: auto;"></label>
					</div>
				</div>
				<div class="weui_cell">
					<div class="weui_cell_hd">
						<label class="weui_label" style="width: auto;">状态信息:&nbsp</label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<label id="lbInfo" class="weui_label" style="width: auto;"></label>
					</div>
				</div>
				<div class="weui_cell">
					<div class="weui_cell_hd">
						<label class="weui_label">日志: </label>
					</div>
					<div class="weui_cell_bd weui_cell_primary">
						<textarea id="logtext" class="weui_textarea" placeholder="日志"
							rows="5"></textarea>
					</div>
				</div>



			</div>



			<div class="weui_btn_area weui">

				<button class="weui_btn weui_btn weui_btn_warn"
					id="CallGetWXrefresh">获取设备</button>
				<br>


			</div>

			<div class="weui_btn_area weui_btn_area_inline">

				<button class="weui_btn  weui_btn_primary" id="icFuWei">复位</button>
				<button class="weui_btn  weui_btn_primary" id="icFuWei2">复位2</button>

			</div>









		</div>


		<div class="weui_dialog_alert" id="Mydialog" style="display: none;">
			<div class="weui_mask"></div>
			<div class="weui_dialog">
				<div class="weui_dialog_hd" id="dialogTitle">
					<strong class="weui_dialog_title">着急啦</strong>
				</div>
				<div class="weui_dialog_bd" id="dialogContent">亲,使用本功能,请先打开手机蓝牙！</div>
				<div class="weui_dialog_ft">
					<a href="#" class="weui_btn_dialog primary">确定</a>
				</div>
			</div>
		</div>


		<!--BEGIN toast-->
		<div id="toast" style="display: none;">
			<div class="weui_mask_transparent"></div>
			<div class="weui_toast">
				<i class="weui_icon_toast"></i>
				<p class="weui_toast_content" id="toast_msg">已完成</p>
			</div>
		</div>
		<!--end toast-->

		<!-- loading toast -->
		<div id="loadingToast" class="weui_loading_toast"
			style="display: none;">
			<div class="weui_mask_transparent"></div>
			<div class="weui_toast">
				<div class="weui_loading">
					<div class="weui_loading_leaf weui_loading_leaf_0"></div>
					<div class="weui_loading_leaf weui_loading_leaf_1"></div>
					<div class="weui_loading_leaf weui_loading_leaf_2"></div>
					<div class="weui_loading_leaf weui_loading_leaf_3"></div>
					<div class="weui_loading_leaf weui_loading_leaf_4"></div>
					<div class="weui_loading_leaf weui_loading_leaf_5"></div>
					<div class="weui_loading_leaf weui_loading_leaf_6"></div>
					<div class="weui_loading_leaf weui_loading_leaf_7"></div>
					<div class="weui_loading_leaf weui_loading_leaf_8"></div>
					<div class="weui_loading_leaf weui_loading_leaf_9"></div>
					<div class="weui_loading_leaf weui_loading_leaf_10"></div>
					<div class="weui_loading_leaf weui_loading_leaf_11"></div>
				</div>
				<p class="weui_toast_content" id="loading_toast_msg">数据加载中</p>
			</div>
		</div>
		<!-- End loading toast -->

		<!--BEGIN dialog1-->
		<div class="weui_dialog_confirm" id="dialog1" style="display: none;">
			<div class="weui_mask"></div>
			<div class="weui_dialog">
				<div class="weui_dialog_hd">
					<strong class="weui_dialog_title">弹窗标题</strong>
				</div>
				<div class="weui_dialog_bd">自定义弹窗内容，居左对齐显示，告知需要确认的信息等</div>
				<div class="weui_dialog_ft">
					<a href="javascript:;" class="weui_btn_dialog default" id="qxBtn">取消</a>
					<a href="javascript:;" class="weui_btn_dialog primary" id="okBtn">确定</a>
				</div>
			</div>
		</div>
		<!--END dialog1-->
		<!--BEGIN dialog2-->
		<div class="weui_dialog_alert" id="dialog2" style="display: none;">
			<div class="weui_mask"></div>
			<div class="weui_dialog">
				<div class="weui_dialog_hd">
					<strong class="weui_dialog_title">弹窗标题</strong>
				</div>
				<div class="weui_dialog_bd">弹窗内容，告知当前页面信息等</div>
				<div class="weui_dialog_ft">
					<a href="javascript:;" class="weui_btn_dialog primary">确定</a>
				</div>
			</div>
		</div>
		<!--END dialog2-->
	</div>

	<div id="myparams" style="display: none">
		<span id="timestamp">${timestamp }</span> <span id="nonceStr">${nonceStr }</span>
		<span id="signature">${signature }</span> <span id="appId">${appId }</span>
		<span id="trueCardRandom"></span>

	</div>



</body>
<script type="text/javascript">
 jQuery(document).ready(function(){
  //初始化库 
 loadXMLDoc();
 //初始化库结束
  
 $("#CallGetWXrefresh").on("click",function(e){  
    //showdialog();
     
     //1. 打开微信设备 
     my_openWXDeviceLib();
      
     //2. 安装设备事件
     my_installwxEvents();
      
     //2.1安装状态改变事件 暂时不检测
    // my_onWXDeviceStateChange(); 
      
     //3. 安装接收到数据事件 暂时 
     my_onReceiveDataFromWXDevice();
      
     //4. 刷新设备信息
     my_getWXDeviceInfos();
      
      
       
  });
   
   
   
  
 });
 //微信硬件jsapi库
function loadXMLDoc()
{
  //  var appId =jQuery("#appId").text();
   // var timestamp=jQuery("#timestamp").text();
   // var nonceStr =jQuery("#nonceStr").text();
   // var signature=jQuery("#signature").text();
    
    var timestamp='1492412067';
    var nonceStr ='81bd9037-14f1-4301-bde1-2d6ddbf5ca84';
    var signature='852f6e902d2293213453bee746bef842f60e90f3';
    var appId ='wxc5156893d7d9c82b';
    wx.config({
             beta: true,
              debug: true,// 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
              appId: appId, 
              timestamp: timestamp,
              nonceStr: nonceStr,
              signature: signature,
              jsApiList: [
                'openWXDeviceLib',
                'closeWXDeviceLib',
                'getWXDeviceInfos',
                'getWXDeviceBindTicket',
                'getWXDeviceUnbindTicket',
                'startScanWXDevice',
                'stopScanWXDevice',
                'connectWXDevice',
                'disconnectWXDevice',
                'sendDataToWXDevice',
                'onWXDeviceBindStateChange',
                'onWXDeviceStateChange',
                'onScanWXDeviceResult',
                'onReceiveDataFromWXDevice',
                'onWXDeviceBluetoothStateChange',
              ]
          });
             alert("初始化库结束");
}
//判断调用jsapi返回状态 true表示成功
wx.error(function (res) {
  alert("调用微信jsapi返回的状态:"+res.errMsg);
});
 
/******************************分割线************************************************/
/*********************************************************
* 打开微信设备
* 作者：wxh 2016-04-04
* my_openWXDeviceLib
* 入口参数：无
* 出口参数：0表示打开成功；1表示打开失败
*********************************************************/
function my_openWXDeviceLib(){
   var x=0; 
   WeixinJSBridge.invoke('openWXDeviceLib', {}, 
   function(res){
       mlog("打开设备返回："+res.err_msg);
      if(res.err_msg=='openWXDeviceLib:ok')
        {
          if(res.bluetoothState=='off')
            {    
              showdialog("太着急啦","亲,使用前请先打开手机蓝牙！");  
              $("#lbInfo").innerHTML="1.请打开手机蓝牙";
              $("#lbInfo").css({color:"red"});
              x=1;
              isOver();
            };
          if(res.bluetoothState=='unauthorized')
            {
              showdialog("出错啦","亲,请授权微信蓝牙功能并打开蓝牙！");    
              $("#lbInfo").html("1.请授权蓝牙功能");
              $("#lbInfo").css({color:"red"});
              x=1;
              isOver();
            }; 
          if(res.bluetoothState=='on')
            {
              //showdialog("太着急啦","亲,请查看您的设备是否打开！");   
              $("#lbInfo").html("1.蓝牙已打开,未找到设备");
              $("#lbInfo").css({color:"red"});
              //$("#lbInfo").attr(("style", "background-color:#000");
              x=0;
              //isOver();
            };      
        }
      else
        {
          $("#lbInfo").html("1.微信蓝牙打开失败");
          x=1; 
          showdialog("微信蓝牙状态","亲,请授权微信蓝牙功能并打开蓝牙！");   
        }
    });
   return x;  //0表示成功 1表示失败
}
 
 
/*********************************************************
* 装载微信事件处理
* 作者：wxh 2016-04-04
* my_installwxEvents
* 入口参数：无
* 出口参数：无
*********************************************************/
 function my_installwxEvents(){
   //1. 安装微信绑定事件
   WeixinJSBridge.on('onWXDeviceBindStateChange', function(argv) {
       //todo
        }); 
   //2. 扫描到某个设备      
   WeixinJSBridge.on('onScanWXDeviceResult', function(argv) {
        //todo
        });
   //3. 手机蓝牙状态改变事件    
   WeixinJSBridge.on('onWXDeviceBluetoothStateChange', function(argv) {
        //todo
        });         
 }
  
/*********************************************************
* 接收到数据事件
* 作者：wxh 2016-04-04
* my_onReceiveDataFromWXDevice
* 入口参数：无
* 出口参数：无
*********************************************************/ 
function my_onReceiveDataFromWXDevice(){
     
    WeixinJSBridge.on('onReceiveDataFromWXDevice', function(argv) {
    mlog("接收的数据-->"+argv.base64Data);
 //       var Bytes=base64_to_bytes_array(argv.base64Data);
   //     alert("硬件设备返回的base64数据"+argv.base64Data);
   //    mlog("接收的数据-->"+pHex(base64_to_bytes_array(argv.base64Data)));
   //     recevResult=checkReceiveData(Bytes);
        
       
      });
}
  
 
 
/**********************************************
* 取得微信设备信息
* 作者：wxh 2016-04-04
* my_getWXDeviceInfos
* 入口参数：无
* 出口参数：返回一个已经链接的设备的ID
**********************************************/
function my_getWXDeviceInfos(){
    
    WeixinJSBridge.invoke('getWXDeviceInfos', {}, function(res){
        var len=res.deviceInfos.length;  //绑定设备总数量
        for(i=0; i<=len-1;i++)
         {
           //alert(i + ' ' + res.deviceInfos[i].deviceId + ' ' +res.deviceInfos[i].state); 
           if(res.deviceInfos[i].state==="connected")
            {
              $("#lbdeviceid").html(res.deviceInfos[i].deviceId); 
              C_DEVICEID = res.deviceInfos[i].deviceId;
              $("#lbInfo").html("2.设备已成功连接");
              $("#lbInfo").css({color:"green"});
              
              break;   
            }  
         }
            
    }); 
  return;    
}
 
function mlog(m){
    var log=$('#logtext').val();
    //log=log+m;
    log = m;
    $('#logtext').val(log);
}
 
/***************************************************************
 * 显示提示信息
***************************************************************/
function showdialog(DialogTitle,DialogContent){
   var $dialog = $("#Mydialog");
   $dialog.find("#dialogTitle").html(DialogTitle);
   $dialog.find("#dialogContent").html(DialogContent);
   $dialog.show();
   $dialog.find(".weui_btn_dialog").one("click", function(){
        $dialog.hide();
   });
}
 
 
/***
   * 
   */
  $("#icFuWei").on("click",function(e){
         alert("开始"+C_DEVICEID);
         
         var Bytes=CheckBalance();
         var x=senddataBytes(Bytes,C_DEVICEID);
          
         if(x===0){$("#lbInfo").html('x.完成')}
         else {$("#lbInfo").html('x.失败')};
    });
     
    function CheckBalance(){
     var Bytes=new Array();
     
        Bytes[0]=0x02;
         
        Bytes[1]=0x00;
        Bytes[2]=0x02;
         
        Bytes[3]=0x37;
        Bytes[4]=0x40;
         
        Bytes[5]=0x03;
        Bytes[6]=0x74;
      return Bytes;
     
  }
   
   
  /*******************************************************************
 * 发送数据函数
 * 作者：V型知识库 www.vxzsk.com 2016-04-04
 * 入口参数：
 *     cmdBytes: 需要发送的命令字节
 *     selDeviceID: 选择的需要发送设备的ID 
 * 出口参数：
 *     返回: 0表示发送成功；1表示发送失败
 *     如果成功，则接收事件应该能够收到相应的数据
*******************************************************************/
function senddataBytes(cmdBytes,selDeviceID){
  //1. 如果输入的参数长度为零，则直接退出
  if(cmdBytes.length<=0){return 1};
 // alert("向微信发送指令数据");
  //1.1 如果设备ID为空，则直接返回
  if(selDeviceID.length<=0){return 1};
  //2. 发送数据
  var x=0;
  WeixinJSBridge.invoke('sendDataToWXDevice', {
            "deviceId":selDeviceID, 
            "base64Data":bytes_array_to_base64(cmdBytes)
            }, function(res){
                //alert("向微信发送指令数据返回的状态"+res.err_msg);
            if(res.err_msg=='sendDataToWXDevice:ok')
               {
                 
                 x=0;
                 alert("数据发送成功");
               }  
            else
               {
                 
                 x=1; 
                 alert("数据发送失败");
               } 
        });  
  return x;      
}
 
 
/**
 *  Byte数组转Base64字符,原理同上 
 * @Param [0x00,0x00]
 * @return Base64字符串
 **/
function bytes_array_to_base64(array) {
    if (array.length == 0) {
        return "";
    }
    var b64Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    var result = "";
    // 给末尾添加的字符,先计算出后面的字符
    var d3 = array.length % 3;
    var endChar = "";
    if (d3 == 1) {
        var value = array[array.length - 1];
        endChar = b64Chars.charAt(value >> 2);
        endChar += b64Chars.charAt((value << 4) & 0x3F);
        endChar += "==";
    } else if (d3 == 2) {
        var value1 = array[array.length - 2];
        var value2 = array[array.length - 1];
        endChar = b64Chars.charAt(value1 >> 2);
        endChar += b64Chars.charAt(((value1 << 4) & 0x3F) + (value2 >> 4));
        endChar += b64Chars.charAt((value2 << 2) & 0x3F);
        endChar += "=";
    }
 
    var times = array.length / 3;
    var startIndex = 0;
    // 开始计算
    for (var i = 0; i < times - (d3 == 0 ? 0 : 1); i++) {
        startIndex = i * 3;
 
        var S1 = array[startIndex + 0];
        var S2 = array[startIndex + 1];
        var S3 = array[startIndex + 2];
 
        var s1 = b64Chars.charAt(S1 >> 2);
        var s2 = b64Chars.charAt(((S1 << 4) & 0x3F) + (S2 >> 4));
        var s3 = b64Chars.charAt(((S2 & 0xF) << 2) + (S3 >> 6));
        var s4 = b64Chars.charAt(S3 & 0x3F);
        // 添加到结果字符串中
        result += (s1 + s2 + s3 + s4);
    }
 
    return result + endChar;
}
 
</script>
</html>