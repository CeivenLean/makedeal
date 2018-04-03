package cn.taobao.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import cn.taobao.service.ShoppingCartService;
import cn.taobao.util.StringHelper;

@WebServlet("/user/cartdelete")
public class CartDelete extends HttpServlet {

	private static final long serialVersionUID = 5829590360265190742L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String values = request.getParameter("cartIds");
		String[] list = values.split(",");
		ShoppingCartService scs = new ShoppingCartService();
		int msg = scs.deleteById(list);
		response.getWriter().print(msg);
	}
	
}
