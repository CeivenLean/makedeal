package cn.taobao.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

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
import cn.taobao.entity.Good;
import cn.taobao.service.GoodService;
import cn.taobao.service.OrderService;
import cn.taobao.service.ShoppingCartService;

@WebServlet("/user/orderFromCart")
public class OrderFromCart extends HttpServlet {

	private static final long serialVersionUID = 6168630777297454140L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Map<Good,Integer> orderMap = new HashMap();
		
		BuyerOrder bo = new BuyerOrder();
		OrderService os = new OrderService();
		GoodService gd = new GoodService();
		HttpSession session = request.getSession();
		Buyer buyer = (Buyer)session.getAttribute("buyer");
		
		/*bo.setBuyerId(buyer.getId());*/
		
		String[] ids = request.getParameterValues("goodSelect");
		ShoppingCartService scs = new ShoppingCartService();
		Map<Integer,BuyerShoppingCart> map = scs.list(ids);
		Set<Integer> set = map.keySet();
		double prices = 0;
		for(Integer key:set) {
			
			BuyerShoppingCart sc = map.get(key);
			prices += sc.getGoodPrice()*sc.getGoodCount();
			
			Good g = gd.select(sc.getGoodId());
			orderMap.put(g, sc.getGoodCount());
			
		}
		
		session.setAttribute("ordermap", orderMap);
		session.setAttribute("totalPrice", prices);
		response.sendRedirect(request.getContextPath()+"/order.jsp");
		
		/*bo.setGoodsInfo(orderMap);
		bo.setTransactionAmount(prices);
		
		if(os.saveOrder(bo)) {
			
			session.setAttribute("prices", prices);
			
			RequestDispatcher rd = request.getRequestDispatcher("/pay.jsp");
			rd.forward(request, response);
			
		}else {
			System.out.println("保存订单错误！");
			
		}*/
		
		
	}
	

}
