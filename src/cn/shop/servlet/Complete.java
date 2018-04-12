package cn.shop.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.shop.entity.Buyer;
import cn.shop.entity.Seller;
import cn.shop.service.BuyerService;
import cn.shop.service.SellerService;
import cn.shop.util.StringHelper;

@WebServlet("/user/complete")
public class Complete extends HttpServlet {

	private static final long serialVersionUID = 267694198853268469L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String src = request.getParameter("src");
		if("1".equals(src)) {
			String gender = request.getParameter("gender");
			String phone = request.getParameter("phone");
			String addr1 = request.getParameter("address1");
			String addr2 = request.getParameter("address2");
			String addr3 = request.getParameter("address3");
			List<String> address = new ArrayList();
			if(StringHelper.notEmpty(addr1))
			address.add(addr1);
			if(StringHelper.notEmpty(addr2))
			address.add(addr2);
			if(StringHelper.notEmpty(addr3))
			address.add(addr3);
			
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
			
		}else if("2".equals(src)) {
			String gender = request.getParameter("gender");
			String phone = request.getParameter("phone");
			String addr = request.getParameter("address");
			
			
			HttpSession session = request.getSession();
			
			if(session.getAttribute("seller")!=null) {
				Object o = session.getAttribute("seller");
				Seller s = (Seller)o;
				s.setGender(gender);
				s.setPhone(phone);
				s.setAddress(addr);
				SellerService ss = new SellerService();
				boolean x = ss.complete(s);
				if(x) {
					response.getWriter().print("success");
				}
			}
		}
	
	}

}
