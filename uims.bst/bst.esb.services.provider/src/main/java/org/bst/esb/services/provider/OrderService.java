package org.bst.esb.services.provider;

import java.io.InputStream;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Provides;
import org.apache.log4j.Logger;
import org.bst.esb.services.OrderUtils;
import org.bst.esb.services.TipInfo;

@Component(name = "OrderService")
@Provides
@Instantiate(name = "OrderService")
public class OrderService implements OrderUtils {

	Logger log = Logger.getLogger(OrderService.class.getName());

	public void finishInfoGet(TipInfo ti) {
		// TODO Auto-generated method stub
		log.info("Update Order Info £º" + ti.getContent());
		updateOrderInfo(ti);
	}

	private void updateOrderInfo(TipInfo ti) {
		saveOrderInfoToDb(ti);
	}

	private void saveOrderInfoToDb(TipInfo ti) {
		// TODO Auto-generated method stub
		
	}

}
