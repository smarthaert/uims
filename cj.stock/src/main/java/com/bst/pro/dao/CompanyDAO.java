package com.bst.pro.dao;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.bst.pro.bo.Company;



public class CompanyDAO extends HibernateDaoSupport {

    public CompanyDAO() {}

    public void save(Company company) {
    	getHibernateTemplate().save( company );
    }
}