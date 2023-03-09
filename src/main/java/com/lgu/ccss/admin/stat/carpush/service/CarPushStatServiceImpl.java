package com.lgu.ccss.admin.stat.carpush.service;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.lgu.ccss.admin.product.domain.ProductVO;
import com.lgu.ccss.admin.stat.api.domain.ApiStatVO;
import com.lgu.ccss.admin.stat.carpush.domain.CarPushStatVO;
import com.lgu.ccss.admin.stat.sms.domain.SmsStatVO;
import com.lgu.ccss.admin.system.code.domain.CodeVO;
import com.lgu.ccss.admin.user.domain.UserVO;
import com.lgu.ccss.common.domain.Constants;

import devonframe.dataaccess.CommonDao;


@Service("carPushStatService")
public class CarPushStatServiceImpl implements CarPushStatService {
	
	private static final Logger logger = LoggerFactory.getLogger(CarPushStatServiceImpl.class);

    @Resource(name = "commonDao_oracle")
    private CommonDao commonDao_oracle;
    
    @Resource(name = "commonDao_altibase")
    private CommonDao commonDao_altibase;
    
	/**
	 * CarPush 전송 이력 리스트 카운트
	 * @param smsStatVO
	 * @return
	 */
	public int selectCarPushStatListCnt(CarPushStatVO statVO) throws Exception{
	    return commonDao_oracle.select("CarPushStat.selectCarPushStatListCnt",statVO);
	}


	/**
	 * CarPush 전송 이력 리스트 조회
	 * @param smsStatVO
	 * @return
	 */
	public Map<String, Object> selectCarPushStatList(CarPushStatVO statVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<UserVO> resultList = commonDao_oracle.selectList("CarPushStat.selectCarPushStatList",statVO);
		int totalCount = commonDao_oracle.select("CarPushStat.selectCarPushStatListCnt",statVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);

		return resultMap;
	}
	
	
	/**
	 * 사용자 리스트 조회 Excel
	 * @param smsStatVO
	 * @return
	 */
	public Map<String, Object> selectCarPushStatListExcel(CarPushStatVO statVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<SmsStatVO> resultList = commonDao_oracle.selectList("CarPushStat.selectCarPushStatListExcel",statVO);
		int totalCount = commonDao_oracle.select("CarPushStat.selectCarPushStatListCnt",statVO);
		
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
