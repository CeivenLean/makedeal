<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎注册</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/favicon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<style type="text/css">
	body {color:white;background: url("images/login-bg.jpg") fixed ;}
	.mycontainer{margin:0 auto;width:40%;padding:10px 10px;}
	input.form-control{background-color:rgba(255,255,255,0.3); }  
	.btn {margin-top:15px;}
	.prompt {padding-left:4px;height:4px;font-size:12px;}
	a {color:white;}
	a:hover{color:white;}
</style>
</head>
<script type="text/javascript">
	(function(w){
		var X = {};
		var emailcode="";
		X.sendCode = function(e){
			var username = document.querySelector("input[name='username']");
			var name = username.value+"";
			var useremail = document.querySelector("input[name='email']");
			var email = useremail.value+"";
			if(""==email){
				alert("请先输入邮箱！");
				return ;
			}
			var xhr = new XMLHttpRequest();
			xhr.open("post","${pageContext.request.contextPath}/genEmailCode");
			xhr.onreadystatechange = function(){
				if(xhr.readyState===xhr.DONE){
					if(xhr.status==200){
						var text = xhr.responseText ;
						if(text!="null"){
							emailcode = text;
							e.value="验证码发送成功";
							e.disabled="disabled";
						}else{
							e.value="发送失败";
						}
					}
				}
			}
			xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
			var data = "data="+"{'name':'"+name+"','email':'"+email+"'}";
			xhr.send(data);
			
		}
		
		X.emailCheck = function(e){
			var content = e.value;
			if(content.indexOf("@")!=-1&&content.indexOf(".")!=-1&&content.indexOf(".")-content.indexOf("@")>1){
				
				var div = e.nextElementSibling;
				e.style.borderColor = "#008000";
				div.innerHTML = "<i class='fa fa-check' aria-hidden='true'></i>" ;
				div.style.color = "#008000";
				document.querySelector(".btn").disabled="";
				document.querySelector(".sendCode").disabled = "";
				
			}else{
				var div = e.nextElementSibling;
				e.style.borderColor = "#ff0000";
				div.style.color = "#ff0000";
				div.innerHTML = "<i class='fa fa-exclamation-triangle' aria-hidden='true'></i>" + "邮箱格式不正确！" ;
				document.querySelector(".btn").disabled="disabled";
				document.querySelector(".sendCode").disabled = "disabled";

			}
		}
		X.emailCodeCheck = function(e){
			if(emailcode!=""){
				emailcode = emailcode.trim();
				var content = e.value;
				if(content==""){
					var div = e.nextElementSibling;
					e.style.borderColor = "#ff0000";
					div.style.color = "#ff0000";
					div.innerHTML = "<i class='fa fa-exclamation-triangle' aria-hidden='true'></i>" + "请输入邮箱中的验证码！" ;
					document.querySelector(".btn").disabled="disabled";
					document.querySelector(".sendCode").disabled = "disabled";
				}else if(emailcode==content){
					var div = e.nextElementSibling;
					e.style.borderColor = "#008000";
					div.innerHTML = "<i class='fa fa-check' aria-hidden='true'></i>" ;
					div.style.color = "#008000";
					document.querySelector(".btn").disabled="";
					document.querySelector(".sendCode").disabled = "";
				}else{
					var div = e.nextElementSibling;
					e.style.borderColor = "#ff0000";
					div.style.color = "#ff0000";
					div.innerHTML = "<i class='fa fa-exclamation-triangle' aria-hidden='true'></i>" + "对不起，验证码不正确！请仔细检查邮箱" ;
					document.querySelector(".btn").disabled="disabled";
					document.querySelector(".sendCode").disabled = "disabled";
				}
			}
		}
		
		
		X.userCheck = function(e){
			//第一步，创建一个XMLHttpRequest对象的实例
			var xhr = new XMLHttpRequest();
			//第二步，建立连接(参数1为请求方式post|get，参数2为servlet的url路径)
			xhr.open("post","${pageContext.request.contextPath}/user/check");
			//第三步，设置对readyState属性值的监听函数(回调函数)
			xhr.onreadystatechange = function(){
				if(xhr.readyState===xhr.DONE){
					if(xhr.status==200){
						var text = xhr.responseText ;
						var o = eval( "(" + text + ")");
						var prompt = document.querySelector( ".username-prompt" );
						if(o.success){
							e.style.borderColor = "#008000";
							prompt.style.color = "#008000";
							prompt.innerHTML = "<i class='fa fa-check' aria-hidden='true'></i>" + o.message ;
							
							document.querySelector(".btn").disabled="";
						}else{
							e.style.borderColor = "#ff0000";
							prompt.style.color = "#ff0000";
							prompt.innerHTML = "<i class='fa fa-exclamation-triangle' aria-hidden='true'></i>" + o.message ;
							
							document.querySelector(".btn").disabled="disabled";
						}
					}
				}
			}
			//第四步，设置请求头[必须格式]
			xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
			//第五步，发送请求
			var data = "username="+e.value;
			xhr.send(data);
		}
		
		
		
		X.inputCheck = function(e){
			var content = e.value;
			if(content.trim().length==0){
				
				var div = e.nextElementSibling;
				e.style.borderColor = "#ff0000";
				div.style.color = "#ff0000";
				div.innerHTML = "<i class='fa fa-exclamation-triangle' aria-hidden='true'></i>" + "输入不能为空！" ;
				
				document.querySelector(".btn").disabled="disabled";
				
			}else{
				var div = e.nextElementSibling;
				div.innerHTML = "<i class='fa fa-check' aria-hidden='true'></i>" ;
				div.style.color = "#008000";
				
				document.querySelector(".btn").disabled="";

			}
		}
		
		X.pwdCheck = function(e){
			var pwd = document.querySelector(".pwd");
			var con = document.querySelector(".con");
			if(pwd.value.trim().length==0||con.value.trim().length==0){
				if(e.value.trim().length==0){
					var div = e.nextElementSibling;
					e.style.borderColor = "#ff0000";
					div.style.color = "#ff0000";
					div.innerHTML = "<i class='fa fa-exclamation-triangle' aria-hidden='true'></i>" + "输入不能为空！" ;
					document.querySelector(".btn").disabled="disabled";
				}
			}else{
				if(pwd.value.trim()!=con.value.trim()){
					pwd.style.borderColor = "#ff0000";
					con.style.borderColor = "#ff0000";
					document.querySelector(".userpassword-prompt").style.color = "#ff0000";
					document.querySelector(".confirmpassword-prompt").style.color = "#ff0000";
					document.querySelector(".userpassword-prompt").innerHTML = "<i class='fa fa-exclamation-triangle' aria-hidden='true'></i>" + "两次输入的密码不一致！" ;
					document.querySelector(".confirmpassword-prompt").innerHTML = "<i class='fa fa-exclamation-triangle' aria-hidden='true'></i>" + "两次输入的密码不一致！" ;
					
					document.querySelector(".btn").disabled="disabled";
				}else{
					pwd.style.borderColor = "#008000";
					con.style.borderColor = "#008000";
					document.querySelector(".userpassword-prompt").style.color = "#008000";
					document.querySelector(".confirmpassword-prompt").style.color = "#008000";
					document.querySelector(".userpassword-prompt").innerHTML = "<i class='fa fa-check' aria-hidden='true'></i>" ;
					document.querySelector(".confirmpassword-prompt").innerHTML = "<i class='fa fa-check' aria-hidden='true'></i>" ;
					
					document.querySelector(".btn").disabled="";
				}
			}
		}
		
		w.X = X;
	})(window);
</script>
<body>
<div style="width:100%; height:100%; background:rgba(4, 40, 68, 0.1);">
	<div class="mycontainer">
		<form id="form1" class="form-horizontal" action="<%=request.getContextPath()%>/user/regist" method="post">
		<h3 style="text-align:center;">欢迎注册</h3>
		  <div class="form-group">
		    <label for="username" class="col-sm-2 control-label">用户名</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="username" onblur="X.userCheck(this)" placeholder="请输入用户名">
		   	  <div class="prompt username-prompt"></div>
		    </div>
		  </div>
		  <div class="prompt"></div>
		  <div class="form-group">
		    <label for="userpassword" class="col-sm-2 control-label">密码</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control pwd" name="userpassword" onblur="X.pwdCheck(this)" placeholder="请输入密码">
		      <div class="prompt userpassword-prompt"></div>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="confirmpassword" class="col-sm-2 control-label">确认密码</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control con" name="confirmpassword" onblur="X.pwdCheck(this)" placeholder="请确认密码">
		      <div class="prompt confirmpassword-prompt"></div>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="email" class="col-sm-2 control-label">邮箱</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control con" name="email" onblur="X.emailCheck(this)" placeholder="请输入邮箱">
		      <div class="prompt email-prompt"></div>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <input type="text" class="form-control con" name="emailCode" onblur="X.emailCodeCheck(this)" placeholder="请输入您邮箱中的验证码">
		      <div class="prompt emailCode-prompt"></div><br>
		      <input onclick="X.sendCode(this)" class="sendCode" type="button" value="点出获取验证码">
		    </div>
		  </div>
		  <hr>
		  <p>根据相关规定，客户必须实名认证，请在以下输入您的真实信息。</p><br>
		  <div class="form-group">
		    <label for="userid" class="col-sm-2 control-label">身份证号</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="userid" onblur="X.inputCheck(this)" placeholder="请输入您的身份证号">
		      <div class="prompt userid-prompt"></div>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="name" class="col-sm-2 control-label">真实姓名</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="name" onblur="X.inputCheck(this)" placeholder="请输入您的真实姓名">
		      <div class="prompt name-prompt"></div>
		    </div>
		  </div>
		  <div class="radio col-sm-5 col-sm-offset-2">
		  <label>
		    <input type="radio" name="role" value="买家" checked>
		    我是买家
		  </label>
		</div>
		<div class="radio col-sm-5">
		  <label>
		    <input type="radio" name="role" value="卖家">
		    我是卖家
		  </label>
		</div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <button type="submit" class="btn btn-primary btn-lg btn-block">注册</button>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-8 col-sm-4">
		      <a href="${pageContext.request.contextPath }/login.jsp">已有账号？点我登录</a>
		    </div>
		  </div>
		</form>
	</div>
</div>

<script src="${pageContext.request.contextPath }/js/canvas-nest.min.js"></script>
</body>
</html>