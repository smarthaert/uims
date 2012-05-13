package com.bst.pro.util;

import java.io.IOException;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.util.EntityUtils;

import com.hfutxf.weibo4j.org.json.JSONException;
import com.hfutxf.weibo4j.org.json.JSONObject;

public class JSONObjectResponseHandler implements ResponseHandler<JSONObject> {

	private JSONObject json;

	public JSONObject handleResponse(HttpResponse response)
			throws ClientProtocolException, IOException {
		try {
			json = new JSONObject(EntityUtils.toString(response.getEntity()));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json;
	}

}
