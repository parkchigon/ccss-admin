package com.lgu.ccss.common.utility.keygenerator;

import java.util.Properties;

public class KeyGenerator {
	
	private static Properties properties;
	private static int instanceId;
	private static int commonShardDbSetId;

	private static final String INSTANCE_ID = System.getProperty("INSTANCE_ID");
	
	public static void setProperties(Properties properties) {
		KeyGenerator.properties = properties;
		try {
			
			
		} catch(Exception e) {
			
		}

	}
	
	public static String createCommonShardKey() throws Exception{
		return String.valueOf(FGOID.getGUID(commonShardDbSetId, getInstanceId(), 0));
	}
	
	public static String createCommonShardKey(int instanceId) throws Exception{
		return String.valueOf(FGOID.getGUID(commonShardDbSetId, instanceId, 0));
	}
	
	/**
	 * 서버 인스턴스 아이디
	 * @return
	 */
	public static int getInstanceId(){
		return Integer.parseInt(INSTANCE_ID);
	}
	
	public static void main(String[] args) throws Exception {
		
		KeyGenerator k = new KeyGenerator();
		
		for(int i=0; i<10; i++) {
			System.out.println(KeyGenerator.createCommonShardKey());
		}
	}
}
