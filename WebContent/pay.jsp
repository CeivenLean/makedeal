<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="cn.shop.entity.*" %>
<%@ page import="cn.shop.servlet.*" %>
<%@ page import="cn.shop.util.*" %>
<%@ page import="cn.shop.service.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="p" uri="http://cn.taobao/pagetag" %>    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>支付宝 - 网上支付 安全快速！</title>
<link rel="shortcut icon" href="https://i.alipayobjects.com/common/favicon/favicon.png" type="image/x-icon">
<style type="text/css">
body, button, input, select, textarea {
    font: 12px/1.5 tahoma,arial,\5b8b\4f53;
}
* {margin:0 0;padding:0 0;}
.topbar {
    width: 100%;
    height: 26px;
    background: url(https://i.alipayobjects.com/e/201305/OzLou0mHd.png) repeat-x 0 0;
}
.topbar .topbar-wrap {
    background: url(https://i.alipayobjects.com/e/201305/OzLou0mHd.png) repeat-x 0 0;
    width: 950px;
    margin: 0 auto;
}
.topbar .topbar-wrap .topbar-link-first {
    padding-left: 0;
    background: 0 0;
}
.topbar .topbar-wrap .topbar-link-last {
    padding-right: 0;
}
ins, a {
    text-decoration: none;
}
.topbar .topbar-wrap a, .topbar .topbar-wrap span {
    float: right;
    color: #fff;
    padding: 4px 15px;
    background: url(https://i.alipayobjects.com/e/201305/OzUPukVET.png) no-repeat 0 7px;
}
#header {
    height: 60px;
    background-color: #fff;
    border-bottom: 1px solid #d9d9d9;
    margin-top: 0px;
}
#header {
    width: 100%;
    zoom: 1;
}
.header-container {
    width: 950px;
    margin: 0 auto;
}
#header .header-title {
    width: 250px;
    height: 60px;
    float: left;
}
.alipay-logo {
    display: block;
    width: 114px;
    position: relative;
    left: 0;
    top: 10px;
    float: left;
    height: 40px;
    background-position: 0 0;
    background-repeat: no-repeat;
    background-image: url(https://t.alipayobjects.com/images/T1HHFgXXVeXXXXXXXX.png);
}
#header .logo-title {
    font-size: 16px;
    font-weight: normal;
    font-family: "Microsoft YaHei",微软雅黑,"宋体";
    border-left: 1px solid #676d70;
    color: #676d70;
    height: 20px;
    float: left;
    margin-top: 15px;
    margin-left: 10px;
    padding-top: 10px;
    padding-left: 10px;
}
.pre-container {width:66%;height:60px;margin:20px auto}
.pre-container div {margin:20px auto}
.mycontainer {border-top:4px solid #aaa;width:70%;height:500px;background-color:#fff;margin:0 auto;padding:50px auto;}
.mycontainer div{margin:0 auto;text-align:center;}
.container-left {float:left;width:83%;height:100%;}
.container-right {float:right;width:17%;height:100%;background-color:#dfdfdf;}
body {
    background-color: #eff0f1;
}
.my-code {width:180px;margin-top:20px;border:1px solid #dedede;}
.switch-tip-btn {
    display: block;
    width: 106px;
    height: 36px;
    margin: 6px auto 0;
    border: 1px solid #0fa4db;
    background-color: #00aeef;
    border-radius: 5px;
    font-size: 12px;
    font-weight: 400;
    line-height: 36px;
    text-align: center;
    color: #fff;
    text-decoration: none;
    margin-top:200px;
}

</style>
</head>
<body>
	<div class="topbar">
	    <div class="topbar-wrap fn-clear">
	        <a href="https://help.alipay.com/lab/help_detail.htm?help_id=258086" class="topbar-link-last" target="_blank" seed="goToHelp">常见问题</a>
	        		<span class="topbar-link-first">你好，欢迎使用支付宝付款！</span>
		</div>
	</div>
	<div id="header">
	    <div class="header-container fn-clear">
	        <div class="header-title">
	            <div class="alipay-logo"></div>
	            <span class="logo-title">我的收银台</span>
	        </div>
	    </div>
	</div>
	<div class="pre-container">
		<div>正在使用即时到账交易 | 交易将在30分钟后关闭，请及时付款！</div>
		<div>收款方：<a>郭晓黎</a><span style="color:red;font-size:24px;float:right"><b>${prices }元</b></span></div>
	</div>
	<div class="mycontainer">
		<div class="container-left">
			<div style="height:15%;">&nbsp</div>
			<div>扫一扫付款（元）</div>
			<div style="margin:10px 0px;"><span style="color:red;font-size:24px;"><b>${prices }</b></span></div>
			<div class="my-code">
				<img alt="" src="${pageContext.request.contextPath }/user/ordercode?prices=${prices }" width="170px">
				<img style="float:left;margin-top:4px;margin-left:20px;" alt="" src="https://t.alipayobjects.com/images/T1bdtfXfdiXXXXXXXX.png">
				<p>打开手机支付宝</p>
				<p style="margin-bottom:4px;margin-top:2px;">扫一扫继续付款</p>
			</div>
		</div>
		<div class="container-right">
			<div class="right-button">
				<a class="switch-tip-btn" href="javascript:void(0)" seed="J_tip_qr-switchTipBtn" smartracker="on">&lt;&nbsp;登录账户付款</a>
			</div>
		</div>
		
	</div>
</body>
</html>