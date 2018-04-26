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

<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/favicon.png">
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
	.table td{text-align:center;}
	.table a {text-decoration:none;}
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
			if(sum==""){	
				input.value= "购买";
			}else {
				input.value= "购买总计：￥"+sum;
			}
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
		<table id="table" class="table">
		<tr class="table-title">
		<td>图</td>
		<td>商品名称</td>
		<td>商品价格</td>
		<td>数量</td>
		<td>全选<input type="checkbox" value="all" onchange='X.totalPrice()' onClick="X.selectAll(this)"></td>
		</tr>
		<c:forEach var="m" items="${myShoppingCart }">
			<tr>
				<td><a href="${pageContext.request.contextPath }/good/detail?id=${m.value.goodId}"><img src="${pageContext.request.contextPath }/images/goods/${m.value.goodId}.jpg" width='50px' height='50px'></a></td>
				<td><a href="${pageContext.request.contextPath }/good/detail?id=${m.value.goodId}">${m.value.goodTitle}</a></td>
				<td>${m.value.goodPrice}</td>
				<td>
					<i class="mycount" onClick="X.updateCount(${m.key},0)">-</i>
					<span id="selector${m.key}">${m.value.goodCount}</span>
					<i class="mycount" onClick="X.updateCount(${m.key},1)">+</i>
				</td>
				<td><input onchange='X.totalPrice()' name='goodSelect' class='mycheckbox'  type='checkbox' value='${m.key}'></td>
			</tr>
		</c:forEach>
		</table>
		<div class="gridItem" style="padding: 5px; width: 250px; float: left; text-align: left; height: 40px; font-size: 15px;" > 
		        共有 <span id="spanTotalInfor"></span> 条记录     
		        当前第<span id="spanPageNum"></span>页     
		        共<span id="spanTotalPage"></span>页
		  </div>
		  <div class="gridItem" style="margin-left:50px;  padding: 5px; width: 400px; float: left; text-align: center; height: 40px; vertical-align: middle; font-size: 15px;">   
		            <span id="spanFirst" >首页</span> 
		            <span id="spanPre">上一页</span>
		            <span id="spanInput" style="margin: 0px; padding: 0px 0px 4px 0px; height:100%; "> 
		                第<input id="Text1" type="text" class="TextBox" onkeyup="changepage()"   style="height:20px; text-align: center;width:50px" />页 
		            </span>
		            <span id="spanNext">下一页</span> 
		            <span  id="spanLast">尾页</span> 
       	 </div>
       	<script type="text/javascript">
       		
			var theTable = document.getElementById("table");
			var txtValue = document.getElementById("Text1").value;
			function changepage() {
			    var txtValue2 = document.getElementById("Text1").value;
			    if (txtValue != txtValue2) {
			        if (txtValue2 > pageCount()) {
			
			        }
			        else if (txtValue2 <= 0) {
			
			        }
			        else if (txtValue2 == 1) {
			            first();
			        }
			        else if (txtValue2 == pageCount()) {
			            last();
			        }
			        else {
			            hideTable();
			            page = txtValue2;
			            pageNum2.value = page;
			
			            currentRow = pageSize * page;
			            maxRow = currentRow - pageSize;
			            if (currentRow > numberRowsInTable) currentRow = numberRowsInTable;
			            for (var i = maxRow; i < currentRow; i++) {
			                theTable.rows[i].style.display = '';
			            }
			            if (maxRow == 0) { preText(); firstText(); }
			            showPage();
			            nextLink();
			            lastLink();
			            preLink();
			            firstLink();
			       }
			
			        txtValue = txtValue2;
			    }
			}
		
		 </script>
		<script type="text/javascript" src="${pageContext.request.contextPath }/js/goodpagging.js"></script>
		<a class='btn btn-warning col-lg-1 col-lg-offset-8' href='javascript:void(0)' onclick='X.cartdelete(this)'>删除</a>
		<input class='btn btn-primary col-lg-2 col-lg-offset-1' type='submit' value='购买'>
		</form>
	 	
	</div>
	<div style="height:20px"></div>

	<script src="${pageContext.request.contextPath }/js/canvas-nest.min.js"></script>
</body>
</html>