package org.vendor.hotdog;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Provides;
import org.apache.felix.ipojo.annotations.Requires;
import org.vendor.services.Product;
import org.vendor.services.Vendor;
import org.vendor.services.ingredient.Bun;
import org.vendor.services.ingredient.Wiener;

@Component(name="HD", publicFactory=false, architecture=true)
@Provides
@Instantiate
public class HotDogVendor implements Vendor {

	/**
	 * Bun provider (required service).
	 */
	@Requires(filter="(buns>=1)")
	private Bun bunProvider;

	/**
	 * Wiener provider (required service).
	 */
	@Requires(filter="(wieners>=1)")
	private Wiener wienerProvider;

	/**
	 * Sell method. To provide an hotdog, the vendor consume a bun and a wiener.
	 * This method is synchronized to avoid serving to client at the same time.
	 * 
	 * @return a hotdog.
	 * @see org.apache.felix.ipojo.example.vendor.service.Vendor#sell()
	 */
	public synchronized Product sell() {
		bunProvider.getBun();
		wienerProvider.getWiener();
		return new HotDog();
	}
}