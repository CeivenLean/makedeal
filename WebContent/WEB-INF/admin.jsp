<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="cn.taobao.entity.*" %>
<%@ page import="cn.taobao.service.*" %>
<%@ page import="cn.taobao.servlet.*" %>
<%@ page import="cn.taobao.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>XXX后台管理</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/font-awesome/css/font-awesome.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/css/sidebar-menu.css">
<style type="text/css">
.main-sidebar{
	position: fixed;
	top: 0;
	left: 0;
	height: 100%;
	min-height: 100%;
	width: 17%;
	z-index: 810;
	background-color: #222d32;
 }
.right-content {margin-left:17%; width:83%; height:100%;background-color:red;}
.right-content>div {display:none; margin:7% 5%;}
td a {cursor:pointer;}
</style>
</head>
<script text="javascript">
	function buyerShow(){
		document.querySelector(".seller-content").style.display="none";
		document.querySelector(".good-content").style.display="none";
		document.querySelector(".buyer-content").style.display="block";
	}
	function sellerShow(){
		document.querySelector(".buyer-content").style.display="none";
		document.querySelector(".good-content").style.display="none";
		document.querySelector(".seller-content").style.display="block";
	}
	function goodShow(){
		/* document.querySelector(".buyer-content").style.display="none";
		document.querySelector(".seller-content").style.display="none";
		document.querySelector(".good-content").style.display="block"; */
		
	}
</script>
<body>
<aside class="main-sidebar">
<section  class="sidebar">
	<ul class="sidebar-menu">
	  <li class="header">管理员面板</a></li>
	  <li class="treeview">
		<a href="javascript:void(0)">
		  <i class="fa fa-dashboard"></i> <span>用户管理</span> <i class="fa fa-angle-down pull-right"></i>
		</a>
		<ul class="treeview-menu">
		  <li onclick="buyerShow()"><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> 买家操作</a></li>
		  <li onclick="sellerShow()"><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> 卖家操作</a></li>
		</ul>
	  </li>
	  <li class="treeview">
		<a href="javascript:void(0)">
		  <i class="fa fa-files-o"></i>
		  <span>商品管理</span>
		  <span class="label label-primary pull-right">4</span>
		</a>
		<ul class="treeview-menu" style="display: none;">
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> 上架商品</a></li>
		  <li onclick="goodShow()"><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> 下架商品</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> 修改库存</a></li>
		  <li class=""><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> 分类管理</a>
		  </li>
		</ul>
	  </li>
	  <li>
		<a href="javascript:void(0)">
		  <i class="fa fa-th"></i> <span>订单日志</span>
		 <!--  <small class="label pull-right label-info">new</small> -->
		</a>
	  </li>
	  <li class="treeview">
		<a href="javascript:void(0)">
		  <i class="fa fa-pie-chart"></i>
		  <span>Charts</span>
		  <i class="fa fa-angle-down pull-right"></i>
		</a>
		<ul class="treeview-menu">
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> ChartJS</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Morris</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Flot</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Inline charts</a></li>
		</ul>
	  </li>
	  <li class="treeview">
		<a href="javascript:void(0)">
		  <i class="fa fa-laptop"></i>
		  <span>UI Elements</span>
		  <i class="fa fa-angle-down pull-right"></i>
		</a>
		<ul class="treeview-menu">
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> General</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Icons</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Buttons</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Sliders</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Timeline</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Modals</a></li>
		</ul>
	  </li>
	  <li class="treeview">
		<a href="javascript:void(0)">
		  <i class="fa fa-edit"></i> <span>Forms</span>
		  <i class="fa fa-angle-down pull-right"></i>
		</a>
		<ul class="treeview-menu">
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> General Elements</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Advanced Elements</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Editors</a></li>
		</ul>
	  </li>
	  <li class="treeview">
		<a href="javascript:void(0)">
		  <i class="fa fa-table"></i> <span>Tables</span>
		  <i class="fa fa-angle-down pull-right"></i>
		</a>
		<ul class="treeview-menu">
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Simple tables</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Data tables</a></li>
		</ul>
	  </li>
	  <li>
		<a href="javascript:void(0)">
		  <i class="fa fa-calendar"></i> <span>Calendar</span>
		  <small class="label pull-right label-danger">3</small>
		</a>
	  </li>
	  <li>
		<a href="javascript:void(0)">
		  <i class="fa fa-envelope"></i> <span>Mailbox</span>
		  <small class="label pull-right label-warning">12</small>
		</a>
	  </li>
	  <li class="treeview">
		<a href="javascript:void(0)">
		  <i class="fa fa-folder"></i> <span>Examples</span>
		  <i class="fa fa-angle-down pull-right"></i>
		</a>
		<ul class="treeview-menu">
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Invoice</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Profile</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Login</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Register</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Lockscreen</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> 404 Error</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> 500 Error</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Blank Page</a></li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Pace Page</a></li>
		</ul>
	  </li>
	  <li class="treeview">
		<a href="javascript:void(0)">
		  <i class="fa fa-share"></i> <span>Multilevel</span>
		  <i class="fa fa-angle-down pull-right"></i>
		</a>
		<ul class="treeview-menu">
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Level One</a></li>
		  <li>
			<a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Level One <i class="fa fa-angle-down pull-right"></i></a>
			<ul class="treeview-menu">
			  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Level Two</a></li>
			  <li>
				<a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Level Two <i class="fa fa-angle-down pull-right"></i></a>
				<ul class="treeview-menu">
				  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Level Three</a></li>
				  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Level Three</a></li>
				</ul>
			  </li>
			</ul>
		  </li>
		  <li><a href="javascript:void(0)"><i class="fa fa-circle-o"></i> Level One</a></li>
		</ul>
	  </li>
	 <!--  
	  <li><a href="javascript:void(0)"><i class="fa fa-book"></i> <span>Documentation</span></a></li>
	  <li class="header">LABELS</li>
	  <li><a href="javascript:void(0)"><i class="fa fa-circle-o text-red"></i> <span>Important</span></a></li>
	  <li><a href="javascript:void(0)"><i class="fa fa-circle-o text-yellow"></i> <span>Warning</span></a></li>
	  <li><a href="javascript:void(0)"><i class="fa fa-circle-o text-aqua"></i> <span>Information</span></a></li>
	  -->
	</ul>
  </section>
 </aside>

<script src="${pageContext.request.contextPath }/js/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/js/sidebar-menu.js"></script>
<script>
$.sidebarMenu($('.sidebar-menu'))
</script>
<!-- <script type="text/javascript">
	function modifysave(e){
		var tr = e.parentNode.parentNode;
		var tds = tr.childNodes;
		var xhr = new XMLHttpRequest();
		xhr.open("post","${pageContext.request.contextPath}/user/good/modifysave");
		xhr.onreadystatechange = function(){
			if(xhr.readyState===xhr.DONE){
				for(var i=3;i<8;i++){
       				var input = tds[i].firstElementChild;
					var value = input.value;
					if(i<7){tds[i].innerHTML = value;}
					/* else if(i=6){tds[i].innerHTML = "";} 这里加分类select,做这个时要把上面i<7改成i<6*/
					else{tds[i].innerHTML="<a onclick=\"modify(this)\">修改</a><a>下架</a>";}
				}
				
			}
			
		}
		xhr.setRequestHeader("content-type","application/x-www-form-urlencoded");
		
		var data = "data="+"{\"goodId\":"+"\""+tds[1].innerHTML+"\",\"goodTitle\":"+"\""+tds[3].firstElementChild.value+"\",\"goodDesc\":"+"\""+tds[4].firstElementChild.value+"\",\"goodPrice\":"+"\""+tds[5].firstElementChild.value+"\"}";
		console.log(data);
		xhr.send(data);
		
	}	
</script> -->

<div class="right-content">
	<jsp:include page='${pageContext.request.contextPath }/admin-good.jsp' flush='true' />
	<%-- <div class="buyer-content">
		<table  class='table table-striped table-hover table-condensed'>
			<tr><th>用户昵称</th><th>性别</th><th>手机号</th><th>地址</th><th>ID</th><th>姓名</th><th>级别</th><th>注册日期</th><th>操作</th></tr>
			<c:forEach var="map" items="${buyerMap}">
				<tr>
					<td>${map.value.name }</td><td>${map.value.gender }</td><td>${map.value.phone }</td><td>${map.value.address }</td><td>${map.value.id }</td><td>${map.value.realName }</td><td>${map.value.level }</td><td>${map.value.registDate }</td>
					<td><p><a>修改</a></p><p><a>删除</a></p></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	
	<div class="seller-content">
		<table  class='table table-striped table-hover table-condensed'>
			<tr><th>用户昵称</th><th>性别</th><th>手机号</th><th>地址</th><th>ID</th><th>姓名</th><th>级别</th><th>注册日期</th><th>操作</th></tr>
			<c:forEach var="map" items="${sellerMap}">
				<tr>
					<td>${map.value.name }</td><td>${map.value.gender }</td><td>${map.value.phone }</td><td>${map.value.address }</td><td>${map.value.id }</td><td>${map.value.realName }</td><td>${map.value.level }</td><td>${map.value.registDate }</td>
					<td><a>修改</a><a>删除</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	
	<div  class="good-content">
		<table id="table"  class='table table-hover'>
			<tr><th>商品编号</th><th>卖家昵称</th><th>商品标题</th><th>商品描述</th><th>商品价格</th><th>商品类别</th><th>操作</th></tr>
			<c:forEach var="map" items="${goodMap}">
				<tr>
					<td>${map.value.goodId }</td><td>${map.value.sellerName }</td><td>${map.value.goodTitle }</td><td>${map.value.goodDesc }</td><td>${map.value.goodPrice }</td><td>${map.value.sort1 }－${map.value.sort2 }－${map.value.sort3 }</td><td><a onclick="modify(this)">修改</a><a>下架</a></td>
				</tr>
			</c:forEach>
		</table>
		 <div class="gridItem" style="padding: 5px; width: 250px; float: left; text-align: left; height: 20px; font-size: 15px;" > 
		        共有 <span id="spanTotalInfor"></span> 条记录     
		        当前第<span id="spanPageNum"></span>页     
		        共<span id="spanTotalPage"></span>页
		  </div>
		  <div class="gridItem" style="margin-left:50px;  padding: 5px; width: 400px; float: left; text-align: center; height: 20px; vertical-align: middle; font-size: 15px;">   
		            <span id="spanFirst" >首页</span> 
		            <span id="spanPre">上一页</span>
		            <span id="spanInput" style="margin: 0px; padding: 0px 0px 4px 0px; height:100%; "> 
		                第<input id="Text1" type="text" class="TextBox" onkeyup="changepage()"   style="height:20px; text-align: center;width:50px" />页 
		            </span>
		            <span id="spanNext">下一页</span> 
		            <span  id="spanLast">尾页</span> 
       	 </div>
       	<script type="text/javascript">
       		function modify(e){
       			var tr = e.parentNode.parentNode;
       			var tds = tr.childNodes;
				console.log(tds);
				/*i从3 开始，即不允许修改商品编号和卖家 */
				for(var i=3;i<8;i++){
					var value = tds[i].innerHTML;
					if(i<7){tds[i].innerHTML = "<input style=\"width:100px\" type=\"text\" value=\""+value+"\">";}
					/* else if(i=6){tds[i].innerHTML = "";} 这里加分类select,做这个时要把上面i<7改成i<6*/
					else{tds[i].innerHTML="<a onclick=\"modifysave(this)\">保存</a><a onclick=\"modifycancel(this)\">取消</a>";}
				}
       		}
       		
       		function modifycancel(e){
       			var tr = e.parentNode.parentNode;
       			var tds = tr.childNodes;
       			/*i从3 开始，即不允许修改商品编号和卖家 */
       			for(var i=3;i<8;i++){
       				var input = tds[i].firstElementChild;
					var value = input.value;
					if(i<7){tds[i].innerHTML = value;}
					/* else if(i=6){tds[i].innerHTML = "";} 这里加分类select,做这个时要把上面i<7改成i<6*/
					else{tds[i].innerHTML="<a onclick=\"modify(this)\">修改</a><a>下架</a>";}
				}
       		}
       		
       		
       		
       		
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
	</div> --%>

</div>

</body>

</html>