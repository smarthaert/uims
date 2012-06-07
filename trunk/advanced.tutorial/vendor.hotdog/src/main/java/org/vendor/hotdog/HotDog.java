package org.vendor.hotdog;

import org.vendor.services.Product;

/**
 * A hotdog implementation.
 */
public class HotDog implements Product {

	/**
	 * Returns the store location.
	 * 
	 * @return 'Fenway Park'
	 * @see org.apache.felix.ipojo.example.vendor.service.Product#getProductOrigin()
	 */
	public String getProductOrigin() {
		return "Fenway Park";
	}

	/**
	 * Returns the product type
	 * 
	 * @return 'hotdog'
	 * @see org.apache.felix.ipojo.example.vendor.service.Product#getProductType()
	 */
	public String getProductType() {
		return "Hotdog";
	}

}