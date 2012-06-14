package org.host.application;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.felix.framework.Felix;
import org.apache.felix.framework.util.FelixConstants;
import org.osgi.framework.BundleException;
import org.osgi.framework.Constants;
import org.osgi.util.tracker.ServiceTracker;
import org.using.services.provided.by.bundles.Command;

public class HostApplication3 {
	private HostActivator3 m_activator = null;
	private Felix m_felix = null;
	private ServiceTracker m_tracker = null;

	public HostApplication3() {
		// Create a configuration property map.
		Map configMap = new HashMap();
		// Export the host provided service interface package.
		configMap.put(Constants.FRAMEWORK_SYSTEMPACKAGES_EXTRA,
				"host.service.command; version=1.0.0");
		// Create host activator;
		m_activator = new HostActivator3();
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
				Command.class.getName(), null);
		m_tracker.open();
	}

	public boolean execute(String name, String commandline) {
		// See if any of the currently tracked command services
		// match the specified command name, if so then execute it.
		Object[] services = m_tracker.getServices();
		for (int i = 0; (services != null) && (i < services.length); i++) {
			try {
				if (((Command) services[i]).getName().equals(name)) {
					return ((Command) services[i]).execute(commandline);
				}
			} catch (Exception ex) {
				// Since the services returned by the tracker could become
				// invalid at any moment, we will catch all exceptions, log
				// a message, and then ignore faulty services.
				System.err.println(ex);
			}
		}
		return false;
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