package com.lgu.ccss.admin.system.role.domain;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.reflect.MethodUtils;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.Tree;

public class RoleTree extends RoleMenuVO implements Tree {
	private static final long serialVersionUID = 2312315918798193251L;

	
	private final Map<String, Boolean> state = new HashMap<String, Boolean>();

	//private String menuNm;
	private String roleYn;
	private String leafYn ="Y";
	
	//private List<String> programIds;
	
	// Default Constructor
	public RoleTree() {}
	
	public <T extends RoleMenuVO> RoleTree(T role) {
		setMenuId(StringUtils.defaultIfEmpty(role.getMenuId(), ""));
		setParentmenuId(StringUtils.defaultIfEmpty(role.getParentmenuId(), ""));
		//setOrderNo(StringUtils.defaultIfEmpty(role.getOrderNo(), "0"));
		setMenuOrder(StringUtils.defaultIfEmpty(role.getOrderNo(), "0"));
		setUseYn(StringUtils.defaultIfEmpty(role.getUseYn(), "N"));
	}
	
	public <T extends Map<String, ? extends Object>> RoleTree(T map) {

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

	@Override
	public Map<String, Boolean> getState() {
		if ( Constants.TOP_MENU_ID.equals(getParentmenuId()) ) {
			state.put("opened", true);
		}
		
		// 권한이 있는 메뉴의 최하위 메뉴에만 체크 표시를 하기 위해
		if ( "Y".equals(getRoleYn()) ) { 			// Role에 포함된 경우
			if ( "Y".equals(getLeafYn()) ) { 		// 최하위 메뉴인 경우
				state.put("checked", true);
			} else { 								// 최하위 메뉴가 아닌 경우
				state.put("opened", true);
			}
		}
		
		return state;
	}
	/*public String getMenuNm() {
		return menuNm;
	}

	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}*/

	public String getRoleYn() {
		return roleYn;
	}

	public void setRoleYn(String roleYn) {
		this.roleYn = roleYn;
	}

	public String getLeafYn() {
		return leafYn;
	}

	public void setLeafYn(String leafYn) {
		this.leafYn = leafYn;
	}
	
	@JsonProperty
	public void setMenuIds(String strMenuIds) {
		super.setMenuIds(new ArrayList<String>(Arrays.asList( StringUtils.split(strMenuIds, ",") )));
	}
	
	public List<String> getProgramIds() {
		return super.getProgramIds();
	}
	
/*	public void setProgramIds(String strProgramIds) {
		this.programIds = Arrays.asList( StringUtils.split(strProgramIds, ",") );
	}*/
	
	public void setProgramIds(String strProgramIds) {
		super.setProgramIds(Arrays.asList( StringUtils.split(strProgramIds, ",") )); 
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
}
