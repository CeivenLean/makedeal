package cn.shop.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.shop.entity.Buyer;
import cn.shop.entity.BuyerShoppingCart;
import cn.shop.entity.Good;
import cn.shop.service.GoodService;
import cn.shop.service.ShoppingCartService;

@WebServlet("/user/shoppingcart")
public class ShoppingCart extends HttpServlet {

	private static final long serialVersionUID = -4547153464791838252L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		Object o = session.getAttribute("buyer");
		Buyer b = (Buyer)o;
//		Object og = session.getAttribute("good");
//		Good g = (Good)og;
		String goodId = request.getParameter("goodId");
		Integer key = Integer.parseInt(goodId);
		String goodCount = request.getParameter("goodCount");
		
		GoodService gd = new GoodService();
		Good g = gd.select(key);
		
		
		BuyerShoppingCart sc = new BuyerShoppingCart();
		
		sc.setBuyerId(b.getId());
		sc.setGoodId(g.getGoodId());
		sc.setGoodTitle(g.getGoodTitle());
		sc.setGoodPrice(g.getGoodPrice());
		if(goodCount!=null&&goodCount.length()>0) {
			sc.setGoodCount(Integer.parseInt(goodCount));
		}else {
			sc.setGoodCount(1);
		}
		
		ShoppingCartService scs = new ShoppingCartService();
		
		boolean n = scs.add(sc);
		if(n) {
			response.getWriter().print("1");
		}else {
			response.getWriter().print("0");
		}
		//response.sendRedirect(request.getContextPath()+"/user/listShoppingCart");
	}
	
	
	

}
