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
package org.vendor.popcorn;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Controller;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Provides;
import org.vendor.services.Product;
import org.vendor.services.Vendor;

/**
 * A popcorn vendor implementation.
 * To sell popcorn, the vendor use corn. This implementation manage its own corn stock.
 */
@Component(name="popcorn", public_factory=true, architecture=true)
@Provides
@Instantiate
public class PopCornVendor implements Vendor {
    
    /**
     * The corn stock.
     */
    private int m_corn_stock;
    
    /**
     * Lifecycle controller.
     * If set to false, the instance becomes invalid. 
     */
    @Controller
    private boolean m_can_sell = true;

    /**
     * The sell method.
     * To provide popcorn, the vendor needs to decrease its corn stock level.
     * This method is synchronized to avoid to client being serve at the same time. 
     * @return
     * @see org.apache.felix.ipojo.example.vendor.service.Vendor#sell()
     */
    public synchronized Product sell() {
        m_corn_stock--;
        if (m_corn_stock == 0 && m_can_sell) { // Last pop corn
            m_can_sell = false;
            System.out.println("Stop selling popcorn ... Run out of stock");
            return new PopCorn();
        } else if (m_corn_stock > 0) { // Normal case
            return new PopCorn();
        } else { // Cannot serve.
            return PopCorn.NO_MORE_POPCORN;
        }
    }
    
    /**
     * A transporter refills the stock of corn.
     * This method is synchronized to avoid to client being served during the update.
     * @param newStock : the stock of corn to add to the current stock.
     */
    public synchronized void refillStock(int newStock) {
        m_corn_stock += newStock;
        System.out.println("Refill the stock : " + m_corn_stock);
        if (m_corn_stock > 0) {
            m_can_sell = true;
        }
    }
}
