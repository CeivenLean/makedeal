package cn.shop.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.shop.entity.Buyer;
import cn.shop.entity.BuyerOrder;
import cn.shop.entity.Good;
import cn.shop.entity.Seller;
import cn.shop.entity.SellerOrder;
import cn.shop.service.GoodService;
import cn.shop.service.OrderService;
import cn.shop.service.SellerService;
import cn.shop.service.ShoppingCartService;

@WebServlet("/pay")
public class Pay extends HttpServlet {


	/**
	 * 
	 */
	private static final long serialVersionUID = -6931261542448604312L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Map<Good,Integer> orderMap = new HashMap();
		
		BuyerOrder bo = new BuyerOrder();
		OrderService os = new OrderService();
		GoodService gd = new GoodService();
		SellerOrder so = new SellerOrder();
		SellerService ss = new SellerService();
		HttpSession session = request.getSession();
		Buyer buyer = (Buyer)session.getAttribute("buyer");
		orderMap = (Map)session.getAttribute("ordermap");
		double prices = (double)session.getAttribute("totalPrice");
		bo.setBuyerId(buyer.getId());
		
		Map<Integer,Integer> goodsInfoMap = new HashMap<Integer,Integer>();
		
		ShoppingCartService scs = new ShoppingCartService();
		
		Set<Good> set = orderMap.keySet();
		Map<Seller,Map<Integer,Integer>> sellerMap = new HashMap<Seller,Map<Integer,Integer>>();
		Seller seller = null;
		Map<String,Seller> tempmap = new HashMap<String,Seller>();
		for(Good g:set) {
			Integer count = orderMap.get(g);
			goodsInfoMap.put(g.getGoodId(), count);
			Map<Integer,Integer> tmp = new HashMap<Integer,Integer>();
			if(!tempmap.containsKey(g.getSellerName())) {
				seller = ss.select(g.getSellerName());
				tempmap.put(seller.getName(), seller);
			}else {
				seller = tempmap.get(g.getSellerName());
				tmp = sellerMap.get(seller);
			}
			
			tmp.put(g.getGoodId(), count);
			sellerMap.put(seller, tmp);
		}
		bo.setGoodsInfo(goodsInfoMap);
		bo.setTransactionAmount(prices);
		bo.setAddress(request.getParameter("address"));
		
		if(os.saveOrder(bo,sellerMap)) {
			
			session.setAttribute("prices", prices);
			session.setAttribute("orderMap", orderMap);
			
			RequestDispatcher rd = request.getRequestDispatcher("/pay.jsp");
			rd.forward(request, response);
			
		}else {
			System.out.println("保存订单错误！");
			
		}
		
		
	}
	

}
