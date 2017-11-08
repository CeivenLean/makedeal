package cn.taobao.servlet;

import java.io.IOException;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.taobao.entity.BuyerShoppingCart;
import cn.taobao.service.ShoppingCartService;

@WebServlet("/user/order")
public class Order extends HttpServlet {

	private static final long serialVersionUID = 6168630777297454140L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		String[] ids = request.getParameterValues("goodSelect");
		ShoppingCartService scs = new ShoppingCartService();
		Map<Integer,BuyerShoppingCart> map = scs.list(ids);
		Set<Integer> set = map.keySet();
		double prices = 0;
		for(Integer key:set) {
			BuyerShoppingCart sc = map.get(key);
			prices += sc.getGoodPrice()*sc.getGoodCount();
		}
		
		session.setAttribute("prices", prices);
			
		RequestDispatcher rd = request.getRequestDispatcher("/order.jsp");
		rd.forward(request, response);
	}
	

}
