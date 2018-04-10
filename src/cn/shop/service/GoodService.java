package cn.shop.service;

import java.util.Map;

import cn.shop.dao.GoodDao;
import cn.shop.entity.Good;
import cn.shop.entity.Seller;
import cn.shop.util.PageUtil;

public class GoodService {
	
	GoodDao gd = new GoodDao();
	
	public long publish(Good g) {
		if(g!=null) {
			return gd.publish(g);
		}
		return 0;
	}
	
	public int totalCount(String value) {
		return gd.totalCount(value);
	}
	public int listSortTotalCount(String sort) {
		return gd.listSortTotalCount(sort);
	}
	
	public Map<Integer,Good> list(String value,PageUtil pageUtil) {
		
		return gd.list(value,pageUtil);
	}
	
	public Map<Integer,Good> listBySort(String sort,PageUtil pageUtil) {
		
		return gd.listBySort(sort,pageUtil);
	}
	
	public Good select(Integer key) {
		return gd.select(key);
	}
	
	public Map listAll() {
		return gd.listAll();
	}
	public Map listBySeller(Seller seller) {
		return gd.listBySeller(seller);
	}
	
	public boolean save(Map map) {
		return gd.save(map);
	}
	
	public boolean delById(int id) {
		return gd.delById(id);
	}
	
	public Map<Integer,Good> listByPublishDate() {
		return gd.listByPublishDate();
	}

}
