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
import cn.taobao.entity.BuyerOrder;
import cn.taobao.entity.BuyerShoppingCart;
import cn.taobao.service.OrderService;
import cn.taobao.service.ShoppingCartService;

@WebServlet("/user/listOrder")
public class OrderList extends HttpServlet {

	private static final long serialVersionUID = 3561641221567898322L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
			response.setContentType("text/html;charset=utf-8");
			
			PrintWriter w = response.getWriter();
			
			HttpSession session = request.getSession();
			
			Object b = session.getAttribute("buyer");
			
			Buyer buyer = (Buyer)b;
			
			OrderService os = new OrderService();
			
			Map map = os.list(buyer);
			
			if(map.size()>0) {
				
				session.setAttribute("myOrder", map);
				
				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/myOrder.jsp");
				
				rd.forward(request, response);
			}else {
				w.println("<h1 style='text-align:center;'>您的订单为空，快去购买商品吧~</h1>");
			}
			
	}
		
		

}


