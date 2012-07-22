package com.bst.pro.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.bst.pro.bo.Company;

public class CompanyDAO extends HibernateDaoSupport {
	public CompanyDAO() {
	}

	public void save(Company company) {
		getHibernateTemplate().save(company);
	}

	public Company load(Integer id) {
		return (Company) getHibernateTemplate().load(Company.class, id);
	}

	@SuppressWarnings("unchecked")
	public List<Company> recentForLocation() {
		return (List<Company>) getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session) {
						Query query = getSession().getNamedQuery(
								"Company.byLocation");
//						query.setParameter("location", location);
						return new ArrayList<Company>(query.list());
					}
				});
	}
}