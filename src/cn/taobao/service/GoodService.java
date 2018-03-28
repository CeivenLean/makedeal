package cn.taobao.service;

import java.util.Map;

import cn.taobao.dao.GoodDao;
import cn.taobao.entity.Good;
import cn.taobao.util.PageUtil;

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

}
