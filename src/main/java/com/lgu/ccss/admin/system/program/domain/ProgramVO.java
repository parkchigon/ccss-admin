package com.lgu.ccss.admin.system.program.domain;

import com.lgu.ccss.common.domain.BaseVO;

public class ProgramVO extends BaseVO{
	private static final long serialVersionUID = 1346668601614548674L;
	
	private String programId;
	private String programNm;
	private String programUrl;
	private String stProgramYn;
	private String regId;				//등록 ID
	private String regDt;				//등록 일자
	private String updId;				//수정 ID
	private String updDt;				//수정 일자
	private String menuId;
	private String useYn;

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
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
}
