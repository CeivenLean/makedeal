<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="cn.taobao.entity.*" %>
<%@ page import="cn.taobao.servlet.*" %>
<%@ page import="cn.taobao.util.*" %>
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
	.good_container .table {margin:20px auto; width:60%;}
	.page-container {width:30%;heigth:20px;margin:20px auto;text-align:center;position:fixed;bottom:50px;left:35%;}
	.mypage {text-align:center;}
	.pagelinkstyle1 , .pagelinkstyle{text-decoration:none;padding:0px 5px;display:inline-block;background-color:#dedede;margin:0px 10px;}
	
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
	
	function addshoppingcart(e,key){
		var xhr = new XMLHttpRequest();
		var method = "post";
		var url = "${pageContext.request.contextPath }/user/shoppingcart";
		xhr.open(method,url);
		xhr.onreadystatechange = function(){
			if(xhr.readyState===xhr.DONE){
				if(xhr.status==200){
					var result = xhr.responseText;
					var td = e.parentNode;
					var p = document.createElement("p");
					p.style.color = "#ff0000";
					td.appendChild(p);
					if(result=="1"){
						p.innerHTML = "添加成功";
					}else{
						p.innerHTML = "添加失败,请勿重复添加";
					}
				}
			}
		}
		xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
		var data = "goodId="+key;
		xhr.send(data);
		
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
				<li><span><a href="#"><i class="fa fa-history" aria-hidden="true"  style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;我的订单</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
			</ul>
		</div>
	</div>
	
	<div class="good_container">
		<table class='table'>
			<tr>
				<td>小图</td>
				<td>卖家</td>
				<td>商品名称</td>
				<td>商品描述</td>
				<td>价格</td>
				<td></td>
			</tr>
			<%	
				Object v = session.getAttribute("goodsMap");
				Map<Integer,Good> map = (Map<Integer,Good>)v;
				Set<Integer> set = map.keySet();
				for(Integer key:set) {
					Good g = map.get(key);
					session.setAttribute("good", g);
					out.print("<tr>");
					out.print("<td>");
					out.print("<img src='"+request.getContextPath()+"/images/goods/"+g.getGoodId()+".jpg' width='80px' height='120px'>");
					out.print("</td>");
					out.print("<td>");
					out.print(g.getSellerName());
					out.print("</td>");
					out.print("<td>");
					out.print(g.getGoodTitle());
					out.print("</td>");
					out.print("<td>");
					out.print(g.getGoodDesc());
					out.print("</td>");
					out.print("<td>");
					out.print(g.getGoodPrice());
					out.print("</td>");
					out.print("<td>");
					out.print("<a class='btn btn-default' href='javascript:void(0)' onclick='addshoppingcart(this,"+key+")'>加入购物车</a>");
					out.print("</td>");
					out.print("</tr>");
				}	
			%>
		</table>
	</div>
	<p:page
		actionName="${pageContext.request.contextPath }/good/list"
		pageIndex="${pageUtil.pageIndex }"
		pageSize="${pageUtil.pageSize }"
		recordCount="${pageUtil.recordCount }"
		pageNums="${pageUtil.pageNums }"
		
	/>

	
</body>
</html>