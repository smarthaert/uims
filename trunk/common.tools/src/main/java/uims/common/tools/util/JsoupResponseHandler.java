package uims.common.tools.util;

import java.io.IOException;

import org.apache.http.HttpResponse;
import org.apache.http.TruncatedChunkException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

public class JsoupResponseHandler implements ResponseHandler<Document> {

	public Document handleResponse(HttpResponse response)
			throws ClientProtocolException, IOException {
		// TODO Auto-generated method stub
		Document doc = null;
		try{
//			doc = Jsoup.parse(response.getEntity().getContent(), "UTF-8", "");
			doc = Jsoup.parse(response.getEntity().getContent(), "gb2312", "");
		}catch(TruncatedChunkException e){
			e.printStackTrace();
		}
		return doc;
	}

}
