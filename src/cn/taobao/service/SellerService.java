package cn.taobao.service;

import java.util.Date;

import cn.taobao.dao.SellerDao;
import cn.taobao.entity.Seller;

public class SellerService {
	
	SellerDao sd = new SellerDao();
	
	public boolean regist(Seller s) {
		if( s!=null ) {
			s.setLevel("青铜");
			s.setRegistDate(new Date());
			return sd.regist(s);
		}
		return false;
	}
	
	public Seller search(String name,String password) {
		
		return sd.search(name,password);
		
	}
	
	public boolean complete(Seller s) {
		return sd.complete(s);
	}
	
	public boolean delete(Seller s) {
		return sd.delete(s);
	}
	
	public Seller select(String name) {
		return sd.select(name);
	}

}
