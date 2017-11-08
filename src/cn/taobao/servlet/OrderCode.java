package cn.taobao.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.taobao.entity.*;
import cn.taobao.util.QRCodeUtil;

@WebServlet("/user/ordercode")
public class OrderCode extends HttpServlet {

	private static final long serialVersionUID = 6168630777297454140L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		Buyer buyer = (Buyer)session.getAttribute("buyer");
		
		double prices = Double.parseDouble(request.getParameter("prices"));
		
		String message = "恭喜"+buyer.getName()+", 付款成功,总计"+prices+"元";
		
		try {
			QRCodeUtil.encode(message, "C:/Users/Ceiven/Pictures/alipaylogo.jpg" , response.getOutputStream(), true);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	

}
