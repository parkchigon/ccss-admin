package com.lgu.ccss.admin.notice.service;


import java.util.Map;

import com.lgu.ccss.admin.notice.domain.NoticeVO;


public interface NoticeService {

	public Map<String, Object> selectNoticeList(NoticeVO noticeVO) throws Exception ;
	
	public NoticeVO selectNoticeDetail(NoticeVO noticeVO) throws Exception ;
	
	public Map<String, Object> insertNotice(NoticeVO noticeVO) throws Exception ;
	
	public Map<String, Object> updateNotice(NoticeVO noticeVO) throws Exception ;

	public Map<String, Object> deleteNotice(NoticeVO noticeVO) throws Exception ;
		
}
