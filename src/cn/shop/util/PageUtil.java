package cn.shop.util;

import java.util.Map;

import cn.shop.entity.Good;

public class PageUtil<T> {
	
	private int pageCount;
	private int pageIndex=1;
	private int[] pageNums;
	private int recordCount;
	private int pageSize=4;
	private Map<Integer,Good> datas;
	private String where;
	
	public int getPageCount() {
		this.pageCount=(recordCount+pageSize-1)/pageSize;
		return this.pageCount;
	}
	
	public void setPageIndex(int pageIndex) {
		if(pageIndex<1) {
			this.pageIndex=1;
		}else if(pageIndex>getPageCount()) {
			this.pageIndex=getPageCount();
		}else {
			this.pageIndex=pageIndex;
		}
	}
	
	public void setPageNums(int displayPageNumber) {
		if(this.getPageCount()<=displayPageNumber) {
			pageNums=new int[this.getPageCount()];
			for(int i=1;i<=this.getPageCount();i++) {
				pageNums[i-1]=i;
			}
		}else if(this.getPageIndex()-displayPageNumber/2>0 && this.getPageIndex()+displayPageNumber/2<this.getPageCount()) {
			pageNums=new int[displayPageNumber];
			for(int i=this.getPageIndex()-displayPageNumber/2,_index=0;i<=this.getPageIndex()+displayPageNumber/2;i++,_index++) {
				pageNums[_index]=i;
			}
		}else if(this.getPageIndex()-displayPageNumber/2>0 && this.getPageIndex()+displayPageNumber/2>=this.getPageCount()) {
			pageNums=new int[displayPageNumber];
			for(int i=this.getPageCount()-displayPageNumber+1,_index=0;i<=this.getPageCount();i++,_index++) {
				pageNums[_index]=i;
			}
		}else {
			pageNums=new int[displayPageNumber];
			for(int i=1;i<=displayPageNumber;i++) {
				pageNums[i-1]=i;
			}
		}
	}

	public int[] getPageNums() {
		return pageNums;
	}

	public void setPageNums(int[] pageNums) {
		this.pageNums = pageNums;
	}

	public int getRecordCount() {
		return recordCount;
	}

	public void setRecordCount(int recordCount) {
		this.recordCount = recordCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public Map<Integer,Good> getDatas() {
		return datas;
	}

	public void setDatas(Map<Integer,Good> datas) {
		this.datas = datas;
	}

	public String getWhere() {
		return where;
	}

	public void setWhere(String where) {
		this.where = where;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	
	
}
