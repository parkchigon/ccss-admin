package com.lgu.ccss.admin.system.role.domain;

import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.lgu.ccss.common.domain.BaseVO;

public class RoleMenuVO extends BaseVO{
	private static final long serialVersionUID = -5253041465187025144L;

	private String menuId;					//메뉴 ID
	private String menuNm;					//메뉴명
	private String parentmenuId;			//부모 메뉴 ID
	private String menuDepth;				//메뉴 뎁스
	private String orderNo;					//정렬 순서
	private String menuOrder;				//정렬 순서
	private String regId;					//등록 ID
	private String regDt;					//등록 일자
	private String updId;					//수정 ID
	private String updDt;					//수정 일자
	private String useYn;					//사용 여부
	private String urlTp;					//
	
	private String menuExplain;				//메뉴 설명
	private String outputYn;				//노출 여부
	private String loginUrl;				//
	private ArrayList<String> menuIds;
	
	
	//private String roleId;				//권한 ID
	//private String roleNm;				//권한명
	private String mngrGrpId;			//권한 그룹 ID
	private String grpNm;				//권한 그룹 명
	private String roleMenuId;
	private int level;
	
	
	private List<String> programIds;
	
	private String programUrl;
	private String programNm;
	private String path;
	
	
	private String mode;
	
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	
	public String getParentmenuId() {
		return parentmenuId;
	}
	public void setParentmenuId(String parentmenuId) {
		this.parentmenuId = parentmenuId;
	}
	public String getMenuDepth() {
		return menuDepth;
	}
	public void setMenuDepth(String menuDepth) {
		this.menuDepth = menuDepth;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	public String getMenuOrder() {
		return menuOrder;
	}
	public void setMenuOrder(String menuOrder) {
		this.menuOrder = menuOrder;
	}
	public String getRegId() {
		return regId;
	}
	public void setRegId(String regId) {
		this.regId = regId;
	}
	public String getRegDt() {
		return regDt;
	}
	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}
	public String getUpdId() {
		return updId;
	}
	public void setUpdId(String updId) {
		this.updId = updId;
	}
	public String getUpdDt() {
		return updDt;
	}
	public void setUpdDt(String updDt) {
		this.updDt = updDt;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getUrlTp() {
		return urlTp;
	}
	public void setUrlTp(String urlTp) {
		this.urlTp = urlTp;
	}
	public String getMenuExplain() {
		return menuExplain;
	}
	public void setMenuExplain(String menuExplain) {
		this.menuExplain = menuExplain;
	}
	public String getOutputYn() {
		return outputYn;
	}
	public void setOutputYn(String outputYn) {
		this.outputYn = outputYn;
	}
	public String getLoginUrl() {
		return loginUrl;
	}
	public void setLoginUrl(String loginUrl) {
		this.loginUrl = loginUrl;
	}
	public String getMngrGrpId() {
		return mngrGrpId;
	}
	public void setMngrGrpId(String mngrGrpId) {
		this.mngrGrpId = mngrGrpId;
	}
	
	
	
	public String getGrpNm() {
		return grpNm;
	}
	public void setGrpNm(String grpNm) {
		this.grpNm = grpNm;
	}
	public String getRoleMenuId() {
		return roleMenuId;
	}
	public void setRoleMenuId(String roleMenuId) {
		this.roleMenuId = roleMenuId;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public String getProgramUrl() {
		return programUrl;
	}
	public void setProgramUrl(String programUrl) {
		this.programUrl = programUrl;
	}
	public String getProgramNm() {
		return programNm;
	}
	public void setProgramNm(String programNm) {
		this.programNm = programNm;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	
	@JsonIgnore
	public ArrayList<String> getMenuIds() {
		return menuIds;
	}
	public void setMenuIds(ArrayList<String> menuIds) {
		this.menuIds = menuIds;
	}
	
	@JsonIgnore
	public List<String> getProgramIds() {
		return programIds;
	}
	public void setProgramIds(List<String> programIds) {
		this.programIds = programIds;
	}
	
	
}
