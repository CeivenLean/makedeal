package cn.taobao.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.taobao.entity.Buyer;
import cn.taobao.entity.BuyerOrder;
import cn.taobao.entity.Good;
import cn.taobao.service.GoodService;
import cn.taobao.service.OrderService;

@WebServlet("/user/orderFromDetail")
public class OrderFromDetail extends HttpServlet {


	/**
	 * 
	 */
	private static final long serialVersionUID = 6302249880998483380L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Map<Good,Integer> orderMap = new HashMap();
		
		BuyerOrder bo = new BuyerOrder();
		OrderService os = new OrderService();
		
		GoodService gd = new GoodService();
		
		HttpSession session = request.getSession();
		Buyer buyer = (Buyer)session.getAttribute("buyer");
		
		/*bo.setBuyerId(buyer.getId());*/
		
		Integer goodId  = Integer.valueOf(request.getParameter("goodId"));
		int goodCount = Integer.parseInt(request.getParameter("goodCount"));
		
		Good g = gd.select(goodId);
		double prices = g.getGoodPrice()*goodCount;
		
		orderMap.put(g, goodCount);
			
		session.setAttribute("ordermap", orderMap);
		session.setAttribute("totalPrice", prices);
		response.sendRedirect(request.getContextPath()+"/order.jsp");
		/*bo.setGoodsInfo(orderMap);
		bo.setTransactionAmount(prices);*/
		
		/*if(os.saveOrder(bo)) {
			
			session.setAttribute("prices", prices);
			
			RequestDispatcher rd = request.getRequestDispatcher("/pay.jsp");
			rd.forward(request, response);
			
			
		}else {
			System.out.println("保存订单错误！");
			
		}*/
		
		
	}
	

}
