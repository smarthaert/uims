package org.vendor.buns.and.wieners;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Provides;
import org.apache.felix.ipojo.annotations.ServiceProperty;
import org.vendor.services.ingredient.Bun;
import org.vendor.services.ingredient.Wiener;

/**
 * Component implementation providing both buns and wieners.
 */
@Component(name="buns_and_wieners", public_factory=false, architecture=true)
@Provides
@Instantiate(name="buns_and_wieners")
public class BunWienerProvider implements Bun, Wiener {

	/**
	 * Buns stock.
	 */
	@ServiceProperty(name="buns", value="10")
	private int bunStock;

	/**
	 * Wieners stock.
	 */
	@ServiceProperty(name="wieners", value="8")
	private int wienerStock;

	/**
	 * Get a bun. This method is synchronized to avoid multiple vendor accessing
	 * the stock at the same time.
	 * 
	 * @see org.apache.felix.ipojo.example.vendor.service.ingredient.Bun#getBun()
	 */
	public synchronized void getBun() {
		bunStock = bunStock - 1;
	}

	/**
	 * Get a wiener. This method is synchronized to avoid multiple vendor
	 * accessing the stock at the same time.
	 * 
	 * @see org.apache.felix.ipojo.example.vendor.service.ingredient.Wiener#getWiener()
	 */
	public void getWiener() {
		wienerStock = wienerStock - 1;
	}

}
