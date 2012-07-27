package com.bst.pro.bo;

import java.io.File;
import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;

import com.bst.pro.util.PanKou;

public class GTPanKou extends PanKou {
	public static void main(String[] args) {
		try {
			Document doc = Jsoup.parse(new File(
					"D:\\html\\getHqUrl.html"), "utf-8");
			PanKou pk  = new GTPanKou(doc, 1);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public GTPanKou(Document doc, int level) {
		super(doc, level);
		//解析扩展信息
		
	}

	public void buildLevel1(Document doc) {
		Element pk = doc.select("table[class=subtable1]:eq(0)").get(0);

		this.sellPrice5 = Double.parseDouble(pk
				.select("tr:eq(1) td:eq(1) a font").html());
		this.sellQuantity5 = Integer.parseInt(pk.select(
				"tr:eq(1) td:eq(2)").html());

		this.sellPrice4 = Double.parseDouble(pk
				.select("tr:eq(2) td:eq(1) a font").html());
		this.sellQuantity4 = Integer.parseInt(pk.select(
				"tr:eq(2) td:eq(2)").html());

		this.sellPrice3 = Double.parseDouble(pk
				.select("tr:eq(3) td:eq(1) a font").html());
		this.sellQuantity3 = Integer.parseInt(pk.select(
				"tr:eq(3) td:eq(2)").html());

		this.sellPrice2 = Double.parseDouble(pk
				.select("tr:eq(4) td:eq(1) a font").html());
		this.sellQuantity2 = Integer.parseInt(pk.select(
				"tr:eq(4) td:eq(2)").html());

		this.sellPrice1 = Double.parseDouble(pk
				.select("tr:eq(5) td:eq(1) a font").html());
		this.sellQuantity1 = Integer.parseInt(pk.select(
				"tr:eq(5) td:eq(2)").html());

		// jump one row

		this.buyPrice1 = Double.parseDouble(pk.select("tr:eq(7) td:eq(1) a font")
				.html());
		this.buyQuantity1 = Integer.parseInt(pk.select(
				"tr:eq(7) td:eq(2)").html());

		this.buyPrice2 = Double.parseDouble(pk.select("tr:eq(8) td:eq(1) a font")
				.html());
		this.buyQuantity2 = Integer.parseInt(pk.select(
				"tr:eq(8) td:eq(2)").html());

		this.buyPrice3 = Double.parseDouble(pk.select("tr:eq(9) td:eq(1) a font")
				.html());
		this.buyQuantity3 = Integer.parseInt(pk.select(
				"tr:eq(9) td:eq(2)").html());

		this.buyPrice4 = Double.parseDouble(pk.select("tr:eq(10) td:eq(1) a font")
				.html());
		this.buyQuantity4 = Integer.parseInt(pk.select(
				"tr:eq(10) td:eq(2)").html());

		this.buyPrice5 = Double.parseDouble(pk
				.select("tr:eq(11) td:eq(1) a font").html());
		this.buyQuantity5 = Integer.parseInt(pk.select(
				"tr:eq(11) td:eq(2)").html());

	}

	public void buildLevel1(String docStr) {
		// TODO Auto-generated method stub

	}

	public void buildLevel2(Document doc) {
		// TODO Auto-generated method stub
	}

	public void buildLevel2(String docStr) {
		// TODO Auto-generated method stub

	}
	
	private String zqmc = null;
	//证券名称： 交运股份 
	private String zqdm = null;
	//证券代码： 600676 
	private double jkp;
	//今开盘： 4.49 
	private double zsp;
	//昨收盘： 4.50 
	private double zgj;
	//最高价： 4.76 
	private double zdj;
	//最低价： 4.48 
	private double zd;
	//涨跌： 0.22 
	private long zcjl;
	//总成交量： 4057523 
	private double zje;
	//总金额： 18925973.00 
	private double dqj;
	//当前价： 4.71 
	private double ztj;
	//涨停价： 4.95 
	private double dtj;
	//跌停价： 
	public String getZqmc() {
		return zqmc;
	}

	public void setZqmc(String zqmc) {
		this.zqmc = zqmc;
	}

	public String getZqdm() {
		return zqdm;
	}

	public void setZqdm(String zqdm) {
		this.zqdm = zqdm;
	}

	public double getJkp() {
		return jkp;
	}

	public void setJkp(double jkp) {
		this.jkp = jkp;
	}

	public double getZsp() {
		return zsp;
	}

	public void setZsp(double zsp) {
		this.zsp = zsp;
	}

	public double getZgj() {
		return zgj;
	}

	public void setZgj(double zgj) {
		this.zgj = zgj;
	}

	public double getZdj() {
		return zdj;
	}

	public void setZdj(double zdj) {
		this.zdj = zdj;
	}

	public double getZd() {
		return zd;
	}

	public void setZd(double zd) {
		this.zd = zd;
	}

	public long getZcjl() {
		return zcjl;
	}

	public void setZcjl(long zcjl) {
		this.zcjl = zcjl;
	}

	public double getZje() {
		return zje;
	}

	public void setZje(double zje) {
		this.zje = zje;
	}

	public double getDqj() {
		return dqj;
	}

	public void setDqj(double dqj) {
		this.dqj = dqj;
	}

	public double getZtj() {
		return ztj;
	}

	public void setZtj(double ztj) {
		this.ztj = ztj;
	}

	public double getDtj() {
		return dtj;
	}

	public void setDtj(double dtj) {
		this.dtj = dtj;
	}

}
