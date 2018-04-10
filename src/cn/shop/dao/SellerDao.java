package cn.shop.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import cn.shop.entity.Buyer;
import cn.shop.entity.Seller;
import cn.shop.util.JdbcHelper;

public class SellerDao {
	
	String TABLE = "seller_info";
	JdbcHelper helper = new JdbcHelper();
	
	public boolean regist(Seller s) {
		String SQL = "INSERT INTO seller_info (seller_name,password,seller_id,real_name,seller_level,regist_date) VALUES (?,?,?,?,?,?)";
		
		int[] i = helper.insert(SQL, s.getName(),s.getPassword(),s.getId(),s.getRealName(),s.getLevel(),s.getRegistDate());
		
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
					s.setRegistDate(rs.getTimestamp("regist_date"));
					s.setEmail(rs.getString("email"));
					
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
					s.setRegistDate(rs.getTimestamp("regist_date"));
					s.setEmail(rs.getString("email"));
					return s;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public Seller selectById(String id) {
		String SQL = "SELECT * FROM seller_info WHERE seller_id=?";
		ResultSet rs = helper.query(SQL, id);
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
					s.setRegistDate(rs.getTimestamp("regist_date"));
					s.setEmail(rs.getString("email"));
					return s;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public Map listAll() {
		String SQL = "SELECT * FROM seller_info";
		ResultSet rs = helper.query(SQL);
		Map map = new HashMap();
		try {
			while(rs.next()) {
				
				Seller b = new Seller();
				b.setName(rs.getString("seller_name"));
				b.setAddress(rs.getString("seller_address"));
				b.setGender(rs.getString("seller_gender"));
				b.setId(rs.getString("seller_id"));		
				b.setLevel(rs.getString("seller_level"));
				b.setPhone(rs.getString("seller_phone"));
				b.setRealName(rs.getString("real_name"));
				b.setRegistDate(rs.getTimestamp("regist_date"));
				b.setEmail(rs.getString("email"));
				map.put(b.getId(),b );
			
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
