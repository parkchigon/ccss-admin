package com.lgu.ccss.admin.term.domain;

import com.lgu.ccss.common.domain.BaseVO;

public class TermsVO extends BaseVO {
	private static final long serialVersionUID = -984145039915784258L;
	
	private String termsNo;
	private String termsVer;
	private String termsTitle;
	private String termsCont;
	private String termsDiv;
	private String exposureYn;
	private String exposureStartDt;
	private String exposureEndDt;
	private String regId;
	private String regDt;
	private String updId;
	private String updDt;
	private String[] termsSeqArray;
	

	private String termsId;
	private String termsContent;
	private String requiredYn;
	private String useYn;
/*	private String postDate;
	private String postHour;
	private String postMinute;*/

	private String spostDate;
	private String spostHour;
	private String spostMinute;
	
	private String epostDate;
	private String epostHour;
	private String epostMinute;
	
	
	private String termsSortNum;
	
	//Not Used
	private String searchDateDiv;
	private String filterYn;
	private String searchText;
	private String seqTermsAgreeInfo;
	private String groupId;
	private String seqMember;			//회원 식별 번호
	private String agreementYn;
	private String ctn;
	
	
	public String getTermsId() {
		return termsId;
	}
	public void setTermsId(String termsId) {
		this.termsId = termsId;
	}
	public String getTermsTitle() {
		return termsTitle;
	}
	public void setTermsTitle(String termsTitle) {
		this.termsTitle = termsTitle;
	}
	public String getTermsContent() {
		return termsContent;
	}
	public void setTermsContent(String termsContent) {
		this.termsContent = termsContent;
	}
	public String getRequiredYn() {
		return requiredYn;
	}
	public void setRequiredYn(String requiredYn) {
		this.requiredYn = requiredYn;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getSpostDate() {
		return spostDate;
	}
	public void setSpostDate(String spostDate) {
		this.spostDate = spostDate.replaceAll("-", "");
	}
	public String getSpostHour() {
		return spostHour;
	}
	public void setSpostHour(String spostHour) {
		this.spostHour = spostHour;
	}
	public String getSpostMinute() {
		return spostMinute;
	}
	public void setSpostMinute(String spostMinute) {
		this.spostMinute = spostMinute;
	}
	public String getEpostDate() {
		return epostDate;
	}
	public void setEpostDate(String epostDate) {
		this.epostDate = epostDate.replaceAll("-", "");
	}
	public String getEpostHour() {
		return epostHour;
	}
	public void setEpostHour(String epostHour) {
		this.epostHour = epostHour;
	}
	public String getEpostMinute() {
		return epostMinute;
	}
	public void setEpostMinute(String epostMinute) {
		this.epostMinute = epostMinute;
	}
	
	public String getSearchDateDiv() {
		return searchDateDiv;
	}
	public void setSearchDateDiv(String searchDateDiv) {
		this.searchDateDiv = searchDateDiv;
	}
	public String getFilterYn() {
		return filterYn;
	}
	public void setFilterYn(String filterYn) {
		this.filterYn = filterYn;
	}
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	
	public String getSeqTermsAgreeInfo() {
		return seqTermsAgreeInfo;
	}
	public void setSeqTermsAgreeInfo(String seqTermsAgreeInfo) {
		this.seqTermsAgreeInfo = seqTermsAgreeInfo;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getSeqMember() {
		return seqMember;
	}
	public void setSeqMember(String seqMember) {
		this.seqMember = seqMember;
	}
	public String getAgreementYn() {
		return agreementYn;
	}
	public void setAgreementYn(String agreementYn) {
		this.agreementYn = agreementYn;
	}
	public String getCtn() {
		return ctn;
	}
	public void setCtn(String ctn) {
		this.ctn = ctn;
	}
	public String getTermsNo() {
		return termsNo;
	}
	public void setTermsNo(String termsNo) {
		this.termsNo = termsNo;
	}
	public String getTermsVer() {
		return termsVer;
	}
	public void setTermsVer(String termsVer) {
		this.termsVer = termsVer;
	}
	public String getTermsCont() {
		return termsCont;
	}
	public void setTermsCont(String termsCont) {
		this.termsCont = termsCont;
	}
	public String getTermsDiv() {
		return termsDiv;
	}
	public void setTermsDiv(String termsDiv) {
		this.termsDiv = termsDiv;
	}
	public String getExposureYn() {
		return exposureYn;
	}
	public void setExposureYn(String exposureYn) {
		this.exposureYn = exposureYn;
	}
	public String getExposureStartDt() {
		return exposureStartDt;
	}
	public void setExposureStartDt(String exposureStartDt) {
		this.exposureStartDt = exposureStartDt;
	}
	public String getExposureEndDt() {
		return exposureEndDt;
	}
	public void setExposureEndDt(String exposureEndDt) {
		this.exposureEndDt = exposureEndDt;
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
	public String[] getTermsSeqArray() {
		return termsSeqArray;
	}
	public void setTermsSeqArray(String[] termsSeqArray) {
		this.termsSeqArray = termsSeqArray;
	}
	public String getTermsSortNum() {
		return termsSortNum;
	}
	public void setTermsSortNum(String termsSortNum) {
		this.termsSortNum = termsSortNum;
	}
	
}
