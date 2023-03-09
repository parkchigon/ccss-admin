package com.lgu.ccss.admin.term.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;







import com.lgu.ccss.admin.system.code.domain.CodeVO;
import com.lgu.ccss.admin.system.code.service.CodeServiceImpl;
import com.lgu.ccss.admin.term.domain.TermsVO;
import com.lgu.ccss.admin.term.service.TermsServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;

@Controller
public class TermsController {
	
	@Resource(name = "termsService")
	private TermsServiceImpl termsService;
	
	
	@Resource(name = "codeService")
	private CodeServiceImpl codeService;
	
	@Autowired
	private PageUtil pageUtil;
	
	/**
	 * 약관 관리 리스트화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/term/termsList.do")
	public String termsList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/term/termsList";
	}
	
	
	/**
	 * 약관 리스트 조회  리스트 5개 7페이지씩 노출
	 * 
	 * @param request
	 * @param response
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/term/selectTermsList.do", method = RequestMethod.POST)
	public Map<String, Object> selectTermsList(HttpServletRequest request, HttpServletResponse response, TermsVO termsVO) throws Exception {

		termsVO.setPageRowCount(Constants.PAGING_CNT_FIVE);
		Map<String, Object> resultMap = termsService.selectTermsList(termsVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(termsVO.getPage(), pageUtil.getTotalPage(totalCount, termsVO.getPageRowCount()), termsVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	/**
	 * 약관 삭제
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/term/deleteTermsAjax.do")
	public Map<String, Object> deleteTermsAjax(HttpServletRequest request, HttpServletResponse response, TermsVO termsVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = termsService.deleteTermsAjax(termsVO);
		return resultMap;
	}
	
	
	/**
	 * 약관 등록 화면
	 * 
	 * @param request
	 * @param response
	 * @param termsVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/term/termsInsertForm.do")
	public String termsInsertForm(HttpServletRequest request, HttpServletResponse response, TermsVO termsVO, ModelMap model) throws Exception {
		return "/term/termsInsertForm";
	}
	
	/**
	 * 신규 약관 등록
	 * @param request
	 * @param response
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/term/insertNewTerms.do")
	public Map<String, Object> insertNewTerms(HttpServletRequest request, HttpServletResponse response, TermsVO termsVO) throws Exception {
	
		termsVO.setRegId(SessionUtil.getLoginId(request));
		termsVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = termsService.insertNewTerms(termsVO);
	
		return resultMap;
	}
	
	/**
	 * 약관 상세 화면
	 * 
	 * @param request
	 * @param response
	 * @param termsVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/term/termsDetail.do")
	public String selectTermsDetail(HttpServletRequest request, HttpServletResponse response, TermsVO termsVO, ModelMap model) throws Exception {
		termsVO = termsService.selectTermsDetail(termsVO);
		model.addAttribute("termsVO", termsVO);
		return "/term/termsDetail";
	}
	
	/**
	 * 약관 수정 화면
	 * 
	 * @param request
	 * @param response
	 * @param termsVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/term/termsEditForm.do")
	public String gunbamTermsEditForm(HttpServletRequest request, HttpServletResponse response, TermsVO termsVO, ModelMap model) throws Exception {
		termsVO = termsService.selectTermsDetail(termsVO);
		model.addAttribute("termsVO", termsVO);
		return "/term/termsEditForm";
	}
	
	/**
	 * 약관 수정
	 * 
	 * @param request
	 * @param response
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/term/updateTerms.do")
	public Map<String, Object> updateTerms(HttpServletRequest request, HttpServletResponse response, TermsVO termsVO) throws Exception {
		termsVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = termsService.updateTerms(termsVO);
		return resultMap;
	}
	
	
	
	/**
	 * 약관 타입 리스트 공통 코드  조회 -> Code Contrller 공통으로 분리
	 * 
	 * @param request
	 * @param response
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	/*@RequestMapping(value = "/term/selectTermsDivList.do")
	public Map<String, Object> selectTermsDivList(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO) throws Exception {
		Map<String, Object> resultMap = codeService.selectDtlCodeListByGrpCodeNm(codeVO);
		return resultMap;
	}*/
}

