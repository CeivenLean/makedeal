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
import cn.shop.service.GoodService;

@WebServlet("/seller/goodList")
public class SellerGoodListServlet extends HttpServlet {

	private static final long serialVersionUID = -3601577489374449181L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		Seller seller = (Seller)session.getAttribute("seller");
	
		GoodService gs = new GoodService();
	
		Map goodMap = gs.listBySeller(seller);
		
		request.setAttribute("goodMap", goodMap);
		
		request.getRequestDispatcher("/WEB-INF/sellergood.jsp").forward(request, response);
	}
	
	
	

}
