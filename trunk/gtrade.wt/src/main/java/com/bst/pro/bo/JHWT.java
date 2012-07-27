package com.bst.pro.bo;

import java.io.File;
import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class JHWT {
	

	public JHWT() {
		super();
	}
	
	public JHWT(Element item) {
		this.id = item.select("td:eq(0) input").attr("value").trim();
		this.gddm = item.select("td:eq(1)").html().trim();
		this.zqdm = item.select("td:eq(2)").html().trim();
		this.zqmc = item.select("td:eq(3)").html().trim();
		this.zqjg = item.select("td:eq(4)").html().trim();
		this.zqsl = item.select("td:eq(5)").html().trim();
	}

	public static void main(String[] args) {
		try {
			Document doc = Jsoup.parse(new File(
					"D:\\html\\planEntrustSave.html"), "utf-8");
			JHWT jhwt  = new JHWT(doc);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//委托单编号
	String id;
	
	//股东代码
	String gddm;
	
	//证券代码
	String zqdm;
	
	//证券名称
	String zqmc;
	
	//证券价格
	String zqjg;
	
	//证券数量
	String zqsl;
	
	//买 入/卖 出
	String opt;
	
	//执行结果 
	String zxjg;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getGddm() {
		return gddm;
	}

	public void setGddm(String gddm) {
		this.gddm = gddm;
	}

	public String getZqdm() {
		return zqdm;
	}

	public void setZqdm(String zqdm) {
		this.zqdm = zqdm;
	}

	public String getZqmc() {
		return zqmc;
	}

	public void setZqmc(String zqmc) {
		this.zqmc = zqmc;
	}

	public String getZqjg() {
		return zqjg;
	}

	public void setZqjg(String zqjg) {
		this.zqjg = zqjg;
	}

	public String getZqsl() {
		return zqsl;
	}

	public void setZqsl(String zqsl) {
		this.zqsl = zqsl;
	}

	public String getOpt() {
		return opt;
	}

	public void setOpt(String opt) {
		this.opt = opt;
	}

	public String getZxjg() {
		return zxjg;
	}

	public void setZxjg(String zxjg) {
		this.zxjg = zxjg;
	}
	
}
