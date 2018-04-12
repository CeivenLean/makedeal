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
	.mycontainer a{text-decoration:none;}
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
	
		<h3 style="text-align:center">所有商品</h3>
		<div class="container-fluid">
		<table id="table" class="table">
			<tr>
					<td class='col-lg-1'>图片</td>
					<td class='col-lg-2'>标题</td>
					
					<td class='col-lg-5'>描述</td>
					<td class='col-lg-1'>价格</td>
					<td class='col-lg-2'>类别</td>
					<td class='col-lg-1'>状态</td>
					
			</tr>
			<c:forEach var="map" items="${goodMap }">
				<tr>
					<td class='col-lg-1'><a href="${pageContext.request.contextPath}/good/detail?id=${map.value.goodId }"><img width="60px" height="60px" src="${pageContext.request.contextPath}/images/goods/${map.value.goodId }.jpg"></a></td>
					<td class='col-lg-2'><a href="${pageContext.request.contextPath}/good/detail?id=${map.value.goodId }">${fn:length(map.value.goodTitle)<30?map.value.goodTitle:fn:substring(map.value.goodTitle,0,30) }</a></td>
					<td class='col-lg-5'><a href="${pageContext.request.contextPath}/good/detail?id=${map.value.goodId }">${fn:length(map.value.goodDesc)<80?map.value.goodDesc:fn:substring(map.value.goodDesc,0,80) }</a></td>
					<td class='col-lg-1'><a href="${pageContext.request.contextPath}/good/detail?id=${map.value.goodId }">${map.value.goodPrice }</a></td>
					<td class='col-lg-2'><a href="${pageContext.request.contextPath}/good/detail?id=${map.value.goodId }">${map.value.sort1 }－${map.value.sort2 }－${map.value.sort3 }</a></td>
					<td class='col-lg-1'><a href="${pageContext.request.contextPath}/good/detail?id=${map.value.goodId }"><c:if test="${map.value.status==0 }">已停售</c:if><c:if test="${map.value.status==1 }">在售</c:if></a></td>
				</tr>
			</c:forEach>
		</table>
		<div style="height:40px;margin:20px auto; width:88%;position:absolute;bottom:15%;">
			<div class="gridItem" style="padding: 5px; width: 250px; float: left; text-align: left; height: 40px; font-size: 15px;" > 
		        共有 <span id="spanTotalInfor"></span> 条记录     
		        当前第<span id="spanPageNum"></span>页     
		        共<span id="spanTotalPage"></span>页
		  </div>
		  <div class="gridItem" style="margin-left:130px;  padding: 5px; width: 400px; float: left; text-align: center; height: 40px; vertical-align: middle; font-size: 15px;">   
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
		</div>
	</div>
		
	</div>

	<a title="点击添加新商品" style="text-decoration:none;cursor:pointer;color:white;" href="${pageContext.request.contextPath }/publish.jsp"><div style="box-shadow:0px 2px 2px 0px;background-color:red;border-radius:50px;display:block;width:60px; text-align:center;height:60px;line-height:60px;position:fixed;right: 48%;bottom: 30px; "><i style="height:60px;line-height:60px;font-size:18px;" class="fa fa-plus"></i></div></a>
</body>
</html>