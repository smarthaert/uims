package org.host.application;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import org.apache.felix.framework.Felix;
import org.apache.felix.framework.util.FelixConstants;
import org.osgi.framework.BundleException;
import org.osgi.framework.Constants;
import org.osgi.util.tracker.ServiceTracker;
import org.using.services.provided.by.bundles.Command;

public class HostApplication2 {
	Logger log = Logger.getLogger(HostApplication2.class.getName());
	private HostActivator2 m_activator = null;
	private Felix m_felix = null;
	private Map m_lookupMap = new HashMap();
	private ServiceTracker m_tracker = null;

	public HostApplication2() {
		// Initialize the map for the property lookup service.
		m_lookupMap.put("name1", "value1");

		m_lookupMap.put("name2", "value2");
		m_lookupMap.put("name3", "value3");
		m_lookupMap.put("name4", "value4");

		// Create a configuration property map.
		Map configMap = new HashMap();
		// Export the host provided service interface package.
		configMap.put(Constants.FRAMEWORK_SYSTEMPACKAGES_EXTRA,
				"org.host.application; version=1.0.0");
		// Create host activator;
		m_activator = new HostActivator2(m_lookupMap);
		List list = new ArrayList();
		list.add(m_activator);
		configMap.put(FelixConstants.SYSTEMBUNDLE_ACTIVATORS_PROP, list);

		try {
			// Now create an instance of the framework with
			// our configuration properties.
			m_felix = new Felix(configMap);
			// Now start Felix instance.
			m_felix.start();

		} catch (Exception ex) {
			System.err.println("Could not create framework: " + ex);
			ex.printStackTrace();
		}
		m_tracker = new ServiceTracker(m_activator.getContext(),
				Lookup.class.getName(), null);
		m_tracker.open();
	}

	public void shutdownApplication() {
		// Shut down the felix framework when stopping the
		// host application.
		try {
			m_felix.stop();
		} catch (BundleException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			m_felix.waitForStop(0);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void getServices() {

		Object[] services = m_tracker.getServices();
		for (int i = 0; (services != null) && (i < services.length); i++) {
			System.out.println(((Lookup) services[i]).lookup("name1"));
		}

	}
}