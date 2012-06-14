package org.host.application;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

public class HostActivator3 implements BundleActivator {
	private BundleContext m_context = null;

	public void start(BundleContext context) {
		m_context = context;
	}

	public void stop(BundleContext context) {
		m_context = null;
	}

	public BundleContext getContext() {
		return m_context;
	}
}