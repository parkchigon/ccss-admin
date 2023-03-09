package com.lgu.ccss.admin.stat.sms.service;


import java.util.Map;
import com.lgu.ccss.admin.stat.sms.domain.SmsStatVO;

public interface SmsStatService {
	
	public int selectSmsStatListCnt(SmsStatVO smsStatVO) throws Exception;

	public Map<String, Object> selectSmsStatList(SmsStatVO smsStatVO) throws Exception;

	public Map<String, Object> selectSmsStatListExcel(SmsStatVO smsStatVO) throws Exception;
	

}
