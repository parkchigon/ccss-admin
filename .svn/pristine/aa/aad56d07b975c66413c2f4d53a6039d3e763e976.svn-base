package com.lgu.ccss.admin.system.role.service;

import java.util.List;
import java.util.Map;

import com.lgu.ccss.admin.system.role.domain.RoleMenuVO;
import com.lgu.ccss.admin.system.role.domain.RoleTree;
import com.lgu.ccss.admin.system.role.domain.RoleVO;


public interface RoleService {

	
	public Map<String, Object> roleList(RoleVO roleVO) throws Exception;

	public RoleVO selectRole(RoleVO roleVO) throws Exception;
	
	public List<Map<String, Object>> selectRoleMenuListAll(RoleMenuVO roleMenuVO) throws Exception ;

	public void editRoleMenu(RoleTree roleTree) throws Exception ;

	public List<Map<String, Object>> selectRoleMenuListOneRole(RoleMenuVO roleMenuVO) throws Exception ;

	public List<Map<String, Object>> selectRoleProgramList(RoleMenuVO roleMenuVO) throws Exception ;

	public void insertRoleProgram(RoleVO roleVO, List<RoleVO> roleProgramList) throws Exception;

	public String insertRole(RoleVO roleVO) throws Exception ;

	public void updateRole(RoleVO roleVO) ;

	public void deleteRole(RoleVO roleVO) ;

}
