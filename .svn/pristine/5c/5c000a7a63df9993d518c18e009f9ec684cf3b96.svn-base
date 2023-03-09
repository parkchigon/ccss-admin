package com.lgu.ccss.admin.system.menu.domain;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.reflect.MethodUtils;

import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.Tree;

public class MenuTree extends MenuVO implements Tree {
	private static final long serialVersionUID = -8789887426928994436L;
	
	private final Map<String, Boolean> state = new HashMap<String, Boolean>();

	// Default Constructor
	public MenuTree() {}
	
	public <T extends MenuVO> MenuTree(T menu) {
		
		System.out.println("1$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		setMenuId(StringUtils.defaultIfEmpty(menu.getMenuId(), ""));
		setMenuNm(StringUtils.defaultIfEmpty(menu.getMenuNm(), ""));
		setParentmenuId(StringUtils.defaultIfEmpty(menu.getParentmenuId(), ""));
		setMenuDepth(StringUtils.defaultIfEmpty(menu.getMenuDepth(), "1"));
		//setOrderNo(StringUtils.defaultIfEmpty(menu.getOrderNo(), "0"));
		setMenuOrder(StringUtils.defaultIfEmpty(menu.getOrderNo(), "0"));
		setUseYn(StringUtils.defaultIfEmpty(menu.getUseYn(), "N"));
		setStProgramUrl(StringUtils.defaultIfEmpty(menu.getStProgramUrl(), ""));
		System.out.println("2$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
	}
	
	public <T extends Map<String, ? extends Object>> MenuTree(T map) {
		for ( String key : map.keySet() ) {
			try {
				MethodUtils.invokeMethod(this, "set" + StringUtils.capitalize(key), ObjectUtils.defaultIfNull(map.get(key), "").toString());
			} catch (Exception e) {
				// setter가 없으면 무시됨.
			}
		}
	}
	@Override
	public String getId() {
		return getMenuId();
	}
	@Override
	public void setId(String id) {
		setMenuId(id);
	}
	@Override
	public String getParent() {
		String parentmenuId = getParentmenuId();
		return Constants.TOP_MENU_ID.equals(parentmenuId) ? "#" : parentmenuId;
	}
	@Override
	public void setParent(String parentId) {
		setParentmenuId(parentId);
	}
	@Override
	public String getText() {
		return getMenuNm();
	}
	@Override
	public void setText(String text) {
		setMenuNm(text);
	}
	@Override
	public void setUseYn(String yn) {
		super.setUseYn(yn);
	}
	
	public void setMenuIds(String strMenuIds) {
		super.setMenuIds(
			new ArrayList<String>(
				Arrays.asList( StringUtils.split(strMenuIds, ",") )
			)
		);
	}
	@Override
	public Map<String, Boolean> getState() {
		if ( Constants.TOP_MENU_ID.equals(getParentmenuId()) ) {
			state.put("opened", true);
		}
		return state;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}

}
