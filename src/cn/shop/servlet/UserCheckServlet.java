package cn.shop.servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.shop.util.JdbcHelper;
import cn.shop.util.StringHelper;

@WebServlet("/user/check")
public class UserCheckServlet extends HttpServlet {

	private static final long serialVersionUID = 7948534773331211099L;
	
	@Override
	protected void doGet(HttpServletRequest request , HttpServletResponse response ) throws ServletException, IOException {
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
		boolean s = false ;
		String m = "" ;
		if(StringHelper.isEmpty(username)) {
			m = "请输入用户名";
		}else {		
			JdbcHelper helper = new JdbcHelper();
			String buyerSql = "SELECT buyer_name FROM buyer_info";
			String sellerSql = "SELECT seller_name FROM seller_info";
			List<String> userList = new ArrayList<String>();
			ResultSet rs = null;			
			try {
				rs = helper.query(buyerSql);
				while(rs.next()) {
					userList.add(rs.getString("buyer_name"));
				}
				rs = helper.query(sellerSql);
				while(rs.next()) {
					userList.add(rs.getString("seller_name"));
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			if(userList.contains(username)) {
				s = false ;
				m = "抱歉！此用户名已存在！" ;
			}else {
				s = true ;
				m = "恭喜！用户名可用~" ;
			}
		}
		
		String json = "{\"success\":" + s + ",\"message\":\"" + m + "\"}";
		response.setContentType( "text/plain;charset=UTF-8" );
		response.getWriter().println( json );

	}

}
