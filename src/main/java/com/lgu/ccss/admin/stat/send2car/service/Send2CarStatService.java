package com.lgu.ccss.admin.stat.send2car.service;


import java.util.Map;

import com.lgu.ccss.admin.stat.send2car.domain.Send2CarStatVO;

public interface Send2CarStatService {
	
	public int selectSend2CarStatListCnt(Send2CarStatVO send2CarStatVO) throws Exception;

	public Map<String, Object> selectSend2CarStatList(Send2CarStatVO send2CarStatVO) throws Exception;
	
	public Map<String, Object> selectSend2CarDetailInfo(Send2CarStatVO send2CarStatVO) throws Exception;
	
	public Map<String, Object> selectSend2CarStatListExcel(Send2CarStatVO send2CarStatVO) throws Exception;
	
}
