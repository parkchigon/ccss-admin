package com.lgu.ccss.admin.stat.apppush.service;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.lgu.ccss.admin.stat.apppush.domain.AppPushStatVO;
import com.lgu.ccss.common.domain.Constants;

import devonframe.dataaccess.CommonDao;


@Service("appPushStatService")
public class AppPushStatServiceImpl implements AppPushStatService {
	
	private static final Logger logger = LoggerFactory.getLogger(AppPushStatServiceImpl.class);

    @Resource(name = "commonDao_oracle")
    private CommonDao commonDao_oracle;
    
    @Resource(name = "commonDao_altibase")
    private CommonDao commonDao_altibase;
    
	/**
	 * CarPush 전송 이력 리스트 카운트
	 * @param smsStatVO
	 * @return
	 */
	public int selectAppPushStatListCnt(AppPushStatVO statVO) throws Exception{
	    return commonDao_oracle.select("AppPushStat.selectAppPushStatListCnt",statVO);
	}


	/**
	 * CarPush 전송 이력 리스트 조회
	 * @param smsStatVO
	 * @return
	 */
	public Map<String, Object> selectAppPushStatList(AppPushStatVO statVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<AppPushStatVO> resultList = commonDao_oracle.selectList("AppPushStat.selectAppPushStatList",statVO);
		int totalCount = commonDao_oracle.select("AppPushStat.selectAppPushStatListCnt",statVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);

		return resultMap;
	}
	
	
	/**
	 * 사용자 리스트 조회 Excel
	 * @param smsStatVO
	 * @return
	 */
	public Map<String, Object> selectAppPushStatListExcel(AppPushStatVO statVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<AppPushStatVO> resultList = commonDao_oracle.selectList("AppPushStat.selectAppPushStatListExcel",statVO);
		int totalCount = commonDao_oracle.select("AppPushStat.selectAppPushStatListCnt",statVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		
		//리스트 검색 조건.
		if(String.valueOf(statVO.getStartDate()) !=null && !String.valueOf(statVO.getStartDate()).equals("")){
			resultMap.put("startDate", String.valueOf(statVO.getStartDate()));
		}
		
		if(String.valueOf(statVO.getEndDate()) !=null && !String.valueOf(statVO.getEndDate()).equals("")){
			resultMap.put("endDate", String.valueOf(statVO.getEndDate()));
		}
		
		if(String.valueOf(statVO.getMsgStatus()) !=null && !String.valueOf(statVO.getMsgStatus()).equals("")){
			resultMap.put("msgStatus", String.valueOf(statVO.getMsgStatus()));
		}
		
		if(String.valueOf(statVO.getRecvPhoneNo()) !=null && !String.valueOf(statVO.getRecvPhoneNo()).equals("")){
			resultMap.put("recvPhoneNo", String.valueOf(statVO.getRecvPhoneNo()));
		}
		
		return resultMap;
	}
}
