package com.lgu.ccss.admin.voice.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;













import com.lgu.ccss.admin.term.domain.TermsVO;
import com.lgu.ccss.admin.term.service.TermsServiceImpl;
import com.lgu.ccss.admin.voice.domain.VoiceVO;
import com.lgu.ccss.admin.voice.service.VoiceServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;

@Controller
public class VoiceController {
	private static final Logger logger = LoggerFactory.getLogger(VoiceController.class);
    @Resource(name = "voiceService")
	private VoiceServiceImpl voiceService;
	
   
	@Autowired
	private PageUtil pageUtil;
	
	
	/**
	 * 도메인 관리 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/domainList.do")
	public String termsList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/voice/domainList";
	}
	
	/**
	 * 도메인 리스트 조회  리스트 10개
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/selectDomainList.do", method = RequestMethod.POST)
    public Map<String, Object> selectTermsList(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {

		voiceVO.setPageRowCount(Constants.PAGING_CNT_TEN);
		Map<String, Object> resultMap = voiceService.selectDomainList(voiceVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(voiceVO.getPage(), pageUtil.getTotalPage(totalCount, voiceVO.getPageRowCount()), voiceVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	
	/**
	 * 도메인 리스트 조회  전체
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/selectAllDomainListAjax.do")
    public Map<String, Object> selectAllDomainListAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {

		
		Map<String, Object> resultMap = voiceService.selectAllDomainList(voiceVO);
		
		return resultMap;
	}
	
	
	/**
	 * 도메인 상세 조회
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	
	@RequestMapping(value = "/voice/selectDomainAjax.do")
	public Map<String, Object> selectDomainAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO, ModelMap model) throws Exception {
		Map<String, Object> resultMap = voiceService.selectDomainAjax(voiceVO);
		return resultMap;
	}

	
	
	
	/**
	 * 도메인 등록
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/addDomainAjax.do")
    public Map<String, Object> addDomainAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {

		voiceVO.setRegId(SessionUtil.getLoginId(request));
		voiceVO.setUpdId(SessionUtil.getLoginId(request));
		
		Map<String, Object> resultMap = voiceService.addDomainAjax(voiceVO);
		return resultMap;
	}
	
	/**
	 * 도메인 수정
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 * */
	
	@RequestMapping(value = "/voice/editDomainAjax.do")
	public Map<String, Object> editDomainAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {

		voiceVO.setRegId(SessionUtil.getLoginId(request));
		voiceVO.setUpdId(SessionUtil.getLoginId(request));
		
		Map<String, Object> resultMap = voiceService.editDomainAjax(voiceVO);
		return resultMap;
	}
	
	

	/**
	 * 도메인 삭제
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/voice/deleteDomainAjax.do")
	public Map<String, Object> deleteDomainAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = voiceService.deleteDomainAjax(voiceVO);
		return resultMap;
	}
	
	
	//음성가이드 버전 관련
	
	/**
	 * 음성가이드 버전 관리 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/versionList.do")
	public String versionList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/voice/versionList";
	}
	
	/**
	 * 음성가이드 버전  리스트  조회(Paging)
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/selectVersionList.do", method = RequestMethod.POST)
    public Map<String, Object> selectVersionList(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {

		voiceVO.setPageRowCount(Constants.PAGING_CNT_TEN);
		Map<String, Object> resultMap = voiceService.selectVersionList(voiceVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(voiceVO.getPage(), pageUtil.getTotalPage(totalCount, voiceVO.getPageRowCount()), voiceVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	/**
	 * 음성가이드 버전  리스트  조회(Paging)
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/selectAllVersionListAjax.do")
	public Map<String, Object> selectAllVersionListAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {

		Map<String, Object> resultMap = voiceService.selectAllVersionList(voiceVO);
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 버전 상세 조회
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	
	@RequestMapping(value = "/voice/selectVersionAjax.do")
	public Map<String, Object> selectVersionAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO, ModelMap model) throws Exception {
		Map<String, Object> resultMap = voiceService.selectVersionAjax(voiceVO);
		return resultMap;
	}

		
	/**
	 * 음성가이드 버전 등록
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/addVersionAjax.do")
    public Map<String, Object> addVersionAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {

		voiceVO.setRegId(SessionUtil.getLoginId(request));
		voiceVO.setUpdId(SessionUtil.getLoginId(request));
		
		Map<String, Object> resultMap = voiceService.addVersionAjax(voiceVO);
		return resultMap;
	}
	
	/**
	 * 음성가이드 버전 수정
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 * */
	
	@RequestMapping(value = "/voice/editVersionAjax.do")
	public Map<String, Object> editVersionAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {

		voiceVO.setRegId(SessionUtil.getLoginId(request));
		voiceVO.setUpdId(SessionUtil.getLoginId(request));
		
		Map<String, Object> resultMap = voiceService.editVersionAjax(voiceVO);
		return resultMap;
	}
	
	

	/**
	 * 음성가이드 버전 삭제
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/voice/deleteVersionAjax.do")
	public Map<String, Object> deleteVersionAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = voiceService.deleteVersionAjax(voiceVO);
		return resultMap;
	}
	
	
	//음성가이드 명령어 관련
	
	/**
	 * 음성가이드 명령어 관리 화면
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/commandList.do")
	public String commandList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/voice/commandList";
	}
	
	/**
	 * 음성가이드 명령어 조회
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/selectCommandList.do", method = RequestMethod.POST)
	public Map<String, Object> selectCommandList(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {
		voiceVO.setPageRowCount(Constants.PAGING_CNT_TWENTY);
		String searchVer = String.valueOf(voiceVO.getVoiceVerNo());
		String searchValue= String.valueOf(voiceVO.getCommand());

		Map<String, Object> resultMap = voiceService.selectCommandList(voiceVO);
		
		if(searchVer!=null && !searchVer.equals("")){
			resultMap.put("searchVer", searchVer);
		}
		
		if(searchValue!=null && !searchValue.equals("")){
			resultMap.put("searchValue", searchValue);
		}
		
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(voiceVO.getPage(), pageUtil.getTotalPage(totalCount, voiceVO.getPageRowCount()), voiceVO.getPageRowCount(), Constants.GO_SEARCH);
		resultMap.put(Constants.PAGING, paging);
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 명령어 등록
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/voice/addCommandAjax.do")
    public Map<String, Object> addCommandAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {

		voiceVO.setRegId(SessionUtil.getLoginId(request));
		voiceVO.setUpdId(SessionUtil.getLoginId(request));
		
		Map<String, Object> resultMap = voiceService.addCommandAjax(voiceVO);
		return resultMap;
	}
	
	

	/**
	 * 음성가이드 명령어 상세 조회
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	
	@RequestMapping(value = "/voice/selectCommadAjax.do")
	public Map<String, Object> selectCommadAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO, ModelMap model) throws Exception {
		Map<String, Object> resultMap = voiceService.selectCommandAjax(voiceVO);
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 명령어 수정
	 * 
	 * @param request
	 * @param response
	 * @param voiceVO
	 * @return
	 * @throws Exception
	 * */
	
	@RequestMapping(value = "/voice/editCommandAjax.do")
	public Map<String, Object> editCommandAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {

		voiceVO.setRegId(SessionUtil.getLoginId(request));
		voiceVO.setUpdId(SessionUtil.getLoginId(request));
		
		Map<String, Object> resultMap = voiceService.editCommandAjax(voiceVO);
		return resultMap;
	}
	
	/**
	 * 음성가이드 명령어 삭제
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/voice/deleteCommandAjax.do")
	public Map<String, Object> deleteCommandAjax(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = voiceService.deleteCommandAjax(voiceVO);
		return resultMap;
	}
	
	
	/**
	 * 음성가이드 명령어 선택 수정
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/voice/selectCommandModi.do")
	public Map<String, Object> selectCommandModi(HttpServletRequest request, HttpServletResponse response, VoiceVO voiceVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = voiceService.selectCommandModi(voiceVO);
		return resultMap;
	}
	
	
	
	
		
}

