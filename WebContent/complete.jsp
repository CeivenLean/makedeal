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
	if(session.getAttribute("buyer")==null&&session.getAttribute("seller")==null){
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>完善个人信息</title>
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
	.mycontainer{margin:40px auto;width:40%;padding:40px 20px;}
</style>
<script type="text/javascript">
		
		function show(){
			document.querySelector(".myhidden").style.display="block";
		}
		function myhidden(){
			document.querySelector(".myhidden").style.display="none";
		}
		function save(e){
			var xhr = new XMLHttpRequest();		
			var method = "post";
			var url = "${pageContext.request.contextPath }/user/complete";
			xhr.open(method,url);
			xhr.onreadystatechange = function(){
				if(xhr.readyState===xhr.DONE){
					if(xhr.status==200){
						var result = xhr.responseText;
						if(result==="success"){
							var div = document.querySelector(".mycontainer");
							div.innerHTML = "<h4 align='center'>保存成功</h5>";
						}else{
							alert("保存失败,请重试！");
						}
					}
				}
				
			}
			xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
			var data="";
			if(e==1){
				var gender = document.querySelector("input[name=\"gender\"]");
				var phone = document.querySelector("input[name=\"phone\"]");
				var address1 = document.querySelector("input[name=\"address1\"]");
				var address2 = document.querySelector("input[name=\"address2\"]");
				var address3 = document.querySelector("input[name=\"address3\"]");
				data = "src=1&gender="+gender.value+"&phone="+phone.value+"&address1="+address1.value+"&address2="+address2.value+"&address3="+address3.value;
			}else if(e==2){
				var gender = document.querySelector("input[name=\"gender\"]");
				var phone = document.querySelector("input[name=\"phone\"]");
				var address = document.querySelector("input[name=\"address\"]");
				data = "src=2&gender="+gender.value+"&phone="+phone.value+"&address="+address.value;
			}
			data=data.trim();
			xhr.send(data);
		}
	
</script>
</head>
<body>
	<c:if test="${not empty buyer}">
	<div class="mynav">
		<div class="mynav-right">
			<div class="mynav-left">
				<a href="${pageContext.request.contextPath }/buyer.jsp">欢迎，${buyer.name }！</a>
			</div>
			<ul class="right">
				<li><span><a href="#">联系客服</a></span></li>
				<li onMouseOver="show()" onMouseOut="myhidden()"><span><a href="#"><i class="fa fa-user-o" aria-hidden="true"   style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;个人中心</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></span></i>
					<div class="myhidden">
					<ul class="abc list-unstyled">
						<li><span><a href="${pageContext.request.contextPath }/complete.jsp">修改个人信息</a></span></li>
						<li><span><a class="mydelete" onClick="">删除此账户</a></span></li>
						<li><span><a href="${pageContext.request.contextPath }/user/logout">退出登录</a></span></li>
					</ul>
					</div>
				</li>
				<li><span><a href="${pageContext.request.contextPath }/user/listShoppingCart"><i class="fa fa-shopping-cart" aria-hidden="true" style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;购物车</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
				<li><span><a href="${pageContext.request.contextPath }/user/listOrder"><i class="fa fa-history" aria-hidden="true"  style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;我的订单</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
			</ul>
		</div>
	</div>
	<h3 style="text-align:center">完善个人信息</h3>
	<div class="mycontainer">
		<form class="form-horizontal">
		  <div class="form-group">
		    <label for="gender" class="col-sm-3 control-label">性  别</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" name="gender" placeholder="请输入男士或女士">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="phone" class="col-sm-3 control-label">手机号</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" name="phone" placeholder="请输入11位有效手机号">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="address" class="col-sm-3 control-label">收获地址一</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" name="address1" placeholder="请输入">
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="address" class="col-sm-3 control-label">收获地址二</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" name="address2" placeholder="请输入">
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="address" class="col-sm-3 control-label">收获地址二</label>
		    <div class="col-sm-9">
		      <input type="text" class="form-control" name="address3" placeholder="请输入">
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-3 col-sm-9">
		      <button type="button" onclick="save(1)" class="btn btn-primary">保存</button>
		    </div>
		  </div>
		</form>
	</div>
	</c:if>
	
	
	<c:if test="${not empty seller }">
	<div class="mynav">
		<div class="mynav-right">
			<div class="mynav-left">
				<a href="${pageContext.request.contextPath }/seller.jsp">欢迎，${seller.name }！</a>
			</div>
			<ul class="right">
				<li><span><a href="#">联系客服</a></span></li>
				<li onMouseOver="show()" onMouseOut="myhidden()"><span><a href="#"><i class="fa fa-user-o" aria-hidden="true"   style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;个人中心</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></span></i>
					<div class="myhidden">
					<ul class="abc list-unstyled">
						<li><span><a href="${pageContext.request.contextPath }/complete.jsp">修改个人信息</a></span></li>
						<li><span><a class="mydelete" onClick="">删除此账户</a></span></li>
						<li><span><a href="${pageContext.request.contextPath }/user/logout">退出登录</a></span></li>
					</ul>
					</div>
				</li>
				<li><span><a href="${pageContext.request.contextPath }/seller/goodList"><i class="fa fa-user" aria-hidden="true" style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;商品管理</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
				<li><span><a href="${pageContext.request.contextPath }/seller/orderList"><i class="fa fa-history" aria-hidden="true"  style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;我的订单</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
			</ul>
		</div>
	</div>
	<h3 style="text-align:center">完善个人信息</h3>
	<div class="mycontainer">
		<form class="form-horizontal">
		  <div class="form-group">
		    <label for="gender" class="col-sm-2 control-label">性  别</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="gender" placeholder="请输入男士或女士">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="phone" class="col-sm-2 control-label">手机号</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="phone" placeholder="请输入11位有效手机号">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="address" class="col-sm-2 control-label">所在地址</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="address" placeholder="请输入您的地址">
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <button type="button" onclick="save(2)" class="btn btn-primary">保存</button>
		    </div>
		  </div>
		</form>
	</div>
	</c:if>
	<script src="${pageContext.request.contextPath }/js/canvas-nest.min.js"></script>
</body>
<script type="text/javascript">
	(function(w){
		
		var X = {};
		
		X.userdelete = function(){
			if(window.confirm("注意，此操作不可取消！！请确认是否删除账户")){
				document.querySelector(".mydelete").href="${pageContext.request.contextPath }/user/delete";
			}
		}
		
		X.save = function(e){
			
			var xhr = new XMLHttpRequest();		
			var method = "post";
			var url = "${pageContext.request.contextPath }/user/complete";
			xhr.open(method,url);
			xhr.onreadystatechange = function(){
				if(xhr.readyState===xhr.DONE){
					if(xhr.status==200){
						var result = xhr.responseText;
						if(result==="success"){
							var div = document.querySelector(".mycontainer");
							div.innerHTML = "<h4 align='center'>保存成功</h5>";
						}else{
							alert("保存失败,请重试！");
						}
					}
				}
				
			}
			xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
			var data="";
			if(e==1){
				var gender = document.querySelector("input[name=\"gender\"]");
				var phone = document.querySelector("input[name=\"phone\"]");
				var address1 = document.querySelector("input[name=\"address1\"]");
				var address2 = document.querySelector("input[name=\"address2\"]");
				var address3 = document.querySelector("input[name=\"address3\"]");
				data = "src=1&gender="+gender.value+"&phone="+phone.value+"&address1="+address1.value+"&address2="+address2.value+"&address3="+address3.value;
			}else if(e==2){
				var gender = document.querySelector("input[name=\"gender\"]");
				var phone = document.querySelector("input[name=\"phone\"]");
				var address = document.querySelector("input[name=\"address\"]");
				data = "src=2gender="+gender.value+"&phone="+phone.value+"&address="+address.value;
			}
			data=data.trim();
			xhr.send(data);
		}
		
		
		w.X = X;
		
	})(window);
	
	
</script>
</html>