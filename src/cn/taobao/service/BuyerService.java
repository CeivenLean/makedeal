package cn.taobao.service;

import java.util.Date;

import cn.taobao.dao.BuyerDao;
import cn.taobao.entity.Buyer;

public class BuyerService {
	
	BuyerDao bd = new BuyerDao();
	
	//注册操作
	public boolean regist(Buyer b) {
		if( b!=null ) {
			b.setLevel("青铜");
			b.setRegistDate(new Date());
			return bd.regist(b);
		}
		return false;
	}
	
	//登录操作
	public Buyer search(String name,String password) {
		
		return bd.search(name,password);
		
	}
	
	public boolean complete(Buyer b) {
		return bd.complete(b);
	}
	
	public boolean delete(Buyer b) {
		return bd.delete(b);
	}

}
