<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.shop.entity.*" %>
<%@ page import="cn.shop.dao.*" %>
<%@ page import="cn.shop.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="cn.shop.servlet.*" %>
<%@ page import="cn.shop.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单确认</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/favicon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/tasp.css" />
<link href="${pageContext.request.contextPath }/css/orderconfirm.css" rel="stylesheet" />
<style type="text/css">

	.mynav-left {float:left;line-height:35px;font-family:arial;}
	.mynav-right {width:88%; margin:0px auto;background-color:cyan;}
	.mynav .right>li{float:right;list-style:none; margin-left:30px;font-size:10px;line-height:35px;font-family:arial;}
	.myhidden {display:none;position:absolute; }
	.abc li{list-style:none;font-size:12px;margin-bottom:-6px;font-family:arial;line-height:30px;height:30px;}
	.mynav .left{float:left;list-style:none;}
	.mynav a {font-size:13px;text-decoration:none; color:black;}
	.mynav span:hover {display:block; background-color:#dedede;}
	.mynav {font-family: arial;width:100%;height:35px; background-color:#f5f5f5;margin-bottom:20px;border:0;}

#page{width:auto;}
#comm-header-inner,#content{width:950px;margin:auto;}
#logo{padding-top:26px;padding-bottom:12px;}
#header .wrap-box{margin-top:-67px;}
#logo .logo{position:relative;overflow:hidden;display:inline-block;width:140px;height:35px;font-size:35px;line-height:35px;color:#f40;}
#logo .logo .i{position:absolute;width:140px;height:35px;top:0;left:0;background:url(http://a.tbcdn.cn/tbsp/img/header/logo.png);}

</style>
</head>
<script type="text/javascript">
	function show(){
		document.querySelector(".myhidden").style.display="block";
	}
	function myhidden(){
		document.querySelector(".myhidden").style.display="none";
	}
	
	function userdelete(){
		if(window.confirm("注意，此操作不可取消！！请确认是否删除账户")){
			document.querySelector(".mydelete").href="${pageContext.request.contextPath }/user/delete";
		}
	}
	
	function confirmAddr(e){
		var value= e.value;
		document.querySelector("#J_AddrConfirm").innerHTML = value;
	}
</script>

<body>
<div id="mytop" class="mynav">
		<div class="mynav-right">
			<div class="mynav-left">
				<a href="${pageContext.request.contextPath }/buyer.jsp">欢迎，${buyer.name }！</a>
			</div>
			<ul class="right">
				<li><span><a href="http://sighttp.qq.com/msgrd?v=1&uin=1584592950">联系客服</a></span></li>
				<li onMouseOver="show()" onMouseOut="myhidden()"><span><a href="#"><i class="fa fa-user-o" aria-hidden="true"   style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;个人中心</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></span></i>
					<div class="myhidden">
					<ul class="abc list-unstyled">
						<li><span><a href="${pageContext.request.contextPath }/complete.jsp">修改个人信息</a></span></li>
						<li><span><a class="mydelete" onClick="userdelete()">删除此账户</a></span></li>
						<li><span><a href="${pageContext.request.contextPath }/user/logout">退出登录</a></span></li>
					</ul>
					</div>
				</li>
				<li><span><a href="${pageContext.request.contextPath }/user/listShoppingCart"><i class="fa fa-shopping-cart" aria-hidden="true" style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;购物车</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
				<li><span><a href="${pageContext.request.contextPath }/user/listOrder"><i class="fa fa-history" aria-hidden="true"  style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;我的订单</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
			</ul>
		</div>
	</div>
<form action="${pageContext.request.contextPath }/pay" method="post">	
	<div id="page">

 		<div id="content" class="grid-c">

  <div id="address" class="address" style="margin-top: 20px;" data-spm="2">

<h3>选择收货地址</h3>
<ul id="address-list" class="address-list">
	<c:forEach var="s" items="${buyer.address }" varStatus="status">
	<li class="J_Addr J_MakePoint clearfix  J_DefaultAddr ">
		<s class="J_Marker marker"></s>
		<span class="marker-tip">寄送至</span>
		<div class="address-info">
			<c:if test="${status.count==1}">
				<input onclick="confirmAddr(this)" name="address" class="J_MakePoint " checked="checked" type="radio" value="${s }" >
				<c:set var="addr1" value="${s }"></c:set>
			</c:if>
			<c:if test="${status.count>1}">
				<input onclick="confirmAddr(this)" name="address" class="J_MakePoint " type="radio" value="${s }" >
			</c:if>
			
			<label for="addrId_674944241" class="user-address">${s }</label>
		</div>
	</li>
	</c:forEach>
</ul>
<ul id="J_MoreAddress" class="address-list hidden">
     
 </ul>

<div class="address-bar">
 <!-- <a href="#" class="new J_MakePoint" id="J_NewAddressBtn">使用新地址</a> -->
 </div>

</div>

           <div>
 <h3 class="dib">确认订单信息</h3>
 <table cellspacing="0" cellpadding="0" class="order-table" id="J_OrderTable" summary="统一下单订单信息区域">
 <caption style="display: none">统一下单订单信息区域</caption>
 <thead>
 <tr>
 <th class="s-title">商品信息<hr/></th>
 <th class="s-price">单价(元)<hr/></th>
 <th class="s-amount">数量<hr/></th>
 
 <th class="s-total">小计(元)<hr/></th>
 </tr>
 </thead>
     


<tbody data-spm="3" class="J_Shop" data-tbcbid="0" data-outorderid="47285539868"  data-isb2c="false" data-postMode="2" data-sellerid="1704508670">
	<c:forEach var="m" items="${ordermap}" >
 		<tr class="item" data-lineid="19614514619:31175333266:35612993875" data-pointRate="0">
			<td class="s-title">
				<a href="${pageContext.request.contextPath }/good/detail?id=${m.key.goodId }" target="_blank" title="${m.key.goodTitle }" class="J_MakePoint">
					<img width="60px" height="60px" src="${pageContext.request.contextPath }/images/goods/${m.key.goodId }.jpg" class="itempic">
					<span class="title J_MakePoint">${m.key.goodTitle }</span>
				</a>
				<div class="props"><span>${fn:length(m.key.goodDesc)<80?m.key.goodDesc:fn:substring(m.key.goodDesc,0,80) } </span></div>
		 		<a title="消费者保障服务，卖家承诺商品如实描述" href="javascript:void(0)" target="_blank">
					<img src="http://img03.taobaocdn.com/tps/i3/T1bnR4XEBhXXcQVo..-14-16.png"/>${m.key.sellerName }
				</a>
			</td>
			<td class="s-price">
	   			<span class='price '><em class="style-normal-small-black J_ItemPrice"  >${m.key.goodPrice }</em></span>
			</td>
			<td class="s-amount">${m.value }</td>
			<td class="s-total">
				<span class='price '><em class="style-normal-bold-red J_ItemTotal "  >${m.key.goodPrice*m.value } </em></span>
			</td>
		</tr>
		<tr class="blue-line" style="height: 2px;"><td colspan="5"></td></tr>
	</c:forEach>

	<tr class="shop-total blue-line">
		<td colspan="5">总计：
			<span class='price g_price '>
				<span>&yen;</span><em class="style-middle-bold-red J_ShopTotal"  >${totalPrice }</em>
			</span>
		</td>
	</tr>
</tbody>
<tfoot>
	<tr>
		<td colspan="5">
			<div class="order-go" data-spm="4">
				<div class="J_AddressConfirm address-confirm">
					<div class="kd-popup pop-back" style="margin-bottom: 40px;">
						<div class="box">
							<div class="bd">
								<div class="point-in">
									<em class="t">实付款：</em>
									<span class='price g_price '>
										<span style="color:red;font-size:22px;">&yen;
										<em class="style-large-bold-red"  id="J_ActualFee"  >${totalPrice }</em>
										</span>
									</span>
								</div>

								<ul>
									<li><em>寄送至:</em>
									<span id="J_AddrConfirm" style="word-break: break-all;">${addr1 }</span>
									</li>
									
								</ul>
							</div>
						</div>
						<a href="#" class="back J_MakePoint" target="_top">返回</a>
						<button type="submit"><a id="J_Go" class=" btn-go"  tabindex="0" title="点击此按钮，转至支付宝付款。">确认并支付<b class="dpl-button"></b></a></button>
					</div>
				</div>
			</div>
		</td>
	</tr>
</tfoot>
</table>
</div>
 
</div>

<div id="footer"></div>
</div>
	
</form>	

<script src="${pageContext.request.contextPath }/js/canvas-nest.min.js"></script>
</body>
</html>