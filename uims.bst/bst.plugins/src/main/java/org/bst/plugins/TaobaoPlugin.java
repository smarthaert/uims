package org.bst.plugins;

import java.io.InputStream;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Provides;
import org.apache.felix.ipojo.annotations.Requires;
import org.apache.log4j.Logger;
import org.bst.esb.services.OCRUtils;
import org.bst.esb.services.OrderUtils;
import org.bst.esb.services.TipInfo;
import org.bst.esb.services.TipOrder;
import org.bst.esb.services.UimsPlugin;

@Component(name = "TaobaoPlugin")
@Provides
@Instantiate(name = "TaobaoPlugin")
public class TaobaoPlugin implements UimsPlugin {

	Logger log = Logger.getLogger(TaobaoPlugin.class.getName());

	@Requires
	OCRUtils ocr;

	@Requires
	OrderUtils ou;

	private String id = "P002";

	public void doOrder(TipOrder to) {
		getInfo(to);
	}

	private void getInfo(TipOrder to) {

		log.info("Visit third web site to get Tip info...");
		InputStream img = null;
		log.info("Use framework service [ocr] to get image code...");
		String ckeck = ocr.analyze(img);
		// get info from ....
		TipInfo ti = null;
		System.out
				.println("Use framework service [order] to put back tip info...");
		ou.finishInfoGet(ti);
	}

	public String getId() {
		return this.id;
	}

}
