/* 
 * Revision History
 * Author              Date             Description
 * ------------------   --------------    ------------------
 *   taeki.kim           2012. 2. 1
 */
package com.lgu.ccss.common.utility;

import java.util.Enumeration;
import java.util.Properties;

import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


/**
 * config.properties + system properties를 하나로 관리하는 Class.
 */
public class ConfigProperties extends PropertiesConfiguration {

	//~ Static fields/initializers =====================================================================================

    /** The Constant logger. */
    private static final Logger logger = LoggerFactory.getLogger(ConfigProperties.class);

  //~ Instance fields ================================================================================================

    /** The properties. */
    private Properties properties;

  //~ Constructors ===================================================================================================

    /**
     * Instantiates a new common configuration.
     */
    public ConfigProperties() {
    }

  //~ Implementation Method (interface/abstract) =====================================================================
  //~ Self Methods ===================================================================================================
    
    /**
     * After properties set.
     */
    @SuppressWarnings("rawtypes")
	public void init() {
        StringBuffer elements = new StringBuffer();

        if (this.properties != null) {
            Enumeration keys = this.properties.propertyNames();
            elements.append("\n ============= dispay config data =============");

            while (keys.hasMoreElements()) {
                String key = (String) keys.nextElement();
                String value = this.properties.getProperty(key);
                elements.append("\n").append("[" + key + "] : " + value);
                super.setProperty(key, value);
            }
        }
        else {
            elements.append("\n ============= no config data =============");
        }
        logger.debug(elements.toString());
        // 기존 데이터 삭제
        this.properties = null;
        elements = null;
    }
    
    /**
     * property 조회.
     * @param key
     * @return
     */
    public String getStrings(String key) {
    	String[] array = this.getStringArray(key);
    	if (array == null) {
    		return null;
    	}
    	return StringUtils.join(array, ",");
    }

  //~ Getter and Setter ==============================================================================================
    
    /**
     * Sets the properties.
     * 
     * @param properties the new properties
     */
    public void setProperties(Properties properties) {
        this.properties = properties;
    }

}
