/*
 * Revision History
 * Author              Date             Description
 * ------------------   --------------    ------------------
 *   taeki.kim           2012. 2. 1
 */

package com.lgu.ccss.common.utility;

import java.net.URL;
import java.util.Properties;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.ConfigurationConverter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.core.io.Resource;

/**
 * ConfigProperties 오브젝트를 생성해주는 빌더 클래스. InitialBean, FactoryBean 구현체
 */
public class ConfigBuildFactoryBean {

	// ~ Static fields/initializers =====================================================================================

	/** The Constant logger. */
	private static final Logger logger = LoggerFactory.getLogger(ConfigBuildFactoryBean.class);

	// ~ Instance fields ================================================================================================

	/** The configuration. */
	private CompositeConfiguration configuration;

	/** The configurations. */
	private Configuration[] configurations;

	/** The locations. */
	private Resource[] locations;

	/** The throw exception on missing. */
	private boolean throwExceptionOnMissing = true;

	// ~ Constructors ===================================================================================================
	/**
	 * Instantiates a new config build factory bean.
	 */
	public ConfigBuildFactoryBean() {
	}

	// ~ Implementation Method (interface/abstract) =====================================================================
	// ~ Self Methods ===================================================================================================

	/**
	 * 빈이 초기화 될때 실행 된다. config.properties, system properties 값들을 하나의 properties로 만든다.
	 * 
	 * @throws Exception the exception
	 */
	public void init() throws Exception {

		logger.info("config Initialize....");

		if (configuration == null && (configurations == null || configurations.length == 0)
				&& (locations == null || locations.length == 0))
			throw new IllegalArgumentException("no configuration object or location specified");

		if (configuration == null)
			configuration = new CompositeConfiguration();

		configuration.setThrowExceptionOnMissing(throwExceptionOnMissing);

		if (configurations != null) {
			for (int i = 0; i < configurations.length; i++) {
				configuration.addConfiguration(configurations[i]);
			}
		}

		if (locations != null) {
			for (int i = 0; i < locations.length; i++) {
				URL url = locations[i].getURL();
				Configuration props = new PropertiesConfiguration(url);
				configuration.addConfiguration(props);
			}
		}
	}

	/**
	 * Creates the instance.
	 * 
	 * @return the properties
	 * @throws Exception the exception
	 */
	public Properties createInstance() throws Exception {
		return (configuration != null) ? ConfigurationConverter.getProperties(configuration) : null;
	}

	@SuppressWarnings("rawtypes")
	public Class getObjectType() {
		return Properties.class;
	}

	// ~ Getter and Setter ==============================================================================================

	/**
	 * Gets the configurations.
	 * 
	 * @return Returns the configurations.
	 */
	public Configuration[] getConfigurations() {
		return configurations;
	}

	/**
	 * Set the commons configurations objects which will be used as properties.
	 * 
	 * @param configurations the configurations
	 */
	public void setConfigurations(Configuration[] configurations) {
		this.configurations = configurations;
	}

	/**
	 * Sets the locations.
	 * 
	 * @param locations the new locations
	 */
	public void setLocations(Resource[] locations) {
		this.locations = locations;
	}
}
