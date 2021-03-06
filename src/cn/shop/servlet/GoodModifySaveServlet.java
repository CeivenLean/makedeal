package cn.shop.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;  
import com.alibaba.fastjson.JSONObject;

import cn.shop.service.GoodService;


@WebServlet("/user/good/modifysave")
public class GoodModifySaveServlet extends HttpServlet {

	private static final long serialVersionUID = 1876100923138122511L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String info = request.getParameter("data");
		System.out.println(request.getParameter("data"));
		Map map = (Map)JSON.parse(info);
		/*System.out.println(maps);
		for (Object map : maps.entrySet()){  
            System.out.println(((Map.Entry)map).getKey()+"     " + ((Map.Entry)map).getValue());  
        }*/
		
		GoodService gs = new GoodService();
		boolean b= gs.save(map);
		response.setContentType( "text/plain;charset=UTF-8" );
		if(b) {
			response.getWriter().println("true");
		}else {
			response.getWriter().println("false");
		}
		
	}
	
	

}
