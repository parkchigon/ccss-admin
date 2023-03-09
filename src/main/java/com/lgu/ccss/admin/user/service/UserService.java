package com.lgu.ccss.admin.user.service;


import java.io.File;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lgu.ccss.admin.user.domain.CommAgrVO;
import com.lgu.ccss.admin.user.domain.UserVO;

public interface UserService {
	
	public int selectUserListCnt(UserVO userVO) throws Exception;

	public Map<String, Object> selectUserList(UserVO userVO) throws Exception;
	
	public Map<String, Object> selectUserListExcel(UserVO userVO) throws Exception;
	
	public Map<String, Object> selectDetailUserInfo(UserVO userVO) throws Exception;

	
	//COMM AGR
	public Map<String, Object> selectcommAgrList(CommAgrVO CommAgrVO) throws Exception;
	
	public Map<String, Object> deleteCommAgr(CommAgrVO CommAgrVO) throws Exception;
	
	public CommAgrVO selectcommAgrDetail(CommAgrVO CommAgrVO) throws Exception;
	
	public Map<String, Object> insertCommAgr(CommAgrVO CommAgrVO) throws Exception;
	
	public Map<String, Object> updateCommAgr(CommAgrVO CommAgrVO) throws Exception;
		
	public  Map<String, Object>  excelUpload(File destFile,String regId) throws Exception;
}
