package cn.taobao.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.taobao.service.BuyerService;
import cn.taobao.service.GoodService;
import cn.taobao.service.SellerService;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1224829687343094165L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BuyerService bs = new BuyerService();
		SellerService ss = new SellerService();
		GoodService gs = new GoodService();
		
		Map buyerMap = bs.listAll();
		Map sellerMap = ss.listAll();
		Map goodMap = gs.listAll();
		
		HttpSession session = request.getSession();
		request.setAttribute("buyerMap", buyerMap);
		request.setAttribute("sellerMap", sellerMap);
		request.setAttribute("goodMap", goodMap);
		
		
		
		
		request.getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
	}
	
	
	

}