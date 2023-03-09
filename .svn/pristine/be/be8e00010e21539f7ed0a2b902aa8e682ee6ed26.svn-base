package com.lgu.ccss.admin.app.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.app.domain.AppVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.Constants.ResultCode;

import devonframe.dataaccess.CommonDao;

@Service("appService")
public class AppServiceImpl implements AppService {

	@Resource(name = "commonDao_oracle")
	 private CommonDao commonDao_oracle;
	
	/**
	 * APP 정보 리스트 조회
	 * 
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectAppList(AppVO appVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = commonDao_oracle.selectList("App.selectAppList",appVO);
		
		List<Map<String, Object>> currentList = commonDao_oracle.selectList("App.selectCurrentAppList",appVO);
		
		
		int totalCount = commonDao_oracle.select("App.selectAppListCnt",appVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("currentList", currentList);
		resultMap.put("totalCount", totalCount);
		
		return resultMap;
	}
	/**
	 * APP 정보 삭제
	 * 
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	
	public Map<String, Object> deleteApp(AppVO appVO)  throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int deleteCnt = commonDao_oracle.delete("App.deleteApp",appVO);
		
		if(deleteCnt > 0){
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
		}else{
			resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
		}
		
		return resultMap;
	}

	
	/**
	 * 신규 APP 정보 등록
	 * @param appVO
	 * @return
	 */
	public Map<String, Object> insertNewApp(AppVO appVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		appVO.setAppId(UniqueKeyUtil.getUniKey());
		int checkCount = 0;
		//해당 termsDiv로 exposureYn 이 있는지 검색
		if(appVO.getUseYn().equals("Y")){
			checkCount =commonDao_oracle.select("App.checkExistApp",appVO);
		}
		
		if(checkCount > 0) {
			resultMap.put(Constants.RESULT, Constants.EXIST);
		}else{
			commonDao_oracle.insert("App.insertNewApp",appVO);
			resultMap.put(Constants.RESULT, Constants.YES);
		}
		return resultMap;
	}
	
	
	/**
	 * APP 정보 상세
	 * 
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	public AppVO selectAppDetail(AppVO appVO) throws Exception {
		appVO = commonDao_oracle.select("App.selectAppDetail",appVO);
		
		String pushStartDt = appVO.getPushStartDt();
		String pushEndDt = 	appVO.getPushEndDt();
		
		//if(appVO.getPushNotiYn().equals("Y")){
		
		
		if(!String.valueOf(appVO.getPushStartDt()).equals("null")){
			appVO.setSpostDate(pushStartDt.substring(0,10).replaceAll("-", ""));
			appVO.setSpostHour(pushStartDt.substring(11,13));
			appVO.setSpostMinute(pushStartDt.substring(14,16));
			
			appVO.setEpostDate(pushEndDt.substring(0,10).replaceAll("-", ""));
			appVO.setEpostHour(pushEndDt.substring(11,13));
			appVO.setEpostMinute(pushEndDt.substring(14,16));
		}
		//}
		
		
		return appVO; 
	}

	
	/**
	 * App 정보 수정
	 * 
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateApp(AppVO appVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int checkCount = 0;
		//해당 appType로 useYn 이 있는지 검색
		if(appVO.getUseYn().equals("Y")){
			checkCount =commonDao_oracle.select("App.checkExistApp",appVO);
		}
		if(checkCount > 0) {
			
			resultMap.put(Constants.RESULT, Constants.EXIST);
			
		}else{
			int resultCount = commonDao_oracle.update("App.updateApp",appVO);
			
			if( resultCount> 0) {
				
				resultMap.put(Constants.RESULT, Constants.YES);
				
			}else{
				
				resultMap.put(Constants.RESULT, Constants.NO);
			}
		}
		
		return resultMap;
	}
}
