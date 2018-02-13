package cn.taobao.dao;

import cn.taobao.entity.BuyerOrder;
import cn.taobao.util.JdbcHelper;

public class OrderDao {
	
	JdbcHelper helper = new JdbcHelper();
	
	public boolean save(BuyerOrder bo) {
		
		String SQL = "INSERT INTO order_info (serial_number,transaction_amount,order_date,buyer_id,goods_info) VALUES (?,?,?,?,?)";
		
		java.util.Date date = bo.getOrderDate();
		java.sql.Date date2 = new java.sql.Date(date.getTime());
		
		int[] i = helper.insert(SQL, bo.getSerialNumber(),bo.getTransactionAmount(),date2,bo.getBuyerId(),bo.getGoodsInfo().toString());
		
		return (i!=null&&i.length>0)?true:false;
	}

}
