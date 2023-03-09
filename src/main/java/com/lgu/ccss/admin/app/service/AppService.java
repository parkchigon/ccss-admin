package com.lgu.ccss.admin.app.service;

import java.util.Map;

import com.lgu.ccss.admin.app.domain.AppVO;

public interface AppService {

	public Map<String, Object> selectAppList(AppVO appVO) throws Exception ;

	public Map<String, Object> insertNewApp(AppVO appVO) throws Exception;

	public AppVO selectAppDetail(AppVO appVO) throws Exception ;

	public Map<String, Object> updateApp(AppVO appVO) throws Exception;
	
	public Map<String, Object> deleteApp(AppVO appVO)  throws Exception;
	
}
