package com.lgu.ccss.admin.system.menu.domain;

import java.util.ArrayList;

import com.lgu.ccss.common.domain.BaseVO;

public class MenuVO extends BaseVO {
	private static final long serialVersionUID = -7465095185196722770L;
	
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
	private String loginUrl;				//
	private String stProgramUrl;
	private ArrayList<String> menuIds;
	private String exposureYn;			
	
	private String programUrl;
	private String programNm;
	
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
	public String getLoginUrl() {
		return loginUrl;
	}
	public void setLoginUrl(String loginUrl) {
		this.loginUrl = loginUrl;
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
	public String getStProgramUrl() {
		return stProgramUrl;
	}
	public void setStProgramUrl(String stProgramUrl) {
		this.stProgramUrl = stProgramUrl;
	}
	public ArrayList<String> getMenuIds() {
		return menuIds;
	}
	public void setMenuIds(ArrayList<String> menuIds) {
		this.menuIds = menuIds;
	}
	public String getExposureYn() {
		return exposureYn;
	}
	public void setExposureYn(String exposureYn) {
		this.exposureYn = exposureYn;
	}

}
