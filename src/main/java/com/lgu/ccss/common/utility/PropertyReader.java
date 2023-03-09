/**
 * @(#)PropertyReader.java
 *
 * @version 1.0  2013. 6. 27. 
 * @author p037205
 * 
 * Copyright 2000-2013 by FEELingk, Inc. All rights reserved.
 */
package com.lgu.ccss.common.utility;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;

/**
 * TODO type class declaration
 */
public class PropertyReader {

    private String configName = "/config/common.config.properties";

    public PropertyReader() {
    }

    public PropertyReader(String configName) {
        this.configName = configName;
    }

    /**
     * getValue 시 null 일 경우 defaultStr 을 반환한다.
     * 
     * @param key
     * @param defaultStr
     * @return
     */
    public String getValueCheckNull(String key, String defaultStr) {
        if (null == getValue(key)) {
            return defaultStr;
        } else {
            return getValue(key);
        }
    }

    /**
     * propertyName file load
     * 
     * @return
     */
    public Properties loadProperity() {

        Properties props = new Properties();
        InputStream in = null;
        try {
            Resource resource = new ClassPathResource(configName);
            props = PropertiesLoaderUtils.loadProperties(resource);
            in = getClass().getResourceAsStream(configName);
            props.load(in);
        } catch (IOException e) {
            throw new RuntimeException("Loading propertied fail.");
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (IOException e) {
                }
            }
        }

        return props;
    }

    public String getValue(String key) {
        Properties prop = loadProperity();
        String value = "";
        if (prop != null) {
            if (prop.getProperty(key) != null) {
                value = prop.getProperty(key);
            }
        }
        return value;
    }

}
