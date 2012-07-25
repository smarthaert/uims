package com.bst.pro.util;

import java.io.IOException;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class JsoupResponseHandler implements ResponseHandler<Document> {

	public Document handleResponse(HttpResponse response)
			throws ClientProtocolException, IOException {
		// TODO Auto-generated method stub
		return Jsoup.parse(response.getEntity().getContent(), "UTF-8", "");
	}

}
