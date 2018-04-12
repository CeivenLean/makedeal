package cn.shop.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.shop.entity.Good;
import cn.shop.entity.Seller;
import cn.shop.service.GoodService;
import cn.shop.service.SellerService;

@WebServlet("/good/detail")
public class GoodDetail extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Integer id = Integer.valueOf(request.getParameter("id"));
		
		GoodService gs = new GoodService();
		Good good = gs.select(id);
		
		SellerService ss = new SellerService();
		Seller seller = ss.select(good.getSellerName());
		
		HttpSession session = request.getSession();
		
		session.setAttribute("good", good);
		session.setAttribute("sellerinfo", seller);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/gooddetail.jsp");
		
		rd.forward(request, response);
		
	}
	
	

}
