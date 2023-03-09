package com.lgu.ccss.admin.product.domain;

import com.lgu.ccss.common.domain.BaseVO;

public class ProductVO extends BaseVO {

	static final long serialVersionUID = 6452632495363392365L;
	
	private String productNm;
	private String productExplain;
	
	public String getProductNm() {
		return productNm;
	}
	public void setProductNm(String productNm) {
		this.productNm = productNm;
	}
	public String getProductExplain() {
		return productExplain;
	}
	public void setProductExplain(String productExplain) {
		this.productExplain = productExplain;
	}
	
	
	
}
