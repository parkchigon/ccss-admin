package com.lgu.ccss.admin.product.service;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.admin.domain.AdminPagingVO;
import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.admin.product.domain.ProductVO;
import com.lgu.ccss.admin.system.role.domain.RoleVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.AES128Cipher;

import devonframe.dataaccess.CommonDao;
import lguplus.security.vulner.SecurityModule;

@Service("productService")
public class ProductServiceImpl implements ProductService {
	

	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;


	/**
	 * 상품 정보 리스트 조회
	 * @param adminVO
	 * @return
	 */
	public Map<String, Object> selectProductList(ProductVO productVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<ProductVO> resultList = commonDao_oracle.selectList("Product.selectProductList",productVO);
		resultMap.put("resultList", resultList);
		return resultMap;
	}
	
	/**
	 * 상품 정보 조회
	 * @param String productNm
	 * @return
	 */
	public ProductVO selectProduct(String productNm) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		ProductVO productVO = commonDao_oracle.select("Product.selectProduct",productNm);
		//resultMap.put("resultList", resultList);
	
		return productVO;
	}
	
	
	

}
