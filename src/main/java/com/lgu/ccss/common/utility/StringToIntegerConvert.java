/* 
 * Revision History
 * Author              Date             Description
 * ------------------   --------------    ------------------
 *   taeki.kim           2012. 2. 1
 */
package com.lgu.ccss.common.utility;

import org.apache.commons.lang.StringUtils;
import org.springframework.core.convert.converter.Converter;

public class StringToIntegerConvert implements Converter<String, Integer> {

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

    public Integer convert(String source) {
        if (StringUtils.isEmpty(source)) {
            return new Integer(0);
        }
        return Integer.valueOf(source);
    }

    // ~ Getter and Setter
    // ==============================================================================================
}
