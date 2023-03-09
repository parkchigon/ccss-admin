package com.lgu.ccss.admin.system.code.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;

import com.lgu.ccss.admin.admin.domain.AdminPagingVO;
import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.admin.admin.service.AdminServiceImpl;
import com.lgu.ccss.admin.app.domain.AppVO;
import com.lgu.ccss.admin.product.domain.ProductVO;
import com.lgu.ccss.admin.product.service.ProductServiceImpl;
import com.lgu.ccss.admin.system.code.domain.CodeVO;
import com.lgu.ccss.admin.system.code.service.CodeServiceImpl;
import com.lgu.ccss.admin.user.service.UserServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;

@Controller
@RequestMapping(value = "/system/code")
public class CodeController {
	
	@Resource(name = "codeService")
	private CodeServiceImpl codeService;
	
	@Autowired
	private PageUtil pageUtil;

	
	/**
	 * Group Code 리스트 조회  리스트 20개 
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectGroupCodeList.do", method = RequestMethod.POST)
	public Map<String, Object> selectGroupCodeList(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO) throws Exception {
		codeVO.setPageRowCount(Constants.PAGING_CNT_TWENTY);
		Map<String, Object> resultMap = codeService.selectGroupCodeList(codeVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(codeVO.getPage(), pageUtil.getTotalPage(totalCount, codeVO.getPageRowCount()), codeVO.getPageRowCount(), Constants.GO_SEARCH);
		resultMap.put(Constants.PAGING, paging);
		return resultMap;
	}
	
	
	/**
	 * 상세 코드(DTL) 코드 조회 (그룹 코드 명)
	 * 
	 * @param codeVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectDtlCodeList.do", method = RequestMethod.POST)
	public Map<String, Object> selectDtlCodeListByGcodeNm(HttpServletRequest request, ModelMap model,CodeVO codeVO) throws Exception {

		if(String.valueOf(codeVO.getGrpCdId()).equals("null")){
			String grpCdId = codeService.selectGrpCdId(codeVO.getGrpCdNm());
			codeVO.setGrpCdId(grpCdId);
		}
		
		Map<String, Object> resultMap = codeService.selectDtlCodeList(codeVO);
		return resultMap;
	}
	
	
	
	/**
	 * Group Code 리스트화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/groupCodeListView.do")
	public String groupCodeListView(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/system/code/groupCodeListView";
	}
	

	/**
	 * Group Code 등록 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/groupCodeInsert.do")
	public String groupCodeInsert(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/system/code/groupCodeInsert";
	}
	
	/**
	 * DTL Code 등록 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dtlCodeInsert.do")
	public String dtlCodeInsert(HttpServletRequest request, HttpServletResponse response, ModelMap model ,CodeVO codeVO) throws Exception {
		
		System.out.println("codeVO:"+  codeVO.toString());
		model.addAttribute("codeVO", codeVO);
		return "/system/code/dtlCodeInsert";
	}
	
	
	/**
	 * DTL Code  정보 등록
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertNewDtlCode.do")
	public Map<String, Object> insertNewDtlCode(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO) throws Exception {
		codeVO.setRegId(SessionUtil.getLoginId(request));
		codeVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = codeService.insertNewDtlCode(codeVO);
		return resultMap;
	}
	
	
	
	/**
	 * Group Code 수정 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/groupCodeEdit.do")
	public String groupCodeEdit(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO,ModelMap model) throws Exception {
		codeVO = codeService.selectGroupCodeDetail(codeVO);
		model.addAttribute("codeVO", codeVO);
		return "/system/code/groupCodeEdit";
	}
	
	
	
	
	/**
	 * Group Code  정보 등록
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertNewGroupCode.do")
	public Map<String, Object> insertNewGroupCode(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO) throws Exception {
		codeVO.setRegId(SessionUtil.getLoginId(request));
		codeVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = codeService.insertNewGroupCode(codeVO);
		return resultMap;
	}
	
	
	/**
	 * Group Code 정보 삭제
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/deleteGroupCode.do")
	public Map<String, Object> deleteGroupCode(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = codeService.deleteGroupCode(codeVO);
		return resultMap;
	}
	

	/**
	 * DTL Code 정보 삭제
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/deleteDtlCode.do")
	public Map<String, Object> deleteDtlCode(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = codeService.deleteDtlCode(codeVO);
		return resultMap;
	}

	
	/**
	 * Group Code 수정
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/updateGroupCode.do")
	public Map<String, Object> updateGroupCode(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO) throws Exception {
		codeVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = codeService.updateGroupCode(codeVO);
		return resultMap;
	}
	
	
	/**
	 * Dtl Code 수정
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/updateDtlCode.do")
	public Map<String, Object> updateDtlCode(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO) throws Exception {
		codeVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = codeService.updateDtlCode(codeVO);
		return resultMap;
	}
	
	
	
	
	/**
	 * Group Code 상세 화면
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/groupCodeDetail.do")
	public String groupCodeDetail(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO, ModelMap model) throws Exception {
		codeVO.setPageRowCount(Constants.PAGING_CNT_TWENTY);
		//그룹 코드 정보 조회
		codeVO = codeService.selectGroupCodeDetail(codeVO);
		model.addAttribute("codeVO", codeVO);
		return "/system/code/groupCodeDetail";
	}
	
	
	/**
	 * Dtl Code 상세 조회
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dtlCodeDetail.do")
	public Map<String, Object> dtlCodeDetail(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO, ModelMap model) throws Exception {
		Map<String, Object> resultMap =  new HashMap<String, Object>();
		resultMap.put("codeVO"	,codeService.selectDtlCodeDetail(codeVO));
		
		return resultMap;
	}

	/**
	 * DTL Code 리스트 조회  리스트 20개 
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectDtlCodeListPaging.do")
	public Map<String, Object> selectDtlCodeListPaging(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO) throws Exception {
		codeVO.setPageRowCount(Constants.PAGING_CNT_FIVE);
		Map<String, Object> resultMap = codeService.selectDtlCodeListPaging(codeVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(codeVO.getPage(), pageUtil.getTotalPage(totalCount, codeVO.getPageRowCount()), codeVO.getPageRowCount(), Constants.GO_SEARCH);
		resultMap.put(Constants.PAGING, paging);
		return resultMap;
	}
	
	
	/**
	 * 약관 타입 리스트 공통 코드  조회 
	 * 
	 * @param request
	 * @param response
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectDtlCodeListByGrpCodeNm.do", method = RequestMethod.POST)
	public Map<String, Object> selectDtlCodeListByGrpCodeNm(HttpServletRequest request, HttpServletResponse response, CodeVO codeVO) throws Exception {
		Map<String, Object> resultMap = codeService.selectDtlCodeListByGrpCodeNm(codeVO);
		return resultMap;
	}
	
}
