package cn.shop.servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;

import cn.shop.util.Sendmail;

@WebServlet("/genEmailCode")
public class GenEmailCode extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6538659293810658514L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String info = request.getParameter("data");
		System.out.println(request.getParameter("data"));
		Map map = (Map)JSON.parse(info);
		
		String code = "";
		Random random = new Random();
		for(int i = 0;i<6;i++){  
			code += Integer.toString(random.nextInt(36), 36);  
	    }
		map.put("code", code);
		System.out.println("邮箱"+map.get("email")+"的验证码是："+code);
		Sendmail send = new Sendmail(map);
		response.setContentType( "text/plain;charset=UTF-8" );
		try {
			
			send.start(); 
			
			response.getWriter().println(code);
		}catch(Exception e){
			response.getWriter().println("null");
			throw new RuntimeException(e);
			
		}
		
	}
	
	

}
