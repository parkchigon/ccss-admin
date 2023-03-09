package com.lgu.ccss.admin.stat.carpush.service;


import java.util.Map;

import com.lgu.ccss.admin.stat.carpush.domain.CarPushStatVO;

public interface CarPushStatService {
	
	public int selectCarPushStatListCnt(CarPushStatVO statVO) throws Exception;

	public Map<String, Object> selectCarPushStatList(CarPushStatVO statVO) throws Exception;

	public Map<String, Object> selectCarPushStatListExcel(CarPushStatVO statVO) throws Exception;
	

}
