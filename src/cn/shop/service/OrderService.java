package cn.shop.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import cn.shop.dao.OrderDao;
import cn.shop.entity.Buyer;
import cn.shop.entity.BuyerOrder;
import cn.shop.entity.Good;
import cn.shop.entity.Seller;
import cn.shop.entity.SellerOrder;

public class OrderService {
	
	OrderDao od = new OrderDao();
	
	public boolean saveOrder(BuyerOrder bo,Map<Seller,Map<Integer,Integer>> sellerMap) {
		if( bo!=null&&sellerMap!=null ) {
			bo.setSerialNumber(UUID.randomUUID().toString().replaceAll("-", ""));
			bo.setOrderDate(new Timestamp(new Date().getTime()));
			
			return od.save(bo,sellerMap);
		}
		return false;
	}
	
	public Map list(Buyer b){
		return od.list(b);
	}
	public Map listBySeller(Seller s){
		return od.listBySeller(s);
	}
	public Map listToday(Seller s){
		return od.listToday(s);
	}
	
	public Map listAll() {
		return od.listAll();
	}

}
