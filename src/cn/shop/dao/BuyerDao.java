package cn.shop.dao;

import java.util.ArrayList;
import java.util.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.shop.entity.Buyer;
import cn.shop.util.JdbcHelper;

public class BuyerDao {
	
	String TABLE = "buyer_info";
	JdbcHelper helper = new JdbcHelper();
	
	public boolean regist(Buyer b) {
		String SQL = "INSERT INTO buyer_info (buyer_name,password,buyer_id,real_name,buyer_level,regist_date) VALUES (?,?,?,?,?,?)";
		
		/*java.util.Date date = b.getRegistDate();
		Timestamp registDate = new Timestamp(date.getTime());*/
		Date date = new Date();  
		Timestamp timeStamp = new Timestamp(date.getTime());
		int[] i = helper.insert(SQL, b.getName(),b.getPassword(),b.getId(),b.getRealName(),b.getLevel(),timeStamp);
		
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
					List<String> address = new ArrayList();
					if(rs.getString("buyer_address1")!=null)
						address.add(rs.getString("buyer_address1"));
					if(rs.getString("buyer_address2")!=null)
						address.add(rs.getString("buyer_address2"));
					if(rs.getString("buyer_address3")!=null)
						address.add(rs.getString("buyer_address3"));
					if(rs.getString("buyer_address1")==null&&rs.getString("buyer_address2")==null&&rs.getString("buyer_address3")==null)
						address.add("NULL");
					b.setAddress(address);
					b.setId(rs.getString("buyer_id"));
					b.setRealName(rs.getString("real_name"));
					b.setLevel(rs.getString("buyer_level"));
					b.setRegistDate(rs.getTimestamp("regist_date"));
					b.setEmail(rs.getString("email"));
					
					return b;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public Buyer selectById(String id) {
		String SQL = "SELECT * FROM buyer_info WHERE buyer_id=?";
		ResultSet rs = helper.query(SQL, id);
		if(rs!=null) {
			try {
				while(rs.next()) {
					Buyer b = new Buyer();
					b.setName(rs.getString("buyer_name"));
					b.setPassword(rs.getString("password"));
					b.setGender(rs.getString("buyer_gender"));
					b.setPhone(rs.getString("buyer_phone"));
					List<String> address = new ArrayList();
					if(rs.getString("buyer_address1")!=null)
						address.add(rs.getString("buyer_address1"));
					if(rs.getString("buyer_address2")!=null)
						address.add(rs.getString("buyer_address2"));
					if(rs.getString("buyer_address3")!=null)
						address.add(rs.getString("buyer_address3"));
					if(rs.getString("buyer_address1")==null&&rs.getString("buyer_address2")==null&&rs.getString("buyer_address3")==null)
						address.add("NULL");
					b.setAddress(address);
					b.setId(rs.getString("buyer_id"));
					b.setRealName(rs.getString("real_name"));
					b.setLevel(rs.getString("buyer_level"));
					b.setRegistDate(rs.getTimestamp("regist_date"));
					b.setEmail(rs.getString("email"));
					
					return b;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public boolean complete(Buyer b) {
		
		String fir= "SELECT * FROM buyer_info WHERE buyer_id=?";
		ResultSet rs = helper.query(fir, b.getId());
		int addrcount = b.getAddress().size();
		String SQL = "UPDATE buyer_info SET buyer_gender='"+b.getGender()+"',buyer_phone='"+b.getPhone()+"',buyer_address1='"+b.getAddress().get(0)+"' WHERE buyer_id='"+b.getId()+"'";
		if(rs!=null) {
			try {
				while(rs.next()) {
					if(addrcount==1) {
						if(rs.getString("buyer_address1")==null) {
							SQL = "UPDATE buyer_info SET buyer_gender='"+b.getGender()+"',buyer_phone='"+b.getPhone()+"',buyer_address1='"+b.getAddress().get(0)+"' WHERE buyer_id='"+b.getId()+"'";
						}else if(rs.getString("buyer_address2")==null) {
							SQL = "UPDATE buyer_info SET buyer_gender='"+b.getGender()+"',buyer_phone='"+b.getPhone()+"',buyer_address2='"+b.getAddress().get(0)+"' WHERE buyer_id='"+b.getId()+"'";
						}else if(rs.getString("buyer_address3")==null) {
							SQL = "UPDATE buyer_info SET buyer_gender='"+b.getGender()+"',buyer_phone='"+b.getPhone()+"',buyer_address3='"+b.getAddress().get(0)+"' WHERE buyer_id='"+b.getId()+"'";
						}
					}else if(addrcount==2){
						if(rs.getString("buyer_address1")==null) {
							SQL = "UPDATE buyer_info SET buyer_gender='"+b.getGender()+"',buyer_phone='"+b.getPhone()+"',buyer_address1='"+b.getAddress().get(0)+"',buyer_address2='"+b.getAddress().get(1)+"' WHERE buyer_id='"+b.getId()+"'";
						}else {
							SQL = "UPDATE buyer_info SET buyer_gender='"+b.getGender()+"',buyer_phone='"+b.getPhone()+"',buyer_address2='"+b.getAddress().get(0)+"',buyer_address3='"+b.getAddress().get(1)+"' WHERE buyer_id='"+b.getId()+"'";
						}
					}else if(addrcount==3){
						
							SQL = "UPDATE buyer_info SET buyer_gender='"+b.getGender()+"',buyer_phone='"+b.getPhone()+"',buyer_address1='"+b.getAddress().get(0)+"',buyer_address2='"+b.getAddress().get(1)+"',buyer_address3='"+b.getAddress().get(2)+"' WHERE buyer_id='"+b.getId()+"'";
						
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		int i = helper.update(SQL);
		
		return (i>0)?true:false;
	}
	
	public boolean delete(Buyer b) {
		String SQL = "DELETE FROM buyer_info WHERE buyer_id='"+b.getId()+"'";
		int i = helper.update(SQL);
		return (i>0)?true:false;
	}
	
	public Map listAll() {
		String SQL = "SELECT * FROM buyer_info";
		ResultSet rs = helper.query(SQL);
		Map map = new HashMap();
		try {
			while(rs.next()) {
				
				Buyer b = new Buyer();
				b.setName(rs.getString("buyer_name"));
				List<String> address = new ArrayList();
				if(rs.getString("buyer_address1")!=null)
					address.add(rs.getString("buyer_address1"));
				if(rs.getString("buyer_address2")!=null)
					address.add(rs.getString("buyer_address2"));
				if(rs.getString("buyer_address3")!=null)
					address.add(rs.getString("buyer_address3"));
				if(rs.getString("buyer_address1")==null&&rs.getString("buyer_address2")==null&&rs.getString("buyer_address3")==null)
					address.add("NULL");
				b.setAddress(address);
				b.setGender(rs.getString("buyer_gender"));
				b.setId(rs.getString("buyer_id"));		
				b.setLevel(rs.getString("buyer_level"));
				b.setPhone(rs.getString("buyer_phone"));
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
