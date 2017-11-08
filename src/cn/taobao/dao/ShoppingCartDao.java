package cn.taobao.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import cn.taobao.entity.Buyer;
import cn.taobao.entity.BuyerShoppingCart;
import cn.taobao.util.JdbcHelper;

public class ShoppingCartDao {
	
	JdbcHelper helper = new JdbcHelper();
	
	public boolean add(BuyerShoppingCart sc) {
		
		ResultSet rs = helper.query("SELECT * FROM shopping_cart WHERE buyer_id="+sc.getBuyerId()+" AND good_id="+sc.getGoodId());
		if(helper.next(rs)) {
			return false;
		}
			
		String SQL = "INSERT INTO shopping_cart (buyer_id,good_id,good_title,good_price) VALUES (?,?,?,?)";
		
		int[] i = helper.insert(SQL, sc.getBuyerId(),sc.getGoodId(),sc.getGoodTitle(),sc.getGoodPrice());
		
		return (i!=null&&i.length>0)?true:false;
		
		
		
	}
	
	public Map<Integer,BuyerShoppingCart> list(Buyer b){
		String SQL = "SELECT * FROM shopping_cart WHERE buyer_id=?";
		
		ResultSet rs = helper.query(SQL, b.getId());
		Map<Integer,BuyerShoppingCart> map = new HashMap<>();
		try {
			while(rs.next()) {
				BuyerShoppingCart sc = new BuyerShoppingCart();
				
				sc.setCartId(rs.getInt("cart_id"));
				sc.setBuyerId(rs.getString("buyer_id"));
				sc.setGoodId(rs.getInt("good_id"));
				sc.setGoodTitle(rs.getString("good_title"));
				sc.setGoodPrice(rs.getDouble("good_price"));
				sc.setGoodCount(rs.getInt("good_count"));
				map.put(sc.getCartId(), sc);
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Map<Integer,BuyerShoppingCart> list(String[] ids){
		StringBuilder nums = new StringBuilder();
		if(ids!=null) {
			for(int i=0;i<ids.length;i++) {
				nums.append(ids[i]);
				if(i!=ids.length-1) {
					nums.append(",");
				}
			}
		}
		String SQL = "SELECT * FROM shopping_cart WHERE cart_id IN ("+nums+")";
		
		ResultSet rs = helper.query(SQL);
		Map<Integer,BuyerShoppingCart> map = new HashMap<>();
		try {
			while(rs.next()) {
				BuyerShoppingCart sc = new BuyerShoppingCart();
				
				sc.setCartId(rs.getInt("cart_id"));
				sc.setBuyerId(rs.getString("buyer_id"));
				sc.setGoodId(rs.getInt("good_id"));
				sc.setGoodTitle(rs.getString("good_title"));
				sc.setGoodPrice(rs.getDouble("good_price"));
				sc.setGoodCount(rs.getInt("good_count"));
				map.put(sc.getCartId(), sc);
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(Integer id,int act) {
		String SQL = null;
		if(act==0) {
			SQL = "UPDATE shopping_cart SET good_count=good_count-1 WHERE cart_id='"+id+"'";
		}
		if(act==1) {
			SQL = "UPDATE shopping_cart SET good_count=good_count+1 WHERE cart_id='"+id+"'";
		}
		
		helper.update(SQL);
		
		SQL = "SELECT good_count FROM shopping_cart WHERE cart_id='"+id+"'";
		ResultSet rs = helper.query(SQL);
		int count = 0;
		if(helper.next(rs)) {
			try {
				count = rs.getInt("good_count");
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		String SQLExtend = "DELETE FROM shopping_cart WHERE good_count=0";
		helper.update(SQLExtend);
		return count;
		
		
		
	}

}
