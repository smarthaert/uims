/* 
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.vendor.corn.transporter;

import java.io.IOException;
import java.util.Properties;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Requires;
import org.apache.felix.ipojo.annotations.Validate;
import org.osgi.service.cm.Configuration;
import org.osgi.service.cm.ConfigurationAdmin;

/**
 * The corn transport refill corn stock. This class use iPOJO reconfiguration
 * features to reconfigure the popcorn vendor.
 */
@Component(name = "transporter", publicFactory = false, architecture = true)
@Instantiate
public class CornTransporter {

	@Requires
	private ConfigurationAdmin m_configAdmin;

	/**
	 * Reconfigure the popcorn vendor with the configuration admin.
	 */
	@Validate
	public void refillStock() {
		try {
			// Retrieve or Create the instance configuration from the
			// configuration admin
			Configuration configuration = m_configAdmin.getConfiguration(
					"Super.PopCorn.Stock",
					"file:D:/svn/uims/advanced.tutorial/vendor.popcorn/target/vendor.popcorn-1.0.0.jar");
			configuration
					.setBundleLocation("file:D:/svn/uims/advanced.tutorial/vendor.popcorn/target/vendor.popcorn-1.0.0.jar");
			Properties props = new Properties();
			props.put("stock", new Integer(15)); // Delivered corn
			configuration.update(props);
			System.out.println("Update configuration of "
					+ configuration.getPid() + "("
					+ configuration.getBundleLocation() + ")");
			configuration.delete();
		} catch (IOException e) {
			e.printStackTrace();
		} // We indicates the set ManagedService PID
	}
}
