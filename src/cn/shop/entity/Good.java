package cn.shop.entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class Good implements Serializable {

	private static final long serialVersionUID = -7232105454172181497L;
	
	private Integer goodId;
	private String sellerName;
	private String goodTitle;
	private String goodDesc;
	private double goodPrice;
	
	private Timestamp publishDate;
	
	private String sort1;
	private String sort2;
	private String sort3;
	
	private int status;
	
	public Integer getGoodId() {
		return goodId;
	}
	public void setGoodId(Integer goodId) {
		this.goodId = goodId;
	}

	public String getGoodTitle() {
		return goodTitle;
	}
	public void setGoodTitle(String goodTitle) {
		this.goodTitle = goodTitle;
	}
	public String getGoodDesc() {
		return goodDesc;
	}
	public void setGoodDesc(String goodDesc) {
		this.goodDesc = goodDesc;
	}
	public double getGoodPrice() {
		return goodPrice;
	}
	public void setGoodPrice(double goodPrice) {
		this.goodPrice = goodPrice;
	}
	public String getSellerName() {
		return sellerName;
	}
	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}
	public String getSort1() {
		return sort1;
	}
	public void setSort1(String sort1) {
		this.sort1 = sort1;
	}
	public String getSort2() {
		return sort2;
	}
	public void setSort2(String sort2) {
		this.sort2 = sort2;
	}
	public String getSort3() {
		return sort3;
	}
	public void setSort3(String sort3) {
		this.sort3 = sort3;
	}
	public Timestamp getPublishDate() {
		return publishDate;
	}
	public void setPublishDate(Timestamp publishDate) {
		this.publishDate = publishDate;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	

}
