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

@WebServlet("/user/complete")
public class Complete extends HttpServlet {

	private static final long serialVersionUID = 267694198853268469L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String gender = request.getParameter("gender");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
		HttpSession session = request.getSession();
		if(session.getAttribute("buyer")!=null) {
			Object o = session.getAttribute("buyer");
			Buyer b = (Buyer)o;
			b.setGender(gender);
			b.setPhone(phone);
			b.setAddress(address);
			BuyerService bs = new BuyerService();
			boolean x = bs.complete(b);
			if(x) {
				response.getWriter().print("success");
			}
		}
		if(session.getAttribute("seller")!=null) {
			Object o = session.getAttribute("seller");
			Seller s = (Seller)o;
			s.setGender(gender);
			s.setPhone(phone);
			s.setAddress(address);
			SellerService ss = new SellerService();
			boolean x = ss.complete(s);
			if(x) {
				response.getWriter().print("success");
			}
		}
		
	}
	
	

}
