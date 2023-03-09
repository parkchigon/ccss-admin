/* Copyright (c) 2012 KT, Inc.
 * All right reserved.
 * http://www.ucloud.com
 * This software is the confidential and proprietary information of KT
 * , Inc. You shall not disclose such Confidential Information and
 * shall use it only in accordance with the terms of the license agreement
 * you entered into with KT.
 *
 * Revision History
 * Author              Date             Description
 * ------------------   --------------    ------------------
 *   taeki.kim           2012. 2. 1
 */
package com.lgu.ccss.common.utility;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;


public final class JsonUtil {

	// ~ Static fields/initializers =====================================================================================
	// ~ Instance fields ================================================================================================
	// ~ Constructors ===================================================================================================
	// ~ Implementation Method (interface/abstract) =====================================================================
	// ~ Self Methods ===================================================================================================

	
	/**
	 * <p>
	 * 객체의 메모리 구조를 json 자료형태로 변형
	 * 
	 * @param object the object
	 * @return the string
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonGenerationException 
	 * @throws Exception the exception
	 */
	public static String marshallingJson(Object object) throws JsonGenerationException, JsonMappingException, IOException {
//		TokenBuffer buffer = new TokenBuffer(null);
//		ObjectMapper objectMapper = new ObjectMapper();
//		objectMapper.setSerializationInclusion(JsonSerialize.Inclusion.NON_NULL);
//		objectMapper.writeValue(buffer, object);
//		JsonNode root = objectMapper.readTree(buffer.asParser());
//		String jsonText = objectMapper.writeValueAsString(root);
//		jsonText = jsonText.replaceAll("null", "\"\"");
//		return jsonText;
		
		if (object != null){
			ObjectMapper mapper = new ObjectMapper();
			String jsonText = mapper.writeValueAsString(object);
			return jsonText.replaceAll("null", "\"\"");
		} else {
			return "";
		}
		
	}

	/**
	 * <p>
	 * description about class
	 * </p>
	 * Unmarshalling json.
	 * 
	 * @param <T> the
	 * @param jsonText the json text
	 * @param valueType the value type
	 * @return the t
	 * @throws IOException 
	 * @throws JsonMappingException 
	 * @throws JsonParseException 
	 * @throws Exception the exception
	 */
	public static <T> T unmarshallingJson(String jsonText, Class<T> valueType) throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper objectMapper = new ObjectMapper();
		String data = jsonText.replaceAll("null", "\"\"");
		return (T) objectMapper.readValue(data, valueType);
	}
	
	// ~ Getter and Setter ==============================================================================================
}
