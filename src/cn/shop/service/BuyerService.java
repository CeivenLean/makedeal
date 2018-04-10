package cn.shop.service;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

import cn.shop.dao.BuyerDao;
import cn.shop.entity.Buyer;

public class BuyerService {
	
	BuyerDao bd = new BuyerDao();
	
	//注册操作
	public boolean regist(Buyer b) {
		if( b!=null ) {
			b.setLevel("青铜");
			/*b.setRegistDate(new Timestamp(new Date().getTime()));*/
			return bd.regist(b);
		}
		return false;
	}
	
	//登录操作
	public Buyer search(String name,String password) {
		
		return bd.search(name,password);
		
	}
	public Buyer selectById(String id) {
		
		return bd.selectById(id);
		
	}
	
	public boolean complete(Buyer b) {
		return bd.complete(b);
	}
	
	public boolean delete(Buyer b) {
		return bd.delete(b);
	}
	
	public Map listAll() {
		return bd.listAll();
	}

}
