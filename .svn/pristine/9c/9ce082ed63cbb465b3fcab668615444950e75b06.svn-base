package com.lgu.ccss.admin.card.service;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.board.domain.BoardVO;
import com.lgu.ccss.admin.card.domain.CardVO;
import com.lgu.ccss.admin.card.domain.EventCardVO;
import com.lgu.ccss.admin.login.controller.LoginController;
import com.lgu.ccss.admin.notice.domain.NoticeVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.Constants.ResultCode;
import com.lgu.ccss.common.utility.FileUtils;
import com.lgu.ccss.common.utility.keygenerator.KeyGenerator;

import devonframe.dataaccess.CommonDao;

@Service("cardService")
public class CardServiceImpl implements CardService{
	
	private static final Logger logger = LoggerFactory.getLogger(CardServiceImpl.class);
	
	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;
	
	@Value("#{config['upload.eventCardImg.path']}")
	private String uploadEventCardImgPath;
	
	@Value("#{config['upload.noticeCardImg.path']}")
	private String uploadNoticeCardImgPath;
	
	@Value("#{config['download.eventCardImg.url']}")
	private String downLoadEventCardImgUrl;
	
	@Value("#{config['download.noticeCardImg.url']}")
	private String downLoadNoticeCardImgUrl;
	

	
	/**
	 * 카드 리스트 조회
	 * @param cardVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCardList(CardVO cardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
	
		List<CardVO> resultList = commonDao_oracle.selectList("Card.selectCardList",cardVO);
		
		/*
		for(CardVO tmpVO : resultList){
			tmpVO.setCardNm(replaceHtmlTag(tmpVO.getCardNm()));
		}
		*/
		
		int totalCount = commonDao_oracle.select("Card.selectCardListCnt",cardVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	

	public CardVO selectCardDetail(CardVO cardVO) throws Exception {
		cardVO = commonDao_oracle.select("Card.selectCardDetail",cardVO);
		
		/*String pushStartDt = noticeVO.getPushStartDt();
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
		
		noticeVO.setNotiCont(replaceHtmlTag(noticeVO.getNotiCont()));*/
		
		return cardVO;
	}
	
	public int selectCardListCnt(CardVO cardVO) throws Exception {
		return commonDao_oracle.select("Card.selectCardListCnt",cardVO);
	}
	
	public Map<String, Object> insertCard(CardVO cardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		cardVO.setCardId(KeyGenerator.createCommonShardKey());
		
		
		//서비스 카드명 중복 체크
		int resultCount = commonDao_oracle.select("Card.checkCardName",cardVO);
		
		if( resultCount> 0) {
			//중복
			resultMap.put(Constants.RESULT, Constants.DUPLICATE_CARD_NAME);
			return resultMap;
		}else{
			
			String fixYn = cardVO.getFixYn();
			
			if(fixYn.equals("Y")){
				int count = commonDao_oracle.select("Card.checkCardNumDuplication",cardVO);
				
				if( count> 0) {
					//중복
					resultMap.put(Constants.RESULT, Constants.DUPLICATE_CARD_SROT_NUM);
					return resultMap;
				}	
			}else{
				cardVO.setCardSortNum(0);
			}
		}
		commonDao_oracle.insert("Card.insertCard",cardVO);
		resultMap.put(Constants.RESULT, Constants.YES);
		return resultMap;
	}
	
	public Map<String, Object> updateCard(CardVO cardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//서비스 카드명 중복 체크
		int checkCount = commonDao_oracle.select("Card.checkCardName",cardVO);
		
		if( checkCount> 0) {
			//중복
			resultMap.put(Constants.RESULT, Constants.DUPLICATE_CARD_NAME);
			return resultMap;
		}else{
			
			String fixYn = cardVO.getFixYn();
			
			if(fixYn.equals("Y")){
				int count = commonDao_oracle.select("Card.checkCardNumDuplication",cardVO);
				
				if( count> 0) {
					//중복
					resultMap.put(Constants.RESULT, Constants.DUPLICATE_CARD_SROT_NUM);
					return resultMap;
				}	
			}else{
				cardVO.setCardSortNum(0);
			}
		}
		
		int resultCount = commonDao_oracle.update("Card.updateCard",cardVO);
		
		if( resultCount> 0) {
			
			resultMap.put(Constants.RESULT, Constants.YES);
			
		}else{
			
			resultMap.put(Constants.RESULT, Constants.NO);
		}
		
		return resultMap;
	}

	public Map<String, Object> deleteCard(CardVO cardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		boolean incluedFixCard = false;
		
		List<CardVO> checkFixCard = commonDao_oracle.selectList("Card.checkFixCardList",cardVO);
		
		for(CardVO tempVO :  checkFixCard){
			String fixYn = tempVO.getFixYn();
			
			if(fixYn.equals("Y")){
				incluedFixCard = true;
				break;
			}
		}
		
		if(incluedFixCard){
			resultMap.put("resultCode", ResultCode.RESULT_CODE_3000.getCode());
		}else{
			int deleteCnt = commonDao_oracle.delete("Card.deleteCard",cardVO);
			
			if(deleteCnt > 0){
				resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
			}else{
				resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
			}
		}
		
		return resultMap;
	}
	
	
	/**
	 * 이벤트 카드 리스트 조회
	 * @param EventCardVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectEventCardList(EventCardVO eventCardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
	
		List<NoticeVO> resultList = commonDao_oracle.selectList("Card.selectEventCardList",eventCardVO);
		

		int totalCount = commonDao_oracle.select("Card.selectEventCardListCnt",eventCardVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	
	
	public EventCardVO selectEventCardDetail(EventCardVO eventCardVO) throws Exception {
		eventCardVO= commonDao_oracle.select("Card.selectEventCardDetail",eventCardVO);
		
		System.out.println("################################################");
		System.out.println(eventCardVO.getEventCardType());
		System.out.println("################################################");
		
		// 이벤트카드유형이 '프로모션'일 경우 이미지 파일 구분
		if (eventCardVO.getEventCardType().equals("02") && eventCardVO.getEventCardUrl() != null 
				&& eventCardVO.getEventCardUrl().split(";").length == 2) {
			String eventCardUrl = eventCardVO.getEventCardUrl();
			eventCardVO.setEventCardUrl(eventCardUrl.split(";")[0]);
			eventCardVO.setEventCardUrlPm(eventCardUrl.split(";")[1]);
		}
		
		String exposureStartDt = eventCardVO.getExposureStartDt();
		String exposureEndDt = 	eventCardVO.getExposureEndDt();

		eventCardVO.setSpostDate(exposureStartDt.substring(0,10).replaceAll("-", ""));
		eventCardVO.setEpostDate(exposureEndDt.substring(0,10).replaceAll("-", ""));
		
		return eventCardVO;
	}
	
	public int selectEventCardListCnt(EventCardVO eventCardVO) throws Exception {
		return commonDao_oracle.select("Card.selectEventCardListCnt",eventCardVO);
	}
	
	public Map<String, Object> insertEventCard(EventCardVO eventCardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		eventCardVO.setEventCardId(KeyGenerator.createCommonShardKey());
		String fileNm = eventCardVO.getEventCardUrl();
		
		eventCardVO.setCardImgFileName(fileNm.substring(fileNm.lastIndexOf("/")+1));
		
		// 이벤트카드 유형이 프로모션일 경우 프로모션 URL을 "EVENT_CARD_URL"에 ';'구분하여 추가 입력
		if (eventCardVO.getEventCardType()!=null && eventCardVO.getEventCardType().equals("02")) {
			eventCardVO.setEventCardUrl(eventCardVO.getEventCardUrl().concat(";").concat(eventCardVO.getEventCardUrlPm()));
		}
		
		commonDao_oracle.insert("Card.insertEventCard",eventCardVO);
		resultMap.put(Constants.RESULT, Constants.YES);
		return resultMap;
	}
	
	public Map<String, Object> updateEventCard(EventCardVO eventCardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		
		int resultCount = commonDao_oracle.update("Card.updateEventCard",eventCardVO);
		
		if( resultCount> 0) {
			
			resultMap.put(Constants.RESULT, Constants.YES);
			
		}else{
			
			resultMap.put(Constants.RESULT, Constants.NO);
		}
		
		return resultMap;
	}

	public Map<String, Object> deleteEventCard(EventCardVO eventCardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<EventCardVO> delFileNameList =  commonDao_oracle.selectList("Card.selectDeleteEventCardFileNm",eventCardVO);
		
	
		
		System.out.println("delFileNameList size:" +delFileNameList.size());
		int deleteCnt = commonDao_oracle.delete("Card.deleteEventCard",eventCardVO);
		
		if(deleteCnt > 0){
			
			for(EventCardVO tempVO : delFileNameList){
				String delFileNm = tempVO.getCardImgFileName();
			
				FileUtils.deleteFile(uploadEventCardImgPath, delFileNm);
			}
				
			
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
		}else{
			resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
		}
		
		return resultMap;
	}
	
	
	public Map<String, Object> insertEventCardImg(EventCardVO eventCardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		MultipartFile uploadfile = eventCardVO.getUploadfile();

		String fileName="";

		if (uploadfile != null) {
			fileName = uploadfile.getOriginalFilename();
			
	        // 이미지 확장자 필터링
			boolean allowExt = false;
	        String[] extension = {"jpg", "gif", "jpeg", "png"};
	        // 이미지 확장자를 가진 파일만 통과 시킨다.
	        for(int i=0; i<extension.length; i++) {
	            if(fileName.endsWith("."  + extension[i])) {
	            	allowExt = true;
	            }
	        }

	        if (!allowExt) {
				//업로드 이미자 확장자 미일지
				resultMap.put(Constants.RESULT, Constants.NOT_ALLOW_FILE_EXT);
				eventCardVO.setUploadfile(null);
				return resultMap;
	        }
			
			boolean resultFlag = saveFile(uploadEventCardImgPath, uploadfile);
			
			if (resultFlag){
				
				String eventCardURL = downLoadEventCardImgUrl + uploadfile.getOriginalFilename();
				resultMap.put(Constants.RESULT, Constants.YES);				
				resultMap.put(Constants.RESULT_DATA, eventCardURL);
				
			} else {
				logger.error("## Event Card File save failed.");
				resultMap.put(Constants.RESULT, Constants.NO);
			}

			eventCardVO.setUploadfile(null);
		}else{
			//notting
		}
				
		return resultMap;
	}
		
	public boolean saveFile(String savePath, MultipartFile multipartFile) {
		boolean isResult = false;
		try {
			
			if (!new File(savePath).exists())
				new File(savePath).mkdirs();
			
			File saveFile = new File(savePath + multipartFile.getOriginalFilename());
		
			multipartFile.transferTo(saveFile);
		
			isResult = true;
		} catch (Exception e)
		{
			logger.error("Evenr Card File Upload Fail : " + e.getMessage(), e);
		}
		return isResult;
	}
	
	
	public Map<String, Object> selectCardOrderList(CardVO cardVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<CardVO> resultList = commonDao_oracle.selectList("Card.selectCardOrderList",cardVO);
		
		resultMap.put("resultList", resultList);
		
		return resultMap;
	}
	
	public Map<String, Object> selectLastModiInfo(CardVO cardVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		CardVO lastUpdateInfo = commonDao_oracle.select("Card.selectLastModiInfo",cardVO);
		
		resultMap.put("lastUpdateInfo", lastUpdateInfo);
		
		return resultMap;
	}
	
	
	@Transactional
	public Map<String, Object> updateCardOrder(CardVO cardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try{
			//기존 카드 순서 리셋 
			commonDao_oracle.update("Card.cardOrderReset",cardVO);
			for(int idx =0; idx < cardVO.getCardOrderKeyList().length; idx++){
				
				
				CardVO tempVO = new CardVO();
				tempVO.setCardId(cardVO.getCardOrderKeyList()[idx]);
				
				tempVO.setCardSortNum(Integer.parseInt(cardVO.getCardOrderValueList()[idx]));
				tempVO.setUpdId(cardVO.getUpdId());
				
				System.out.println("tempVO:" + tempVO.toString());
				commonDao_oracle.update("Card.updateCardOrder",tempVO);
				System.out.println(cardVO.getCardOrderKeyList()[idx] + " : " + Integer.parseInt(cardVO.getCardOrderValueList()[idx]));
			}
			resultMap.put(Constants.RESULT, Constants.YES);
		}catch(Exception e){
			resultMap.put(Constants.RESULT, Constants.NO);
		}
		
		return resultMap;
	}
	
	
	public Map<String, Object> insertNoticeCardImg(EventCardVO eventCardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		MultipartFile uploadfile = eventCardVO.getUploadfile();


		String fileName="";

		if (uploadfile != null) {
			fileName = uploadfile.getOriginalFilename();

	        // 이미지 확장자 필터링
			boolean allowExt = false;
	        String[] extension = {"jpg", "gif", "jpeg", "png"};
	        // 이미지 확장자를 가진 파일만 통과 시킨다.
	        for(int i=0; i<extension.length; i++) {
	            if(fileName.endsWith("."  + extension[i])) {
	            	allowExt = true;
	            }
	        }

	        if (!allowExt) {
				//업로드 이미자 확장자 미일지
				resultMap.put(Constants.RESULT, Constants.NOT_ALLOW_FILE_EXT);
				eventCardVO.setUploadfile(null);
				return resultMap;
	        }
			
			boolean resultFlag = saveFile(uploadNoticeCardImgPath, uploadfile);
			
			if (resultFlag){
				
				String eventCardURL = downLoadNoticeCardImgUrl + uploadfile.getOriginalFilename();
				resultMap.put(Constants.RESULT, Constants.YES);				
				resultMap.put(Constants.RESULT_DATA, eventCardURL);
				
			} else {
				logger.error("## Event Card File save failed.");
				resultMap.put(Constants.RESULT, Constants.NO);
			}

			eventCardVO.setUploadfile(null);
		}else{
			//notting
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
