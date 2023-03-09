/* 
 * Revision History
 * Author              Date             Description
 * ------------------   --------------    ------------------
 *   taeki.kim           2012. 2. 1
 */
package com.lgu.ccss.common.utility;

import org.apache.commons.lang.StringUtils;
import org.springframework.core.convert.converter.Converter;

/**
 * The Class StringTrimConvert.
 */
public class StringTrimConvert implements Converter<String, String> {

    // ~ Static fields/initializers
    // =====================================================================================
    // ~ Instance fields
    // ================================================================================================
    // ~ Constructors
    // ===================================================================================================
    // ~ Implementation Method (interface/abstract)
    // =====================================================================
    // ~ Self Methods
    // ===================================================================================================

    /*
     * (non-Javadoc)
     * 
     * @see
     * org.springframework.core.convert.converter.Converter#convert(java.lang
     * .Object)
     */
    public String convert(String source) {
        String str = null;
        if (source != null) {
            str = XSSUtil.sanitize(source);
        }
        return StringUtils.trimToEmpty(str);
    }

    // ~ Getter and Setter
    // ==============================================================================================
}
