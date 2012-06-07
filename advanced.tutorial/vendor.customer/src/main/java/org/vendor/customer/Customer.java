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
package org.vendor.customer;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Property;
import org.apache.felix.ipojo.annotations.Requires;
import org.vendor.services.Product;
import org.vendor.services.Vendor;

/**
 * Component class implementing a Customer.
 * A customer just starts and uses an available Vendor service to eat something.
 */
@Component(name="customer", immediate=true, architecture=true)
public class Customer {
    
    /**
     * Vendor service.
     * (Injected).
     */
	@Requires
    private Vendor vendor;
    
    /**
     * Customer name.
     * (Injected Property). 
     */
	@Property(name="customer.name")
    private String name;
    
    /**
     * Constructor.
     * Get a product from the vendor and eat it.
     */
    public Customer() {
        Product product = vendor.sell();
        System.out.println("Customer " + name + " bought " +  product.getProductType() + " from " + product.getProductType());
    }

}
