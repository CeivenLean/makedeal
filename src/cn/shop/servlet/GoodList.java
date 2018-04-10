package cn.shop.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.shop.entity.Good;
import cn.shop.service.GoodService;
import cn.shop.util.*;

@WebServlet("/good/list")
public class GoodList extends HttpServlet {

	private static final long serialVersionUID = 1373450241563606621L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String value = request.getParameter("search");
		HttpSession session = request.getSession();
		if(value==null) {
			value = session.getAttribute("value")+"";
		}
		
		response.setContentType("text/html;charset=utf-8");

		PrintWriter w = response.getWriter();
		GoodService gs = new GoodService();
		Map<Integer,Good> map = new HashMap<>();
		int count = gs.totalCount(value);
		
		PageUtil pageUtil = new PageUtil();
		pageUtil.setRecordCount(count);
		
		String strPageIndex = request.getParameter("pageIndex");
		if(strPageIndex!=null && !strPageIndex.equals("")) {
			pageUtil.setPageIndex(Integer.parseInt(strPageIndex));
		}
		map = gs.list(value, pageUtil);
		pageUtil.setDatas(map);
		pageUtil.setPageNums(5);
		
		session.setAttribute("pageUtil", pageUtil);
		
		if(map.size()>0) {
			
			
			session.setAttribute("goodsMap", map);
			session.setAttribute("value", value);
			session.setAttribute("actionName", request.getContextPath()+"/good/list");
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/goodlist.jsp");
			
			rd.forward(request, response);
		}else {
			w.println("<h1 style='text-align:center;'>对不起，查询结果为零！试试其它关键字吧~~</h1>");
		}
	}
	
	

}
