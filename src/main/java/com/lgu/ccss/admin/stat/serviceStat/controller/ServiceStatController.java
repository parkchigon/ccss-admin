package com.lgu.ccss.admin.stat.serviceStat.controller;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lgu.ccss.admin.product.domain.ProductVO;
import com.lgu.ccss.admin.product.service.ProductServiceImpl;
import com.lgu.ccss.admin.stat.api.domain.ApiStatVO;
import com.lgu.ccss.admin.stat.api.service.ApiStatServiceImpl;
import com.lgu.ccss.admin.stat.serviceStat.domain.ServiceStatVO;
import com.lgu.ccss.admin.stat.serviceStat.service.ServiceStatServiceImpl;
import com.lgu.ccss.admin.user.domain.UserVO;
import com.lgu.ccss.admin.user.service.UserServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.DateUtil;
import com.lgu.ccss.common.utility.JsonUtil;
import com.lgu.ccss.common.utility.PageUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
@RequestMapping(value = "/stat")
public class ServiceStatController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ServiceStatController.class);
	
	@Resource(name = "serviceStatService")
	private ServiceStatServiceImpl serviceStatService;
	
	
	@Value("#{config['use.logStat.Yn']}")
	private String useLogStatYn;
	
	@Autowired
	private PageUtil pageUtil;
	
	//	public static Map<String, Object> serviceCodeMap = new HashMap<String,Object>();
	
	@PostConstruct
	public void init() {
		
		try {
			//serviceCodeMap = new HashMap<String,Object>();
			if(useLogStatYn !=null && useLogStatYn.equals("Y")){
				logger.info("Start Service Code List");
				serviceStatService.selectServiceStatCodeList();
				//logger.info("Service Code List : ",JsonUtil.marshallingJson(serviceCodeMap));
				logger.info("Start Service Code List End");
			}else{
				logger.info("Not Used Log Stat Service Code");
			}
						
		} catch (Exception e) {
			
			logger.error("### [" + DateUtil.getDate( "yyyy-MM-dd HH:mm:ss:SSS" ) + "] An error has occurred while initializing service stat code.");
			
		}
	}
	
	
	
	/**
	 * 서비스 통계 이력 리스트 화면
	 * 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/serviceStat.do")
	public String apiStat(HttpServletRequest request, ModelMap model) throws Exception {
	
		
		return "/stats/serviceStat";
	}
	
	
	/**
	 *  서비스 통계 이력 리스트 조회
	 * 
	 * @param request
	 * @param apiStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectServiceStatList.do")
	public Map<String, Object> selectServiceStatList(HttpServletRequest request, ServiceStatVO serviceStatVO) throws Exception {
		

		Map<String, Object> resultMap = serviceStatService.selectServiceStatList(serviceStatVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(serviceStatVO.getPage(), pageUtil.getTotalPage(totalCount, serviceStatVO.getPageRowCount()), serviceStatVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);

		return resultMap;
	}
	
	
	/**
	 * 서비스 통계 이력 엑셀 다운로드
	 * 
	 * @param request
	 * @param apiStatVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectServiceStatListExcel.do")
	public String selectApiStatListExcel(HttpServletRequest request,HttpServletResponse resonse, ServiceStatVO serviceStatVO ,Model model) throws Exception {
	//public void selectApiStatListExcel(HttpServletRequest request,HttpServletResponse resonse, ServiceStatVO serviceStatVO ,Model model) throws Exception {
			
		Map<String, Object> resultMap = serviceStatService.selectServiceStatListExcel(serviceStatVO);
		model.addAttribute("resultList", resultMap.get("resultList"));
		model.addAttribute("totalCount", resultMap.get("totalCount"));	
		model.addAttribute("serviceStatVO", resultMap.get("serviceStatVO"));
		model.addAttribute("type", "통합_서비스통계");
		return "/excel/stat/service/serviceStatListExcel";	
		
	}
	
	@RequestMapping(value = "/selectServiceStatDtlCodeList.do")
	public Map<String, Object> selectServiceStatDtlCodeList(HttpServletRequest request, ModelMap model) throws Exception {
		
		return ServiceStatServiceImpl.serviceCodeMap;
	}
}
