package com.bst.pro.bo;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public class ZQZCObject {

	public static void main(String[] args) {
		try {
			Document doc = Jsoup.parse(new File(
					"D:\\html\\searchStackDetailUrl.html"), "utf-8");
			ZQZCObject zqzc = new ZQZCObject(doc);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public ZQZCObject(Document zqzcDoc) {

		// 构造资产账户状况对象
		Elements zjzkzkDoc = zqzcDoc.select("table:contains(资产总值(含基金))");
		Elements zjzkzkItem = zjzkzkDoc.get(3).select("tr:eq(1)");
		zjzkzk.zjzh = zjzkzkItem.select("td:eq(0)").html().trim().toString();
		zjzkzk.bz = zjzkzkItem.select("td:eq(1)").html().trim().toString();
		zjzkzk.zjye = Double.parseDouble(zjzkzkItem.select("td:eq(2)").html()
				.trim().toString());
		zjzkzk.kyye = Double.parseDouble(zjzkzkItem.select("td:eq(3)").html()
				.trim().toString());
		zjzkzk.ktqye = Double.parseDouble(zjzkzkItem.select("td:eq(4)").html()
				.trim().toString());
		zjzkzk.zqsz = Double.parseDouble(zjzkzkItem.select("td:eq(5)").html()
				.trim().toString());
		zjzkzk.zczz = Double.parseDouble(zjzkzkItem.select("td:eq(6)").html()
				.trim().toString());
		zjzkzk.yhmc = zjzkzkItem.select("td:eq(7)").html().trim().toString();

		// 构造证券资产状况对象列表
		Elements itemsDoc = zqzcDoc.select("table:contains(浮动盈亏(元))");

		// 取得记录个数
		int itemNum = Integer.parseInt(zqzcDoc.select("td:containsOwn(记录个数：")
				.html().trim().substring(5));
		if (itemNum > 0) {
			Element itemList = itemsDoc.get(1);
			ZQZCItem item = null;
			for (int i = 1; i <= itemNum; i++) {
				item = new ZQZCItem();
				String selectStr = "tr:eq(" + i + ")";
				Elements itemEle = itemList.select(selectStr);
				item.cz = itemEle.select("td:eq(0) a").html().trim();
				item.zqdm = itemEle.select("td:eq(1)").html().trim();
				item.zqmc = itemEle.select("td:eq(2)").html().trim();
				item.zjsl = Long.parseLong(itemEle.select("td:eq(3)").html()
						.trim());
				item.kyslsz = Double.parseDouble(itemEle.select("td:eq(4)")
						.html().trim());
				item.zxjg = Double.parseDouble(itemEle.select("td:eq(5)")
						.html().trim());
				item.cbj = Double.parseDouble(itemEle.select("td:eq(6)").html()
						.trim());
				item.fdyk = Double.parseDouble(itemEle.select("td:eq(7)")
						.html().trim());
				if(item.getKyslsz() > 0){
					zqzcList.add(item);
				}else{
				
				}
			}
		}

	}

	ZJZHZK zjzkzk = new ZJZHZK();
	List<ZQZCItem> zqzcList = new ArrayList<ZQZCItem>();
	
	public String printZqzcList() {
		String ret = null;
		for(ZQZCItem i : zqzcList){
			ret = ret + "| " + i.getZqdm();
		}
		return ret;
	}


	public List<ZQZCItem> getZqzcList() {
		return zqzcList;
	}

	public void setZqzcList(List<ZQZCItem> zqzcList) {
		this.zqzcList = zqzcList;
	}

	// 资金帐户状况
	class ZJZHZK {
		// 资金账号 10206(主)
		public String zjzh = null;

		// 币种 人民币
		public String bz = null;

		// 资金余额 5000.00
		public double zjye;

		public String getZjzh() {
			return zjzh;
		}

		public void setZjzh(String zjzh) {
			this.zjzh = zjzh;
		}

		public String getBz() {
			return bz;
		}

		public void setBz(String bz) {
			this.bz = bz;
		}

		public double getZjye() {
			return zjye;
		}

		public void setZjye(double zjye) {
			this.zjye = zjye;
		}

		public double getKyye() {
			return kyye;
		}

		public void setKyye(double kyye) {
			this.kyye = kyye;
		}

		public double getKtqye() {
			return ktqye;
		}

		public void setKtqye(double ktqye) {
			this.ktqye = ktqye;
		}

		public double getZqsz() {
			return zqsz;
		}

		public void setZqsz(double zqsz) {
			this.zqsz = zqsz;
		}

		public double getZczz() {
			return zczz;
		}

		public void setZczz(double zczz) {
			this.zczz = zczz;
		}

		public String getYhmc() {
			return yhmc;
		}

		public void setYhmc(String yhmc) {
			this.yhmc = yhmc;
		}

		// 可用余额 5000.00
		public double kyye;

		// 可提取余额 5000.00
		public double ktqye;

		// 证券市值 ) 0.00
		public double zqsz;

		// 资产总值(含基金) 5000.00
		public double zczz;

		// 银行名称 建行三方
		public String yhmc = null;
	}

	// 证券资产状况
	public class ZQZCItem {
		// 操作
		public String cz = null;

		// 证券代码
		public String zqdm = null;

		// 证券名称
		public String zqmc = null;

		// 实际数量
		public long zjsl;

		public String getCz() {
			return cz;
		}

		public void setCz(String cz) {
			this.cz = cz;
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

		public long getZjsl() {
			return zjsl;
		}

		public void setZjsl(long zjsl) {
			this.zjsl = zjsl;
		}

		public double getKyslsz() {
			return kyslsz;
		}

		public void setKyslsz(double kyslsz) {
			this.kyslsz = kyslsz;
		}

		public double getZxjg() {
			return zxjg;
		}

		public void setZxjg(double zxjg) {
			this.zxjg = zxjg;
		}

		public double getCbj() {
			return cbj;
		}

		public void setCbj(double cbj) {
			this.cbj = cbj;
		}

		public double getFdyk() {
			return fdyk;
		}

		public void setFdyk(double fdyk) {
			this.fdyk = fdyk;
		}

		// 可用数量 市值(元)
		public double kyslsz;

		// 最新价格
		public double zxjg;

		// 成本价(元)
		public double cbj;

		// 浮动盈亏(元)
		public double fdyk;
	}
}
