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
	.mynav-right {width:88%; margin:0px auto;background-color:cyan;}
	.mynav .right>li{float:right;list-style:none; margin-left:30px;font-size:10px;line-height:35px;font-family:arial;}
	.myhidden {display:none;position:absolute;}
	.abc li{list-style:none;font-size:8px;margin-bottom:-6px;font-family:arial;}
	.mynav .left{float:left;list-style:none;}
	.mynav a {text-decoration:none; color:black;}
	.mynav span:hover {display:block; background-color:#dedede;}
	.mynav {width:100%;height:35px; background-color:#f5f5f5;margin-bottom:20px;border:0;margin-top:-10px;}
	
	.table {margin:20px auto;}
	.good_container {width:70%;margin:0px auto;}
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
		
		X.totalPrice = function(){
			var totalprice="";
			var sum="";
			var input = document.querySelector("input[type='submit']");
			var n = document.querySelectorAll(".mycheckbox");
			for(var i=0;i<n.length;i++){
				if(n[i].checked==true){
					var price = n[i].parentNode.previousElementSibling.previousElementSibling.innerHTML;
					var count = n[i].parentNode.previousElementSibling.firstElementChild.nextElementSibling.innerHTML;
					totalprice = (price*1) * (count*1);
					sum += totalprice;
					sum = sum*1;
				}
				
			}
				input.value= "购买"+sum;
		}
		
		
		X.cartdelete = function(e){
			
			var input = document.querySelector("input[type='submit']");
			input.value= "购买";
			
			var xhr = new XMLHttpRequest();
			xhr.open("post","${pageContext.request.contextPath}/user/cartdelete");
			var cartIds="";
			var selects = document.querySelectorAll(".mycheckbox");
			
			for(var i=0;i<selects.length;i++){
				if(selects[i].checked==true){
					cartIds+=(selects[i].value+",");
				}
			}
			cartIds = cartIds.substring(0,cartIds.length-1);
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState===xhr.DONE){
					var msg = xhr.responseText;
					if(msg!==null){
						for(var i=0;i<selects.length;i++){
							if(selects[i].checked==true){
								var tr = selects[i].parentNode.parentNode;
								var table = tr.parentNode;
								table.removeChild(tr);
							}
						}
					}else{
						window.alert("删除时发生错误，请重试！");
					}
					
				}
			}
			xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
			xhr.send("cartIds="+cartIds);
		}
		
		
		
		
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
	<h3 style="text-align:center">我的购物车</h3>
	<form action="${pageContext.request.contextPath }/user/orderFromCart" method="post">
	<table class="table table-bordered table-striped">
	<tr class="table-title">
	<td>图图</td>
	<td>商品名称</td>
	<td>商品价格</td>
	<td>数量</td>
	<td>全选<input type="checkbox" value="all" onchange='X.totalPrice()' onClick="X.selectAll(this)"></td>
	</tr>
	<%
		Object o = session.getAttribute("myShoppingCart");
		Map<Integer,BuyerShoppingCart> map = (Map<Integer,BuyerShoppingCart>)o;
		Set<Integer> set = map.keySet();
		for(Integer key:set) {
			BuyerShoppingCart sc = map.get(key);
			session.setAttribute("BuyerShoppingCart", sc);
			out.print("<tr class='table-title'><a href='"+request.getContextPath()+"/good/detail?id="+sc.getGoodId()+"'>");
			out.print("<td>");
			out.print("<img src='"+request.getContextPath()+"/images/goods/"+sc.getGoodId()+".jpg' width='25px' height='42px'>");
			out.print("</td>");
			out.print("<td>");
			out.print(sc.getGoodTitle());
			out.print("</td>");
			out.print("<td>");
			out.print(sc.getGoodPrice());
			out.print("</td>");
			out.print("<td class='good-count col-xs-2'>");			
			out.print("<i class='mycount' onClick='X.updateCount("+sc.getCartId()+",0)'>-</i>");
			out.print("<span id='selector"+sc.getCartId()+"' >"+sc.getGoodCount()+"</span>");
			out.print("<i class='mycount' onClick='X.updateCount("+sc.getCartId()+",1)'>+</i>");
			out.print("</td>");
			out.print("<td>");
			out.print("<input onchange='X.totalPrice()' name='goodSelect' class='mycheckbox'  type='checkbox' value='"+sc.getCartId()+"'>");
			out.print("</td>");
			out.print("</a></tr>");
		}
		out.print("</table>");
		out.print("<a class='btn btn-warning col-lg-1 col-lg-offset-8' href='javascript:void(0)' onclick='X.cartdelete(this)'>删除</a>");
		out.print("<input class='btn btn-primary col-lg-2 col-lg-offset-1' type='submit' value='购买'>");
		out.print("</form>");
	%>
	</div>
	<div style="height:100px"></div>

	
</body>
</html>