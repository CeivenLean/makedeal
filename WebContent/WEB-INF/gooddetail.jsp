<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
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
	
	.input-group input {border:none;}
	.input-group button {border:none;}
	.input-group button {color:white;background-color:red;}
	.input-group button:hover {color:white;background-color:red;}
	.input-group {border:1px solid red;}
	.input-group input:focus {border:none;box-shadow:none;}
	
	.good-container {padding:10px 2%;margin:0px auto;width:88%;height:400px;}
	.good-pic {float:left;margin-right:5%;display:inline-block;width:22%;margin-top:2%;height:98%;background-color:red;}
	.good-info {float:left;margin-right:2%;display:inline-block;width:50%;height:100%;}
	.seller-info {float:left;display:inline-block;width:20%;line-height:100%;height:100%;}
	.seller-info p{font-size:15px;text-align:center;height:30px;line-height:30px;display:block;margin:10px auto;}
	
	.good-info .mycount {cursor:pointer;margin:0px 0px;display:inline-block; width:28px;height:28px;background-color:#dedede;line-height:28px;text-align:center}
	.good-info input[type='text'] {width:50px;height:28px;line-height:28px;;margin:0px -4px;border:none; text-align:center;}
	.good-info input[type='text']:focus {border:none;box-shadow:none;}
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
		
		
		w.X = X;
	})(window);
</script>
<script type="text/javascript">
function addshoppingcart(e){
	var count = document.querySelector("#goodCount");
	var value = count.value;
	var xhr = new XMLHttpRequest();
	var method = "post";
	var url = "${pageContext.request.contextPath }/user/shoppingcart?goodId=${good.goodId }&goodCount="+value;
	xhr.open(method,url);
	xhr.onreadystatechange = function(){
		if(xhr.readyState===xhr.DONE){
			if(xhr.status==200){
				var result = xhr.responseText;
				if(result=="1"){
					e.firstElementChild.innerHTML = "添加成功" ;
				}else{
					e.firstElementChild.innerHTML = "添加失败，请重试";
				}
			}
		}
	}
	xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
	xhr.send();
	
}

function buyThisOne(){
	document.querySelector("#form2").submit();
}
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
	
	<div class="container-fluid">
	    <form action="${pageContext.request.contextPath }/good/list" method="post">
		    <div  class="row">
			  <div  class="col-lg-6 col-lg-offset-3">
			    <div class="input-group">
			      <input type="text" class="form-control" name="search"  onfocus="inputclear()" placeholder="请输入关键字..">
			      <span class="input-group-btn">
			        <button class="btn btn-default" type="submit" value="搜索">搜索</button>
			      </span>
			    </div>
			  </div>
			</div>
	    </form>
	</div>
	
	<p style="margin-left:6%;margin-top:60px;">${good.sort1 }&nbsp;>>&nbsp;${good.sort2 }&nbsp;>>&nbsp;${good.sort3 }</p>
	<div class="good-container">
		<form id="form2" action="${pageContext.request.contextPath }/user/orderFromDetail" method="post">
		<input type="hidden" name="goodId" value="${good.goodId }">
		
		<div class="good-pic">
			<img alt="" src="${pageContext.request.contextPath }/images/goods/${good.goodId }.jpg" width="280px" height="280px">
		</div>
		<div class="good-info">
			<div style="height:66%">
			<h4>${good.goodTitle }</h4><hr>
			
			<h5>${good.goodDesc }</h5><h6>[上架日期]${good.publishDate }</h6><hr>
			
			<p>价格<span style="margin-left:24px;font-size:24px;color:#f40;font-family:verdana,arial;font-weight:700">&yen;${good.goodPrice }</span></p><hr>
			</div>
			
			<div  style="height:34%">
				<p>数量<span style="margin-left:24px;">
						<i class='mycount' onclick="increCount(this)">-</i>
						<input name="goodCount" id="goodCount" type="text" value="1" maxlength="8" title="请输入购买量">
						<i class='mycount' onclick="decreCount(this)">+</i>
					</span>
				</p>
				<script>
					function increCount(e){
						var input = e.nextElementSibling;
						var value = input.value;
						value = value*1;
						if(value==1){
							e.style.cursor="not-allowed";
							input.value = 1;
						}else{
							value = value -1;
							if(value==1){
								e.style.cursor="not-allowed";
							}
							input.value = value;
						}
					}
					function decreCount(e){
						var input = e.previousElementSibling;
						var value = input.value;
						value = value*1;
						value = value +1;
						input.value = value;
						if(value>1){
							e.previousElementSibling.previousElementSibling.style.cursor="pointer";
						}
					}
				</script>
				<div onclick="buyThisOne()"  style="margin-top:20px;cursor:pointer;float:left;width:136px;height:40px;line-height:40px;text-align:center;border-color: #F0CAB6;background-color: #FFD9BC;color: #E5511D;"><a style="text-decoration:none;inline-block;width:136px;height:40px;line-height:40px;text-align:center;border-color: #F0CAB6;background-color: #FFD9BC;color: #E5511D;">立即购买</a></div>
				<div onclick="addshoppingcart(this)" style="margin-top:20px;margin-left:10px;cursor:pointer;float:left;width:180px;height:40px;line-height:40px;text-align:center;color: #FFF;border-color: #F40;background: #F40;"><a style="text-decoration:none;inline-block;width:180px;height:40px;line-height:40px;text-align:center;color: #FFF;border-color: #F40;background: #F40;">加入购物车</a></div>				
			</div>
		</div>
		<div class="seller-info">
			<p>------------卖家信息------------</p>
			<p>昵称：${seller.name }</p>
			<p>等级：${seller.level }</p>
			<p>性别：${seller.gender }</p>
			<p>手机号：${seller.phone }</p>
			<p>所在地：${seller.address }</p>
			<p>邮箱：${seller.email }</p>
			<p><h6 style="text-align:center;">注册日期：${seller.registDate }</h6></p>
		</div>
		</form>
	</div>

</body>
</html>