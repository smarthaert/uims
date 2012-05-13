package com.bst.pro.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Logger;

import javax.imageio.ImageIO;

import org.apache.http.HeaderIterator;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;

public class ImageResponseHandler implements ResponseHandler<String> {

	Logger log = Logger.getLogger(ImageResponseHandler.class.getName());
	public String handleResponse(HttpResponse response)
			throws ClientProtocolException, IOException {
		//print the response cookies 
		HeaderIterator hi = response.headerIterator("Set-Cookie");
		while(hi.hasNext()){
			log.info(hi.next().toString());
		}
		
		//get and save check image
		InputStream ins =  response.getEntity().getContent();
		BufferedImage bi = ImageIO.read(ins);  
        File f =new File("qqimg.jpg");  
        ImageIO.write(bi, "jpg", f);  
        
        //return image file path
		return f.getAbsolutePath();
	}

}
