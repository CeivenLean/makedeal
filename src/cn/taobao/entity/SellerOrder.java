package cn.taobao.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Map;

public class SellerOrder implements Serializable {

	private static final long serialVersionUID = -7515711078362000348L;
	
	private Seller seller;
	private Buyer buyer;
	private String address;
	private String serialNumber;
	private double orderPrice;
	private Timestamp orderDate;
	private Map goodsInfo;
	public Seller getSeller() {
		return seller;
	}
	public void setSeller(Seller seller) {
		this.seller = seller;
	}
	public Buyer getBuyer() {
		return buyer;
	}
	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public double getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(double orderPrice) {
		this.orderPrice = orderPrice;
	}
	public Timestamp getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}
	
	public Map getGoodsInfo() {
		return goodsInfo;
	}
	public void setGoodsInfo(Map goodsInfo) {
		this.goodsInfo = goodsInfo;
	}
	
	
}
