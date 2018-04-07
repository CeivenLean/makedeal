package cn.taobao.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

import cn.taobao.entity.Buyer;
import cn.taobao.entity.BuyerOrder;
import cn.taobao.entity.Good;
import cn.taobao.entity.Seller;
import cn.taobao.entity.SellerOrder;
import cn.taobao.service.BuyerService;
import cn.taobao.service.GoodService;
import cn.taobao.util.JdbcHelper;
import cn.taobao.util.StringHelper;

public class OrderDao {
	
	JdbcHelper helper = new JdbcHelper();
	GoodService gs = new GoodService();
	public boolean save(BuyerOrder bo,Map<Seller,Map<Integer,Integer>> sellerMap) {
		String SQL = "INSERT INTO order_info (serial_number,transaction_amount,order_date,buyer_id,goods_info,address) VALUES (?,?,?,?,?,?)";
		String sellerOrderSQL = "INSERT INTO seller_order (seller_id,serial_number,order_price,order_date,goods_info,buyer_id,address) VALUES (?,?,?,?,?,?,?)";
		for(Seller s:sellerMap.keySet()) {
			String col1 = s.getId();
			String col2 = UUID.randomUUID().toString().replaceAll("-", "");
			Map<Integer,Integer> tmp = sellerMap.get(s);
			double price = 0;
			for(Integer goodId:tmp.keySet()) {
				Good g = gs.select(goodId);
				price+=tmp.get(goodId)*g.getGoodPrice();
			}
			double col3 = price;
			Timestamp col4 = new Timestamp(new Date().getTime());
			String col5 = tmp.toString();
			String col6 = bo.getBuyerId();
			int[] j = helper.insert(sellerOrderSQL, col1,col2,col3,col4,col5,col6,bo.getAddress());
			if(j==null||j.length<=0) {
				return false;
			}
		}
		int[] i = helper.insert(SQL, bo.getSerialNumber(),bo.getTransactionAmount(),bo.getOrderDate(),bo.getBuyerId(),bo.getGoodsInfo().toString(),bo.getAddress());
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
				od.setOrderDate(rs.getTimestamp("order_date"));
				String goods = rs.getString("goods_info");
				Map m1 = StringHelper.toMap(goods);
				Map m2 = StringHelper.reset(m1);
				od.setGoodsInfo(m2);
				od.setAddress(rs.getString("address"));
				map.put(od.getSerialNumber(),od);
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	public  Map listBySeller(Seller s) {
		String SQL = "SELECT * FROM seller_order WHERE seller_id="+s.getId()+" AND to_days(order_date) != to_days(now()) ORDER BY order_date DESC";
		ResultSet rs = helper.query(SQL);
		Map map = new LinkedHashMap<>();
		try {
			while(rs.next()) {
				SellerOrder so = new SellerOrder();
				so.setSeller(s);
				so.setSerialNumber(rs.getString("serial_number"));
				so.setOrderPrice(rs.getDouble("order_price"));
				so.setOrderDate(rs.getTimestamp("order_date"));
				String goods = rs.getString("goods_info");
				Map m1 = StringHelper.toMap(goods);
				Map m2 = StringHelper.reset(m1);
				so.setGoodsInfo(m2);
				so.setAddress(rs.getString("address"));
				String buyerid = rs.getString("buyer_id");
				BuyerService bs = new BuyerService();
				Buyer buyer = bs.selectById(buyerid);
				so.setBuyer(buyer);
				map.put(so.getSerialNumber(),so);
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	public  Map listToday(Seller s) {
		String SQL = "SELECT * FROM seller_order WHERE seller_id="+s.getId()+" AND to_days(order_date) = to_days(now())";
		ResultSet rs = helper.query(SQL);
		Map map = new LinkedHashMap<>();
		try {
			while(rs.next()) {
				SellerOrder so = new SellerOrder();
				so.setSeller(s);
				
				so.setSerialNumber(rs.getString("serial_number"));
				so.setOrderPrice(rs.getDouble("order_price"));
				so.setOrderDate(rs.getTimestamp("order_date"));
				String goods = rs.getString("goods_info");
				Map<String,String> m1 = StringHelper.toMap(goods);
				Map<Good,Integer> m2 = new HashMap<Good,Integer>();
				for(Map.Entry<String,String> entry:m1.entrySet()) {
					Good good = gs.select(Integer.valueOf(entry.getKey()));
					Integer count = Integer.valueOf(entry.getValue());
					m2.put(good, count);
				}
				so.setGoodsInfo(m2);
				so.setAddress(rs.getString("address"));
				String buyerid = rs.getString("buyer_id");
				BuyerService bs = new BuyerService();
				Buyer buyer = bs.selectById(buyerid);
				so.setBuyer(buyer);
				map.put(so.getSerialNumber(),so);
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
	public  Map listAll() {
		String SQL = "SELECT serial_number,transaction_amount,order_date,buyer_id,goods_info FROM order_info ORDER BY order_date DESC";
		ResultSet rs = helper.query(SQL);
		Map map = new LinkedHashMap<>();
		try {
			while(rs.next()) {
				BuyerOrder od = new BuyerOrder();
				od.setSerialNumber(rs.getString("serial_number"));
				od.setTransactionAmount(rs.getDouble("transaction_amount"));
				od.setOrderDate(rs.getTimestamp("order_date"));
				String goods = rs.getString("goods_info");
				Map m1 = StringHelper.toMap(goods);
				Map m2 = StringHelper.reset(m1);
				od.setGoodsInfo(m2);
				od.setAddress(rs.getString("address"));
				map.put(od.getSerialNumber(),od);
			}
			return map;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
		
	}


}
