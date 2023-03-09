package com.lgu.ccss.admin.admin.service;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import com.lgu.ccss.admin.admin.domain.AdminPagingVO;
import com.lgu.ccss.admin.admin.domain.AdminVO;

public interface AdminService {
	
	public int selectAdminListCnt(AdminVO adminVO) throws Exception;

	public Map<String, Object> selectAdminList(AdminVO adminVO) throws Exception;

	public Map<String, Object> insertAdmin(AdminVO adminVO) throws InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException ;

	public Map<String, Object> updateAdmin(AdminVO adminVO) throws InvalidKeyException, UnsupportedEncodingException, NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, IllegalBlockSizeException, BadPaddingException;

	public AdminVO selectAdminDetail(AdminVO adminVO) throws Exception;

	public Map<String, Object> selectAdminRoleList() throws Exception;
	
	public Map<String, Object> checkAdminId(AdminVO adminVO) throws Exception;
	
	public int deleteAdmin(AdminVO adminVO) throws Exception;
	
	public Map<String, Object> checkAdminRole(AdminVO adminVO) throws Exception;
	
	public Map<String, Object> sendTmpPassWd(AdminVO adminVO) throws Exception;
	
	public Map<String, Object> entrustRoleAdmin(AdminVO adminVO) throws Exception;
	
	public Map<String, Object> checkAdminPwd(AdminVO adminVO) throws Exception;
	
	//페이징
	 public List<AdminVO> selectAdminPageList(AdminPagingVO ㅁdminPagingVO);
}
