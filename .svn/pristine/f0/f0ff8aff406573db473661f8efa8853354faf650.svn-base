package com.lgu.ccss.admin.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lgu.ccss.admin.admin.domain.AdminPagingVO;
import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.admin.admin.service.AdminServiceImpl;
import com.lgu.ccss.admin.product.domain.ProductVO;
import com.lgu.ccss.admin.product.service.ProductServiceImpl;
import com.lgu.ccss.admin.user.service.UserServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;

@Controller
@RequestMapping(value = "/product")
public class ProductController {
	
	@Resource(name = "productService")
	private ProductServiceImpl productService;
	
	@Autowired
	private PageUtil pageUtil;

	
	
	/**
	 * 상품 정보 리스트 조회
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectProductList.do")
	public Map<String, Object> selectProductList(HttpServletRequest request, ModelMap model,ProductVO productVO) throws Exception {
		Map<String, Object> resultMap = productService.selectProductList(productVO);
		return resultMap;
	}
}
