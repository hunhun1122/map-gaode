<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
session.setAttribute("basePath",basePath);
%>
<!DOCTYPE html>  
<html>  
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
<meta http-equiv="X-UA-Compatible" content="IE=edge">  
<meta name="viewport"  
    content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0">  
<meta name="apple-mobile-web-app-capable" content="yes">  
<meta name="apple-mobile-web-app-status-bar-style" content="black">  
<meta name="format-detection" content="telephone=no">  
<title>测试蓝牙1</title>  

  <link rel="stylesheet" href="<%=basePath %>static/weui.min.css?what=0">
  <script src="http://libs.baidu.com/jquery/2.0.0/jquery.js"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>  
<style type="text/css">  
.wdbll4 {  
    margin-top: 15px;  
}  
  
.grxx_top_biaoge td {  
    text-align: center;  
}  
</style>  
</head>  
<body id="activity-detail" class="zh_CN ">  
    <div class="wdbll4" align="center"  
        style="padding-left: 10px; padding-right: 10px;">  
        <div style="width: 95%; margin: 0 auto; text-align: center" id="scan">  
            <div class='aui-btn aui-btn-info aui-btn-block' onclick="scan();"  
                id="startScanWXDevice">搜索蓝牙</div>  
        </div>  
    </div>  
    <div class="wdbll4" align="center"  
        style="padding-left: 10px; padding-right: 10px;">  
        <div style="width: 95%; margin: 0 auto; text-align: center" id="scan">  
            <div class='aui-btn aui-btn-info aui-btn-block' onclick="stopSacn();"  
                id="stopScanWXDevice">停止搜索</div>  
        </div>  
    </div>  
    <div class="wdbll4" align="center"  
        style="padding-left: 10px; padding-right: 10px;">  
        <div style="width: 95%; margin: 0 auto; text-align: center" id="scan">  
            <div class='aui-btn aui-btn-info aui-btn-block' onclick="getInfo()">获取设备信息</div>  
        </div>  
    </div>  
    <div class="wdbll4" align="center"  
        style="padding-left: 10px; padding-right: 10px;">  
        <div style="width: 95%; margin: 0 auto; text-align: center" id="scan">  
            <div class='aui-btn aui-btn-info aui-btn-block' onclick="bleConn()">连接蓝牙</div>  
        </div>  
    </div>  
    <div class="wdbll4" align="center"  
        style="padding-left: 10px; padding-right: 10px;">  
        <div style="width: 95%; margin: 0 auto; text-align: center" id="scan">  
            <div class='aui-btn aui-btn-info aui-btn-block' onclick="sendData()">发送数据</div>  
        </div>  
    </div>  
    <div id="initBle"></div>  
</body>  
<script type="text/javascript">  
    function BleManage() {  
    };  
    //在它的原型上添加方法    
    BleManage.prototype = {  
        //搜索蓝牙    
        bleInit_sAcn : function() {  
            wx.invoke('startScanWXDevice', {  
                //  'connType' : 'blue',    
                'btVersion' : 'ble'  
            }, function(res) {  
                console.log('开始扫描设备：', res);  
                $("#initBle").append("<p>开始扫描设备：" + res.err_msg + "</p>");  
            });  
        },  
        //关不搜索蓝牙    
        bleInit_stopSacn : function() {  
            wx.invoke('stopScanWXDevice', {  
                'connType' : 'blue'  
            }, function(res) {  
                $("#initBle").append("<p>停止扫描设备：" + res.err_msg + "</p>");  
                console.log('停止扫描设备：', res);  
                //alert(res.err_msg);      
            });  
        },  
        //获取设备信息    
        bleInit_getDev_Info : function() {  
            wx.invoke('getWXDeviceInfos', {  
                'connType' : 'ble'  
            }, function(res) {  
                alert(JSON.stringify(res))  
            });  
        },  
        //连接兰芽    
        bleInit_connBle : function() {  
            wx.invoke('connectWXDevice', {  
                'deviceId' : 'gh_c126ac0e71a5_6f34fbf77e2686d1',  
                'connType' : 'ble'  
            }, function(res) {  
                alert(JSON.stringify(res))  
            });  
        },  
        //发送数据    
        bleInit_sendData : function() {  
            wx  
                    .invoke(  
                            'sendDataToWXDevice',  
                            {  
                                'deviceId' : 'gh_c126ac0e71a5_6f34fbf77e2686d1',  
                                'connType' : 'ble',  
                                'base64Data' : 'MDAwMEZGRjItMDAwMC0xMDAwLTgwMDAtMDA4MDVGOUIzNEZC'  
                            }, function(res) {  
                                alert(JSON.stringify(res))  
                            });  
        },  
        //初始化微信配置    
        bleInit_callback_ : function() {  
            //刚刚开测试 建议这4个值 直接在页面上写死    
            //动态获取签名的时候才建议 使用下面 ready里面的ajax    
            /* 
            var appId = data.appId;   
            var timestamp = data.timestamp;   
            var nonceStr = data.nonceStr;   
            var signature = data.signature;  6eee7ee157ea0fbe3bb92e11e12357c696933b9e 
             */  
             
            wx.config({  
                beta : true, //坑：这个很重要，必须配置这个为true,才能调用微信的硬件API  
                debug : true, //是否开启调试模式，会自动弹一些消息框显示微信返回的数据  
                appId : "wxc5156893d7d9c82b", //让后台返回appid  
                timestamp : "1492409897", //让后台返回生成证书时用的时间戳  
                nonceStr : "c7a3c75f-df20-4b57-b8a0-1788269ad80a", //让后台返回生成证书时用的随机串  
                signature : "ff1d63abcf3b334cb2acd32144ed8a5cae38d4cc", //让后台返回已当前URL地址生成的证书  
                jsApiList : [ //需要调用的接口，都得在这里面写一遍      
                "openWXDeviceLib",//初始化设备库（只支持蓝牙设备）      
                "closeWXDeviceLib",//关闭设备库（只支持蓝牙设备）      
                "getWXDeviceInfos",//获取设备信息（获取当前用户已绑定的蓝牙设备列表）      
                "sendDataToWXDevice",//发送数据给设备      
                "startScanWXDevice",//扫描设备（获取周围所有的设备列表，无论绑定还是未被绑定的设备都会扫描到）      
                "stopScanWXDevice",//停止扫描设备      
                "connectWXDevice",//连接设备      
                "disconnectWXDevice",//断开设备连接      
                "getWXDeviceTicket",//获取操作凭证      
  
                //下面是监听事件：      
                "onWXDeviceBindStateChange",//微信客户端设备绑定状态被改变时触发此事件      
                "onWXDeviceStateChange",//监听连接状态，可以监听连接中、连接上、连接断开      
                "onReceiveDataFromWXDevice",//接收到来自设备的数据时触发      
                "onScanWXDeviceResult",//扫描到某个设备时触发      
                "onWXDeviceBluetoothStateChange",//手机蓝牙打开或关闭时触发      
                ]  
            });  
            wx.ready(function() {  
                wx.invoke('openWXDeviceLib', {  
                // 'brandUserName' : '',  
                // 'connType':'blue'  
                }, function(res) {  
                    $("#initBle").append("<p>初始化设备库：" + res.err_msg + "</p>");  
                    if (res.bluetoothState == "off") {  
                        alert("请先开启手机蓝牙");  
                        $("#initBle").append("<p>请先开启手机蓝牙</p>");  
  
                    }  
                });  
                wx.invoke('getWXDeviceInfos', {  
                    'connType' : 'blue'  
                }, function(res) {  
                    $("#initBle").append("<p>获取我的设备：" + res.err_msg + "</p>");  
                });  
  
                wx.on('onScanWXDeviceResult', function(res) {  
                    var ret_ = res.devices;  
                    for (var i = 0; i < ret_.length; i++) {  
                        var macid = JSON.stringify(res.devices[i].deviceId)  
                                .replace(/\"/g, "");  
                        //给扫描到的设备添加点击事件  
                        $("#initBle").append(  
                                "<button onclick=\"bindBle('" + macid  
                                        + "')\">扫描到设备：" + macid + "</button>");  
                    }  
                });  
                //手机蓝牙状态改变时触发 （这是监听事件的调用方法，注意，监听事件都没有参数）      
                wx.on('onWXDeviceBluetoothStateChange', function(res) {  
                    //把res输出来看吧      
                    $("#initBle").append(  
                            "<p>蓝牙状态变更：" + JSON.stringify(res) + "</p>");  
                });  
                //设备绑定状态改变事件（解绑成功，绑定成功的瞬间，会触发）      
                wx.on('onWXDeviceBindStateChange', function(res) {  
  
                    $("#initBle").append(  
                            "<p>绑定状态变更：" + JSON.stringify(res) + "</p>");  
                });  
                //设备连接状态改变      
                wx.on('onWXDeviceStateChange', function(res) {  
                    //有3个状态：connecting连接中,connected已连接,unconnected未连接      
                    //每当手机和设备之间的状态改变的瞬间，会触发一次      
  
                    $("#initBle").append("<p>设备连接状态：" + res.state + "</p>");  
                });  
                //接收到设备传来的数据      
                wx.on('onReceiveDataFromWXDevice', function(res) {  
                    $("#initBle").append(  
                            "<p>收到设备数据：" + JSON.stringify(res) + "</p>");  
                });  
                wx.error(function(res) {  
                    alert("wx.error错误：" + JSON.stringify(res));  
                    //如果初始化出错了会调用此方法，没什么特别要注意的      
                });  
  
            });  
        }  
    }  
    //绑定设备  
    function bindBle(str) {  
        //先去后台验证一下当前用户的openid有效  
        $.ajax({  
            type : "post",  
            url : "ble/bleServlet",  
            data : {  
                "method" : "getOpenid"  
            },  
            dataType : "json",  
            success : function(data) {  
                var openid = data.openid;  
                if (openid == 1) {  
                    alert("errr");  
                } else {  
                    //强制绑定 传值 后台获取的openid  和当前点击的设备ID  
                    $.ajax({  
                        type : "post",  
                        url : "ble/bleServlet",  
                        data : {  
                            "method" : "bindDe",  
                            "deviceId" : str,  
                            "openid" : openid  
                        },  
                        dataType : "json",  
                        success : function(data) {  
                            alert(JSON.stringify(data))  
                            var s = data.errmsg;  
                            if (s == "ok") {  
                                alert("bind   succ");  
                            }  
                        },  
                        error : function(e) {  
                        }  
                    });  
                }  
            },  
            error : function(e) {  
            }  
        });  
    }  
  
    var bleManage = null;  
    //进来动态加载签名    
    $(document).ready(function() {  
        bleManage = new BleManage();  
        bleManage.bleInit_callback_();  
        /* 
        $.ajax({   
            type : "post",   
            url : "xxx.com",   
            data : {},   
            dataType : "json",   
            success : function(data) {   
                //调用之前先打印一下传回来的4个值 是否跟你之前写死的 能成功的值是一样的   
                bleManage.bleInit_callback_(data);   
            }   
        }); 
         */  
    });  
  
    function scan() {  
        bleManage.bleInit_sAcn();  
    }  
    function stopSacn() {  
        bleManage.bleInit_stopSacn();  
    }  
    function getInfo() {  
        bleManage.bleInit_getDev_Info();  
    }  
    function bleConn() {  
        bleManage.bleInit_connBle();  
    }  
    function sendData() {  
        bleManage.bleInit_sendData();  
    }  
    var base64EncodeChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";  
    function base64encode(str) {  
        var out, i, len;  
        var c1, c2, c3;  
        len = str.length;  
        i = 0;  
        out = "";  
        while (i < len) {  
            c1 = str.charCodeAt(i++) & 0xff;  
            if (i == len) {  
                out += base64EncodeChars.charAt(c1 >> 2);  
                out += base64EncodeChars.charAt((c1 & 0x3) << 4);  
                out += "==";  
                break;  
            }  
            c2 = str.charCodeAt(i++);  
            if (i == len) {  
                out += base64EncodeChars.charAt(c1 >> 2);  
                out += base64EncodeChars.charAt(((c1 & 0x3) << 4)  
                        | ((c2 & 0xF0) >> 4));  
                out += base64EncodeChars.charAt((c2 & 0xF) << 2);  
                out += "=";  
                break;  
            }  
            c3 = str.charCodeAt(i++);  
            out += base64EncodeChars.charAt(c1 >> 2);  
            out += base64EncodeChars.charAt(((c1 & 0x3) << 4)  
                    | ((c2 & 0xF0) >> 4));  
            out += base64EncodeChars.charAt(((c2 & 0xF) << 2)  
                    | ((c3 & 0xC0) >> 6));  
            out += base64EncodeChars.charAt(c3 & 0x3F);  
        }  
        return out;  
    }  
</script>  
</html> 