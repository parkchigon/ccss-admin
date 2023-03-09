package com.lgu.ccss.admin.admin.domain;

public class SmsVO {
	
	
	
	private String smsSeq;
	private String senderId;
	private String senderName;
	private String sendType;			//I:즉시, B:예약
	private String content;
	private String insertDate;
	private String bookDate;
	private String sendStatusCode;		//대기, 실패, 성공
	private String cancelYn;
	private String receiverMobileNum;
	private String senderMobileNum;
	private int sendingCount;
	private String receiverUserIdNum;
	private String receiverUserName;
	private String receiverType;		//A:지인, S:군인, M:관리자
	private String sendDate;
	private String smsAgreeYn;
	
	public String getSmsSeq() {
		return smsSeq;
	}
	public void setSmsSeq(String smsSeq) {
		this.smsSeq = smsSeq;
	}
	public String getSenderId() {
		return senderId;
	}
	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}
	public String getSenderName() {
		return senderName;
	}
	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}
	public String getSendType() {
		return sendType;
	}
	public void setSendType(String sendType) {
		this.sendType = sendType;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(String insertDate) {
		this.insertDate = insertDate;
	}
	public String getBookDate() {
		return bookDate;
	}
	public void setBookDate(String bookDate) {
		this.bookDate = bookDate;
	}
	public String getSendStatusCode() {
		return sendStatusCode;
	}
	public void setSendStatusCode(String sendStatusCode) {
		this.sendStatusCode = sendStatusCode;
	}
	public String getCancelYn() {
		return cancelYn;
	}
	public void setCancelYn(String cancelYn) {
		this.cancelYn = cancelYn;
	}
	public String getReceiverMobileNum() {
		return receiverMobileNum;
	}
	public void setReceiverMobileNum(String receiverMobileNum) {
		this.receiverMobileNum = receiverMobileNum;
	}
	public String getSenderMobileNum() {
		return senderMobileNum;
	}
	public void setSenderMobileNum(String senderMobileNum) {
		this.senderMobileNum = senderMobileNum;
	}
	public int getSendingCount() {
		return sendingCount;
	}
	public void setSendingCount(int sendingCount) {
		this.sendingCount = sendingCount;
	}
	public String getReceiverUserIdNum() {
		return receiverUserIdNum;
	}
	public void setReceiverUserIdNum(String receiverUserIdNum) {
		this.receiverUserIdNum = receiverUserIdNum;
	}
	public String getReceiverUserName() {
		return receiverUserName;
	}
	public void setReceiverUserName(String receiverUserName) {
		this.receiverUserName = receiverUserName;
	}
	public String getReceiverType() {
		return receiverType;
	}
	public void setReceiverType(String receiverType) {
		this.receiverType = receiverType;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getSmsAgreeYn() {
		return smsAgreeYn;
	}
	public void setSmsAgreeYn(String smsAgreeYn) {
		this.smsAgreeYn = smsAgreeYn;
	}

	
	
}
