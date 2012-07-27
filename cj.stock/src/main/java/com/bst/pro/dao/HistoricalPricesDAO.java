package com.bst.pro.dao;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.bst.pro.bo.HistoricalPrices;



public class HistoricalPricesDAO extends HibernateDaoSupport {

    public HistoricalPricesDAO() {}

    public void save(HistoricalPrices historicalPrices) {
    	getHibernateTemplate().save( historicalPrices );
    }
}