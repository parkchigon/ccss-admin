package com.lgu.ccss.admin.stat.send2car.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.lgu.ccss.admin.admin.service.AdminServiceImpl;
import com.lgu.ccss.admin.stat.send2car.domain.Send2CarStatVO;

import devonframe.dataaccess.CommonDao;

@Service("send2CarStatService")
public class Send2CarStatServiceImpl implements Send2CarStatService {
	
	private static final Logger logger = LoggerFactory.getLogger(Send2CarStatServiceImpl.class);

    @Resource(name = "commonDao_oracle")
    private CommonDao commonDao_oracle;
    
    @Resource(name = "commonDao_altibase")
    private CommonDao commonDao_altibase;
    
	/**
	 * Send2Car 이력 리스트 카운트
	 * @param send2CarStatVO
	 * @return
	 */
	public int selectSend2CarStatListCnt(Send2CarStatVO send2CarStatVO) throws Exception{
	    return commonDao_oracle.select("Send2CarStat.selectSend2CarStatListCnt",send2CarStatVO);
	}


	/**
	 * Send2Car 사용 이력 리스트 조회
	 * @param send2CarStatVO
	 * @return
	 */
	public Map<String, Object> selectSend2CarStatList(Send2CarStatVO send2CarStatVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Send2CarStatVO> resultList = commonDao_oracle.selectList("Send2CarStat.selectSend2CarStatList",send2CarStatVO);
		int totalCount = commonDao_oracle.select("Send2CarStat.selectSend2CarStatListCnt",send2CarStatVO);
		
		//마스킹 처리
		for(Send2CarStatVO tempVO : resultList) {
			String mgrappCtn = tempVO.getMgrappCtn();
			String mgrappLoginId = tempVO.getMgrappLoginId();
			String deviceCtn = tempVO.getDeviceCtn();
			
			tempVO.setMgrappCtn(AdminServiceImpl.userInfoMasking(mgrappCtn,"ctn"));
			tempVO.setMgrappLoginId(AdminServiceImpl.userInfoMasking(mgrappLoginId,"ctn"));
			tempVO.setDeviceCtn(AdminServiceImpl.userInfoMasking(deviceCtn,"ctn"));
		}
		
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);

		return resultMap;
	}
	
	/**
	 * Send2Car 사용 이력 상세
	 * @param send2CarStatVO
	 * @return
	 */
	public Map<String, Object> selectSend2CarDetailInfo(Send2CarStatVO send2CarStatVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		send2CarStatVO = commonDao_oracle.select("Send2CarStat.selectSend2CarDetailInfo",send2CarStatVO);
	
		
		resultMap.put("send2CarStatVO", send2CarStatVO);
		return resultMap;
	}
	
	
	
	
	/**
	 * Send2Car 리스트 조회 Excel
	 * @param send2CarStatVO
	 * @return
	 */
	public Map<String, Object> selectSend2CarStatListExcel(Send2CarStatVO send2CarStatVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Send2CarStatVO> resultList = commonDao_oracle.selectList("Send2CarStat.selectSend2CarStatListExcel",send2CarStatVO);
		int totalCount = commonDao_oracle.select("Send2CarStat.selectSend2CarStatListCnt",send2CarStatVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		
		//리스트 검색 조건.
		if(String.valueOf(send2CarStatVO.getStartDate()) !=null && !String.valueOf(send2CarStatVO.getStartDate()).equals("")){
			resultMap.put("startDate", String.valueOf(send2CarStatVO.getStartDate()));
		}
		
		if(String.valueOf(send2CarStatVO.getEndDate()) !=null && !String.valueOf(send2CarStatVO.getEndDate()).equals("")){
			resultMap.put("endDate", String.valueOf(send2CarStatVO.getEndDate()));
		}
		
		if(String.valueOf(send2CarStatVO.getMembId()) !=null && !String.valueOf(send2CarStatVO.getMembId()).equals("")){
			resultMap.put("membId", String.valueOf(send2CarStatVO.getMembId()));
		}
		
		if(String.valueOf(send2CarStatVO.getDeviceCtn()) !=null && !String.valueOf(send2CarStatVO.getDeviceCtn()).equals("")){
			resultMap.put("deviceCtn", String.valueOf(send2CarStatVO.getDeviceCtn()));
		}
		
		/*if(String.valueOf(send2CarStatVO.getMgrappCtn()) !=null && !String.valueOf(send2CarStatVO.getMgrappCtn()).equals("")){
			resultMap.put("mgrappCtn", String.valueOf(send2CarStatVO.getMgrappCtn()));
		}*/
		if(String.valueOf(send2CarStatVO.getMgrappLoginId()) !=null && !String.valueOf(send2CarStatVO.getMgrappLoginId()).equals("")){
			resultMap.put("mgrappLoginId", String.valueOf(send2CarStatVO.getMgrappLoginId()));
		}
		
		if(String.valueOf(send2CarStatVO.getSendStatus()) !=null && !String.valueOf(send2CarStatVO.getSendStatus()).equals("")){
			resultMap.put("sendStatus", String.valueOf(send2CarStatVO.getSendStatus()));
		}
		
		if(String.valueOf(send2CarStatVO.getServiceType()) !=null && !String.valueOf(send2CarStatVO.getServiceType()).equals("")){
			resultMap.put("serviceType", String.valueOf(send2CarStatVO.getServiceType()));
		}
		
		return resultMap;
	}

}
