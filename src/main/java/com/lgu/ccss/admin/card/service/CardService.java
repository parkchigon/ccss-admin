package com.lgu.ccss.admin.card.service;


import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.lgu.ccss.admin.card.domain.CardVO;
import com.lgu.ccss.admin.card.domain.EventCardVO;
import com.lgu.ccss.admin.notice.domain.NoticeVO;


public interface CardService {

	public Map<String, Object> selectCardList(CardVO cardVO) throws Exception ;
	
	public CardVO selectCardDetail(CardVO cardVO) throws Exception ;
	
	public Map<String, Object> insertCard(CardVO cardVO) throws Exception ;
	
	public Map<String, Object> updateCard(CardVO cardVO) throws Exception ;

	public Map<String, Object> deleteCard(CardVO cardVO) throws Exception ;
	
	//이벤트 카드 영역
	public Map<String, Object> selectEventCardList(EventCardVO eventCardVO) throws Exception ;
	
	public EventCardVO selectEventCardDetail(EventCardVO eventCardVO) throws Exception ;
	
	public Map<String, Object> insertEventCard(EventCardVO eventCardVO) throws Exception ;
	
	public Map<String, Object> updateEventCard(EventCardVO eventCardVO) throws Exception ;

	public Map<String, Object> deleteEventCard(EventCardVO eventCardVO) throws Exception ;
	
	public Map<String, Object> insertEventCardImg(EventCardVO eventCardVO) throws Exception ;
	//public boolean saveFile(String savePath, MultipartFile multipartFile) throws Exception ;
	
	
	//Card Order
	public Map<String, Object> selectCardOrderList(CardVO CardVO) throws Exception;
	
	public Map<String, Object> selectLastModiInfo(CardVO CardVO) throws Exception;
	
}
