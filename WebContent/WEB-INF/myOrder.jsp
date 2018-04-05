<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="cn.taobao.entity.*" %>
<%@ page import="cn.taobao.servlet.*" %>
<%@ page import="cn.taobao.util.*" %>
<%@ page import="cn.taobao.service.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	if(session.getAttribute("buyer")==null){
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的购物车</title>

<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<style type="text/css">
	* {margin:0px 0px;padding:0px 0px;font-family:arial;} 
	.mynav-left {float:left;line-height:35px;font-family:arial;}
	.mynav-right {width:88%; margin:0px auto;background-color:cyan;position:relative;}
	.mynav .right>li{float:right;list-style:none; margin-left:30px;font-size:10px;line-height:35px;font-family:arial;}
	.myhidden {display:none; position:absolute;}
	.abc li{list-style:none;font-size:8px;margin-bottom:-6px;font-family:arial;}
	.mynav .left{float:left;list-style:none;}
	.mynav a {text-decoration:none; color:black;}
	.mynav span:hover {display:block; background-color:#dedede;}
	.mynav {width:100%;height:35px; background-color:#f5f5f5;margin-bottom:20px;border:0;margin-top:-10px;}
	.table {margin:20px auto;}
	.good_container {width:60%;margin:0px auto;}
	.good-count {text-align:center;}
	.myselect {text-align:center;}
	.good-count a:hover{text-decoration:none;}
	.mycount {cursor:pointer;margin:0px 8px;display:inline-block; width:20px;height:20px;background-color:#dedede;text-align:center}
	.table-title {text-align:center;}
</style>
</head>
<script type="text/javascript">
	(function(w){
		var X = {};
	
		X.show = function(){
			document.querySelector(".myhidden").style.display="block";
		}
		X.myhidden = function(){
			document.querySelector(".myhidden").style.display="none";
		}
		X.userdelete = function(){
			if(window.confirm("注意，此操作不可取消！！请确认是否删除账户")){
				document.querySelector(".mydelete").href="${pageContext.request.contextPath }/user/delete";
			}
		}
		X.selectAll = function(e){
			var n = document.querySelectorAll(".mycheckbox");
			for(var i=0;i<n.length;i++){
				n[i].checked=e.checked;
			}
		}
		
		X.updateCount = function(id,act){
			var xhr = new XMLHttpRequest();
			xhr.open("post","${pageContext.request.contextPath}/shoppingcart/count");
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState===xhr.DONE){
					var c = xhr.responseText;
					var e = document.querySelector("#selector"+id);
					
					e.innerHTML = c;
					
					if(e.innerHTML == 0){
						e.parentNode.parentNode.parentNode.removeChild(e.parentNode.parentNode);
					}
					
				}
			}
			
			xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
			
			xhr.send("cartId="+id+"&act="+act);
			
		}
		
		<!--
		X.cartdelete = function(e){
			var n = document.querySelectorAll(".mycheckbox");
			for(var i=0;i<n.length;i++){
				if(n[i].checked=="checked"){
					var cartid = n[i].value;
				}
				
			}
		}
		-->
		
		
		
		w.X = X;
	})(window);
</script>

<body>
	<div class="mynav">
		<div class="mynav-right">
			<div class="mynav-left">
				<a href="${pageContext.request.contextPath }/buyer.jsp">欢迎，${buyer.name }！</a>
			</div>
			<ul class="right">
				<li><span><a href="#">联系客服</a></span></li>
				<li onMouseOver="X.show()" onMouseOut="X.myhidden()"><span><a href="#"><i class="fa fa-user-o" aria-hidden="true"   style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;个人中心</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></span></i>
					<div class="myhidden">
					<ul class="abc list-unstyled">
						<li><span><a href="${pageContext.request.contextPath }/complete.jsp">修改个人信息</a></span></li>
						<li><span><a class="mydelete" onClick="X.userdelete()">删除此账户</a></span></li>
						<li><span><a href="${pageContext.request.contextPath }/user/logout">退出登录</a></span></li>
					</ul>
					</div>
				</li>
				<li><span><a href="${pageContext.request.contextPath }/user/listShoppingCart"><i class="fa fa-shopping-cart" aria-hidden="true" style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;购物车</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
				<li><span><a href="${pageContext.request.contextPath }/user/listOrder"><i class="fa fa-history" aria-hidden="true"  style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;我的订单</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
			</ul>
		</div>
	</div>
	
	<div class="good_container">
	<h3 style="text-align:center">我的订单</h3><hr>
	<div class="container-fluid">
	<form action="${pageContext.request.contextPath }/user/order" method="post">
	
	<%
		Object o = session.getAttribute("myOrder");
		Map<String,BuyerOrder> map = (Map<String,BuyerOrder>)o;
		Set<String> set = map.keySet();
		for(String orderKey:set) {
			BuyerOrder bo = map.get(orderKey);
			//session.setAttribute("BuyerShoppingCart", sc);
			out.print("<div class='row'>");
			
			out.print("<div class='col-lg-4'>流水号:");
			out.print(bo.getSerialNumber().substring(0, 11)+"....");
			out.print("</div>");
			
			out.print("<div class='col-lg-4'>订单日期:");
			out.print(bo.getOrderDate());
			out.print("</div>");
			
			out.print("<div class='col-lg-4'>订单总金额:  ");
			out.print("<span style='height:34px;line-height:34px;color:#ff0000;font-size:24px'>&yen;"+bo.getTransactionAmount()+"</span>");
			out.print("</div>");
			
			
			GoodService gd = new GoodService();
			Map<Integer, Integer> m = bo.getGoodsInfo();
			for(Map.Entry<Integer, Integer> entry : m.entrySet()) {
				Integer aaa = Integer.valueOf(entry.getKey());
				Good g = gd.select(aaa);
				out.print("<div class='row'><a href='"+request.getContextPath()+"/good/detail?id="+g.getGoodId()+"'>");
				out.print("<div class='col-lg-1'>");
				out.print("<img src='"+request.getContextPath()+"/images/goods/"+g.getGoodId()+".jpg' height='60px'>");
				out.print("</div>");
				out.print("<div class='col-lg-3'>");
				out.print(g.getGoodTitle().length()<20?g.getGoodTitle():g.getGoodTitle().substring(0,20));
				out.print("</div>");
				out.print("<div class='col-lg-6'>");
				if(g.getGoodDesc().length()<50){
					out.print(g.getGoodDesc());
				}else{
					out.print(g.getGoodDesc().substring(0,50));	
				}
				out.print("</div>");
				out.print("<div class='col-lg-1'>");
				out.print(g.getGoodPrice());
				out.print("</div>");
				out.print("<div class='col-lg-1'>x ");
				out.print(entry.getValue());
				out.print("</div>");
				out.print("</a></div>");
			}
						
			out.print("</div>");
			out.print("<hr>");
		}
		
	%>
	</div>
	</div>

	
</body>
</html>