package com.bst.pro.dao;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.bst.pro.bo.OptionChain;



public class OptionChainDAO extends HibernateDaoSupport {

    public OptionChainDAO() {}

    public void save(OptionChain optionChain) {
    	getHibernateTemplate().save( optionChain );
    }
}