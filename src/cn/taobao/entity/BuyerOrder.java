package cn.taobao.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

public class BuyerOrder implements Serializable {

	private static final long serialVersionUID = 7979952986452600426L;
	
	private String serialNumber;
	private double transactionAmount;
	private Date orderDate;
	private String buyerId;
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
	public Date getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}
	public String getBuyerId() {
		return buyerId;
	}
	public void setBuyerId(String buyerId) {
		this.buyerId = buyerId;
	}
	public Map<Integer, Integer> getGoodsInfo() {
		return goodsInfo;
	}
	public void setGoodsInfo(Map<Integer, Integer> goodsInfo) {
		this.goodsInfo = goodsInfo;
	}
	
	

}
