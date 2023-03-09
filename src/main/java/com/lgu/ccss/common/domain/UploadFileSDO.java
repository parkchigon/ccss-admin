package com.lgu.ccss.common.domain;

import java.io.File;
import java.util.Date;

import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * 업로드파일정보
 * 
 * @author lsk
 *
 */
@XStreamAlias("file")
public class UploadFileSDO {

    /**
     * 원본파일명
     */
    String orgFileName;

    /**
     * 생성된 파일명
     */
    String storeFileName;

    /**
     * 생성된 파일 확장자명
     */
    String storeFileExtention;

    /**
     * 파일경로
     */
    String filePath;

    /**
     * 파일용량
     */
    private int fileSize;

    /**
     * 저장 파일
     */
    File saveFile;

    /**
     * 파일가로
     */
    private int fileWidth;

    /**
     * 파일세로
     */
    private int fileHeight;

    /**
     * 저장한 시간
     */
    Date uploadDate;

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    /**
     * @return the orgFileName
     */
    public String getOrgFileName() {
        return orgFileName;
    }

    /**
     * @param orgFileName
     *            the orgFileName to set
     */
    public void setOrgFileName(String orgFileName) {
        this.orgFileName = orgFileName;
    }

    /**
     * @return the storeFileName
     */
    public String getStoreFileName() {
        return storeFileName;
    }

    /**
     * @param storeFileName
     *            the storeFileName to set
     */
    public void setStoreFileName(String storeFileName) {
        this.storeFileName = storeFileName;
    }

    public String getStoreFileExtention() {
        return storeFileExtention;
    }

    public void setStoreFileExtention(String storeFileExtention) {
        this.storeFileExtention = storeFileExtention;
    }

    /**
     * @return the filePath
     */
    public String getFilePath() {
        return filePath;
    }

    /**
     * @param filePath
     *            the filePath to set
     */
    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    /**
     * @return the fileSize
     */
    public int getFileSize() {
        return fileSize;
    }

    /**
     * @param fileSize
     *            the fileSize to set
     */
    public void setFileSize(int fileSize) {
        this.fileSize = fileSize;
    }

    /**
     * @return the saveFile
     */
    public File getSaveFile() {
        return saveFile;
    }

    /**
     * @param saveFile
     *            the saveFile to set
     */
    public void setSaveFile(File saveFile) {
        this.saveFile = saveFile;
    }

    /**
     * @return the fileWidth
     */
    public int getFileWidth() {
        return fileWidth;
    }

    /**
     * @param fileWidth
     *            the fileWidth to set
     */
    public void setFileWidth(int fileWidth) {
        this.fileWidth = fileWidth;
    }

    /**
     * @return the fileHeight
     */
    public int getFileHeight() {
        return fileHeight;
    }

    /**
     * @param fileHeight
     *            the fileHeight to set
     */
    public void setFileHeight(int fileHeight) {
        this.fileHeight = fileHeight;
    }

}
