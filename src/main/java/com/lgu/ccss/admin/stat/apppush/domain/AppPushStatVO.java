package com.lgu.ccss.admin.stat.apppush.domain;

import com.lgu.ccss.common.domain.BaseVO;

public class AppPushStatVO extends BaseVO {

	static final long serialVersionUID = -3977847169863071344L;
	
	private String msgId;
	private String msgStatus;
	private String code;
	private String msgTitle;
	private String msgCont;
	private String msgType;
	private String recvPhoneNo;
	private String sendType;
	private String regDt;
	private String regId;
	private String updDt;
	private String updId;
	private String sendDt;
	private String svrId;
	private String orgNo;
	private String callbackNo;
	private String sendTryCnt;
	private String wasInfo;
	
	public String getMsgStatus() {
		return msgStatus;
	}
	public void setMsgStatus(String msgStatus) {
		this.msgStatus = msgStatus;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMsgTitle() {
		return msgTitle;
	}
	public void setMsgTitle(String msgTitle) {
		this.msgTitle = msgTitle;
	}
	public String getMsgCont() {
		return msgCont;
	}
	public void setMsgCont(String msgCont) {
		this.msgCont = msgCont;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getRecvPhoneNo() {
		return recvPhoneNo;
	}
	public void setRecvPhoneNo(String recvPhoneNo) {
		this.recvPhoneNo = recvPhoneNo;
	}
	public String getSendType() {
		return sendType;
	}
	public void setSendType(String sendType) {
		this.sendType = sendType;
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
	public String getSendDt() {
		return sendDt;
	}
	public void setSendDt(String sendDt) {
		this.sendDt = sendDt;
	}
	public String getSvrId() {
		return svrId;
	}
	public void setSvrId(String svrId) {
		this.svrId = svrId;
	}
	public String getOrgNo() {
		return orgNo;
	}
	public void setOrgNo(String orgNo) {
		this.orgNo = orgNo;
	}
	public String getCallbackNo() {
		return callbackNo;
	}
	public void setCallbackNo(String callbackNo) {
		this.callbackNo = callbackNo;
	}
	public String getMsgId() {
		return msgId;
	}
	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}
	public String getSendTryCnt() {
		return sendTryCnt;
	}
	public void setSendTryCnt(String sendTryCnt) {
		this.sendTryCnt = sendTryCnt;
	}
	public String getWasInfo() {
		return wasInfo;
	}
	public void setWasInfo(String wasInfo) {
		this.wasInfo = wasInfo;
	}
	
	
}
