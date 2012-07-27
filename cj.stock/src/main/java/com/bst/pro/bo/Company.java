package com.bst.pro.bo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


@Entity
public class Company {
	
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
	Integer _id;
	
	public Company() {
		
	}
	String title;
	String myid;
	boolean hasOc;
	public boolean isHasOc() {
		return hasOc;
	}
	public void setHasOc(boolean hasOc) {
		this.hasOc = hasOc;
	}
	String ticker;
	String exchange;
	
	double grossMargin; //Gross margin (%)
	double return1Week; //1w return
	double return156Week; //156w return
	double nextYearEPS; //Next year EPS
	double lTDebtToAssetsYear; //LT debt/assets (Recent yr) (%)
	double revenueGrowthRate5Years; //5y revenue growth rate
	double earningsAfterTaxes; //Earnings after taxes
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMyid() {
		return myid;
	}
	public void setMyid(String myid) {
		this.myid = myid;
	}
	public String getTicker() {
		return ticker;
	}
	public void setTicker(String ticker) {
		this.ticker = ticker;
	}
	public String getExchange() {
		return exchange;
	}
	public void setExchange(String exchange) {
		this.exchange = exchange;
	}
	public double getMarketCap() {
		return marketCap;
	}
	public void setMarketCap(double marketCap) {
		this.marketCap = marketCap;
	}
	public double getQuotePercChange() {
		return quotePercChange;
	}
	public void setQuotePercChange(double quotePercChange) {
		this.quotePercChange = quotePercChange;
	}
	public double getVolume() {
		return volume;
	}
	public void setVolume(double volume) {
		this.volume = volume;
	}
	public double getpE() {
		return pE;
	}
	public void setpE(double pE) {
		this.pE = pE;
	}
	double dividendPerShare; //Div per share
	double marketCap; //Market cap
	double netProfitMarginPercent; //Net profit margin (%)
	double c_float; //Float
	double earningsBeforeTaxes; //Earnings before taxes
	double quotePercChange; //Quote change (%)
	double totalDebtToEquityYear; //Total debt/equity (Recent yr) (%)
	double totalDebtToCapitalQuarter; //Total debt/capital (Recent qtr) (%)
	double lTDebtToCapitalQuarter; //LT debt/capital (Recent qtr) (%)
	double ePSGrowthRate10Years; //10y EPS growth rate
	double beta; //Beta
	double returnOnAssetsPTM; //Return on assets (PTM) (%)
	double capitalGain; //Capital gain
	double betaDown; //Beta down from RAS
	double incomeDividend; //Income dividend
	double revenueGrowthRate10Years; //10y revenue growth rate
	double marketCapShareBasis; //Market cap share basis
	double iAD; //Div rate indicated annual
	double return4Week; //4w return
	double price150DayAverage; //150d avg price
	double ePSGrowthRate5Years; //5y EPS growth rate
	double returnOnAssetsTTM; //Return on assets (TTM) (%)
	double totalDebtToAssetsYear; //Total debt/assets (Recent yr) (%)
	double volume; //Volume
	double dividendRecentQuarter; //Div recent quarter
	double currentRatioYear; //Current ratio
	double low52Week; //52w low
	double expenseRatio; //Expense ratio
	double price13WeekPercChange; //13w price change (%)
	double price1DayPercChange; //1d price change (%)
	double returnOnEquity5Years; //Return on equity (5 yr avg) (%)
	double totalDebtToCapitalYear; //Total debt/capital (Recent yr) (%)
	double totalDebtToAssetsQuarter; //Total debt/assets (Recent qtr) (%)
	double navChange; //Nav change
	double operatingMargin; //Operating margin (%)
	double dPSRecentYear; //Div per share (Recent yr)
	double aNI; //Earnings after taxes (Recent yr)
	double averageVolume; //Average volume
	double high52Week; //52w high
	double return13Week; //13w return
	double priceToCashFlowPerShare; //Price to cash flow per share
	double aTAXRATE; //Tax rate (Recent yr)
	double price26WeekPercChange; //26w price change (%)
	double quoteChange; //Quote change
	double netIncomeChangePerc; //Net income change (%)
	double returnOnInvestment5Years; //Return on investment (5 yr avg) (%)
	double pE; //P/E ratio
	double returnOnInvestmentYear; //Return on investment (Recent yr) (%)
	double price200DayAverage; //200d avg price
	double dividendNextQuarter; //Div next quarter
	double eBITD; //EBITDA
	double priceYTDPercChange; //YTD price change (%)
	double returnOnInvestmentTTM; //Return on investment (TTM) (%)
	double navChangePercent; //Nav change (%)
	double eBITDMargin; //EBITDA margin (%)
	double lTDebtToEquityQuarter; //LT debt/equity (Recent qtr) (%)
	double betaRAS; //Beta from RAS
	double priceSales; //Price to sales
	double netAssets; //Net assets
	double returnOnEquityTTM; //Return on equity (TTM) (%)
	double cashPerShareYear; //Cash/share
	double returnOnAssets5Years; //Return on assets (5 yr avg) (%)
	double returnDay; //1d return
	double return52Week; //52w return
	double forwardPE1Year; //1y fwd P/E
	double netIncomeGrowthRate5Years; //5y net income growth rate
	double dividendYield; //Div yield (%)
	double dividend; //Div from cash flow
	double betaUp; //Beta up from RAS
	double lTDebtToCapitalYear; //LT debt/capital (Recent yr) (%)
	double nprice; //Price from RAS
	double return260Week; //260w return
	double returnOnEquityQuarter; //Return on equity (Recent qtr) (%)
	double aCOGS; //Cost of goods sold
	double lTDebtToAssetsQuarter; //LT debt/assets (Recent qtr) (%)
	double priceToBook; //Price to book
	double lTDebtToEquityYear; //LT debt/equity (Recent yr) (%)
	double returnYTD; //Return YTD
	double returnOnEquityYear; //Return on equity (Recent yr) (%)
	double returnOnAssetsQuarter; //Return on assets (Recent qtr) (%)
	double totalDebtToEquityQuarter; //Total debt/equity (Recent qtr) (%)
	double navPrior; //Nav prior
	double aINTCOV; //Interest coverage
	double ePS; //EPS
	double returnOnInvestmentQuarter; //Return on investment (Recent qtr) (%)
	double quoteLast; //Last price
	double price50DayAverage; //50d avg price
	double price4WeekPercChange; //4w price change (%)
	double returnOnAssetsYear; //Return on assets (Recent yr) (%)
	double marketCapRAS; //Mkt cap from RAS
	double price52WeekPercChange; //52w price change (%)
	double shortInterestRatioPercent; //Short interest ratio (%)
	double institutionalPercentHeld; //Institutional percent held
	double bookValuePerShareYear; //Book value/share
	double returnOnEquityPTM; //Return on equity (PTM) (%)
}
