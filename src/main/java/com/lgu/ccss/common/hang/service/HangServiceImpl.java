package com.lgu.ccss.common.hang.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.CoreConnectionPNames;
import org.apache.http.params.HttpParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


@Service
public class HangServiceImpl implements HangService{
	private final Logger logger = LoggerFactory.getLogger(HangServiceImpl.class);
	private final Logger hangLogger = LoggerFactory.getLogger("HANGLogger");
	
	@Value("#{config['app.hang.id']}")
	private String appHangID;
	
	@Value("#{config['common.hang.url']}")
	private String hangUrl;
	
	
	public void doTask() {
		
		
		HttpPost post = new HttpPost(hangUrl);
		HttpParams params = new BasicHttpParams();
		params.setParameter(CoreConnectionPNames.CONNECTION_TIMEOUT, 10000);
		params.setParameter(CoreConnectionPNames.SO_TIMEOUT, 10000);
		post.setParams(params);
		
		HttpClient client = new DefaultHttpClient();
		HttpResponse response = null;
		
		try {
			response = client.execute(post);
		} catch (ClientProtocolException e) {
			logger.error("{}", e);
		} catch (IOException e) {
			logger.error("{}", e);
		}
		
		if (response == null) {
			logger.error("hang check error.");
			return;
		}
		
		if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
			String body = null;
			try {
				body = getBody(response);
			} catch (IllegalStateException e) {
				logger.error("{}", e);
			} catch (IOException e) {
				logger.error("{}", e);
			}
			
			if ("success".equals(body)) {
				hangLogger.info(appHangID + " health check : alived");
				return;
			}
		}
	}
	
	private String getBody(HttpResponse response) throws IllegalStateException, IOException {
		BufferedReader rd = new BufferedReader(
		        new InputStreamReader(response.getEntity().getContent()));

		StringBuffer result = new StringBuffer();
		String line = "";
		while ((line = rd.readLine()) != null) {
			result.append(line);
		}
		
		return result.toString();
	}
}
