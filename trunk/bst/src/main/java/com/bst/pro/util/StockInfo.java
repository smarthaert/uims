package com.bst.pro.util;

public class StockInfo {
	private String stockCode = null;
	private String stockName = null;
	private int stockQuantity;
	private int avilableSellQty;
	private float stockValue;
	private float lastPrice;
	private float costPrice;
	private float profit;
	private String fundAccount = null;

	public StockInfo(String stockCode, String stockName, int stockQuantity,
			int avilableSellQty, float stockValue, float lastPrice,
			float costPrice, float profit, String fundAccount) {
		super();
		this.stockCode = stockCode;
		this.stockName = stockName;
		this.stockQuantity = stockQuantity;
		this.avilableSellQty = avilableSellQty;
		this.stockValue = stockValue;
		this.lastPrice = lastPrice;
		this.costPrice = costPrice;
		this.profit = profit;
		this.fundAccount = fundAccount;
	}

	public StockInfo() {
		// TODO Auto-generated constructor stub
	}

	public String getStockCode() {
		return stockCode;
	}

	public void setStockCode(String stockCode) {
		this.stockCode = stockCode;
	}

	public String getStockName() {
		return stockName;
	}

	public void setStockName(String stockName) {
		this.stockName = stockName;
	}

	public int getStockQuantity() {
		return stockQuantity;
	}

	public void setStockQuantity(int stockQuantity) {
		this.stockQuantity = stockQuantity;
	}

	public int getAvilableSellQty() {
		return avilableSellQty;
	}

	public void setAvilableSellQty(int avilableSellQty) {
		this.avilableSellQty = avilableSellQty;
	}

	public float getStockValue() {
		return stockValue;
	}

	public void setStockValue(float stockValue) {
		this.stockValue = stockValue;
	}

	public float getLastPrice() {
		return lastPrice;
	}

	public void setLastPrice(float lastPrice) {
		this.lastPrice = lastPrice;
	}

	public float getCostPrice() {
		return costPrice;
	}

	public void setCostPrice(float costPrice) {
		this.costPrice = costPrice;
	}

	public float getProfit() {
		return profit;
	}

	public void setProfit(float profit) {
		this.profit = profit;
	}

	public String getFundAccount() {
		return fundAccount;
	}

	public void setFundAccount(String fundAccount) {
		this.fundAccount = fundAccount;
	}

}
