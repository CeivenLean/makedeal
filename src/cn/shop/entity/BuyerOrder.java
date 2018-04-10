package cn.shop.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

public class BuyerOrder implements Serializable {

	private static final long serialVersionUID = 7979952986452600426L;
	
	private String serialNumber;
	private double transactionAmount;
	private Timestamp orderDate;
	private String buyerId;
	private String address;
	private Map<Integer,Integer> goodsInfo;
	public String getSerialNumber() {
		return serialNumber;
	}
	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}
	public double getTransactionAmount() {
		return transactionAmount;
	}
	public void setTransactionAmount(double transactionAmount) {
		this.transactionAmount = transactionAmount;
	}
	
	public Timestamp getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Timestamp orderDate) {
		this.orderDate = orderDate;
	}
	public String getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Map<Integer, Integer> getGoodsInfo() {
		return goodsInfo;
	}
	public void setGoodsInfo(Map<Integer, Integer> goodsInfo) {
		this.goodsInfo = goodsInfo;
	}
	
	

}
