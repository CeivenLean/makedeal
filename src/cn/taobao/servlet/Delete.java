package cn.taobao.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.taobao.entity.Buyer;
import cn.taobao.entity.Seller;
import cn.taobao.service.BuyerService;
import cn.taobao.service.SellerService;

@WebServlet("/user/delete")
public class Delete extends HttpServlet {

	private static final long serialVersionUID = 4693143313683353766L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		boolean x = false;
		if(session.getAttribute("buyer")!=null) {
			Object o = session.getAttribute("buyer");
			Buyer b = (Buyer)o;
			BuyerService bs = new BuyerService();
			x = bs.delete(b);
		}
		if(session.getAttribute("seller")!=null) {
			Object o = session.getAttribute("seller");
			Seller s = (Seller)o;
			SellerService ss = new SellerService();
			x = ss.delete(s);
		}
		if(x) {
			session.invalidate();
			response.sendRedirect(request.getContextPath()+"/regist.jsp");
		}
		
	}

}
