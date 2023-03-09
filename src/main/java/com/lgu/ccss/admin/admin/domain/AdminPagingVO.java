package com.lgu.ccss.admin.admin.domain;

import devonframe.paging.model.PagingEntity;


public class AdminPagingVO extends PagingEntity {

	private static final long serialVersionUID = 988272069826495303L;

	private String mngrId;
	private String passWd;
	private String passWdEnc;
	private String mngrNm;
	private String clphNo;
	private String emailAddr;
	private String useYn;
	private String withdrowDt;
	private int loginFailCount;
	private String pwChgDt;
	private String regId;
	private String regDt;
	private String updDt;
	private String updId;
	private String mngrLevel;
	private String mngrLevelNm;
	private String smsCertiNo;
	private String smsCertiExprDttm;
	// 기존 비밀 번호 이력
	private String bfrPassWd;

	private String accountStatus;
	
	private String resultType;

	private String grpNm;

	public String getMngrId() {
		return mngrId;
	}



	public void setMngrId(String mngrId) {
		this.mngrId = mngrId;
	}



	


	public String getPassWd() {
		return passWd;
	}



	public void setPassWd(String passWd) {
		this.passWd = passWd;
	}



	public String getPassWdEnc() {
		return passWdEnc;
	}



	public void setPassWdEnc(String passWdEnc) {
		this.passWdEnc = passWdEnc;
	}





	public String getMngrNm() {
		return mngrNm;
	}



	public void setMngrNm(String mngrNm) {
		this.mngrNm = mngrNm;
	}



	public String getClphNo() {
		return clphNo;
	}



	public void setClphNo(String clphNo) {
		this.clphNo = clphNo;
	}



	public String getEmailAddr() {
		return emailAddr;
	}



	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}



	public String getUseYn() {
		return useYn;
	}



	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}



	public String getWithdrowDt() {
		return withdrowDt;
	}



	public void setWithdrowDt(String withdrowDt) {
		this.withdrowDt = withdrowDt;
	}



	public int getLoginFailCount() {
		return loginFailCount;
	}



	public void setLoginFailCount(int loginFailCount) {
		this.loginFailCount = loginFailCount;
	}



	public String getPwChgDt() {
		return pwChgDt;
	}



	public void setPwChgDt(String pwChgDt) {
		this.pwChgDt = pwChgDt;
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



	public String getUpdDt() {
		return updDt;
	}



	public void setUpdDt(String updDt) {
		this.updDt = updDt;
	}



	public String getUpdId() {
		return updId;
	}



	public void setUpdId(String updId) {
		this.updId = updId;
	}



	



	public String getMngrLevel() {
		return mngrLevel;
	}



	public void setMngrLevel(String mngrLevel) {
		this.mngrLevel = mngrLevel;
	}



	public String getMngrLevelNm() {
		return mngrLevelNm;
	}



	public void setMngrLevelNm(String mngrLevelNm) {
		this.mngrLevelNm = mngrLevelNm;
	}



	public String getSmsCertiNo() {
		return smsCertiNo;
	}



	public void setSmsCertiNo(String smsCertiNo) {
		this.smsCertiNo = smsCertiNo;
	}



	public String getSmsCertiExprDttm() {
		return smsCertiExprDttm;
	}



	public void setSmsCertiExprDttm(String smsCertiExprDttm) {
		this.smsCertiExprDttm = smsCertiExprDttm;
	}


	public String getBfrPassWd() {
		return bfrPassWd;
	}



	public void setBfrPassWd(String bfrPassWd) {
		this.bfrPassWd = bfrPassWd;
	}



	public String getAccountStatus() {
		return accountStatus;
	}



	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}



	public String getResultType() {
		return resultType;
	}



	public void setResultType(String resultType) {
		this.resultType = resultType;
	}



	public String getGrpNm() {
		return grpNm;
	}



	public void setGrpNm(String grpNm) {
		this.grpNm = grpNm;
	}



	
	
   /* private String[] adminSeqArray;
    
    public String[] getAdminSeqArray() {
		return adminSeqArray;
	}
	public void setAdminSeqArray(String[] adminSeqArray) {
		this.adminSeqArray = adminSeqArray;
	}*/
	
	
}
