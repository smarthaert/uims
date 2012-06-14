package org.host.application;

import java.util.Map;
import java.util.Properties;

import org.apache.felix.framework.Felix;
import org.apache.felix.main.AutoProcessor;
import org.apache.felix.main.Main;
import org.osgi.framework.Constants;
import org.osgi.framework.launch.FrameworkFactory;

public class StdFelixFrameworkLauncher {
	private static final Object BUNDLE_DIR_SWITCH = null;
	private static final String CONFIG_PROPERTIES_FILE_VALUE = null;
	private static final String SHUTDOWN_HOOK_PROP = null;

	public static void main(String[] args) throws Exception {
		// (1) Check for command line arguments and verify usage.
		String bundleDir = null;
		String cacheDir = null;
		boolean expectBundleDir = false;
		for (int i = 0; i < args.length; i++) {
			if (args[i].equals(BUNDLE_DIR_SWITCH)) {
				expectBundleDir = true;
			} else if (expectBundleDir) {
				bundleDir = args[i];
				expectBundleDir = false;
			} else {
				cacheDir = args[i];
			}
		}

		if ((args.length > 3) || (expectBundleDir && bundleDir == null)) {
			System.out
					.println("Usage: [-b <bundle-deploy-dir>] [<bundle-cache-dir>]");
			System.exit(0);
		}

		// (2) Load system properties.
		Main.loadSystemProperties();

		// (3) Read configuration properties.
		Map<Object, Object> configProps = Main.loadConfigProperties();
		if (configProps == null) {
			System.err
					.println("No " + CONFIG_PROPERTIES_FILE_VALUE + " found.");
			configProps = new Properties();
		}

		// (4) Copy framework properties from the system properties.
		Main.copySystemProperties((Properties) configProps);

		// (5) Use the specified auto-deploy directory over default.
		if (bundleDir != null) {
			((Properties) configProps).setProperty(
					AutoProcessor.AUTO_DEPLOY_DIR_PROPERY, bundleDir);
		}

		// (6) Use the specified bundle cache directory over default.
		if (cacheDir != null) {
			((Properties) configProps).setProperty(Constants.FRAMEWORK_STORAGE,
					cacheDir);
		}

		// (7) Add a shutdown hook to clean stop the framework.
		String enableHook = ((Properties) configProps)
				.getProperty(SHUTDOWN_HOOK_PROP);
		if ((enableHook == null) || !enableHook.equalsIgnoreCase("false")) {
			Runtime.getRuntime().addShutdownHook(
					new Thread("Felix Shutdown Hook") {
						Felix m_fwk = null;

						public void run() {
							try {
								if (m_fwk != null) {
									m_fwk.stop();
									m_fwk.waitForStop(0);
								}
							} catch (Exception ex) {
								System.err.println("Error stopping framework: "
										+ ex);
							}
						}
					});
		}

		Felix m_fwk = null;
		try {
			// (8) Create an instance and initialize the framework.
			FrameworkFactory factory = getFrameworkFactory();
//			m_fwk = factory.newFramework(configProps);
			m_fwk.init();
			// (9) Use the system bundle context to process the auto-deploy
			// and auto-install/auto-start properties.
			AutoProcessor.process(configProps, m_fwk.getBundleContext());
			// (10) Start the framework.
			m_fwk.start();
			// (11) Wait for framework to stop to exit the VM.
			m_fwk.waitForStop(0);
			System.exit(0);
		} catch (Exception ex) {
			System.err.println("Could not create framework: " + ex);
			ex.printStackTrace();
			System.exit(0);
		}
	}

	private static FrameworkFactory getFrameworkFactory() {
		// TODO Auto-generated method stub
		return null;
	}
}
