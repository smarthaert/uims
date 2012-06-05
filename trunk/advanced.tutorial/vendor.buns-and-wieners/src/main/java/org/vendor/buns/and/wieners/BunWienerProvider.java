package org.vendor.buns.and.wieners;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Provides;
import org.vendor.services.BunService;
import org.vendor.services.WienerService;

@Component(name="buns_and_wieners")
@Provides
public class BunWienerProvider implements BunService, WienerService {

	public void getBun() {
		System.out.println("Get a bun");
	}

	public void getWiener() {
		System.out.println("Get a wiener");
	}
}