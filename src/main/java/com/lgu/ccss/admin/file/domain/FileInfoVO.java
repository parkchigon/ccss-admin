package com.lgu.ccss.admin.file.domain;

public class FileInfoVO {

	private String bizClassifyCode;
	private String fileSeq;
	private String uploadId;
	private String uploadDtime;
	private String originFileName;
	private String saveFileName;
	private String filePath;
	
	private String width;
	private String height;
	private String fileSize;
	
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getBizClassifyCode() {
		return bizClassifyCode;
	}
	public void setBizClassifyCode(String bizClassifyCode) {
		this.bizClassifyCode = bizClassifyCode;
	}
	public String getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(String fileSeq) {
		this.fileSeq = fileSeq;
	}
	public String getUploadId() {
		return uploadId;
	}
	public void setUploadId(String uploadId) {
		this.uploadId = uploadId;
	}
	public String getUploadDtime() {
		return uploadDtime;
	}
	public void setUploadDtime(String uploadDtime) {
		this.uploadDtime = uploadDtime;
	}
	public String getOriginFileName() {
		return originFileName;
	}
	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	
}
