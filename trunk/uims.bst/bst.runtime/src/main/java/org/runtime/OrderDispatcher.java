package org.runtime;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.felix.ipojo.annotations.Bind;
import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Unbind;
import org.apache.felix.ipojo.annotations.Validate;
import org.apache.log4j.Logger;
import org.bst.esb.services.TipOrder;
import org.bst.esb.services.UimsPlugin;

@Component
@Instantiate
public class OrderDispatcher {
	Logger log = Logger.getLogger(OrderDispatcher.class.getName());

	private Map<String, UimsPlugin> plugins = new HashMap<String, UimsPlugin>();

	@Bind(aggregate = true)
	private void bindPlugin(UimsPlugin p) {
		plugins.put(p.getId(), p);
		log.info("find plugin : " + p.getId());
	}

	@Unbind
	private void unbindPlugin(UimsPlugin p) {
		plugins.remove(p.getId());
		log.info("remove plugin : " + p.getId());
	}

	@Validate
	private void start() {
		Thread task = new Thread(new Runnable() {

			public void run() {
				dispatcher();
				try {
					Thread.sleep(1000 * 3);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		});
	}

	private void dispatcher() {
		// get order info from db
		List<Order> orders = getOrders();
		for (Order o : orders) {
			// plugins.get(o.getPluginId()).doOrder(preDo(o));
			UimsPlugin up = plugins.get(o.getPluginId());
			if (up != null) {
				up.doOrder(preDo(o));
				log.info("Plugin was found : " + o.getPluginId());
			} else {
				log.info("Plugin was not found : " + o.getPluginId());
			}
		}
	}

	/**
	 * 对于第三方插件要屏蔽一些信息，保证客户信息的安全
	 * 
	 * @param o
	 * @return
	 */
	private TipOrder preDo(Order o) {
		TipOrder to = new TipOrder();
		try {
			BeanUtils.copyProperties(to, o);
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return to;
	}

	private List<Order> getOrders() {
		return queryOrders();
	}

	private List<Order> queryOrders() {
		List<Order> orders = new ArrayList<Order>();
		orders.add(new Order("P001", "O001", "13611913740"));
		orders.add(new Order("P002", "O001", "13611913741"));
		orders.add(new Order("P002", "O002", "13611913742"));
		return orders;
	}
}
