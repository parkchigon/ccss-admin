package com.lgu.ccss.admin.system.menu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lgu.ccss.admin.system.menu.domain.MenuTree;
import com.lgu.ccss.admin.system.menu.domain.MenuVO;
import com.lgu.ccss.admin.system.role.domain.RoleMenuVO;


public interface MenuService {

	public List roleList() throws Exception ;
	
	public List siteList(RoleMenuVO roleMenuVO) throws Exception ;
	
	public List siteMenuList(RoleMenuVO roleMenuVO) throws Exception ;

	public ArrayList setMenuMap(HashMap map, Object[] menuList) ;
	
	public List siteProgramList(RoleMenuVO roleMenuVO) throws Exception ;
	
	public void menuMapSetting() throws Exception ;

	public List<Map<String, Object>> selectMenuList() throws Exception ;
	
	public boolean menuInsert(MenuVO menuVO) throws Exception ;

	public boolean menuUpdate(MenuVO menuVO) throws Exception ;

	public void updateMenuOrder(MenuTree menuTree) throws Exception ;

	public void deleteMenu(MenuTree menuTree) throws Exception;
}
