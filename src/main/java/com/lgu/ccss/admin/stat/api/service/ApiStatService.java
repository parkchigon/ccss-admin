package com.lgu.ccss.admin.stat.api.service;


import java.util.Map;
import com.lgu.ccss.admin.stat.api.domain.ApiStatVO;

public interface ApiStatService {
	
	public Map<String, Object> selectDeviceModelList(ApiStatVO apiStatVO) throws Exception;
	
	public int selectApiStatListCnt(ApiStatVO apiStatVO) throws Exception;

	public Map<String, Object> selectApiStatList(ApiStatVO apiStatVO) throws Exception;

	public Map<String, Object> selectApiStatListExcel(ApiStatVO apiStatVO) throws Exception;
	

}
