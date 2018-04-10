package cn.shop.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.shop.util.RandomValidateCode;
@WebServlet("/imageCodeServlet")
public class ImageCodeServlet extends HttpServlet {

	

	/**
	 * 
	 */
	private static final long serialVersionUID = -3574237787598371108L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("image/jpeg");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "No-cache");
		response.setDateHeader("Expires", 0);
		
		RandomValidateCode rc = new RandomValidateCode();
		
		try {
			rc.getRandomCode(request,response);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	
	
	
	

}
