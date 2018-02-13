package cn.taobao.service;

import java.util.Date;
import java.util.UUID;

import cn.taobao.dao.OrderDao;
import cn.taobao.entity.BuyerOrder;

public class OrderService {
	
	OrderDao od = new OrderDao();
	
	public boolean saveOrder(BuyerOrder bo) {
		if( bo!=null ) {
			bo.setSerialNumber(UUID.randomUUID().toString().replaceAll("-", ""));
			bo.setOrderDate(new Date());
			return od.save(bo);
		}
		return false;
	}	

}
