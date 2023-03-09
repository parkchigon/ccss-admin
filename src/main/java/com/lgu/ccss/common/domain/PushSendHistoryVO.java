package com.lgu.ccss.common.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class PushSendHistoryVO extends BaseVO {
	private static final long serialVersionUID = -7540863323561275280L;
	
	private String pushSeq;
	private String senderId;
	private String senderName;
	private String deviceType;
	private String contentTypeCode;
	private String title;
	private String content;
	private String attachFileSeq;
	private String insertDate;
	private String bookDate;
	private String sendDate;
	private String sendStatusCode;
	private String cancelYn;
	private String receiverMobileNum;
	private String senderMobileNum;
	private int sendingCount;
	private String linkType;
	private String linkUrl;
	private String receiverUserIdNum;
	private String receiverUserName;
	private String pushAgreeYn;
	
	private String searchYear;
	private String searchMonth;
	private String searchDate;
	private String searchText;
	private String searchDateDiv;
	private String searchDiv;
	
	private List<String> receiverMobileNumList;
	private String bookHour;
	private String bookMinute;
	
	private String sendType1Count;
	private String sendType2Count;
	private String sendType3Count;
	
	private List<String> pushSeqArr;
	
	// 2016.08.26 변수종 이벤트당첨자팝업등록 시 자동푸쉬등록을 위한 수정 시작
	private String eventSeq;
	private String eventTypeSeq;
	// 2016.08.26 변수종 이벤트당첨자팝업등록 시 자동푸쉬등록을 위한 수정 끝
	
	@JsonIgnore
	private MultipartFile uploadfile;
	@JsonIgnore
	private MultipartFile uploadImagefile;
	
	private String receiveType;
	
	public String getEventTypeSeq() {
		return eventTypeSeq;
	}
	public void setEventTypeSeq(String eventTypeSeq) {
		this.eventTypeSeq = eventTypeSeq;
	}
	public String getEventSeq() {
		return eventSeq;
	}
	public void setEventSeq(String eventSeq) {
		this.eventSeq = eventSeq;
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
	public String getDeviceType() {
		return deviceType;
	}
	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}
	public String getContentTypeCode() {
		return contentTypeCode;
	}
	public void setContentTypeCode(String contentTypeCode) {
		this.contentTypeCode = contentTypeCode;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAttachFileSeq() {
		return attachFileSeq;
	}
	public void setAttachFileSeq(String attachFileSeq) {
		this.attachFileSeq = attachFileSeq;
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
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
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
	public String getLinkType() {
		return linkType;
	}
	public void setLinkType(String linkType) {
		this.linkType = linkType;
	}
	public String getLinkUrl() {
		return linkUrl;
	}
	public void setLinkUrl(String linkUrl) {
		this.linkUrl = linkUrl;
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
	public String getPushAgreeYn() {
		return pushAgreeYn;
	}
	public void setPushAgreeYn(String pushAgreeYn) {
		this.pushAgreeYn = pushAgreeYn;
	}
	public String getSearchYear() {
		return searchYear;
	}
	public void setSearchYear(String searchYear) {
		this.searchYear = searchYear;
	}
	public String getSearchMonth() {
		return searchMonth;
	}
	public void setSearchMonth(String searchMonth) {
		this.searchMonth = searchMonth;
	}
	public String getSearchDate() {
		return searchDate;
	}
	public void setSearchDate(String searchDate) {
		this.searchDate = searchDate;
	}
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	public String getSearchDateDiv() {
		return searchDateDiv;
	}
	public void setSearchDateDiv(String searchDateDiv) {
		this.searchDateDiv = searchDateDiv;
	}
	public String getSearchDiv() {
		return searchDiv;
	}
	public void setSearchDiv(String searchDiv) {
		this.searchDiv = searchDiv;
	}
	public String getPushSeq() {
		return pushSeq;
	}
	public void setPushSeq(String pushSeq) {
		this.pushSeq = pushSeq;
	}
	public List<String> getReceiverMobileNumList() {
		return receiverMobileNumList;
	}
	public void setReceiverMobileNumList(List<String> receiverMobileNumList) {
		this.receiverMobileNumList = receiverMobileNumList;
	}
	public String getBookHour() {
		return bookHour;
	}
	public void setBookHour(String bookHour) {
		this.bookHour = bookHour;
	}
	public String getBookMinute() {
		return bookMinute;
	}
	public void setBookMinute(String bookMinute) {
		this.bookMinute = bookMinute;
	}
	public String getSendType1Count() {
		return sendType1Count;
	}
	public void setSendType1Count(String sendType1Count) {
		this.sendType1Count = sendType1Count;
	}
	public String getSendType2Count() {
		return sendType2Count;
	}
	public void setSendType2Count(String sendType2Count) {
		this.sendType2Count = sendType2Count;
	}
	public String getSendType3Count() {
		return sendType3Count;
	}
	public void setSendType3Count(String sendType3Count) {
		this.sendType3Count = sendType3Count;
	}
	public List<String> getPushSeqArr() {
		return pushSeqArr;
	}
	public void setPushSeqArr(List<String> pushSeqArr) {
		this.pushSeqArr = pushSeqArr;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public MultipartFile getUploadImagefile() {
		return uploadImagefile;
	}
	public void setUploadImagefile(MultipartFile uploadImagefile) {
		this.uploadImagefile = uploadImagefile;
	}
	public String getReceiveType() {
		return receiveType;
	}
	public void setReceiveType(String receiveType) {
		this.receiveType = receiveType;
	}
	
}
