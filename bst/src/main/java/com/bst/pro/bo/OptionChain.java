package com.bst.pro.bo;

import java.util.Date;

public class OptionChain {
	
	public OptionChain() {
		
	}
	Date expiration = null;	//expiration
	String opt = null;		//Calls & Puts
	double strike;	//Strike 
	double price;	//Price 
	double change;	//Change 
	double bid;		//Bid 
	double ask;		//Ask 
	long volume;	//Volume 
	long openInt;	//Open Int 
	public Date getExpiration() {
		return expiration;
	}
	public void setExpiration(Date expiration) {
		this.expiration = expiration;
	}
	public String getOpt() {
		return opt;
	}
	public void setOpt(String opt) {
		this.opt = opt;
	}
	public double getStrike() {
		return strike;
	}
	public void setStrike(double strike) {
		this.strike = strike;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getChange() {
		return change;
	}
	public void setChange(double change) {
		this.change = change;
	}
	public double getBid() {
		return bid;
	}
	public void setBid(double bid) {
		this.bid = bid;
	}
	public double getAsk() {
		return ask;
	}
	public void setAsk(double ask) {
		this.ask = ask;
	}
	public long getVolume() {
		return volume;
	}
	public void setVolume(long volume) {
		this.volume = volume;
	}
	public long getOpenInt() {
		return openInt;
	}
	public void setOpenInt(long openInt) {
		this.openInt = openInt;
	}
	
}
