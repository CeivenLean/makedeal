package cn.taobao.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import cn.taobao.entity.Seller;
import cn.taobao.util.JdbcHelper;

public class SellerDao {
	
	String TABLE = "seller_info";
	JdbcHelper helper = new JdbcHelper();
	
	public boolean regist(Seller s) {
		String SQL = "INSERT INTO seller_info (seller_name,password,seller_id,real_name,seller_level,regist_date) VALUES (?,?,?,?,?,?)";
		
		java.util.Date date = s.getRegistDate();
		java.sql.Date registDate = new java.sql.Date(date.getTime());
		
		int[] i = helper.insert(SQL, s.getName(),s.getPassword(),s.getId(),s.getRealName(),s.getLevel(),registDate);
		
		return (i!=null&&i.length>0)?true:false;
	}
	
	public Seller search(String name,String password) {
		String SQL = "SELECT * FROM seller_info WHERE seller_name=? AND password=?";
		ResultSet rs = helper.query(SQL, name, password);
		if(rs!=null) {
			try {
				while(rs.next()) {
					Seller s = new Seller();
					s.setName(rs.getString("seller_name"));
					s.setPassword(rs.getString("password"));
					s.setGender(rs.getString("seller_gender"));
					s.setPhone(rs.getString("seller_phone"));
					s.setAddress(rs.getString("seller_address"));
					s.setId(rs.getString("seller_id"));
					s.setRealName(rs.getString("real_name"));
					s.setLevel(rs.getString("seller_level"));
					s.setRegistDate(rs.getDate("regist_date"));
					
					return s;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public boolean complete(Seller s) {
		
		String SQL = "UPDATE seller_info SET seller_gender='"+s.getGender()+"',seller_phone='"+s.getPhone()+"',seller_address='"+s.getAddress()+"' WHERE seller_id='"+s.getId()+"'";
		
		int i = helper.update(SQL);
		
		return (i>0)?true:false;
	}
	
	public boolean delete(Seller s) {
		String SQL = "DELETE FROM seller_info WHERE seller_id='"+s.getId()+"'";
		int i = helper.update(SQL);
		return (i>0)?true:false;
	}
	
	public Seller select(String name) {
		String SQL = "SELECT * FROM seller_info WHERE seller_name=?";
		ResultSet rs = helper.query(SQL, name);
		if(rs!=null) {
			try {
				while(rs.next()) {
					Seller s = new Seller();
					s.setName(rs.getString("seller_name"));
					s.setPassword(rs.getString("password"));
					s.setGender(rs.getString("seller_gender"));
					s.setPhone(rs.getString("seller_phone"));
					s.setAddress(rs.getString("seller_address"));
					s.setId(rs.getString("seller_id"));
					s.setRealName(rs.getString("real_name"));
					s.setLevel(rs.getString("seller_level"));
					s.setRegistDate(rs.getDate("regist_date"));
					
					return s;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
}
