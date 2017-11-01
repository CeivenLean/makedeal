package cn.taobao.service;

import java.util.Map;

import cn.taobao.dao.ShoppingCartDao;
import cn.taobao.entity.Buyer;
import cn.taobao.entity.BuyerShoppingCart;

public class ShoppingCartService {
	
	ShoppingCartDao scd = new ShoppingCartDao();
	
	public boolean add(BuyerShoppingCart sc) {
	
		return scd.add(sc);
	}
	
	public Map<Integer,BuyerShoppingCart> list(Buyer b){
		return scd.list(b);
	}
	
	public int update(Integer id,int act) {
		return scd.update(id,act);
	}

}
