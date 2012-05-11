package com.bst.pro;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;

public class ImageResponseHandler implements ResponseHandler<String> {

	public String handleResponse(HttpResponse response)
			throws ClientProtocolException, IOException {
		// TODO Auto-generated method stub
		InputStream ins =  response.getEntity().getContent();
		BufferedImage bi = ImageIO.read(ins);  
        File f =new File("qqimg.jpg");  
        ImageIO.write(bi, "jpg", f);  
		return f.getAbsolutePath();
	}

}
