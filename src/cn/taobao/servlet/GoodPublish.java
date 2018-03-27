package cn.taobao.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import cn.taobao.entity.Good;
import cn.taobao.entity.Seller;
import cn.taobao.service.GoodService;

@WebServlet("/good/publish")
@MultipartConfig
public class GoodPublish extends HttpServlet {

	private static final long serialVersionUID = 737128732422100743L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter writer = response.getWriter();
		response.setContentType("text/html;character=utf8");
		HttpSession session = request.getSession();
		Object seller = session.getAttribute("seller");
		Seller s = (Seller)seller;
		
		//将商品信息存放到数据库中
		String goodTitle = request.getParameter("goodTitle");
		String goodDesc = request.getParameter("goodDesc");
		String goodPrice = request.getParameter("goodPrice");
		String sort1 = request.getParameter("sort1");
		String sort2 = request.getParameter("sort2");
		String sort3 = request.getParameter("sort3");
		
		if(goodPrice!=null && goodPrice.length()>0) {
			double price = Double.valueOf(goodPrice);
			Good good = new Good();
			good.setSellerName(s.getName());
			good.setGoodTitle(goodTitle);
			good.setGoodDesc(goodDesc);
			good.setGoodPrice(price);
			
			GoodService gs = new GoodService();
			long r = gs.publish(good);
			if(r>0) {
				String savePath = request.getServletContext().getRealPath("/images/goods");
				Part part = request.getPart("upload");
				String filename = part.getSubmittedFileName();
				filename = r+filename.substring(filename.lastIndexOf("."));
				part.write(savePath+File.separator+filename);
				writer.println("添加成功");
				writer.println("<a href='"+request.getHeader("referer")+"'>返回继续添加</a>");
				
				
			}else {
				writer.println("添加失败");
				writer.println("<a href='"+request.getHeader("referer")+"'>返回重试</a>");
			}
		
		}
		

	}
	
}
