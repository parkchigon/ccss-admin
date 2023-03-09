/* 
 * Revision History
 * Author              Date             Description
 * ------------------   --------------    ------------------
 *   taeki.kim           2012. 2. 14 오후 3:02:50  com.ucloud.app.core.utility
 */
package com.lgu.ccss.common.utility;

import org.apache.commons.lang.StringUtils;

/**
 * The Class XSSUtil.
 */
public class XSSUtil {
	
	//~ Static fields/initializers =====================================================================================
	//~ Instance fields ================================================================================================
	//~ Constructors ===================================================================================================
	//~ Implementation Method (interface/abstract) =====================================================================
	//~ Self Methods ===================================================================================================
	
	/**
	 * <p>
	 * description about class
	 * </p>
	 * Sanitize.
	 * 
	 * @param string the string
	 * @return the string
	 */
	public static String sanitize(String string) {

		if (string == null) {
			return "";
		}
		String value = "";
		try{
			value = string.replaceAll("(?i)<script.*?>.*?</script.*?>", "")
					.replaceAll("(?i)<.*?javascript:.*?>.*?</.*?>", "")
					.replaceAll("(?i)<.*?\\s+on.*?>.*?</.*?>", "");
			value = escapeHTML(value);
		}catch(Exception e){
			e.printStackTrace();
		}
		return value;
	}
	
	/**
	 * <p>
	 * description about class
	 * </p>
	 * Escape html.
	 * 
	 * @param value the value
	 * @return the string
	 * @throws Exception the exception
	 */
	public static String escapeHTML (String value) throws Exception {
		String str = value;
		str = StringUtils.replace(str, "<", "&lt;");
		str = StringUtils.replace(str, ">", "&gt;");
		return str;
	}
	
	/**
	 * <p>
	 * description about class
	 * </p>
	 * Unescape html.
	 * 
	 * @param value the value
	 * @return the string
	 * @throws Exception the exception
	 */
	public static String unescapeHTML (String value) throws Exception {
		String str = value;
		str = StringUtils.replace(str, "&lt;", "<");
		str = StringUtils.replace(str, "&gt;", ">" );
		return str;
	}
	

	/**
	 * <p>
	 * description about class
	 * </p>
	 * .
	 * 
	 * @param vars the arguments
	 */
	public static void main(String[] vars) throws Exception {
		String str = "<p>체험판</p>";
		System.out.println(sanitize(str));
		System.out.println(unescapeHTML(sanitize(str)));
	}
	
	//~ Getter and Setter ==============================================================================================
}
