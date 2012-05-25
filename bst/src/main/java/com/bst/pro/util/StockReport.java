package com.bst.pro.util;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class StockReport {
	private String bz = null;
	private String stockAccount = null;
	private float startFund = 0;
	private float yesFund = 0;
	private float avilableFund = 0;
	private float stockValue = 0;
	private float fundValue = 0;
	private float leave = 0;
	public StockReport(Document doc) {
		super();
		buildSRFromDoc(doc);
	}
	private void buildSRFromDoc(Document doc) {
		this.bz = doc.select("table tr:eq(1) td:eq(0)").html();
		this.stockAccount = doc.select("table tr:eq(1) td:eq(1)").html();
		this.startFund = Float.parseFloat(doc.select("table tr:eq(1) td:eq(2)").html());
		this.yesFund = Float.parseFloat(doc.select("table tr:eq(1) td:eq(3)").html());
		this.avilableFund = Float.parseFloat(doc.select("table tr:eq(1) td:eq(4)").html());
		this.stockValue = Float.parseFloat(doc.select("table tr:eq(1) td:eq(5)").html());
		this.fundValue = Float.parseFloat(doc.select("table tr:eq(1) td:eq(6)").html());
		this.leave = Float.parseFloat(doc.select("table tr:eq(1) td:eq(7)").html());
	}
	public StockReport(String docStr) {
		super();
		buildSRFromDoc(Jsoup.parse(docStr));
	}
	
}
