package com.bst.pro.bo;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class HistoricalPrices {

	@Id
	String _id;
	public HistoricalPrices() {
		
	}

	Date date = null; // Date
	double open; // Open
	double high; // High
	double low; // Low
	double close; // Close
	long volume; // Volume

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public double getOpen() {
		return open;
	}

	public void setOpen(double open) {
		this.open = open;
	}

	public double getHigh() {
		return high;
	}

	public void setHigh(double high) {
		this.high = high;
	}

	public double getLow() {
		return low;
	}

	public void setLow(double low) {
		this.low = low;
	}

	public double getClose() {
		return close;
	}

	public void setClose(double close) {
		this.close = close;
	}

	public long getVolume() {
		return volume;
	}

	public void setVolume(long volume) {
		this.volume = volume;
	}
}
