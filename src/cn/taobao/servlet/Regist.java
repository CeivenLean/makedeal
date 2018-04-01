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
import cn.taobao.util.StringHelper;

@WebServlet("/user/regist")
public class Regist extends HttpServlet {

	private static final long serialVersionUID = -4758290724120650809L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		response.setContentType("text/html;charset=UTF-8");
		
		
		HttpSession session = request.getSession();
		
		String username = request.getParameter("username").trim();
		String userpassword = request.getParameter("userpassword").trim();
		String confirmpassword = request.getParameter("confirmpassword").trim();
		String userid = request.getParameter("userid").trim();
		String name = request.getParameter("name").trim();
		String email = request.getParameter("email").trim();
		String role = request.getParameter("role").trim();
		
		if(StringHelper.notEmpty(username)&&
				StringHelper.notEmpty(userpassword)&&
				StringHelper.notEmpty(confirmpassword)&&
				StringHelper.notEmpty(userid)&&
				StringHelper.notEmpty(name)&&StringHelper.notEmpty(email)&&
				StringHelper.notEmpty(role)) {
			
			if(userpassword.equals(confirmpassword)) {
				if("买家".equals(role)) {
					Buyer buyer = new Buyer();
					buyer.setName(username);
					buyer.setPassword(userpassword);
					buyer.setId(userid);
					buyer.setRealName(name);
					buyer.setEmail(email);
					BuyerService bs = new BuyerService();
					bs.regist(buyer);
					session.setAttribute("buyer", buyer);
					response.sendRedirect(request.getContextPath()+"/buyer.jsp");
					
				}
				if("卖家".equals(role)) {
					Seller seller = new Seller();
					seller.setName(username);
					seller.setEmail(email);
					seller.setPassword(userpassword);
					seller.setId(userid);
					seller.setRealName(name);
					SellerService ss = new SellerService();
					ss.regist(seller);
					session.setAttribute("seller", seller);
					response.sendRedirect(request.getContextPath()+"/seller.jsp");
					
				}
			}
			
		}
		
	}
	

}
