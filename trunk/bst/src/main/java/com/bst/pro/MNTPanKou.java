package com.bst.pro;

import org.jsoup.nodes.Document;

import com.bst.pro.util.PanKou;

public class MNTPanKou extends PanKou {

	public MNTPanKou(Document doc, int level) {
		super(doc, level);
	}


	public void buildLevel1(Document doc) {

		this.sellPrice5 = Double.parseDouble(doc
				.select("table tr:eq(0) td:eq(1)").html());
		this.sellQuantity5 = Integer.parseInt(doc.select(
				"table tr:eq(0) td:eq(2)").html());

		this.sellPrice4 = Double.parseDouble(doc
				.select("table tr:eq(1) td:eq(1)").html());
		this.sellQuantity4 = Integer.parseInt(doc.select(
				"table tr:eq(1) td:eq(2)").html());

		this.sellPrice3 = Double.parseDouble(doc
				.select("table tr:eq(2) td:eq(1)").html());
		this.sellQuantity3 = Integer.parseInt(doc.select(
				"table tr:eq(2) td:eq(2)").html());

		this.sellPrice2 = Double.parseDouble(doc
				.select("table tr:eq(3) td:eq(1)").html());
		this.sellQuantity2 = Integer.parseInt(doc.select(
				"table tr:eq(3) td:eq(2)").html());

		this.sellPrice1 = Double.parseDouble(doc
				.select("table tr:eq(4) td:eq(1)").html());
		this.sellQuantity1 = Integer.parseInt(doc.select(
				"table tr:eq(4) td:eq(2)").html());

		//jump one row
		
		this.buyPrice1 = Double.parseDouble(doc.select("table tr:eq(6) td:eq(1)")
				.html());
		this.buyQuantity1 = Integer.parseInt(doc.select(
				"table tr:eq(6) td:eq(2)").html());

		this.buyPrice2 = Double.parseDouble(doc.select("table tr:eq(7) td:eq(1)")
				.html());
		this.buyQuantity2 = Integer.parseInt(doc.select(
				"table tr:eq(7) td:eq(2)").html());

		this.buyPrice3 = Double.parseDouble(doc.select("table tr:eq(8) td:eq(1)")
				.html());
		this.buyQuantity3 = Integer.parseInt(doc.select(
				"table tr:eq(8) td:eq(2)").html());

		this.buyPrice4 = Double.parseDouble(doc.select("table tr:eq(9) td:eq(1)")
				.html());
		this.buyQuantity4 = Integer.parseInt(doc.select(
				"table tr:eq(9) td:eq(2)").html());

		this.buyPrice5 = Double.parseDouble(doc.select("table tr:eq(10) td:eq(1)")
				.html());
		this.buyQuantity5 = Integer.parseInt(doc.select(
				"table tr:eq(10) td:eq(2)").html());

	}
	

	public void buildLevel1(String docStr) {
		// TODO Auto-generated method stub

	}

	public void buildLevel2(Document doc) {
		

		this.sellPrice10 = Double.parseDouble(doc
				.select("table tr:eq(0) td:eq(1)").html());
		this.sellQuantity10 = Integer.parseInt(doc.select(
				"table tr:eq(0) td:eq(2)").html());

		this.sellPrice9 = Double.parseDouble(doc
				.select("table tr:eq(1) td:eq(1)").html());
		this.sellQuantity9 = Integer.parseInt(doc.select(
				"table tr:eq(1) td:eq(2)").html());

		this.sellPrice8 = Double.parseDouble(doc
				.select("table tr:eq(2) td:eq(1)").html());
		this.sellQuantity8 = Integer.parseInt(doc.select(
				"table tr:eq(2) td:eq(2)").html());

		this.sellPrice7 = Double.parseDouble(doc
				.select("table tr:eq(3) td:eq(1)").html());
		this.sellQuantity7 = Integer.parseInt(doc.select(
				"table tr:eq(3) td:eq(2)").html());

		this.sellPrice6 = Double.parseDouble(doc
				.select("table tr:eq(4) td:eq(1)").html());
		this.sellQuantity6 = Integer.parseInt(doc.select(
				"table tr:eq(4) td:eq(2)").html());

		this.sellPrice5 = Double.parseDouble(doc
				.select("table tr:eq(5) td:eq(1)").html());
		this.sellQuantity5 = Integer.parseInt(doc.select(
				"table tr:eq(5) td:eq(2)").html());

		this.sellPrice4 = Double.parseDouble(doc
				.select("table tr:eq(6) td:eq(1)").html());
		this.sellQuantity4 = Integer.parseInt(doc.select(
				"table tr:eq(6) td:eq(2)").html());

		this.sellPrice3 = Double.parseDouble(doc
				.select("table tr:eq(7) td:eq(1)").html());
		this.sellQuantity3 = Integer.parseInt(doc.select(
				"table tr:eq(7) td:eq(2)").html());

		this.sellPrice2 = Double.parseDouble(doc
				.select("table tr:eq(8) td:eq(1)").html());
		this.sellQuantity2 = Integer.parseInt(doc.select(
				"table tr:eq(8) td:eq(2)").html());

		this.sellPrice1 = Double.parseDouble(doc
				.select("table tr:eq(9) td:eq(1)").html());
		this.sellQuantity1 = Integer.parseInt(doc.select(
				"table tr:eq(9) td:eq(2)").html());

		//jump one row
		
		this.buyPrice1 = Double.parseDouble(doc.select("table tr:eq(11) td:eq(1)")
				.html());
		this.buyQuantity1 = Integer.parseInt(doc.select(
				"table tr:eq(11) td:eq(2)").html());

		this.buyPrice2 = Double.parseDouble(doc.select("table tr:eq(12) td:eq(1)")
				.html());
		this.buyQuantity2 = Integer.parseInt(doc.select(
				"table tr:eq(12) td:eq(2)").html());

		this.buyPrice3 = Double.parseDouble(doc.select("table tr:eq(13) td:eq(1)")
				.html());
		this.buyQuantity3 = Integer.parseInt(doc.select(
				"table tr:eq(13) td:eq(2)").html());

		this.buyPrice4 = Double.parseDouble(doc.select("table tr:eq(14) td:eq(1)")
				.html());
		this.buyQuantity4 = Integer.parseInt(doc.select(
				"table tr:eq(14) td:eq(2)").html());

		this.buyPrice5 = Double.parseDouble(doc.select("table tr:eq(15) td:eq(1)")
				.html());
		this.buyQuantity5 = Integer.parseInt(doc.select(
				"table tr:eq(15) td:eq(2)").html());
		
		this.buyPrice6 = Double.parseDouble(doc.select("table tr:eq(16) td:eq(1)")
				.html());
		this.buyQuantity6 = Integer.parseInt(doc.select(
				"table tr:eq(16) td:eq(2)").html());

		this.buyPrice7 = Double.parseDouble(doc.select("table tr:eq(17) td:eq(1)")
				.html());
		this.buyQuantity7 = Integer.parseInt(doc.select(
				"table tr:eq(17) td:eq(2)").html());

		this.buyPrice8 = Double.parseDouble(doc.select("table tr:eq(18) td:eq(1)")
				.html());
		this.buyQuantity8 = Integer.parseInt(doc.select(
				"table tr:eq(18) td:eq(2)").html());

		this.buyPrice9 = Double.parseDouble(doc.select("table tr:eq(19) td:eq(1)")
				.html());
		this.buyQuantity9 = Integer.parseInt(doc.select(
				"table tr:eq(19) td:eq(2)").html());

		this.buyPrice10 = Double.parseDouble(doc.select("table tr:eq(20) td:eq(1)")
				.html());
		this.buyQuantity10 = Integer.parseInt(doc.select(
				"table tr:eq(20) td:eq(2)").html());
	}

	public void buildLevel2(String docStr) {
		// TODO Auto-generated method stub

	}
}
