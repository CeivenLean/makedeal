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

<%
	if(session.getAttribute("seller")==null){
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>卖家主页</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<style type="text/css">
	.mycontainer{margin:20px auto; width:88%}
	* {margin:0px 0px;padding:0px 0px;font-family:arial;} 
	.mynav-left {float:left;line-height:35px;font-family:arial;}
	.mynav-right {width:88%; margin:0px auto;background-color:cyan;}
	.mynav .right>li{float:right;list-style:none; margin-left:30px;font-size:10px;line-height:35px;font-family:arial;}
	.myhidden {display:none;position:absolute;background-color:#f5f5f5;}
	.abc li{list-style:none;font-size:8px;margin-bottom:-6px;font-family:arial;}
	.mynav .left{float:left;list-style:none;}
	.mynav a {text-decoration:none; color:black;}
	.mynav span:hover {display:block; background-color:#dedede;}
	.mynav {width:100%;height:35px; background-color:#f5f5f5;margin-bottom:20px;border:0;margin-top:-10px;}
	 
	 
</style>

</head>
<script type="text/javascript">
	(function(w){
		var $ = {};
		
		$.show = function(){
			document.querySelector(".myhidden").style.display="block";
		}
		$.myhidden = function(){
			document.querySelector(".myhidden").style.display="none";
		}
		$.userdelete = function(){
			if(window.confirm("注意，此操作不可取消！！请确认是否删除账户")){
				document.querySelector(".mydelete").href="${pageContext.request.contextPath }/user/delete";
			}
		}
		
		w.$ = $;
		
	})(window);
	
	
</script>

<body>
	<div class="mynav">
		<div class="mynav-right">
			<div class="mynav-left">
				<a href="${pageContext.request.contextPath }/seller.jsp">欢迎，${seller.name }！</a>
			</div>
			<ul class="right">
				<li><span><a href="#">联系客服</a></span></li>
				<li onMouseOver="$.show()" onMouseOut="$.myhidden()"><span><a href="#"><i class="fa fa-user-o" aria-hidden="true"   style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;个人中心</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></span></i>
					<div class="myhidden">
					<ul class="abc list-unstyled">
						<li><span><a href="${pageContext.request.contextPath }/complete.jsp">修改个人信息</a></span></li>
						<li><span><a class="mydelete" onClick="$.userdelete()">删除此账户</a></span></li>
						<li><span><a href="${pageContext.request.contextPath }/user/logout">退出登录</a></span></li>
					</ul>
					</div>
				</li>
				<li><span><a href="${pageContext.request.contextPath }/seller/goodList"><i class="fa fa-user" aria-hidden="true" style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;商品管理</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
				<li><span><a href="${pageContext.request.contextPath }/seller/orderList"><i class="fa fa-history" aria-hidden="true"  style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;我的订单</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
			</ul>
		</div>
	</div>	

	<div class="mycontainer">
	<h3 style="text-align:center">所有订单<c:if test="${empty sellerOrderMap }">（暂无）</c:if></h3><hr>
		<div class="container-fluid">
			<c:forEach var="m" items="${sellerOrderMap }">
				<div class="row">
					<div class='col-lg-2'>流水号:${fn:substring(m.key,0,11) }...</div>
					<div class='col-lg-2'>订单日期:${fn:substring(m.value.orderDate,11,19) }</div>
					<div class='col-lg-2'>订单总金额:<span style="color:red;font-size:18px;">&yen;${m.value.orderPrice }</span></div>
					<div class='col-lg-2'>买家:${m.value.buyer.name }</div>
					<div class='col-lg-4'>配送地址:${fn:substring(m.value.address,0,23) }...</div>
				</div>
				<c:forEach var="g" items="${m.value.goodsInfo }">
				<div class="row"><a href="${pageContext.request.contextPath }/good/detail?id=${g.key.goodId}">
					<div class='col-lg-1'><img height='60px' src="${pageContext.request.contextPath }/images/goods/${g.key.goodId}.jpg"></div>
					<div class='col-lg-3'>${g.key.goodTitle}</div>
					<div class='col-lg-6'>${fn:length(g.key.goodDesc)<80?g.key.goodDesc:fn:substring(g.key.goodDesc,0,80) }</div>
					<div class='col-lg-1'>${g.key.goodPrice}</div>
					<div class='col-lg-1'>x ${g.value}</div>
					
				</a></div>
				</c:forEach>
				<hr>
			</c:forEach>
		</div>
		
	</div>

	<a title="点击添加新商品" style="text-decoration:none;cursor:pointer;color:white;" href="${pageContext.request.contextPath }/publish.jsp"><div style="box-shadow:0px 2px 2px 0px;background-color:red;border-radius:50px;display:block;width:60px; text-align:center;height:60px;line-height:60px;position:fixed;right: 48%;bottom: 30px; "><i style="height:60px;line-height:60px;font-size:18px;" class="fa fa-plus"></i></div></a>
</body>
</html>