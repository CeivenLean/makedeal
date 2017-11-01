package cn.taobao.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.taobao.service.ShoppingCartService;

@WebServlet("/shoppingcart/count")
public class ShoppingCartCount extends HttpServlet {

	private static final long serialVersionUID = -3253856832518947522L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Integer cartId = Integer.parseInt(request.getParameter("cartId"));
		int act = Integer.parseInt(request.getParameter("act"));
		
		ShoppingCartService scs = new ShoppingCartService();
		
		int c = scs.update(cartId, act);
		
		response.getWriter().print(c);
	}
	
	

}
