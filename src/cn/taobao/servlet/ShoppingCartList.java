package cn.taobao.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.taobao.entity.Buyer;
import cn.taobao.entity.BuyerShoppingCart;
import cn.taobao.service.ShoppingCartService;

@WebServlet("/user/listShoppingCart")
public class ShoppingCartList extends HttpServlet {

	private static final long serialVersionUID = 3505525628063951948L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter w = response.getWriter();
		
		HttpSession session = request.getSession();
		
		Object b = session.getAttribute("buyer");
		
		Buyer buyer = (Buyer)b;
		
		ShoppingCartService scs = new ShoppingCartService();
		
		Map<Integer,BuyerShoppingCart> map = scs.list(buyer);
		
		if(map.size()>0) {
			
			session.setAttribute("myShoppingCart", map);
			
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/myShoppingCart.jsp");
			
			rd.forward(request, response);
		}else {
			w.println("<h1 style='text-align:center;'>您的购物车是空的哟，去添加商品吧~~</h1>");
		}
		
	}
	
	

}
