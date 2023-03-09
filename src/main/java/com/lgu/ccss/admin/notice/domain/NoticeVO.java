package com.lgu.ccss.admin.notice.domain;

import com.lgu.ccss.common.domain.BaseVO;

public class NoticeVO extends BaseVO {

	private static final long serialVersionUID = 4370627653161740140L;
	
	private String notiId;
	private String notiTitle;
	private String notiImportance;
	private String exposureYn;
	private String pushYn;
	private String serviceCategory;
	
	private String notiStartDt;
	private String notiEndDt;
	private String notiCont;
	
	private String regDt;
	private String regId;
	private String updDt;
	private String updId;
	
	private String pushStartDt;
	private String pushEndDt;

	private String spostDate;
	private String spostHour;
	private String spostMinute;
	
	private String epostDate;
	private String epostHour;
	private String epostMinute;
	
	
	private String notiSpostDate;
	private String notiSpostHour;
	private String notiSpostMinute;
	
	private String notiEpostDate;
	private String notiEpostHour;
	private String notiEpostMinute;
	
	private String[] notiIdArray;
	
	private String searchStatus;
	
	private String searchServiceCategory;

	private String serviceExposure;
	
	private String notiType;
	private String firmVer;
	private String contType;
	
	public String getNotiId() {
		return notiId;
	}

	public void setNotiId(String notiId) {
		this.notiId = notiId;
	}

	public String getNotiTitle() {
		return notiTitle;
	}

	public void setNotiTitle(String notiTitle) {
		this.notiTitle = notiTitle;
	}

	public String getNotiImportance() {
		return notiImportance;
	}

	public void setNotiImportance(String notiImportance) {
		this.notiImportance = notiImportance;
	}

	public String getExposureYn() {
		return exposureYn;
	}

	public void setExposureYn(String exposureYn) {
		this.exposureYn = exposureYn;
	}

	public String getPushYn() {
		return pushYn;
	}

	public void setPushYn(String pushYn) {
		this.pushYn = pushYn;
	}

	public String getServiceCategory() {
		return serviceCategory;
	}

	public void setServiceCategory(String serviceCategory) {
		this.serviceCategory = serviceCategory;
	}

	public String getNotiStartDt() {
		return notiStartDt;
	}

	public void setNotiStartDt(String notiStartDt) {
		this.notiStartDt = notiStartDt;
	}

	public String getNotiEndDt() {
		return notiEndDt;
	}

	public void setNotiEndDt(String notiEndDt) {
		this.notiEndDt = notiEndDt;
	}

	public String getNotiCont() {
		return notiCont;
	}

	public void setNotiCont(String notiCont) {
		this.notiCont = notiCont;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
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

	

	public String[] getNotiIdArray() {
		return notiIdArray;
	}

	public void setNotiIdArray(String[] notiIdArray) {
		this.notiIdArray = notiIdArray;
	}

	public String getSearchStatus() {
		return searchStatus;
	}

	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
	}

	public String getSearchServiceCategory() {
		return searchServiceCategory;
	}

	public void setSearchServiceCategory(String searchServiceCategory) {
		this.searchServiceCategory = searchServiceCategory;
	}

	public String getPushStartDt() {
		return pushStartDt;
	}

	public void setPushStartDt(String pushStartDt) {
		this.pushStartDt = pushStartDt;
	}

	public String getPushEndDt() {
		return pushEndDt;
	}

	public void setPushEndDt(String pushEndDt) {
		this.pushEndDt = pushEndDt;
	}

	public String getSpostDate() {
		return spostDate;
	}

	public void setSpostDate(String spostDate) {
		this.spostDate = spostDate;
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
		this.epostDate = epostDate;
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

	public String getNotiSpostDate() {
		return notiSpostDate;
	}

	public void setNotiSpostDate(String notiSpostDate) {
		this.notiSpostDate = notiSpostDate;
	}

	public String getNotiSpostHour() {
		return notiSpostHour;
	}

	public void setNotiSpostHour(String notiSpostHour) {
		this.notiSpostHour = notiSpostHour;
	}

	public String getNotiSpostMinute() {
		return notiSpostMinute;
	}

	public void setNotiSpostMinute(String notiSpostMinute) {
		this.notiSpostMinute = notiSpostMinute;
	}

	public String getNotiEpostDate() {
		return notiEpostDate;
	}

	public void setNotiEpostDate(String notiEpostDate) {
		this.notiEpostDate = notiEpostDate;
	}

	public String getNotiEpostHour() {
		return notiEpostHour;
	}

	public void setNotiEpostHour(String notiEpostHour) {
		this.notiEpostHour = notiEpostHour;
	}

	public String getNotiEpostMinute() {
		return notiEpostMinute;
	}

	public void setNotiEpostMinute(String notiEpostMinute) {
		this.notiEpostMinute = notiEpostMinute;
	}

	
	public String getServiceExposure() {
		return serviceExposure;
	}

	public void setServiceExposure(String serviceExposure) {
		this.serviceExposure = serviceExposure;
	}

	public String getNotiType() {
		return notiType;
	}

	public void setNotiType(String notiType) {
		this.notiType = notiType;
	}

	public String getFirmVer() {
		return firmVer;
	}

	public void setFirmVer(String firmVer) {
		this.firmVer = firmVer;
	}

	public String getContType() {
		return contType;
	}

	public void setContType(String contType) {
		this.contType = contType;
	}
	
	
}
