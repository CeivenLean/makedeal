<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
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
<title>Insert title here</title>
</head>

<body>
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
		<script type="text/javascript">
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
</script>
	</div>
</body>
</html>