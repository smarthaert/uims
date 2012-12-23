package uims.common.tools.util;

import java.io.IOException;

import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.StatusLine;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpResponseException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.util.EntityUtils;


public class RedirectUrlResponseHandler implements ResponseHandler<String> {

	public String handleResponse(HttpResponse response)
			throws ClientProtocolException, IOException {
		StatusLine statusLine = response.getStatusLine();
        HttpEntity entity = response.getEntity();
        String redirectUrl = null;
        if (statusLine.getStatusCode() == 302) {
        	redirectUrl = response.getFirstHeader("Location").getValue();
        }else if (statusLine.getStatusCode() >= 300) {
            EntityUtils.consume(entity);
            throw new HttpResponseException(statusLine.getStatusCode(),
                    statusLine.getReasonPhrase());
        }
        
        return redirectUrl;
	}

}
