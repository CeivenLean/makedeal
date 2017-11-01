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
	
	public Map<Integer,Good> list(String value,PageUtil pageUtil) {
		
		return gd.list(value,pageUtil);
	}
	
	public Good select(Integer key) {
		return gd.select(key);
	}

}
