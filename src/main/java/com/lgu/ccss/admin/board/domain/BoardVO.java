package com.lgu.ccss.admin.board.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.lgu.ccss.admin.file.domain.FileInfoVO;
import com.lgu.ccss.common.domain.BaseVO;

public class BoardVO extends BaseVO {
	private static final long serialVersionUID = 113762736401091164L;
	
	private String boardId;
	private String boardMstId;
	private String title;
	private String content;
	private String useYn;
	private String opt1;
	private String opt2;
	private String opt3;
	private String opt4;
	private String opt5;
	private String opt6;
	private String opt7;
	private String insertId;
	private String insertDate;
	private String updateId;
	private String updateDate;
	private String postDate;
	private String serviceClassifyCode;
	private String postHour;
	private String postMinute;
	private MultipartFile uploadfile;
	private FileInfoVO fileInfoVO;
	private List<String> boardIdArr;
	private String[] boardIdArray;
	
	private String fixYn;
	private String contentsType;
	
	private int seqBoardId;
	
	private String dndColor;
	private String strUseYn; 
	
	private String updatetime;
	private String originFileName;
	private String filePath;

	private String bannerEndDate;
	private String bannerEndHour;
	private String bannerEndMinute;
	
	/*
	 * 조회용
	 */
	
	
	private String searchDateDiv;
	private String searchType;
	private String serachOrderBy;
	
	
	public String getSerachOrderBy() {
		return serachOrderBy;
	}
	public void setSerachOrderBy(String serachOrderBy) {
		this.serachOrderBy = serachOrderBy;
	}
	public String getBannerEndHour() {
		return bannerEndHour;
	}
	public void setBannerEndHour(String bannerEndHour) {
		this.bannerEndHour = bannerEndHour;
	}
	public String getBannerEndMinute() {
		return bannerEndMinute;
	}
	public void setBannerEndMinute(String bannerEndMinute) {
		this.bannerEndMinute = bannerEndMinute;
	}
	public String getBannerEndDate() {
		return bannerEndDate;
	}
	public void setBannerEndDate(String bannerEndDate) {
		this.bannerEndDate = bannerEndDate;
	}
	public String getSearchDateDiv() {
		return searchDateDiv;
	}
	public void setSearchDateDiv(String searchDateDiv) {
		this.searchDateDiv = searchDateDiv;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getStrUseYn() {
		return strUseYn;
	}
	public void setStrUseYn(String strUseYn) {
		this.strUseYn = strUseYn;
	}
	
	public String getDndColor() {
		return dndColor;
	}
	public void setDndColor(String dndColor) {
		this.dndColor = dndColor;
	}
	public List<String> getBoardIdArr() {
		return boardIdArr;
	}
	public void setBoardIdArr(List<String> boardIdArr) {
		this.boardIdArr = boardIdArr;
	}
	public FileInfoVO getFileInfoVO() {
		return fileInfoVO;
	}
	public String[] getBoardIdArray() {
		return boardIdArray;
	}
	public void setBoardIdArray(String[] boardIdArray) {
		this.boardIdArray = boardIdArray;
	}
	public void setFileInfoVO(FileInfoVO fileInfoVO) {
		this.fileInfoVO = fileInfoVO;
	}
	public MultipartFile getUploadfile() {
		return uploadfile;
	}
	public void setUploadfile(MultipartFile uploadfile) {
		this.uploadfile = uploadfile;
	}
	public String getBoardId() {
		return boardId;
	}
	public void setBoardId(String boardId) {
		this.boardId = boardId;
	}
	public String getBoardMstId() {
		return boardMstId;
	}
	public void setBoardMstId(String boardMstId) {
		this.boardMstId = boardMstId;
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
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getOpt1() {
		return opt1;
	}
	public void setOpt1(String opt1) {
		this.opt1 = opt1;
	}
	public String getOpt2() {
		return opt2;
	}
	public void setOpt2(String opt2) {
		this.opt2 = opt2;
	}
	public String getOpt3() {
		return opt3;
	}
	public void setOpt3(String opt3) {
		this.opt3 = opt3;
	}
	public String getOpt4() {
		return opt4;
	}
	public void setOpt4(String opt4) {
		this.opt4 = opt4;
	}
	public String getOpt5() {
		return opt5;
	}
	public void setOpt5(String opt5) {
		this.opt5 = opt5;
	}
	public String getInsertId() {
		return insertId;
	}
	public void setInsertId(String insertId) {
		this.insertId = insertId;
	}
	public String getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(String insertDate) {
		this.insertDate = insertDate;
	}
	public String getUpdateId() {
		return updateId;
	}
	public void setUpdateId(String updateId) {
		this.updateId = updateId;
	}
	public String getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}
	public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	public String getServiceClassifyCode() {
		return serviceClassifyCode;
	}
	public void setServiceClassifyCode(String serviceClassifyCode) {
		this.serviceClassifyCode = serviceClassifyCode;
	}
	
	public String getPostHour() {
		return postHour;
	}
	public void setPostHour(String postHour) {
		this.postHour = postHour;
	}
	public String getPostMinute() {
		return postMinute;
	}
	public void setPostMinute(String postMinute) {
		this.postMinute = postMinute;
	}
	public int getSeqBoardId() {
		return seqBoardId;
	}
	public void setSeqBoardId(int seqBoardId) {
		this.seqBoardId = seqBoardId;
	}
	public String getOpt6() {
		return opt6;
	}
	public void setOpt6(String opt6) {
		this.opt6 = opt6;
	}
	public String getFixYn() {
		return fixYn;
	}
	public void setFixYn(String fixYn) {
		this.fixYn = fixYn;
	}
	public String getContentsType() {
		return contentsType;
	}
	public void setContentsType(String contentsType) {
		this.contentsType = contentsType;
	}
	public String getOpt7() {
		return opt7;
	}
	public void setOpt7(String opt7) {
		this.opt7 = opt7;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
	public String getOriginFileName() {
		return originFileName;
	}
	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}
	
	
}
