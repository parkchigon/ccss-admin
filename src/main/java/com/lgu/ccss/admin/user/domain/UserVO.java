package com.lgu.ccss.admin.user.domain;

import com.lgu.ccss.common.domain.BaseVO;

public class UserVO extends BaseVO {

private static final long serialVersionUID = 988272069826495303L;
	
	//TB_MEMB
	private String useYn;
	private String loginFailCnt;
	private String regDt;
	private String regId;
	private String updDt;
	private String updId;
	private String membId;
	private String joinDt;
	private String securityKey;
	private String membNo;
	private String latestLoginDt;
	private String serverId;
	private String membCtn;
	private String transToken;
	private String payResvYn;
	private String payResvDt;
	private String marketType;

	
	//TB_CONN_DEVICE
	private String deviceEsn;
	private String usimModel;
	private String usimSn;
	private String devicePushClientId;
	private String deviceLoginDt;
	private String devicePushConnDt;
	private String devicePushConStatus;
	private String vehicleModelId;
	private String connDeviceId;
	private String deviceModelId;
	private String firmwareInfo;
	private String jsonSetInfo;
	private String uiccid;
	private String deviceType;
	

	//Search Condition
	private String deviceCtn;
	private String productNm;
	private String productExplain;
	private String newRejoinYn;
	private String useStatus;
	private String feeType;
	
	private String pushConnectionYn;
	

	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getLoginFailCnt() {
		return loginFailCnt;
	}
	public void setLoginFailCnt(String loginFailCnt) {
		this.loginFailCnt = loginFailCnt;
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
	public String getMembId() {
		return membId;
	}
	public void setMembId(String membId) {
		this.membId = membId;
	}
	public String getJoinDt() {
		return joinDt;
	}
	public void setJoinDt(String joinDt) {
		this.joinDt = joinDt;
	}
	public String getSecurityKey() {
		return securityKey;
	}
	public void setSecurityKey(String securityKey) {
		this.securityKey = securityKey;
	}
	public String getMembNo() {
		return membNo;
	}
	public void setMembNo(String membNo) {
		this.membNo = membNo;
	}
	public String getLatestLoginDt() {
		return latestLoginDt;
	}
	public void setLatestLoginDt(String latestLoginDt) {
		this.latestLoginDt = latestLoginDt;
	}
	public String getServerId() {
		return serverId;
	}
	public void setServerId(String serverId) {
		this.serverId = serverId;
	}
	public String getDeviceEsn() {
		return deviceEsn;
	}
	public void setDeviceEsn(String deviceEsn) {
		this.deviceEsn = deviceEsn;
	}
	public String getUsimModel() {
		return usimModel;
	}
	public void setUsimModel(String usimModel) {
		this.usimModel = usimModel;
	}
	public String getUsimSn() {
		return usimSn;
	}
	public void setUsimSn(String usimSn) {
		this.usimSn = usimSn;
	}
	public String getDevicePushClientId() {
		return devicePushClientId;
	}
	public void setDevicePushClientId(String devicePushClientId) {
		this.devicePushClientId = devicePushClientId;
	}
	public String getDeviceLoginDt() {
		return deviceLoginDt;
	}
	public void setDeviceLoginDt(String deviceLoginDt) {
		this.deviceLoginDt = deviceLoginDt;
	}
	public String getDevicePushConnDt() {
		return devicePushConnDt;
	}
	public void setDevicePushConnDt(String devicePushConnDt) {
		this.devicePushConnDt = devicePushConnDt;
	}
	public String getDevicePushConStatus() {
		return devicePushConStatus;
	}
	public void setDevicePushConStatus(String devicePushConStatus) {
		this.devicePushConStatus = devicePushConStatus;
	}
	public String getVehicleModelId() {
		return vehicleModelId;
	}
	public void setVehicleModelId(String vehicleModelId) {
		this.vehicleModelId = vehicleModelId;
	}
	public String getConnDeviceId() {
		return connDeviceId;
	}
	public void setConnDeviceId(String connDeviceId) {
		this.connDeviceId = connDeviceId;
	}
	public String getDeviceModelId() {
		return deviceModelId;
	}
	public void setDeviceModelId(String deviceModelId) {
		this.deviceModelId = deviceModelId;
	}
	public String getFirmwareInfo() {
		return firmwareInfo;
	}
	public void setFirmwareInfo(String firmwareInfo) {
		this.firmwareInfo = firmwareInfo;
	}
	public String getJsonSetInfo() {
		return jsonSetInfo;
	}
	public void setJsonSetInfo(String jsonSetInfo) {
		this.jsonSetInfo = jsonSetInfo;
	}
	public String getUiccid() {
		return uiccid;
	}
	public void setUiccid(String uiccid) {
		this.uiccid = uiccid;
	}
	public String getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}
	/*public String getDeviceCtn() {
		String returnVal="";
		if(deviceCtn !=null){
			returnVal = deviceCtn.replaceAll("-", "");
		}
		return returnVal;
	}*/
	
	public void setDeviceCtn(String deviceCtn) {
		this.deviceCtn = deviceCtn;
	}
	public String getDeviceCtn() {
		return deviceCtn;
	}
	public String getProductNm() {
		return productNm;
	}
	public void setProductNm(String productNm) {
		this.productNm = productNm;
	}
	public String getNewRejoinYn() {
		return newRejoinYn;
	}
	public void setNewRejoinYn(String newRejoinYn) {
		this.newRejoinYn = newRejoinYn;
	}
	public String getUseStatus() {
		return useStatus;
	}
	public void setUseStatus(String useStatus) {
		this.useStatus = useStatus;
	}
	public String getPushConnectionYn() {
		return pushConnectionYn;
	}
	public void setPushConnectionYn(String pushConnectionYn) {
		this.pushConnectionYn = pushConnectionYn;
	}
	public String getProductExplain() {
		return productExplain;
	}
	public void setProductExplain(String productExplain) {
		this.productExplain = productExplain;
	}
	public String getFeeType() {
		return feeType;
	}
	public void setFeeType(String feeType) {
		this.feeType = feeType;
	}
	public String getMembCtn() {
		return membCtn;
	}
	public void setMembCtn(String membCtn) {
		this.membCtn = membCtn;
	}
	public String getTransToken() {
		return transToken;
	}
	public void setTransToken(String transToken) {
		this.transToken = transToken;
	}
	public String getPayResvYn() {
		return payResvYn;
	}
	public void setPayResvYn(String payResvYn) {
		this.payResvYn = payResvYn;
	}
	public String getPayResvDt() {
		return payResvDt;
	}
	public void setPayResvDt(String payResvDt) {
		this.payResvDt = payResvDt;
	}
	public String getMarketType() {
		return marketType;
	}
	public void setMarketType(String marketType) {
		this.marketType = marketType;
	}
	
}
