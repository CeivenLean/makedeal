package cn.shop.service;

import java.util.Map;

import cn.shop.dao.ShoppingCartDao;
import cn.shop.entity.Buyer;
import cn.shop.entity.BuyerShoppingCart;

public class ShoppingCartService {
	
	ShoppingCartDao scd = new ShoppingCartDao();
	
	public boolean add(BuyerShoppingCart sc) {
	
		return scd.add(sc);
	}
	
	public Map<Integer,BuyerShoppingCart> list(Buyer b){
		return scd.list(b);
	}
	
	public Map<Integer,BuyerShoppingCart> list(String[] ids){
		return scd.list(ids);
	}
	
	public int update(Integer id,int act) {
		return scd.update(id,act);
	}
	
	public int deleteById(String[] cartIds) {
		return scd.deleteById(cartIds);
	}

}
