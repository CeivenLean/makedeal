<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>欢迎登录</title>
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath }/images/favicon.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/normalize.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/login-style.css">
<script src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js"></script>
<style type="text/css">
.mycontainer{margin:80px auto;width:40%;padding:40px 20px;}
.error {font-size:10px;color:red;}
</style>
</head>
<body>
	<%-- <div class="mycontainer">
		<form class="form-horizontal" action="<%=request.getContextPath() %>/user/login" method="post">
		  <div class="form-group">
		    <label for="username" class="col-sm-2 control-label">用户名</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="username" placeholder="请输入用户名">
		      <div class="error">
		      ${sessionScope. usernameError}
		      <c:remove var="usernameError" scope="session"/>
		   	  </div>
		    </div>
		    
		  </div>
		  <div class="form-group">
		    <label for="password" class="col-sm-2 control-label">密  码</label>
		    <div class="col-sm-10">
		      <input type="password" class="form-control" name="password" placeholder="请输入密码">
		      <div class="error">
		      ${sessionScope. passwordError}
		      <c:remove var="passwordError" scope="session"/>
		      </div>
		    </div>
		    
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <div class="checkbox">
		        <label>
		          <input type="checkbox">记住密码
		        </label>
		      </div>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <button type="submit" class="btn btn-primary btn-lg btn-block">登录</button>
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <a href="${pageContext.request.contextPath }/regist.jsp">没有账号？点我注册</a>
		    </div>
		  </div>
		</form>
	</div> --%>
<div class="wrapper">
  <form class="login" action="${pageContext.request.contextPath}/user/login" method="post">
    <p class="title">欢迎登录</p>
    <input type="text" name="username" placeholder="请输入用户名" autofocus/>
    <i class="fa fa-user"></i>
	<div class="error">
		      ${sessionScope. usernameError}
		      <c:remove var="usernameError" scope="session"/>
	</div>
    <input type="password" name="password" placeholder="请输入密码" />
    <i class="fa fa-key"></i>
	<div class="error">
		      ${sessionScope. passwordError}
		      <c:remove var="passwordError" scope="session"/>
	</div>
	
	<input  style="width:60%; display:inline" type="text" name="imgCode" placeholder="请输入右图中的验证码">
	<span style="width:40%;"><img id="imgcode" alt="" src="${pageContext.request.contextPath }/imageCodeServlet" onClick="changeValidCode()"></span>
	<div class="error">
		      ${sessionScope. imgcodeError}
		      <c:remove var="imgcodeError" scope="session"/>
	</div>
	
	<script type="text/javascript">
	function changeValidCode(){
		var d = new Date().getTime();
		document.getElementById("imgcode").src="${pageContext.request.contextPath }/imageCodeServlet?d="+d
	}
	</script>
	<br>
    <a href="#">忘记密码?</a><a style="float:right" href="${pageContext.request.contextPath }/regist.jsp">没有账号？点我注册</a>
    <button type="submit">
      <span class="state">登录</span>
    </button>
  </form>
</div>

<script src="${pageContext.request.contextPath }/js/canvas-nest.min.js"></script>
</body>
</html>