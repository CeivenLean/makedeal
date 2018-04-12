package cn.shop.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.shop.entity.Seller;
import cn.shop.service.OrderService;

@WebServlet("/seller/orderList")
public class SellerOrderListServlet extends HttpServlet {

	private static final long serialVersionUID = 454893808678696667L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		Seller seller = (Seller)session.getAttribute("seller");
	
		OrderService os = new OrderService();
	
		Map sellerOrderMap = os.listBySeller(seller);
		
		request.setAttribute("sellerOrderMap", sellerOrderMap);
		
		request.getRequestDispatcher("/WEB-INF/sellerorder.jsp").forward(request, response);
	}
	
	
	

}
