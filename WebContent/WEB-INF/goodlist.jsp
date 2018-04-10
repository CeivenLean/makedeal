<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="cn.shop.entity.*" %>
<%@ page import="cn.shop.servlet.*" %>
<%@ page import="cn.shop.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="p" uri="http://cn.taobao/pagetag" %>
<%
	if(session.getAttribute("buyer")==null){
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询结果</title>

<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/product.css">
<style type="text/css">
	* {margin:0px 0px;padding:0px 0px;font-family:arial;} 
	.mynav-left {float:left;line-height:35px;font-family:arial;}
	.mynav-right {width:88%; margin:0px auto;background-color:cyan;}
	.mynav .right>li{float:right;list-style:none; margin-left:30px;font-size:10px;line-height:35px;font-family:arial;}
	.myhidden {display:none;}
	.abc li{list-style:none;font-size:8px;margin-bottom:-6px;font-family:arial;}
	.mynav .left{float:left;list-style:none;}
	.mynav a {text-decoration:none; color:black;}
	.mynav span:hover {display:block; background-color:#dedede;}
	.mynav {width:100%;height:35px; background-color:#f5f5f5;margin-bottom:20px;border:0;margin-top:-10px;}
	.good_container{width:90%;margin:20px auto;}
	.good_container .table {margin:20px auto; width:80%;}
	.page-container {width:100%;heigth:20px;margin:420px 0 20px 0;position:relative;text-align:center;}
	.mypage {text-align:center;}
	.good-list {background-color:cyan;width:88%;height:auto;}
	.good-list>div {background-color:green;width:32%;}	
	
	.input-group input {border:none;}
.input-group button {border:none;}
.input-group button {color:white;background-color:red;}
.input-group button:hover {color:white;background-color:red;}
.input-group {border:1px solid red;}

.input-group input:focus {border:none;box-shadow:none;}
	
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
	
	/* function addshoppingcart(e,key){
		var xhr = new XMLHttpRequest();
		var method = "post";
		var url = "${pageContext.request.contextPath }/user/shoppingcart";
		xhr.open(method,url);
		xhr.onreadystatechange = function(){
			if(xhr.readyState===xhr.DONE){
				if(xhr.status==200){
					var result = xhr.responseText;
					var msg = e.nextElementSibling;
					msg.style.color = "#ff0000";
					if(result=="1"){
						msg.innerHTML = "添加成功";
					}else{
						msg.innerHTML = "请勿重复添加";
					}
				}
			}
		}
		xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
		var data = "goodId="+key;
		xhr.send(data);
		
	} */
function addshoppingcart(e,goodId){
		
		var xhr = new XMLHttpRequest();
		var method = "post";
		var url = "${pageContext.request.contextPath }/user/shoppingcart?goodId="+goodId+"&goodCount=1";
		xhr.open(method,url);
		xhr.onreadystatechange = function(){
			if(xhr.readyState===xhr.DONE){
				if(xhr.status==200){
					var result = xhr.responseText;
					if(result=="1"){
						e.innerHTML = "添加成功" ;
					}else{
						e.innerHTML = "添加失败，请重试";
					}
				}
			}
		}
		xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
		xhr.send();
		
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
	  
	<%-- <div class="good_container">
		
		<table class='table'>
			<tr><td style="border:0">>>${sort }</td></tr>
			<tr>
				<th>小图</th>
				<th>卖家</th>
				<th>商品名称</th>
				<th>商品描述</th>
				<th>价格</th>
				<th></th>
			</tr>
			<c:forEach var="m" items="${pageUtil.datas }">
				<tr>
					<td>
						<a href="${pageContext.request.contextPath }/good/detail?id=${m.value.goodId }"><img src="${pageContext.request.contextPath }/images/goods/${m.value.goodId }.jpg" width="80px" height="120px"></a>
					</td>
					<td><a href="${pageContext.request.contextPath }/good/detail?id=${m.value.goodId }">${m.value.sellerName }</a></td>
					<td><a href="${pageContext.request.contextPath }/good/detail?id=${m.value.goodId }">${m.value.goodTitle }</a></td>
					<td><a href="${pageContext.request.contextPath }/good/detail?id=${m.value.goodId }">${m.value.goodDesc }</a></td>
					<td>${m.value.goodPrice }</td>
					<td>
						<a class="btn btn-default" onclick="addshoppingcart(this,${m.key})">加入购物车</a>
						<p class="msg"></p>
					</td>
				</tr>
			</c:forEach>	
		</table>
	</div> --%>
	
	<div class="good_container">
	<div class="product-list">
		 <div style="margin-left:3%;"><h5>搜索结果：</h5>
        <ul>
            <c:forEach var="m" items="${pageUtil.datas }" >
                <li class="cell-3">
                    <div class="inner"><a href="${pageContext.request.contextPath}/good/detail?id=${m.value.goodId }">
                        <p class="pic">
                            
                                <img src="${pageContext.request.contextPath}/images/goods/${m.value.goodId }.jpg" height="200px" width="200px" border="0" alt="商品图片">
                            
                        </p>
                        <p class="pro_name">
                            ${m.value.goodTitle }
                        <p/></a>
                        <h5 class="pro_sellingPrice">商家：${m.value.sellerName }</h5>
                        <h6 class="pro_memberPrice">单价：<span style="color:red;font-size:20px;">${m.value.goodPrice}</span><span onclick="addshoppingcart(this,${m.value.goodId})" style="cursor:pointer;height:30px;line-height:30px;padding:2px 4px;float:right;border:1px solid red;background-color:red;color:#fff"><i class="fa fa-shopping-cart" aria-hidden="true" style="color:#FFF;font-size:20px;"></i>加入购物车</span> </h6>
                    </div>
                </li>

            </c:forEach>
        </ul>
        </div>
	</div>
	</div>
	
	
	<%-- <div style="width:100%;">
		<div class="good-list">
		<table>
			<c:forEach var="m" items="${pageUtil.datas }">
			
				<tr>
					<td rowspan="4"><img src="${pageContext.request.contextPath }/images/goods/${m.value.goodId }.jpg" width="80px" height="120px"></td>
				</tr>
				<tr><td>${m.value.goodTitle }</td></tr>
				<tr><td>${m.value.goodDesc }</td></tr>
				<tr>
					<td>${m.value.sellerName }</td>
					<td>${m.value.goodPrice }</td>
				</tr>
			</c:forEach>
			</table>
		</div>
	</div> --%>
	
	<p:page
		actionName="${ actionName}"
		pageIndex="${pageUtil.pageIndex }"
		pageSize="${pageUtil.pageSize }"
		recordCount="${pageUtil.recordCount }"
		pageNums="${pageUtil.pageNums }"
		
	/>

	
</body>
</html>