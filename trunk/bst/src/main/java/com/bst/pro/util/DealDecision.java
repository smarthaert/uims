package com.bst.pro.util;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class DealDecision {
	List<StockInfo> stockInfo = new ArrayList<StockInfo>();

	public DealDecision(Document slDoc) {
		Elements es = slDoc.select("table tr[align=center]");
		for (Element e : es) {
			
			stockInfo.add(new StockInfo(e.select("tr>td:eq(1)").html(), e
					.select("tr>td:eq(2)").html(), Integer.parseInt(e.select(
					"tr>td:eq(3)").html()), Integer.parseInt(e.select(
					"tr>td:eq(4)").html()), Float.parseFloat(e.select(
					"tr>td:eq(5)").html()), Float.parseFloat(e.select(
					"tr>td:eq(6)").html()), Float.parseFloat(e.select(
					"tr>td:eq(7)").html()), Float.parseFloat(e.select(
					"tr>td:eq(8)").html()), e.select("tr>td:eq(9)").html()));
		}
	}

	public List<StockInfo> getSellStock() {
		List<StockInfo> sellStockInfo = new ArrayList<StockInfo>();
		for(StockInfo si : stockInfo){
			int l = (int) (100*(si.getProfit()/(si.getStockValue() + si.getProfit())));
			if(l < 0){
				return sellStockInfo;
			}else{
				if(l > 5){
					StockInfo copy = new StockInfo();
					try {
						BeanUtils.copyProperties(copy, si);
					} catch (IllegalAccessException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (InvocationTargetException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					sellStockInfo.add(copy);
				}
			}
		}
		return sellStockInfo;
	}
}
