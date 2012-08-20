package com.bst.pro.bo;

public class StockDayData {
	int date;	//日期
	int open;	//开盘价
	int high;	//最高价
	int low;	//最低价
	int close;	//收盘价
	int amount;	//
	int vol;	//成交量
	int reservation;	//保留
	public int getDate() {
		return date;
	}
	public void setDate(int date) {
		this.date = date;
	}
	public int getOpen() {
		return open;
	}
	public void setOpen(int open) {
		this.open = open;
	}
	public int getHigh() {
		return high;
	}
	public void setHigh(int high) {
		this.high = high;
	}
	public int getLow() {
		return low;
	}
	public void setLow(int low) {
		this.low = low;
	}
	public int getClose() {
		return close;
	}
	public void setClose(int close) {
		this.close = close;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getVol() {
		return vol;
	}
	public void setVol(int vol) {
		this.vol = vol;
	}
	public int getReservation() {
		return reservation;
	}
	public void setReservation(int reservation) {
		this.reservation = reservation;
	}
	
	
}
