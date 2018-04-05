package cn.taobao.servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

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

@WebServlet("/user/orderFromCart")
public class OrderFromCart extends HttpServlet {

	private static final long serialVersionUID = 6168630777297454140L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Map<Integer,Integer> orderMap = new HashMap();
		
		BuyerOrder bo = new BuyerOrder();
		OrderService os = new OrderService();
		
		HttpSession session = request.getSession();
		Buyer buyer = (Buyer)session.getAttribute("buyer");
		
		bo.setBuyerId(buyer.getId());
		
		String[] ids = request.getParameterValues("goodSelect");
		ShoppingCartService scs = new ShoppingCartService();
		Map<Integer,BuyerShoppingCart> map = scs.list(ids);
		Set<Integer> set = map.keySet();
		double prices = 0;
		for(Integer key:set) {
			
			BuyerShoppingCart sc = map.get(key);
			prices += sc.getGoodPrice()*sc.getGoodCount();
			
			orderMap.put(sc.getGoodId(), sc.getGoodCount());
			
		}
		
		bo.setGoodsInfo(orderMap);
		bo.setTransactionAmount(prices);
		
		if(os.saveOrder(bo)) {
			
			session.setAttribute("prices", prices);
			
			RequestDispatcher rd = request.getRequestDispatcher("/order.jsp");
			rd.forward(request, response);
			
		}else {
			System.out.println("保存订单错误！");
			
		}
		
		
	}
	

}
