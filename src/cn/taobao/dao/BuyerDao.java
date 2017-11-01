package cn.taobao.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import cn.taobao.entity.Buyer;
import cn.taobao.util.JdbcHelper;

public class BuyerDao {
	
	String TABLE = "buyer_info";
	JdbcHelper helper = new JdbcHelper();
	
	public boolean regist(Buyer b) {
		String SQL = "INSERT INTO buyer_info (buyer_name,password,buyer_id,real_name,buyer_level,regist_date) VALUES (?,?,?,?,?,?)";
		
		java.util.Date date = b.getRegistDate();
		java.sql.Date registDate = new java.sql.Date(date.getTime());
		
		int[] i = helper.insert(SQL, b.getName(),b.getPassword(),b.getId(),b.getRealName(),b.getLevel(),registDate);
		
		return (i!=null&&i.length>0)?true:false;
	}
	
	public Buyer search(String name,String password) {
		String SQL = "SELECT * FROM buyer_info WHERE buyer_name=? AND password=?";
		ResultSet rs = helper.query(SQL, name, password);
		if(rs!=null) {
			try {
				while(rs.next()) {
					Buyer b = new Buyer();
					b.setName(rs.getString("buyer_name"));
					b.setPassword(rs.getString("password"));
					b.setGender(rs.getString("buyer_gender"));
					b.setPhone(rs.getString("buyer_phone"));
					b.setAddress(rs.getString("buyer_address"));
					b.setId(rs.getString("buyer_id"));
					b.setRealName(rs.getString("real_name"));
					b.setLevel(rs.getString("buyer_level"));
					b.setRegistDate(rs.getDate("regist_date"));
					
					return b;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public boolean complete(Buyer b) {
		
		String SQL = "UPDATE buyer_info SET buyer_gender='"+b.getGender()+"',buyer_phone='"+b.getPhone()+"',buyer_address='"+b.getAddress()+"' WHERE buyer_id='"+b.getId()+"'";
		
		int i = helper.update(SQL);
		
		return (i>0)?true:false;
	}
	
	public boolean delete(Buyer b) {
		String SQL = "DELETE FROM buyer_info WHERE buyer_id='"+b.getId()+"'";
		int i = helper.update(SQL);
		return (i>0)?true:false;
	}
}
