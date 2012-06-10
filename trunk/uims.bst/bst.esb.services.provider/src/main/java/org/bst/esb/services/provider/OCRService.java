package org.bst.esb.services.provider;

import java.io.InputStream;

import org.apache.felix.ipojo.annotations.Component;
import org.apache.felix.ipojo.annotations.Instantiate;
import org.apache.felix.ipojo.annotations.Provides;
import org.apache.log4j.Logger;
import org.bst.esb.services.OCRUtils;

@Component(name="OCRService")
@Provides
@Instantiate(name="OCRService")
public class OCRService implements OCRUtils {

	Logger log = Logger.getLogger(OCRService.class.getName());

	public String analyze(InputStream img) {
		String check = null;
		log.info("use robot ocr service....");
		check = robotOCR(img);
		if (check == null) {
			log.info("use manual ocr service....");
			check = manualOCR(img);
		}
		if (check == null) {
			log.info("There is something wrong with ocr manual service");
		}
		return check;
	}

	private String manualOCR(InputStream img) {
		String check = null;

		// TODO Auto-generated method stub
		return check;

	}

	private String robotOCR(InputStream img) {
		String check = null;

		// TODO Auto-generated method stub
		return check;
	}

}
