package com.lgu.ccss.admin.stat.send2car.domain;

import com.lgu.ccss.common.domain.BaseVO;

public class Send2CarStatVO extends BaseVO {

	public final static String SEND_STATUS_READY = "READY";
	public final static String SEND_STATUS_SCHEDULE = "SCHEDULE";
	public final static String SEND_STATUS_SEND = "SEND";
	public final static String SEND_STATUS_SENDING = "SENDING";
	public final static String SEND_STATUS_RECV = "RECV";
	public final static String SEND_STATUS_FINAL = "FINAL";
	public final static String SEND_STATUS_SLEEP = "SLEEP";
	public final static String SEND_STATUS_DELETE = "DELETE";
	

	private String sendToCarId;
	private String targetNm;
	private String targetAddress;
	private String targetLonx;
	private String targetLaty;
	private String sendStatus;
	private String useYn;
	private String arrivHopeTime;
	private String estTime;
	private String regId;
	private String regDt;
	private String updId;
	private String updDt;
	private String membId;
	private String mgrappId;
	private String serviceType;
	private String rsvType;
	private String svrId;
	private String hostNm;
	private String processDt;
	private String scheduleId;
	
	private String mgrappCtn;
	private String mgrappLoginId;
	private String deviceCtn;
	public String getSendToCarId() {
		return sendToCarId;
	}
	public void setSendToCarId(String sendToCarId) {
		this.sendToCarId = sendToCarId;
	}
	public String getTargetNm() {
		return targetNm;
	}
	public void setTargetNm(String targetNm) {
		this.targetNm = targetNm;
	}
	public String getTargetAddress() {
		return targetAddress;
	}
	public void setTargetAddress(String targetAddress) {
		this.targetAddress = targetAddress;
	}
	public String getTargetLonx() {
		return targetLonx;
	}
	public void setTargetLonx(String targetLonx) {
		this.targetLonx = targetLonx;
	}
	public String getTargetLaty() {
		return targetLaty;
	}
	public void setTargetLaty(String targetLaty) {
		this.targetLaty = targetLaty;
	}
	public String getSendStatus() {
		return sendStatus;
	}
	public void setSendStatus(String sendStatus) {
		this.sendStatus = sendStatus;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getArrivHopeTime() {
		return arrivHopeTime;
	}
	public void setArrivHopeTime(String arrivHopeTime) {
		this.arrivHopeTime = arrivHopeTime;
	}
	public String getEstTime() {
		return estTime;
	}
	public void setEstTime(String estTime) {
		this.estTime = estTime;
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
	public String getMembId() {
		return membId;
	}
	public void setMembId(String membId) {
		this.membId = membId;
	}
	public String getMgrappId() {
		return mgrappId;
	}
	public void setMgrappId(String mgrappId) {
		this.mgrappId = mgrappId;
	}
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public String getRsvType() {
		return rsvType;
	}
	public void setRsvType(String rsvType) {
		this.rsvType = rsvType;
	}
	public String getSvrId() {
		return svrId;
	}
	public void setSvrId(String svrId) {
		this.svrId = svrId;
	}
	
	public String getHostNm() {
		return hostNm;
	}
	public void setHostNm(String hostNm) {
		this.hostNm = hostNm;
	}
	public String getProcessDt() {
		return processDt;
	}
	public void setProcessDt(String processDt) {
		this.processDt = processDt;
	}
	public String getScheduleId() {
		return scheduleId;
	}
	public void setScheduleId(String scheduleId) {
		this.scheduleId = scheduleId;
	}
	public String getMgrappCtn() {
		return mgrappCtn;
	}
	public void setMgrappCtn(String mgrappCtn) {
		this.mgrappCtn = mgrappCtn;
	}
	
	public String getDeviceCtn() {
		return deviceCtn;
	}
	public String getMgrappLoginId() {
		return mgrappLoginId;
	}
	public void setMgrappLoginId(String mgrappLoginId) {
		this.mgrappLoginId = mgrappLoginId;
	}
	public void setDeviceCtn(String deviceCtn) {
		this.deviceCtn = deviceCtn;
	}
	@Override
	public String toString() {
		return "Send2CarStatVO [sendToCarId=" + sendToCarId + ", targetNm="
				+ targetNm + ", targetAddress=" + targetAddress
				+ ", targetLonx=" + targetLonx + ", targetLaty=" + targetLaty
				+ ", sendStatus=" + sendStatus + ", useYn=" + useYn
				+ ", arrivHopeTime=" + arrivHopeTime + ", estTime=" + estTime
				+ ", regId=" + regId + ", regDt=" + regDt + ", updId=" + updId
				+ ", updDt=" + updDt + ", membId=" + membId + ", mgrappId="
				+ mgrappId + ", serviceType=" + serviceType + ", rsvType="
				+ rsvType + ", svrId=" + svrId + ", hostNm=" + hostNm
				+ ", processDt=" + processDt + ", scheduleId=" + scheduleId
				+ ", mgrappCtn=" + mgrappCtn + ", mgrappLoginId="
				+ mgrappLoginId + ", deviceCtn=" + deviceCtn + "]";
	}
	

	
	
}
