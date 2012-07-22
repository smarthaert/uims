package com.bst.pro.util;

import javax.swing.text.TabableView;

import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public abstract class PanKou {
	protected double buyPrice1;

	protected double buyPrice10;
	protected double buyPrice2;
	protected double buyPrice3;
	protected double buyPrice4;
	protected double buyPrice5;

	protected double buyPrice6;
	protected double buyPrice7;
	protected double buyPrice8;
	protected double buyPrice9;
	protected int buyQuantity1;

	protected int buyQuantity10;
	protected int buyQuantity2;
	protected int buyQuantity3;
	protected int buyQuantity4;

	protected int buyQuantity5;

	protected int buyQuantity6;

	protected int buyQuantity7;

	protected int buyQuantity8;

	protected int buyQuantity9;

	private int level;

	private int maxBuyQty;
	private int maxSellQty;

	public double getBuyPrice1() {
		return buyPrice1;
	}

	public double getBuyPrice10() {
		return buyPrice10;
	}

	public double getBuyPrice2() {
		return buyPrice2;
	}

	public double getBuyPrice3() {
		return buyPrice3;
	}

	public double getBuyPrice4() {
		return buyPrice4;
	}

	public double getBuyPrice5() {
		return buyPrice5;
	}

	public double getBuyPrice6() {
		return buyPrice6;
	}

	public double getBuyPrice7() {
		return buyPrice7;
	}

	public double getBuyPrice8() {
		return buyPrice8;
	}

	public double getBuyPrice9() {
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

	public double getSellPrice1() {
		return sellPrice1;
	}

	public double getSellPrice10() {
		return sellPrice10;
	}

	public double getSellPrice2() {
		return sellPrice2;
	}

	public double getSellPrice3() {
		return sellPrice3;
	}

	public double getSellPrice4() {
		return sellPrice4;
	}

	public double getSellPrice5() {
		return sellPrice5;
	}

	public double getSellPrice6() {
		return sellPrice6;
	}

	public double getSellPrice7() {
		return sellPrice7;
	}

	public double getSellPrice8() {
		return sellPrice8;
	}

	public double getSellPrice9() {
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

	protected double sellPrice1;
	protected double sellPrice10;
	protected double sellPrice2;
	protected double sellPrice3;
	protected double sellPrice4;

	protected double sellPrice5;
	protected double sellPrice6;
	protected double sellPrice7;
	protected double sellPrice8;
	protected double sellPrice9;

	protected int sellQuantity1;
	protected int sellQuantity10;
	protected int sellQuantity2;
	protected int sellQuantity3;
	protected int sellQuantity4;

	protected int sellQuantity5;
	protected int sellQuantity6;
	protected int sellQuantity7;
	protected int sellQuantity8;
	protected int sellQuantity9;

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

	public abstract void buildLevel1(Document doc);

	public abstract void buildLevel1(String docStr);

	public abstract void buildLevel2(Document doc);

	public abstract void buildLevel2(String docStr);

	/**
	 * get sell price by taget sell quantity to sell stock quickly
	 * 
	 * @param tagetQty
	 * @return
	 */
	public double getSellPrice(int tagetQty) {
		double price = 0;
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

	private double getMaxSellQtyPrice() {
		double price = 0;
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

	public boolean isSale(double cbj, double zyp) {
		boolean ret = false;
		//根据当前价来判断
		if((cbj * (1 + zyp)) < buyPrice1){
			ret = true;
		}
		return ret;
	}
}
