package cn.shop.util;

import cn.shop.exception.DataAccessException;

public interface Runner {
	
	void doInTransaction() throws DataAccessException ;

}
