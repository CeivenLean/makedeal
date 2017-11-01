package cn.taobao.util;

import cn.taobao.exception.DataAccessException;

public interface Runner {
	
	void doInTransaction() throws DataAccessException ;

}
