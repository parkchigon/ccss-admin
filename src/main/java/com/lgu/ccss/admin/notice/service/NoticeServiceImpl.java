package com.lgu.ccss.admin.notice.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.board.domain.BoardVO;
import com.lgu.ccss.admin.notice.domain.NoticeVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.Constants.ResultCode;
import com.lgu.ccss.common.utility.keygenerator.KeyGenerator;

import devonframe.dataaccess.CommonDao;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{

	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;

	/**
	 * 게시판 리스트 조회
	 * @param noticeVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectNoticeList(NoticeVO noticeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
	
		List<NoticeVO> resultList = commonDao_oracle.selectList("Notice.selectNoticeList",noticeVO);
		
		for(NoticeVO tmpVO : resultList){
			tmpVO.setNotiCont(replaceHtmlTag(tmpVO.getNotiCont()));
		}
		int totalCount = commonDao_oracle.select("Notice.selectNoticeListCnt",noticeVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	
	public NoticeVO selectNoticeDetail(NoticeVO noticeVO) throws Exception {
		 noticeVO = commonDao_oracle.select("Notice.selectNoticeDetail",noticeVO);
		
		String pushStartDt = noticeVO.getPushStartDt();
		String pushEndDt = 	noticeVO.getPushEndDt();
		
		String notiStartDt = noticeVO.getNotiStartDt();
		String notiEndDt = 	noticeVO.getNotiEndDt();
		
		//if(appVO.getPushNotiYn().equals("Y")){
		
		
		
		if(!String.valueOf(noticeVO.getPushStartDt()).equals("null")){
			noticeVO.setSpostDate(pushStartDt.substring(0,10).replaceAll("-", ""));
			noticeVO.setSpostHour(pushStartDt.substring(11,13));
			noticeVO.setSpostMinute(pushStartDt.substring(14,16));
			
			noticeVO.setEpostDate(pushEndDt.substring(0,10).replaceAll("-", ""));
			noticeVO.setEpostHour(pushEndDt.substring(11,13));
			noticeVO.setEpostMinute(pushEndDt.substring(14,16));
		}
		//}
		
	
		
		noticeVO.setNotiSpostDate(notiStartDt.substring(0,10).replaceAll("-", ""));
		noticeVO.setNotiSpostHour(notiStartDt.substring(11,13));
		noticeVO.setNotiSpostMinute(notiStartDt.substring(14,16));
		
		noticeVO.setNotiEpostDate(notiEndDt.substring(0,10).replaceAll("-", ""));
		noticeVO.setNotiEpostHour(notiEndDt.substring(11,13));
		noticeVO.setNotiEpostMinute(notiEndDt.substring(14,16));
		
		noticeVO.setNotiCont(replaceHtmlTag(noticeVO.getNotiCont()));
		
		return noticeVO;
	}
	
	public int selectNoticeListCnt(NoticeVO noticeVO) throws Exception {
		return commonDao_oracle.select("Notice.selectNoticeListCnt",noticeVO);
	}
	
	public Map<String, Object> insertNotice(NoticeVO noticeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		noticeVO.setNotiId(KeyGenerator.createCommonShardKey());
		
		int checkCount = 0;
		checkCount =commonDao_oracle.select("Notice.checkTitleDulicate",noticeVO);
			
		if(checkCount > 0) {
			resultMap.put(Constants.RESULT, Constants.EXIST);
		}else{
			if(noticeVO.getFirmVer() !=null && noticeVO.getFirmVer().length() > 0){
				checkCount =commonDao_oracle.select("Notice.checkFirmVerDulicate",noticeVO);
				if(checkCount > 0){
					resultMap.put(Constants.RESULT, Constants.DUPLICATE_FIRM_VER);					
				}else{
					commonDao_oracle.insert("Notice.insertNotice",noticeVO);
					resultMap.put(Constants.RESULT, Constants.YES);
				}
			}else{
				commonDao_oracle.insert("Notice.insertNotice",noticeVO);
				resultMap.put(Constants.RESULT, Constants.YES);
			}
			

		}
		
		return resultMap;
	}
	
	public Map<String, Object> updateNotice(NoticeVO noticeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int checkCount = 0;
		
		checkCount =commonDao_oracle.select("Notice.checkTitleDulicate",noticeVO);
		
		if(checkCount > 0) {
			resultMap.put(Constants.RESULT, Constants.EXIST);
		}else{
			
			if(noticeVO.getFirmVer() !=null && noticeVO.getFirmVer().length() > 0){
				
				checkCount =commonDao_oracle.select("Notice.checkFirmVerDulicate",noticeVO);
				
				if(checkCount > 0){
				
					resultMap.put(Constants.RESULT, Constants.DUPLICATE_FIRM_VER);					
				
				}else{
					int resultCount = commonDao_oracle.update("Notice.updateNotice",noticeVO);
					
					if( resultCount> 0) {
						
						resultMap.put(Constants.RESULT, Constants.YES);
						
					}else{
						
						resultMap.put(Constants.RESULT, Constants.NO);
					}
				}
			}else{
				int resultCount = commonDao_oracle.update("Notice.updateNotice",noticeVO);
				
				if( resultCount> 0) {
					
					resultMap.put(Constants.RESULT, Constants.YES);
					
				}else{
					
					resultMap.put(Constants.RESULT, Constants.NO);
				}
			}
		}

		return resultMap;
	}

	public Map<String, Object> deleteNotice(NoticeVO noticeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int deleteCnt = commonDao_oracle.delete("Notice.deleteNotice",noticeVO);
		
		if(deleteCnt > 0){
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
		}else{
			resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
		}
		return resultMap;
	}
	
	
	
	public String replaceHtmlTag(String value) {
		value = value.replaceAll("&lt;", "<").replaceAll("&gt;", ">");
		value = value.replaceAll("&#40;", "\\(").replaceAll("&#41;", "\\)");
		value = value.replaceAll("&#39;", "'");
		return value;
	}
}
