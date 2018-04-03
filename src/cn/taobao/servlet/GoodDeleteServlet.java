package cn.taobao.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;  
import com.alibaba.fastjson.JSONObject;

import cn.taobao.service.GoodService;


@WebServlet("/user/good/gooddel")
public class GoodDeleteServlet extends HttpServlet {

	private static final long serialVersionUID = 1876100923138122511L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int goodId = Integer.parseInt(request.getParameter("goodId"));
		
		GoodService gs = new GoodService();
		boolean b= gs.delById(goodId);
		response.setContentType( "text/plain;charset=UTF-8" );
		if(b) {
			response.getWriter().print("true");
		}else {
			response.getWriter().print("false");
		}
		
	}
	
	

}
