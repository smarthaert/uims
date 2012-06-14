package org.host.application;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

import org.apache.felix.framework.Felix;
import org.apache.felix.framework.util.FelixConstants;
import org.osgi.framework.BundleException;
import org.osgi.framework.Constants;

public class HostApplication2 {
	private HostActivator2 m_activator = null;
	private Felix m_felix = null;
	private Map m_lookupMap = new HashMap();

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
}