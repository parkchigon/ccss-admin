package com.lgu.ccss.common.domain;

import java.io.Serializable;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;


/**
 * 기본 모델
 */
public class BaseVO implements Serializable {
	private static final long serialVersionUID = -7498733523702829012L;

	// 현재 페이지
	private int page = 1;
	// 한페이지에 보여줄 데이터의 개수
	private int pageRowCount = 20;

	// 리스트화면
	private String startDate;
	private String startHour;
	private String endDate;
	private String endHour;
	private String excelDownYn;

	private int rnum;
	
	
	//
	private String searchType;
	private String searchValue;
	
	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate.replaceAll("-", "");
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate.replaceAll("-", "");
	}

	public String getExcelDownYn() {
		return excelDownYn;
	}

	public void setExcelDownYn(String excelDownYn) {
		this.excelDownYn = excelDownYn;
	}

	public int getPage() {
        return page;
    }
    
    public void setPage(int page) {
        this.page = page;
    }
    
    public int getPageRowCount() {
        return pageRowCount;
    }
    
    public void setPageRowCount(int pageRowCount) {
        this.pageRowCount = pageRowCount;
    }
    /**
     * 현 페이지의 시작 카운트
     * 
     * @return int
     */
    public int getStartCount(){
        return ((page - 1) * pageRowCount)+1;
    }
    /**
     * 현 페이지에서 시작 카운트 부터 가져올 데이터의 카운트
     * 
     * @return int
     */
    public int getEndCount(){
    	return page * pageRowCount;
    }
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this, ToStringStyle.SIMPLE_STYLE);
    }

    public boolean equals(Object o) {
        return EqualsBuilder.reflectionEquals(this, o);
    }

    public int hashCode() {
        return HashCodeBuilder.reflectionHashCode(this);
    }

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public String getStartHour() {
		return startHour;
	}

	public void setStartHour(String startHour) {
		this.startHour = startHour;
	}

	public String getEndHour() {
		return endHour;
	}

	public void setEndHour(String endHour) {
		this.endHour = endHour;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchValue() {
		return searchValue;
	}

	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
}