package com.lgu.ccss.admin.system.menu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.admin.domain.AdminVO;
import com.lgu.ccss.admin.system.menu.domain.MenuTree;
import com.lgu.ccss.admin.system.menu.domain.MenuVO;
import com.lgu.ccss.admin.system.program.domain.ProgramVO;
import com.lgu.ccss.admin.system.role.domain.RoleMenuVO;
import com.lgu.ccss.admin.system.role.domain.RoleTree;
import com.lgu.ccss.admin.system.role.domain.RoleVO;
import com.lgu.ccss.common.service.ServiceConfig;

import org.apache.commons.collections.CollectionUtils;

import devonframe.dataaccess.CommonDao;

@Service("menuService")
public class MenuServiceImpl implements MenuService {
	
	private static final Logger logger = LoggerFactory.getLogger(MenuServiceImpl.class);
	
    @Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;
    
    
    //@Scheduled(cron ="0 */5 * * * *")
    @Scheduled(cron="${ReInit.menuMap.Cron}")
    public void reInitMenu(){
    	try {
    		logger.debug("#reInitMenu !!");
			this.menuMapSetting();
		} catch (Exception e) {
			logger.error("reInitMenuMap Fail!!");
		}
    }
    
	public List roleList() throws Exception {
		return commonDao_oracle.selectList("Menu.selectRoleList");
	}
	
	public List siteList(RoleMenuVO roleMenuVO) throws Exception {
		
		
		List<RoleMenuVO> roleMenuList = commonDao_oracle.selectList("Menu.roleMenuList",roleMenuVO);
		
		
		if(CollectionUtils.isEmpty(roleMenuList)) {
			return new ArrayList();
		}
		
		
		
		TreeSet<String> treeSet = new TreeSet<String>();
		
		for(RoleMenuVO list : roleMenuList) {
			if(list.getRoleMenuId() != null) {
				treeSet.add(list.getRoleMenuId());
			}
		}
		
		//ArrayList<String> menuIds = new ArrayList<String>(treeSet);
		//roleMenuVO.setMenuIds(menuIds);

		
		return commonDao_oracle.selectList("Menu.siteList",roleMenuVO);
	}
	
	
	public List siteMenuList(RoleMenuVO roleMenuVO) throws Exception {
		
	/*	String roleMenuList = commonDao_oracle.select("Menu.roleMenuList",roleMenuVO);

		String roleMenuIds[] = roleMenuList.split(",");
		TreeSet<String> treeSet = new TreeSet<String>();

		*//** 중복 제거 *//*
		for (int i = 0; i < roleMenuIds.length; i++) {
			treeSet.add(roleMenuIds[i]);
		}

		ArrayList<String> menuIds = new ArrayList<String>(treeSet);
		roleMenuVO.setMenuIds(menuIds);*/

		return commonDao_oracle.selectList("Menu.selectMenuList",roleMenuVO);
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public ArrayList setMenuMap(HashMap map, Object[] menuList) {
        ArrayList list = new ArrayList();
        for (int i = 0; i < menuList.length; i++) {
            Map nodeMap = (Map) menuList[i];
            // 하위노드 맵
            if (String.valueOf(map.get("menuId")).equals(nodeMap.get("parentmenuId"))) {
                HashMap subNodeMap = new HashMap();
                subNodeMap.put("menuId", nodeMap.get("menuId"));
                subNodeMap.put("menuNm", nodeMap.get("menuNm"));
                //subNodeMap.put("orderNo", nodeMap.get("orderNo"));
                subNodeMap.put("menuOrder", nodeMap.get("menuOrder"));
                subNodeMap.put("parentmenuId", nodeMap.get("parentmenuId"));
                subNodeMap.put("programUrl", nodeMap.get("programUrl"));
                subNodeMap.put("programNm", nodeMap.get("programNm"));
                subNodeMap.put("useYn", nodeMap.get("useYn"));
                subNodeMap.put("path", nodeMap.get("path"));
                subNodeMap.put("subNodeList", setMenuMap(subNodeMap, menuList));
                list.add(subNodeMap);
            }
        }

        return list;
    }
	
	public List siteProgramList(RoleMenuVO roleMenuVO) throws Exception {
		return commonDao_oracle.selectList("Menu.selectSiteProgramList",roleMenuVO);
	}
	
	
	@SuppressWarnings("rawtypes")
	public void menuMapSetting() throws Exception {
		logger.info("START menuMapSetting !!");
		
		/**
		 * 1. 전체 권한 조회
		 * 2. 각 권한별 메뉴트리 생성
		 * 3. 필요한 메뉴트리만 서브로 추출
		 * 4. 전체 프로그램 목록 조회
		 * 5. 각 권한별 프로그램 목록 추출
		 *  
		 */
		
		
		//전체 메뉴 트리 담을 맵
		HashMap<String, HashMap> menuTotMap = new HashMap<String, HashMap>();
		
		List roleList = roleList();

		if(roleList != null) {
			
			String urlTp = "";
			String loginUrl = "";
			String menuId = "";
			String roleId = "";
			
			for(int x=0; x < roleList.size(); x++) {
				
				Map roleMap = (Map) roleList.get(x);
				HashMap<String, HashMap> siteMenuMap = new HashMap<String, HashMap>();
				
				//roleId = (String) roleMap.get("roleId");
				roleId = (String) roleMap.get("mngrGrpId");
				RoleMenuVO roleMenuVO = new RoleMenuVO();
				roleMenuVO.setMngrGrpId(roleId);
				List siteList = siteList(roleMenuVO);
				
				for(int j=0; j<siteList.size(); j++) {
					
					HashMap<String, Object> menuMap = new HashMap<String, Object>();
					Map siteHm = (Map) siteList.get(j);
					
					// 사이트 URL타입. 요청 URL타입을 기준으로 사이트를 구분한다.
					urlTp = (String) siteHm.get("urlTp");
					// 요청에 대한 권한이 없는 경우 로그인할 URL설정
					loginUrl = (String) siteHm.get("loginUrl");
					// 사이트 최상위 메뉴아이디
					menuId = String.valueOf(siteHm.get("menuId"));
					
					// 권한, 사이트별 메뉴목록 조회
					roleMenuVO.setMenuId(menuId);
					
					List siteMenuList = siteMenuList(roleMenuVO);
					
					// 최상위 메뉴데이타 맵설정. 깝데기
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("menuId", menuId);
					map.put("menuNm", "");
					map.put("orderNum", 1);
					map.put("parentmenuId", "");
					map.put("programUrl", "");
					
					
					Object[] leftMObj = siteMenuList.toArray();
					map.put("subNodeList", setMenuMap(map, leftMObj));
					
					
					List siteProgramList = siteProgramList(roleMenuVO);
				
					menuMap.put("LOGIN_URL", loginUrl);
					menuMap.put("MENU_MAP", map);
					menuMap.put("MENU_LIST_MAP", siteProgramList);
					
					// 권한, 사이트별 메뉴설정
					siteMenuMap.put(urlTp, menuMap);
				}
				
				menuTotMap.put(roleId, siteMenuMap);
			}
			ServiceConfig.MENU_MAP = menuTotMap;
			
		}
	}

	public List<Map<String, Object>> selectMenuList() throws Exception {
		return commonDao_oracle.selectList("Menu.selectMenuListAll");
		
	}
	
	@Transactional
	public boolean menuInsert(MenuVO menuVO) throws Exception {
		
		
		menuVO.setMenuId(UniqueKeyUtil.getUniKey());
		logger.debug("####### menuVO:" + menuVO);
		
		int result = commonDao_oracle.insert("Menu.insertMenu",menuVO);
		if(result == 1) {
			menuMapSetting();
			return true;
		} else {
			return false;
		}
		
	}
	
	@Transactional
	public boolean menuUpdate(MenuVO menuVO) throws Exception {
	
		int result = commonDao_oracle.update("Menu.updateMenu",menuVO);
		if(result == 1) {
			menuMapSetting();
			return true;
		} else {
			return false;
		}
	}

	public void updateMenuOrder(MenuTree menuTree) throws Exception {

		int menuOrderIndex = 1;
		for(String menuId : menuTree.getMenuIds()) {
			
			MenuVO menuVO = new MenuVO();
			menuVO.setMenuId(menuId);
			menuVO.setParentmenuId(menuTree.getParentmenuId());
			//menuVO.setOrderNo(String.valueOf(menuOrderIndex));
			menuVO.setMenuOrder(String.valueOf(menuOrderIndex));
			menuVO.setUpdId(menuTree.getUpdId());
			commonDao_oracle.update("Menu.updateMenuOrder",menuVO);
			
			menuOrderIndex++;
			
		}

		menuMapSetting();
		
		
	}

	public void deleteMenu(MenuTree menuTree) throws Exception{
		
		for(String menuId : menuTree.getMenuIds()) {
			
			//삭제하려는 메뉴의 딸린 하위 프로그램 권한 삭제
			//TB_ROLE_PROGRAM
			RoleVO roleVO = new RoleVO();
			roleVO.setMenuId(menuId);
			commonDao_oracle.delete("Role.deleteRoleProgram",roleVO);
			
			//삭제하려는 메뉴에 대한 권한 삭제
			//TB_ROLE_MENU
			RoleTree roleTree = new RoleTree();
			roleTree.setMenuId(menuId);;
			commonDao_oracle.delete("Role.deleteRoleMenu",roleTree);
			
		}
		
		//삭제하려는 메뉴의 딸린 하위 프로그램 삭제
		//TB_PROGRAM
		commonDao_oracle.delete("Menu.deleteMenuProgramByMenuId",menuTree);
		
		//메뉴 삭제
		//TB_MENU
		commonDao_oracle.delete("Menu.deleteMenu",menuTree);
	
		
		//메뉴 순서 업데이트
		commonDao_oracle.update("Menu.updateMenuOrderAuto",menuTree);
		
		menuMapSetting();
	}
	
	
	public void insertMngrUseHstr(AdminVO adminVO,long processDt){
		ProgramVO programVO = new ProgramVO();
		//URL로 메뉴  ID 프로그램 ID 이름  가져옴
		programVO.setProgramUrl(adminVO.getReqUrl());
		programVO = commonDao_oracle.select("Role.selectProgramByUrl",programVO);
		//System.out.println("####programVO:" + programVO.toString());
		adminVO.setMenuNm(programVO.getProgramNm());
		adminVO.setProcessDt(Long.toString(processDt));
		
		//System.out.println("1MenuMm:" + programVO.getProgramNm());
		//System.out.println("2MenuMm:" + adminVO.getMenuNm());
		String loginDt = commonDao_oracle.select("Login.selectLastLoginDt",adminVO.getMngrId());
		//System.out.println("loginDt:" + loginDt);
		adminVO.setLoginDt(loginDt);
		commonDao_oracle.insert("Admin.insertMngrUseHstr",adminVO);
		//System.out.println("processDt:" +processDt);
	}
}
