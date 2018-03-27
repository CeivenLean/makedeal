package cn.taobao.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import cn.taobao.entity.Buyer;
import cn.taobao.entity.BuyerOrder;
import cn.taobao.entity.BuyerShoppingCart;
import cn.taobao.util.*;

public class OrderDao {
	
	JdbcHelper helper = new JdbcHelper();
	
	public boolean save(BuyerOrder bo) {
		
		String SQL = "INSERT INTO order_info (serial_number,transaction_amount,order_date,buyer_id,goods_info) VALUES (?,?,?,?,?)";
		
		java.util.Date date = bo.getOrderDate();
		java.sql.Date date2 = new java.sql.Date(date.getTime());
		
		int[] i = helper.insert(SQL, bo.getSerialNumber(),bo.getTransactionAmount(),date2,bo.getBuyerId(),bo.getGoodsInfo().toString());
		
		return (i!=null&&i.length>0)?true:false;
	}
	
	public  Map list(Buyer b) {
		String SQL = "SELECT serial_number,transaction_amount,order_date,goods_info FROM order_info WHERE buyer_id="+b.getId()+" ORDER BY order_date DESC";
		ResultSet rs = helper.query(SQL);
		Map map = new LinkedHashMap<>();
		try {
			while(rs.next()) {
				BuyerOrder od = new BuyerOrder();
				od.setSerialNumber(rs.getString("serial_number"));
				od.setTransactionAmount(rs.getDouble("transaction_amount"));
				od.setOrderDate(rs.getDate("order_date"));
				String goods = rs.getString("goods_info");
				Map m1 = StringHelper.toMap(goods);
				Map m2 = StringHelper.reset(m1);
				od.setGoodsInfo(m2);
				
				map.put(od.getSerialNumber(),od);
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
		
	}


}
