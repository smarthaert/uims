package com.bst.pro.util;

import javax.swing.text.TabableView;

import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class PanKou {
	private float buyPrice1;

	private float buyPrice10;
	private float buyPrice2;
	private float buyPrice3;
	private float buyPrice4;
	private float buyPrice5;

	private float buyPrice6;
	private float buyPrice7;
	private float buyPrice8;
	private float buyPrice9;
	private int buyQuantity1;

	private int buyQuantity10;
	private int buyQuantity2;
	private int buyQuantity3;
	private int buyQuantity4;

	private int buyQuantity5;

	private int buyQuantity6;

	private int buyQuantity7;

	private int buyQuantity8;

	private int buyQuantity9;

	private int level;

	private int maxBuyQty;
	private int maxSellQty;

	public float getBuyPrice1() {
		return buyPrice1;
	}

	public float getBuyPrice10() {
		return buyPrice10;
	}

	public float getBuyPrice2() {
		return buyPrice2;
	}

	public float getBuyPrice3() {
		return buyPrice3;
	}

	public float getBuyPrice4() {
		return buyPrice4;
	}

	public float getBuyPrice5() {
		return buyPrice5;
	}

	public float getBuyPrice6() {
		return buyPrice6;
	}

	public float getBuyPrice7() {
		return buyPrice7;
	}

	public float getBuyPrice8() {
		return buyPrice8;
	}

	public float getBuyPrice9() {
		return buyPrice9;
	}

	public int getBuyQuantity1() {
		return buyQuantity1;
	}

	public int getBuyQuantity10() {
		return buyQuantity10;
	}

	public int getBuyQuantity2() {
		return buyQuantity2;
	}

	public int getBuyQuantity3() {
		return buyQuantity3;
	}

	public int getBuyQuantity4() {
		return buyQuantity4;
	}

	public int getBuyQuantity5() {
		return buyQuantity5;
	}

	public int getBuyQuantity6() {
		return buyQuantity6;
	}

	public int getBuyQuantity7() {
		return buyQuantity7;
	}

	public int getBuyQuantity8() {
		return buyQuantity8;
	}

	public int getBuyQuantity9() {
		return buyQuantity9;
	}

	public int getLevel() {
		return level;
	}

	public int getMaxBuyQty() {
		switch (level) {
		case 1:
			maxBuyQty = buyQuantity5 + buyQuantity4 + buyQuantity3
					+ buyQuantity2 + buyQuantity1;
			break;

		case 2:
			maxBuyQty = buyQuantity10 + buyQuantity9 + buyQuantity8
					+ buyQuantity7 + buyQuantity6 + buyQuantity5 + buyQuantity4
					+ buyQuantity3 + buyQuantity2 + buyQuantity1;
			break;
		default:
			break;
		}
		return maxBuyQty;
	}

	public int getMaxSellQty() {
		switch (level) {
		case 1:
			maxSellQty = sellQuantity5 + sellQuantity4 + sellQuantity3
					+ sellQuantity2 + sellQuantity1;
			break;

		case 2:
			maxSellQty = sellQuantity10 + sellQuantity9 + sellQuantity8
					+ sellQuantity7 + sellQuantity6 + sellQuantity5
					+ sellQuantity4 + sellQuantity3 + sellQuantity2
					+ sellQuantity1;
			break;
		default:
			break;
		}
		return maxSellQty;
	}

	public float getSellPrice1() {
		return sellPrice1;
	}

	public float getSellPrice10() {
		return sellPrice10;
	}

	public float getSellPrice2() {
		return sellPrice2;
	}

	public float getSellPrice3() {
		return sellPrice3;
	}

	public float getSellPrice4() {
		return sellPrice4;
	}

	public float getSellPrice5() {
		return sellPrice5;
	}

	public float getSellPrice6() {
		return sellPrice6;
	}

	public float getSellPrice7() {
		return sellPrice7;
	}

	public float getSellPrice8() {
		return sellPrice8;
	}

	public float getSellPrice9() {
		return sellPrice9;
	}

	public int getSellQuantity1() {
		return sellQuantity1;
	}

	public int getSellQuantity10() {
		return sellQuantity10;
	}

	public int getSellQuantity2() {
		return sellQuantity2;
	}

	public int getSellQuantity3() {
		return sellQuantity3;
	}

	public int getSellQuantity4() {
		return sellQuantity4;
	}

	public int getSellQuantity5() {
		return sellQuantity5;
	}

	public int getSellQuantity6() {
		return sellQuantity6;
	}

	public int getSellQuantity7() {
		return sellQuantity7;
	}

	public int getSellQuantity8() {
		return sellQuantity8;
	}

	public int getSellQuantity9() {
		return sellQuantity9;
	}

	private float sellPrice1;
	private float sellPrice10;
	private float sellPrice2;
	private float sellPrice3;
	private float sellPrice4;

	private float sellPrice5;
	private float sellPrice6;
	private float sellPrice7;
	private float sellPrice8;
	private float sellPrice9;

	private int sellQuantity1;
	private int sellQuantity10;
	private int sellQuantity2;
	private int sellQuantity3;
	private int sellQuantity4;

	private int sellQuantity5;
	private int sellQuantity6;
	private int sellQuantity7;
	private int sellQuantity8;
	private int sellQuantity9;

	public PanKou(Document doc, int level) {
		super();
		this.level = level;
		switch (level) {
		case 1:
			buildLevel1(doc);
			break;

		case 2:
			buildLevel2(doc);
			break;
		default:
			break;
		}
	}

	public PanKou(String docStr, int level) {
		super();
		this.level = level;
		switch (level) {
		case 1:
			buildLevel1(docStr);
			break;

		case 2:
			buildLevel2(docStr);
			break;
		default:
			break;
		}
	}

	private void buildLevel1(Document doc) {

		this.sellPrice5 = Float.parseFloat(doc
				.select("table tr:eq(0) td:eq(1)").html());
		this.sellQuantity5 = Integer.parseInt(doc.select(
				"table tr:eq(0) td:eq(2)").html());

		this.sellPrice4 = Float.parseFloat(doc
				.select("table tr:eq(1) td:eq(1)").html());
		this.sellQuantity4 = Integer.parseInt(doc.select(
				"table tr:eq(1) td:eq(2)").html());

		this.sellPrice3 = Float.parseFloat(doc
				.select("table tr:eq(2) td:eq(1)").html());
		this.sellQuantity3 = Integer.parseInt(doc.select(
				"table tr:eq(2) td:eq(2)").html());

		this.sellPrice2 = Float.parseFloat(doc
				.select("table tr:eq(3) td:eq(1)").html());
		this.sellQuantity2 = Integer.parseInt(doc.select(
				"table tr:eq(3) td:eq(2)").html());

		this.sellPrice1 = Float.parseFloat(doc
				.select("table tr:eq(4) td:eq(1)").html());
		this.sellQuantity1 = Integer.parseInt(doc.select(
				"table tr:eq(4) td:eq(2)").html());

		//jump one row
		
		this.buyPrice1 = Float.parseFloat(doc.select("table tr:eq(6) td:eq(1)")
				.html());
		this.buyQuantity1 = Integer.parseInt(doc.select(
				"table tr:eq(6) td:eq(2)").html());

		this.buyPrice2 = Float.parseFloat(doc.select("table tr:eq(7) td:eq(1)")
				.html());
		this.buyQuantity2 = Integer.parseInt(doc.select(
				"table tr:eq(7) td:eq(2)").html());

		this.buyPrice3 = Float.parseFloat(doc.select("table tr:eq(8) td:eq(1)")
				.html());
		this.buyQuantity3 = Integer.parseInt(doc.select(
				"table tr:eq(8) td:eq(2)").html());

		this.buyPrice4 = Float.parseFloat(doc.select("table tr:eq(9) td:eq(1)")
				.html());
		this.buyQuantity4 = Integer.parseInt(doc.select(
				"table tr:eq(9) td:eq(2)").html());

		this.buyPrice5 = Float.parseFloat(doc.select("table tr:eq(10) td:eq(1)")
				.html());
		this.buyQuantity5 = Integer.parseInt(doc.select(
				"table tr:eq(10) td:eq(2)").html());

	}

	private void buildLevel1(String docStr) {
		// TODO Auto-generated method stub

	}

	private void buildLevel2(Document doc) {
		

		this.sellPrice10 = Float.parseFloat(doc
				.select("table tr:eq(0) td:eq(1)").html());
		this.sellQuantity10 = Integer.parseInt(doc.select(
				"table tr:eq(0) td:eq(2)").html());

		this.sellPrice9 = Float.parseFloat(doc
				.select("table tr:eq(1) td:eq(1)").html());
		this.sellQuantity9 = Integer.parseInt(doc.select(
				"table tr:eq(1) td:eq(2)").html());

		this.sellPrice8 = Float.parseFloat(doc
				.select("table tr:eq(2) td:eq(1)").html());
		this.sellQuantity8 = Integer.parseInt(doc.select(
				"table tr:eq(2) td:eq(2)").html());

		this.sellPrice7 = Float.parseFloat(doc
				.select("table tr:eq(3) td:eq(1)").html());
		this.sellQuantity7 = Integer.parseInt(doc.select(
				"table tr:eq(3) td:eq(2)").html());

		this.sellPrice6 = Float.parseFloat(doc
				.select("table tr:eq(4) td:eq(1)").html());
		this.sellQuantity6 = Integer.parseInt(doc.select(
				"table tr:eq(4) td:eq(2)").html());

		this.sellPrice5 = Float.parseFloat(doc
				.select("table tr:eq(5) td:eq(1)").html());
		this.sellQuantity5 = Integer.parseInt(doc.select(
				"table tr:eq(5) td:eq(2)").html());

		this.sellPrice4 = Float.parseFloat(doc
				.select("table tr:eq(6) td:eq(1)").html());
		this.sellQuantity4 = Integer.parseInt(doc.select(
				"table tr:eq(6) td:eq(2)").html());

		this.sellPrice3 = Float.parseFloat(doc
				.select("table tr:eq(7) td:eq(1)").html());
		this.sellQuantity3 = Integer.parseInt(doc.select(
				"table tr:eq(7) td:eq(2)").html());

		this.sellPrice2 = Float.parseFloat(doc
				.select("table tr:eq(8) td:eq(1)").html());
		this.sellQuantity2 = Integer.parseInt(doc.select(
				"table tr:eq(8) td:eq(2)").html());

		this.sellPrice1 = Float.parseFloat(doc
				.select("table tr:eq(9) td:eq(1)").html());
		this.sellQuantity1 = Integer.parseInt(doc.select(
				"table tr:eq(9) td:eq(2)").html());

		//jump one row
		
		this.buyPrice1 = Float.parseFloat(doc.select("table tr:eq(11) td:eq(1)")
				.html());
		this.buyQuantity1 = Integer.parseInt(doc.select(
				"table tr:eq(11) td:eq(2)").html());

		this.buyPrice2 = Float.parseFloat(doc.select("table tr:eq(12) td:eq(1)")
				.html());
		this.buyQuantity2 = Integer.parseInt(doc.select(
				"table tr:eq(12) td:eq(2)").html());

		this.buyPrice3 = Float.parseFloat(doc.select("table tr:eq(13) td:eq(1)")
				.html());
		this.buyQuantity3 = Integer.parseInt(doc.select(
				"table tr:eq(13) td:eq(2)").html());

		this.buyPrice4 = Float.parseFloat(doc.select("table tr:eq(14) td:eq(1)")
				.html());
		this.buyQuantity4 = Integer.parseInt(doc.select(
				"table tr:eq(14) td:eq(2)").html());

		this.buyPrice5 = Float.parseFloat(doc.select("table tr:eq(15) td:eq(1)")
				.html());
		this.buyQuantity5 = Integer.parseInt(doc.select(
				"table tr:eq(15) td:eq(2)").html());
		
		this.buyPrice6 = Float.parseFloat(doc.select("table tr:eq(16) td:eq(1)")
				.html());
		this.buyQuantity6 = Integer.parseInt(doc.select(
				"table tr:eq(16) td:eq(2)").html());

		this.buyPrice7 = Float.parseFloat(doc.select("table tr:eq(17) td:eq(1)")
				.html());
		this.buyQuantity7 = Integer.parseInt(doc.select(
				"table tr:eq(17) td:eq(2)").html());

		this.buyPrice8 = Float.parseFloat(doc.select("table tr:eq(18) td:eq(1)")
				.html());
		this.buyQuantity8 = Integer.parseInt(doc.select(
				"table tr:eq(18) td:eq(2)").html());

		this.buyPrice9 = Float.parseFloat(doc.select("table tr:eq(19) td:eq(1)")
				.html());
		this.buyQuantity9 = Integer.parseInt(doc.select(
				"table tr:eq(19) td:eq(2)").html());

		this.buyPrice10 = Float.parseFloat(doc.select("table tr:eq(20) td:eq(1)")
				.html());
		this.buyQuantity10 = Integer.parseInt(doc.select(
				"table tr:eq(20) td:eq(2)").html());
	}

	private void buildLevel2(String docStr) {
		// TODO Auto-generated method stub

	}

	/**
	 * get sell price by taget sell quantity to sell stock quickly
	 * 
	 * @param tagetQty
	 * @return
	 */
	public float getSellPrice(int tagetQty) {
		float price = 0;
		if (tagetQty >= getMaxBuyQty()) {
			return getMaxSellQtyPrice();
		}
		switch (level) {
		case 1:
			tagetQty -= buyQuantity1;
			if (tagetQty <= 0) {
				price = buyPrice1;
			} else {
				tagetQty -= buyQuantity2;
				if (tagetQty <= 0) {
					price = buyPrice2;
				} else {
					tagetQty -= buyQuantity3;
					if (tagetQty <= 0) {
						price = buyPrice3;
					} else {
						tagetQty -= buyQuantity4;
						if (tagetQty <= 0) {
							price = buyPrice4;
						} else {
							price = buyPrice5;
						}
					}
				}
			}
			break;
		case 2:
			tagetQty -= buyQuantity1;
			if (tagetQty <= 0) {
				price = buyPrice1;
			} else {
				tagetQty -= buyQuantity2;
				if (tagetQty <= 0) {
					price = buyPrice2;
				} else {
					tagetQty -= buyQuantity3;
					if (tagetQty <= 0) {
						price = buyPrice3;
					} else {
						tagetQty -= buyQuantity4;
						if (tagetQty <= 0) {
							price = buyPrice4;
						} else {
							tagetQty -= buyQuantity5;
							if (tagetQty <= 0) {
								price = buyPrice5;
							} else {
								tagetQty -= buyQuantity6;
								if (tagetQty <= 0) {
									price = buyPrice6;
								} else {
									tagetQty -= buyQuantity7;
									if (tagetQty <= 0) {
										price = buyPrice7;
									} else {
										tagetQty -= buyQuantity8;
										if (tagetQty <= 0) {
											price = buyPrice8;
										} else {
											tagetQty -= buyQuantity9;
											if (tagetQty <= 0) {
												price = buyPrice9;
											} else {
												price = buyPrice10;
											}
										}
									}
								}
							}
						}
					}
				}
			}
			break;
		default:
			break;
		}
		return price;
	}

	private float getMaxSellQtyPrice() {
		float price = 0;
		switch (level) {
		case 1:
			price = buyPrice5;
			break;

		case 2:
			price = buyPrice10;
			break;
		default:
			break;
		}
		return price;
	}
}
