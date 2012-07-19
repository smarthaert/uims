package com.bst.pro.util;

import java.util.regex.Pattern;

import junit.framework.Assert;

public class IFHQ {
	
	public IFHQ() {
		super();
	}

	public IFHQ(String name, String code, double zxj, double zd1, double zd2,
			double kpj, double zgj, double zdj, int cjl, int ccl, int zkc,
			int zpc, int zzl, double jsj, double zjs, double ztj, double dtj,
			double jj) {
		super();
		this.name = name;
		this.code = code;
		this.zxj = zxj;
		this.zd1 = zd1;
		this.zd2 = zd2;
		this.kpj = kpj;
		this.zgj = zgj;
		this.zdj = zdj;
		this.cjl = cjl;
		this.ccl = ccl;
		this.zkc = zkc;
		this.zpc = zpc;
		this.zzl = zzl;
		this.jsj = jsj;
		this.zjs = zjs;
		this.ztj = ztj;
		this.dtj = dtj;
		this.jj = jj;
	}

	public static IFHQ creator(String name, String code, String zxj, String zd1, String zd2,
			String kpj, String zgj, String zdj, String cjl, String ccl, String zkc,
			String zpc, String zzl, String jsj, String zjs, String ztj, String dtj,
			String jj) {
		
		
		//check data
		Assert.assertNotNull(name);
		Assert.assertEquals(name.length(), 8);
		Assert.assertNotNull(code);
		Assert.assertEquals(code.length(), 8);
		Pattern pattern = Pattern.compile("^[\\-0-9.]*$"); 
		Assert.assertTrue(pattern.matcher(zxj).matches());
		Assert.assertTrue(pattern.matcher(zd1).matches());
		Assert.assertNotNull(zd2);
		Assert.assertTrue(zd2.length() > 3);
		zd2 = zd2.substring(1, zd2.length() - 2);
		Assert.assertTrue(pattern.matcher(zd2).matches());
		Assert.assertTrue(pattern.matcher(kpj).matches());
		Assert.assertTrue(pattern.matcher(zgj).matches());
		Assert.assertTrue(pattern.matcher(zdj).matches());
		Assert.assertTrue(pattern.matcher(cjl).matches());
		Assert.assertTrue(pattern.matcher(ccl).matches());
		Assert.assertTrue(pattern.matcher(zkc).matches());
		Assert.assertTrue(pattern.matcher(zpc).matches());
		Assert.assertTrue(pattern.matcher(zzl).matches());
		Assert.assertTrue(pattern.matcher(jsj).matches());
		Assert.assertTrue(pattern.matcher(zjs).matches());
		Assert.assertTrue(pattern.matcher(ztj).matches());
		Assert.assertTrue(pattern.matcher(dtj).matches());
		Assert.assertTrue(pattern.matcher(jj).matches());
		
		
		IFHQ ifhq = new IFHQ(name.substring(1, name.length()),
				code.substring(1, code.length()),
				Double.parseDouble(zxj),
				Double.parseDouble(zd1),
				Double.parseDouble(zd2),
				Double.parseDouble(kpj),
				Double.parseDouble(zgj),
				Double.parseDouble(zdj),
				Integer.parseInt(cjl),
				Integer.parseInt(ccl),
				Integer.parseInt(zkc),
				Integer.parseInt(zpc),
				Integer.parseInt(zzl),
				Double.parseDouble(jsj),
				Double.parseDouble(zjs),
				Double.parseDouble(ztj),
				Double.parseDouble(dtj),
				Double.parseDouble(jj)
				);

		
		return ifhq;
	}

	private String name = null;
	
	private String code = null;	//名称代码
	// 'IF1207'

	// 3
	private double zxj = 0.0;
	// 2417	//最新价
	
	// 2457

	private double zd1 = 0.0;
	// -38.8	// 涨跌
	
	private double zd2 = 0.0;
	// '-1.58%'	// 涨跌

	private double kpj = 0.0;
	// 2462	//开盘价

	private double zgj = 0.0;
	// 2464.8	//最高价

	private double zdj = 0.0;
	// 2413.6	//最低价

	private int cjl = 0;
	// 347330	//成交量

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public double getZxj() {
		return zxj;
	}

	public void setZxj(double zxj) {
		this.zxj = zxj;
	}

	public double getZd1() {
		return zd1;
	}

	public void setZd1(double zd1) {
		this.zd1 = zd1;
	}

	public double getZd2() {
		return zd2;
	}

	public void setZd2(double zd2) {
		this.zd2 = zd2;
	}

	public double getKpj() {
		return kpj;
	}

	public void setKpj(double kpj) {
		this.kpj = kpj;
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

	public int getCjl() {
		return cjl;
	}

	public void setCjl(int cjl) {
		this.cjl = cjl;
	}

	public int getCcl() {
		return ccl;
	}

	public void setCcl(int ccl) {
		this.ccl = ccl;
	}

	public int getZkc() {
		return zkc;
	}

	public void setZkc(int zkc) {
		this.zkc = zkc;
	}

	public int getZpc() {
		return zpc;
	}

	public void setZpc(int zpc) {
		this.zpc = zpc;
	}

	public int getZzl() {
		return zzl;
	}

	public void setZzl(int zzl) {
		this.zzl = zzl;
	}

	public double getJsj() {
		return jsj;
	}

	public void setJsj(double jsj) {
		this.jsj = jsj;
	}

	public double getZjs() {
		return zjs;
	}

	public void setZjs(double zjs) {
		this.zjs = zjs;
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

	public double getJj() {
		return jj;
	}

	public void setJj(double jj) {
		this.jj = jj;
	}

	private int ccl = 0;
	// 45844	//持仓量

	private int zkc = 0;
	// 0	//日开仓

	private int zpc = 0;
	// 0	//日平仓

	private int zzl = 0;
	// 0	//日增量

	private double jsj = 0.0;
	// 2416.2	//结算价

	private double zjs = 0.0;
	// 2455.8	//昨结算

	private double ztj = 0.0;
	// 2701.38	//涨停价

	private double dtj = 0.0;
	// 2210.22	//跌停价

	private double jj = 0.0;
	// 2429.802	//均价
}
