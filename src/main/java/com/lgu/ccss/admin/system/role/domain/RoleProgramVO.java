package com.lgu.ccss.admin.system.role.domain;

import com.lgu.ccss.common.domain.BaseVO;

public class RoleProgramVO extends BaseVO {
	private static final long serialVersionUID = 7099039980505934779L;
	
	/*private String roleId;			//권한 ID
	private String roleNm;				//권한명
	 */	
	private String mngrGrpId;			//권한 그룹 ID
	private String grpNm;				//권한 그룹 명
	
	private String regId;			//등록 ID
	private String regDt;			//등록 일자
	private String updId;			//수정 ID
	private String updDt;			//수정 일자
	private String useYn;				//사용 여부
	private String orderNo;				//정렬 순서
	private String menuOrder;				//정렬 순서
	
	private String programId;
	private String programNm;
	private String programUrl;
	private String stProgramYn;
	private String menuId;
	
	
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
	public String getProgramId() {
		return programId;
	}
	public void setProgramId(String programId) {
		this.programId = programId;
	}
	public String getProgramNm() {
		return programNm;
	}
	public void setProgramNm(String programNm) {
		this.programNm = programNm;
	}
	public String getProgramUrl() {
		return programUrl;
	}
	public void setProgramUrl(String programUrl) {
		this.programUrl = programUrl;
	}
	public String getStProgramYn() {
		return stProgramYn;
	}
	public void setStProgramYn(String stProgramYn) {
		this.stProgramYn = stProgramYn;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
}
