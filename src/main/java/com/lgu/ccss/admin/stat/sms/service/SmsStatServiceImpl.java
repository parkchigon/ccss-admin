package com.lgu.ccss.admin.stat.sms.service;

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
import com.lgu.ccss.admin.stat.sms.domain.SmsStatVO;
import com.lgu.ccss.admin.system.code.domain.CodeVO;
import com.lgu.ccss.admin.user.domain.UserVO;
import com.lgu.ccss.common.domain.Constants;

import devonframe.dataaccess.CommonDao;


@Service("smsStatService")
public class SmsStatServiceImpl implements SmsStatService {
	
	private static final Logger logger = LoggerFactory.getLogger(SmsStatServiceImpl.class);

    @Resource(name = "commonDao_oracle")
    private CommonDao commonDao_oracle;
    
    @Resource(name = "commonDao_altibase")
    private CommonDao commonDao_altibase;
    
	/**
	 * SMS 전송 이력 리스트 카운트
	 * @param smsStatVO
	 * @return
	 */
	public int selectSmsStatListCnt(SmsStatVO smsStatVO) throws Exception{
	    return commonDao_oracle.select("SmsStat.selectSmsStatListCnt",smsStatVO);
	}


	/**
	 * SMS 전송 이력 리스트 조회
	 * @param smsStatVO
	 * @return
	 */
	public Map<String, Object> selectSmsStatList(SmsStatVO smsStatVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<SmsStatVO> resultList = commonDao_oracle.selectList("SmsStat.selectSmsStatList",smsStatVO);
		int totalCount = commonDao_oracle.select("SmsStat.selectSmsStatListCnt",smsStatVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);

		return resultMap;
	}
	
	
	/**
	 * 사용자 리스트 조회 Excel
	 * @param smsStatVO
	 * @return
	 */
	public Map<String, Object> selectSmsStatListExcel(SmsStatVO smsStatVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<SmsStatVO> resultList = commonDao_oracle.selectList("SmsStat.selectSmsStatListExcel",smsStatVO);
		int totalCount = commonDao_oracle.select("SmsStat.selectSmsStatListCnt",smsStatVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		
		//리스트 검색 조건.
		if(String.valueOf(smsStatVO.getStartDate()) !=null && !String.valueOf(smsStatVO.getStartDate()).equals("")){
			resultMap.put("startDate", String.valueOf(smsStatVO.getStartDate()));
		}
		
		if(String.valueOf(smsStatVO.getEndDate()) !=null && !String.valueOf(smsStatVO.getEndDate()).equals("")){
			resultMap.put("endDate", String.valueOf(smsStatVO.getEndDate()));
		}
		
		if(String.valueOf(smsStatVO.getMsgStatus()) !=null && !String.valueOf(smsStatVO.getMsgStatus()).equals("")){
			resultMap.put("msgStatus", String.valueOf(smsStatVO.getMsgStatus()));
		}
		
		if(String.valueOf(smsStatVO.getRecvPhoneNo()) !=null && !String.valueOf(smsStatVO.getRecvPhoneNo()).equals("")){
			resultMap.put("recvPhoneNo", String.valueOf(smsStatVO.getRecvPhoneNo()));
		}
		
		return resultMap;
	}

}
