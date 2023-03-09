package com.lgu.ccss.admin.system.role.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.system.menu.service.MenuServiceImpl;
import com.lgu.ccss.admin.system.role.domain.RoleMenuVO;
import com.lgu.ccss.admin.system.role.domain.RoleTree;
import com.lgu.ccss.admin.system.role.domain.RoleVO;
import com.lgu.ccss.common.domain.Constants;

import devonframe.dataaccess.CommonDao;

@Service("roleService")
public class RoleServiceImpl implements RoleService{

    @Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;
	
	@Autowired
	private MenuServiceImpl menuService;
	
	
	public Map<String, Object> roleList(RoleVO roleVO) throws Exception {
		
		Map<String, Object> result = new HashMap<String, Object>();
		List list = commonDao_oracle.selectList("Role.roleList",roleVO);
		int totalCount = commonDao_oracle.select("Role.roleListCount");
		
		List superAdminList = commonDao_oracle.selectList("Role.roleListSuperAdmin",roleVO);
		
		
		result.put("list", list);
		result.put("superAdminList", superAdminList);
		result.put("totalCount", totalCount);
		
		return result;
		
	}


	public RoleVO selectRole(RoleVO roleVO) throws Exception {
		return commonDao_oracle.select("Role.selectRole",roleVO);
	}
	
	public List<Map<String, Object>> selectRoleMenuListAll(RoleMenuVO roleMenuVO) throws Exception {

		roleMenuVO.setParentmenuId(StringUtils.defaultIfEmpty(roleMenuVO.getParentmenuId(), Constants.TOP_MENU_ID));
		return commonDao_oracle.selectList("Role.roleMenuListAll",roleMenuVO);
	}

	
	@Transactional
	public void editRoleMenu(RoleTree roleTree) throws Exception {
		
		//메뉴 권한 삭제
		commonDao_oracle.delete("Role.deleteRoleMenu",roleTree);
		
		if(CollectionUtils.isNotEmpty(roleTree.getMenuIds())) {
			commonDao_oracle.delete("Role.deleteRoleProgramNotIn",roleTree);

			for(String menuId : roleTree.getMenuIds()) {
				roleTree.setMenuId(menuId);
				commonDao_oracle.insert("Role.insertRoleMenu",roleTree);
			}
		} else {
			RoleVO roleVO = new RoleVO(roleTree.getMngrGrpId(), roleTree.getMenuId());
			commonDao_oracle.delete("Role.deleteRoleProgram",roleVO);
		}
		
		menuService.menuMapSetting();
	}


	public List<Map<String, Object>> selectRoleMenuListOneRole(RoleMenuVO roleMenuVO) throws Exception {

		
		roleMenuVO.setParentmenuId(StringUtils.defaultIfEmpty(roleMenuVO.getParentmenuId(), Constants.TOP_MENU_ID));
		
		return commonDao_oracle.selectList("Role.roleMenuList",roleMenuVO);
	}


	public List<Map<String, Object>> selectRoleProgramList(RoleMenuVO roleMenuVO) throws Exception {
		return commonDao_oracle.selectList("Role.selectRoleProgramList",roleMenuVO);
		
	}


	@Transactional
	public void insertRoleProgram(RoleVO roleVO, List<RoleVO> roleProgramList) throws Exception{
	
		//기존 데이터 전부 삭제
		commonDao_oracle.delete("Role.deleteRoleProgram",roleVO);

		if(CollectionUtils.isNotEmpty(roleProgramList)) {
			
			//신규 등록
			for(RoleVO program: roleProgramList) {
	
				commonDao_oracle.insert("Role.insertRoleProgram",program);
				
			}
		}
		
		//메뉴 맵 다시 셋팅
		menuService.menuMapSetting();
		
	}

	@Transactional
	public String insertRole(RoleVO roleVO) throws Exception {
		
		String mngrGrpId = UniqueKeyUtil.getUniKey();
		
		String grpMngrId = UniqueKeyUtil.getUniKey();
		
		roleVO.setRoleId(mngrGrpId);
		roleVO.setGrpMngrId(grpMngrId);
		commonDao_oracle.insert("Role.insertRole",roleVO);
//		commonDao.updateRoleOrderNo(roleVO);
		return mngrGrpId;
	}


	@Transactional
	public void updateRole(RoleVO roleVO) {
		
		commonDao_oracle.update("Role.updateRole",roleVO);
//		commonDao.updateRoleOrderNo(roleVO);
		
	}


	@Transactional
	public void deleteRole(RoleVO roleVO) {
		//권한 프로그램 삭제
		commonDao_oracle.delete("Role.deleteRoleProgramOne",roleVO);
		//권한 메뉴 삭제
		commonDao_oracle.delete("Role.deleteRoleMenuOne",roleVO);
		//권한 삭제
		commonDao_oracle.delete("Role.deleteRole",roleVO);		
	}

}
