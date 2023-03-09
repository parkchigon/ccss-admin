package com.lgu.ccss.admin.stat.api.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.lgu.ccss.admin.stat.api.domain.ApiStatVO;
import com.lgu.ccss.admin.system.code.domain.CodeVO;

import devonframe.dataaccess.CommonDao;


@Service("apiStatService")
public class ApiStatServiceImpl implements ApiStatService {
	
	private static final Logger logger = LoggerFactory.getLogger(ApiStatServiceImpl.class);

    @Resource(name = "commonDao_oracle")
    private CommonDao commonDao_oracle;
    
    @Resource(name = "commonDao_altibase")
    private CommonDao commonDao_altibase;
    
	/**
	 * DEVICE_MODEL 조회
	 * @param apiStatVO
	 * @return
	 */
	public Map<String, Object> selectDeviceModelList(ApiStatVO apiStatVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<CodeVO> resultList = commonDao_oracle.selectList("ApiStat.selectDeviceModelList",apiStatVO);
	
		resultMap.put("resultList", resultList);

		return resultMap;
	}    
    
	/**
	 * API 사용 이력 리스트 카운트
	 * @param apiStatVO
	 * @return
	 */
	public int selectApiStatListCnt(ApiStatVO apiStatVO) throws Exception{
	    return commonDao_oracle.select("ApiStat.selectApiStatListCnt",apiStatVO);
	}


	/**
	 * API 사용 이력 리스트 조회
	 * @param apiStatVO
	 * @return
	 */
	public Map<String, Object> selectApiStatList(ApiStatVO apiStatVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<ApiStatVO> resultList = commonDao_oracle.selectList("ApiStat.selectApiStatList",apiStatVO);
		int totalCount = commonDao_oracle.select("ApiStat.selectApiStatListCnt",apiStatVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);

		return resultMap;
	}
	
	
	/**
	 * 사용자 리스트 조회 Excel
	 * @param apiStatVO
	 * @return
	 */
	public Map<String, Object> selectApiStatListExcel(ApiStatVO apiStatVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<ApiStatVO> resultList = commonDao_oracle.selectList("ApiStat.selectApiStatListExcel",apiStatVO);
		int totalCount = commonDao_oracle.select("ApiStat.selectApiStatListCnt",apiStatVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		
		//리스트 검색 조건.
		if(String.valueOf(apiStatVO.getStartDate()) !=null && !String.valueOf(apiStatVO.getStartDate()).equals("")){
			resultMap.put("startDate", String.valueOf(apiStatVO.getStartDate()));
		}
		
		if(String.valueOf(apiStatVO.getEndDate()) !=null && !String.valueOf(apiStatVO.getEndDate()).equals("")){
			resultMap.put("endDate", String.valueOf(apiStatVO.getEndDate()));
		}
		
		if(String.valueOf(apiStatVO.getReqCtn()) !=null && !String.valueOf(apiStatVO.getReqCtn()).equals("")){
			resultMap.put("reqCtn", String.valueOf(apiStatVO.getReqCtn()));
		}
		if(String.valueOf(apiStatVO.getMembId()) !=null && !String.valueOf(apiStatVO.getMembId()).equals("")){
			resultMap.put("membId", String.valueOf(apiStatVO.getMembId()));
		}
		if(String.valueOf(apiStatVO.getApiNm()) !=null && !String.valueOf(apiStatVO.getApiNm()).equals("")){
			resultMap.put("apiNm", String.valueOf(apiStatVO.getApiNm()));
		}
		if(String.valueOf(apiStatVO.getResultStatus()) !=null && !String.valueOf(apiStatVO.getResultStatus()).equals("")){
			resultMap.put("resultStatus", String.valueOf(apiStatVO.getResultStatus()));
		}
		
		if(String.valueOf(apiStatVO.getMembNo()) !=null && !String.valueOf(apiStatVO.getMembNo()).equals("")){
			resultMap.put("membNo", String.valueOf(apiStatVO.getMembNo()));
		}
		
		if(String.valueOf(apiStatVO.getDeviceType()) !=null && !String.valueOf(apiStatVO.getDeviceType()).equals("")){
			resultMap.put("deviceType", String.valueOf(apiStatVO.getDeviceType()));
		}
		
		if(String.valueOf(apiStatVO.getDeviceModelNm()) !=null && !String.valueOf(apiStatVO.getDeviceModelNm()).equals("")){
			resultMap.put("deviceModelNm", String.valueOf(apiStatVO.getDeviceModelNm()));
		}		
		
		return resultMap;
	}

}
