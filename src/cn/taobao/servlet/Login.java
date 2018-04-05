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
/**
 * 
 * @author Ceiven
 *
 */
@WebServlet("/user/login")
public class Login extends HttpServlet {

	private static final long serialVersionUID = 5637410909419919929L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String name = request.getParameter("username");
		String password = request.getParameter("password");
		String imgCode = request.getParameter("imgCode").toUpperCase();
		
		Object randomCode = session.getAttribute("RANDOMVALIDATECODEKEY");
		
		String code = (String)randomCode;
		code = code.toUpperCase();
		if(StringHelper.notEmpty(name)&&StringHelper.notEmpty(password)&&StringHelper.notEmpty(imgCode)) {
			
			if(!imgCode.equals(code)) {
				session.setAttribute("imgcodeError", "验证码不正确！");
				response.sendRedirect(request.getHeader("referer"));
				return ;
			}
			
			BuyerService bs = new BuyerService();
			Buyer buyer = bs.search(name,password);
			
			SellerService ss = new SellerService();
			Seller seller = ss.search(name,password);
			
			if(buyer==null&&seller==null) {
				session.setAttribute("usernameError", "用户名或密码不正确！");
				session.setAttribute("passwordError", "用户名或密码不正确！");
				response.sendRedirect(request.getHeader("referer"));
			}else {
				if(buyer!=null) {
					session.setAttribute("buyer", buyer);
					response.sendRedirect(request.getContextPath()+"/buyer.jsp");
				}
				if(seller!=null) {
					session.setAttribute("seller", seller);
					response.sendRedirect(request.getContextPath()+"/seller.jsp");
				}
			}

			
			
		}else {
			if(StringHelper.isEmpty(name)) {
				session.setAttribute("usernameError", "用户名不能为空！");
			}
			if(StringHelper.isEmpty(password)) {
				session.setAttribute("passwordError", "密码不能为空！");
			}
			if(StringHelper.isEmpty(password)) {
				session.setAttribute("imgcodeError", "验证码不能为空！");
			}
			response.sendRedirect(request.getHeader("referer"));
		}
		
	}
	
	
}
