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
}
