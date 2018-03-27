package cn.taobao.servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.taobao.entity.Buyer;
import cn.taobao.entity.BuyerOrder;
import cn.taobao.entity.BuyerShoppingCart;
import cn.taobao.service.OrderService;
import cn.taobao.service.ShoppingCartService;
import cn.taobao.util.StringHelper;

@WebServlet("/user/cartdelete")
public class CartDelete extends HttpServlet {

	private static final long serialVersionUID = 5829590360265190742L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String values = request.getParameter("cartIds");
		System.out.println("values:"+values);
		String[] cartIds = StringHelper.strToArray(values);
		ShoppingCartService scs = new ShoppingCartService();
		int msg = scs.deleteById(cartIds);
		response.getWriter().print(msg);
		
	}
	
}
