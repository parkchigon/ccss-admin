package com.lgu.ccss.admin.user.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.common.io.ByteStreams;
import com.lgu.ccss.admin.app.domain.AppVO;
import com.lgu.ccss.admin.product.domain.ProductVO;
import com.lgu.ccss.admin.product.service.ProductServiceImpl;
import com.lgu.ccss.admin.user.domain.CommAgrVO;
import com.lgu.ccss.admin.user.domain.UserVO;
import com.lgu.ccss.admin.user.service.UserServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;


@Controller
@RequestMapping(value = "/user")
public class UserController {
	
	@Resource(name = "userService")
	private UserServiceImpl userService;
	
	@Resource(name = "productService")
	private ProductServiceImpl productService;
	
	@Autowired
	private PageUtil pageUtil;

	
	@Value("#{config['excel.upload.path']}")
	private String EXCEL_UPLOAD_PATH;
	
	@Value("#{config['excel.download.path']}")
	private String EXCEL_DOWNLOAD_PATH;
	
	@Value("#{config['excel.form.download.path']}")
	private String EXCEL_FORM_DOWNLOAD_PATH;
	
	@Value("#{config['excel.form.download.file.name']}")
	private String EXCEL_FORM_DOWNLOAD_FILE_NAME;
	
	
	/**
	 * ????????? ????????? ??????
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/userListForm.do")
	public String userListForm(HttpServletRequest request, ModelMap model) throws Exception {
		return "/user/userListForm";
	}
	
	
	/**
	 * ????????? ????????? ??????
	 * 
	 * @param request
	 * @param userVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectUserList.do")
	public Map<String, Object> selectUserList(HttpServletRequest request, UserVO userVO) throws Exception {

		Map<String, Object> resultMap = userService.selectUserList(userVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(userVO.getPage(), pageUtil.getTotalPage(totalCount, userVO.getPageRowCount()), userVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	/**
	 * ????????? ????????? ?????? ????????????
	 * 
	 * @param request
	 * @param userVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectUserListExcel.do" ,method = RequestMethod.POST)
	public String selectUserListExcel(HttpServletRequest request,HttpServletResponse resonse, UserVO userVO ,Model model) throws Exception {
		Map<String, Object> resultMap = userService.selectUserListExcel(userVO);
	/*	
		ProductVO productVO =  productService.selectProduct(userVO.getProductNm());
		
		String productExplain="";
		if(productVO == null){
			productExplain=Constants.ALL;
		}else{
			productExplain = productVO.getProductExplain();
		}*/
		
		
		model.addAttribute("resultList", resultMap.get("resultList"));
		model.addAttribute("totalCount", resultMap.get("totalCount"));	
		model.addAttribute("startDate", resultMap.get("startDate"));	
		model.addAttribute("endDate", resultMap.get("endDate"));	
		model.addAttribute("deviceCtn", resultMap.get("deviceCtn"));	
		model.addAttribute("newRejoinYn", resultMap.get("newRejoinYn"));	
		model.addAttribute("useStatus", resultMap.get("useStatus"));	
		model.addAttribute("membId", resultMap.get("membId"));	
		model.addAttribute("membNo", resultMap.get("membNo"));	
		model.addAttribute("feeType", resultMap.get("feeType"));	
		
		//model.addAttribute("productExplain", productExplain);	
		//model.addAttribute("pushConnectionYn", resultMap.get("pushConnectionYn"));	
		model.addAttribute("type", "????????? ??????");
		return "/excel/user/userListExcel";	
	}
	
	
	/**
	 * ????????? ?????? ??????
	 * 
	 * @param request
	 * @param userVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectDetailUserInfo.do")
	public Map<String, Object> selectDetailUserInfo(HttpServletRequest request, UserVO userVO) throws Exception {

		Map<String, Object> resultMap = userService.selectDetailUserInfo(userVO);
		
		return resultMap;
	}
	
	

	/*##################################################################################################
	  										????????? ?????? ?????? ??????
	##################################################################################################*/
	/**
	 * ????????? ?????? ???????????????
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/commAgrManagement.do")
	public String commAgrManagement(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/user/commAgrList";
	}
	
	
	/**
	 * ????????? ??????  ????????? ??????  ????????? 5??? 
	 * 
	 * @param request
	 * @param response
	 * @param CommAgrVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectcommAgrList.do ")
	public Map<String, Object> selectcommAgrList(HttpServletRequest request, HttpServletResponse response, CommAgrVO commAgrVO) throws Exception {

		commAgrVO.setPageRowCount(Constants.PAGING_CNT_TWENTY);
		Map<String, Object> resultMap = userService.selectcommAgrList(commAgrVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(commAgrVO.getPage(), pageUtil.getTotalPage(totalCount, commAgrVO.getPageRowCount()), commAgrVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	/**
	 * ????????? ?????? ?????? ??????
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/deleteCommAgr.do")
	public Map<String, Object> deleteCommAgr(HttpServletRequest request, HttpServletResponse response, CommAgrVO commAgrVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = userService.deleteCommAgr(commAgrVO);
		return resultMap;
	}
	
	
	/**
	 * ????????? ?????? ?????? ?????? ??????
	 * 
	 * @param request
	 * @param response
	 * @param commAgrVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertCommAgrForm.do")
	public String insertCommAgrForm(HttpServletRequest request, HttpServletResponse response, CommAgrVO commAgrVO, ModelMap model) throws Exception {
		return "/user/commAgrInsertForm";
	}
	
	
	/**
	 * ????????? ?????? ???????????? ?????? ??????
	 * 
	 * @param request
	 * @param response
	 * @param commAgrVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editCommAgrForm.do")
	public String editCommAgrForm(HttpServletRequest request, HttpServletResponse response, CommAgrVO commAgrVO, ModelMap model) throws Exception {
		commAgrVO = userService.selectcommAgrDetail(commAgrVO);
		model.addAttribute("commAgrVO", commAgrVO);
		return "/user/commAgrEditForm";
	}
	
	/**
	 * ??????  ????????? ?????? ?????? ??????
	 * @param request
	 * @param response
	 * @param commAgrVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertCommAgr.do")
	public Map<String, Object> insertCommAgr(HttpServletRequest request, HttpServletResponse response, CommAgrVO commAgrVO) throws Exception {
	
		commAgrVO.setRegId(SessionUtil.getLoginId(request));
		commAgrVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = userService.insertCommAgr(commAgrVO);
	
		return resultMap;
	}
	
	/**
	 * ????????? ?????? ?????? ?????? ??????
	 * 
	 * @param request
	 * @param response
	 * @param commAgrVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectcommAgrDetail.do")
	public String selectcommAgrDetail(HttpServletRequest request, HttpServletResponse response, CommAgrVO commAgrVO, ModelMap model) throws Exception {
		commAgrVO = userService.selectcommAgrDetail(commAgrVO);
		model.addAttribute("commAgrVO", commAgrVO);
		return "/user/commAgrDetail";
	}
	
	
	/**
	 * ????????? ?????? ?????? ??????
	 * 
	 * @param request
	 * @param response
	 * @param commAgrVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/updateCommAgr.do")
	public Map<String, Object> updateCommAgr(HttpServletRequest request, HttpServletResponse response, CommAgrVO commAgrVO) throws Exception {
		commAgrVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = userService.updateCommAgr(commAgrVO);
		return resultMap;
	}
	
	
	/**
	 * CommAgr ???????????? ?????????
	 * ?????? ?????? ??????
	 *  DEVICE_CTN |UICCID|TERMS_NO|TERMS_AUTH_NO|AGR_YN |VALID_START_DT|VALID_END_DT|ITEM_SN|USIM_MODEL_NM|NAVI_SN
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/commAgrExcelUpload", method = RequestMethod.POST)
	public Map<String, Object> excelUploadAjax(MultipartHttpServletRequest request)  throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String regId = SessionUtil.getLoginId(request);
		
		MultipartFile excelFile =request.getFile("excelFile");
		
		if(excelFile==null || excelFile.isEmpty()){
			throw new RuntimeException("??????????????? ?????? ??? ?????????.");
		}

		File destFile = new File(EXCEL_UPLOAD_PATH+excelFile.getOriginalFilename());
		try{
			excelFile.transferTo(destFile);
		}catch(IllegalStateException ise){
			throw new RuntimeException(ise.getMessage(),ise);
		}catch(IOException ie){
			throw new RuntimeException(ie.getMessage(),ie);
		}

		resultMap = userService.excelUpload(destFile,regId);
			
		
		return resultMap;
	}
	
	@RequestMapping("/downCommAgrExcel.do")
	public void downTestCctvExcel(@RequestParam Map<String,Object> map, HttpServletResponse response,HttpServletRequest request) throws Exception {

		String filePath = request.getSession().getServletContext().getRealPath(EXCEL_FORM_DOWNLOAD_PATH+EXCEL_FORM_DOWNLOAD_FILE_NAME);
		String oriFileName = EXCEL_FORM_DOWNLOAD_FILE_NAME;
		
		String docName = URLEncoder.encode(oriFileName,"UTF-8").replaceAll("\\+", "%20"); //??????????????? ?????? ??????
		response.setHeader("Content-Disposition", "attachment;filename=" + docName + ";");
		response.setContentType("text/plain");

		File down_file = new File(filePath); //?????? ??????
		FileInputStream fileIn = new FileInputStream(down_file); //?????? ????????????
		ByteStreams.copy(fileIn, response.getOutputStream());
		response.flushBuffer();
	}
}
