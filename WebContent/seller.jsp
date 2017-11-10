<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.taobao.entity.*" %>
<%@ page import="cn.taobao.dao.*" %>
<%@ page import="cn.taobao.service.*" %>

<%
	if(session.getAttribute("seller")==null){
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${seller.name }发布商品</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<style type="text/css">
	.mycontainer{margin:20px auto;}
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
	.upload {cursor: pointer;}
</style>
</head>
<script type="text/javascript" src="/scripts/org.malajava.ajax.js"></script>
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
		
		$.upload = function(e){
			var ele = e.previousElementSibling;
			if(ele.type=="file"){
				e.parentNode.removeChild(ele);
			}
			var input = document.createElement("input");
			input.type = "file";
			input.name = "upload";
			input.style.display = "none";
			
			e.parentNode.insertBefore(input,e);
			input.click();
			
			input.onchange = function(){
				var file = input.files[0];
				e.value = file.name;
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
				<li><span><a href="#"><i class="fa fa-history" aria-hidden="true"  style="color:#FF6905;font-size:14px;"></i>&nbsp;&nbsp;我的订单</a>&nbsp;&nbsp;&nbsp;<i class="fa fa-angle-down" aria-hidden="true"></i></span></li>
			</ul>
		</div>
	</div>	

	<div class="mycontainer">
		<form action="<%=request.getContextPath()%>/good/publish" method="post" enctype="multipart/form-data">
		
		  <div class="form-group col-sm-6 col-sm-offset-3">
		    <label for="goodTitle">输入商品名称</label>
		    <input type="text" class="form-control input" name="goodTitle" placeholder="">
		  </div>
		  <div class="form-group col-sm-6 col-sm-offset-3">
		    <label for="goodDesc">输入商品描述</label>
		    <textarea class="form-control input-" rows="6" name="goodDesc"></textarea>
		  </div>
		  <div class="form-group col-sm-6 col-sm-offset-3">
		    <label for="goodPrice">输入商品单价</label>
		    <input type="text" class="form-control input" name="goodPrice" placeholder="">
		  </div>
		  <div class="form-group col-sm-6 col-sm-offset-3">
		    <label for="goodPrice">为商品添加图片</label>
		    <input type="text" class="form-control upload" onclick="$.upload(this)" placeholder="点击选择图片...">
		  </div>
		  <div class="form-group col-sm-6 col-sm-offset-3">
		  <button type="submit" class="btn btn-info btn-lg btn-block" >发布</button>
		  </div>
		</form>
	</div>
</body>
</html>