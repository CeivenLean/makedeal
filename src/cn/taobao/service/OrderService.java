package cn.taobao.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;
import java.util.UUID;

import cn.taobao.dao.OrderDao;
import cn.taobao.entity.Buyer;
import cn.taobao.entity.BuyerOrder;

public class OrderService {
	
	OrderDao od = new OrderDao();
	
	public boolean saveOrder(BuyerOrder bo) {
		if( bo!=null ) {
			bo.setSerialNumber(UUID.randomUUID().toString().replaceAll("-", ""));
			bo.setOrderDate(new Timestamp(new Date().getTime()));
			return od.save(bo);
		}
		return false;
	}
	
	public Map list(Buyer b){
		return od.list(b);
	}
	
	public Map listAll() {
		return od.listAll();
	}

}
