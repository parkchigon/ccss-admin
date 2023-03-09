package com.lgu.ccss.admin.card.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.lgu.ccss.admin.app.domain.AppVO;
import com.lgu.ccss.admin.card.domain.CardVO;
import com.lgu.ccss.admin.card.domain.EventCardVO;
import com.lgu.ccss.admin.card.service.CardServiceImpl;
import com.lgu.ccss.admin.notice.domain.NoticeVO;
import com.lgu.ccss.admin.notice.service.NoticeServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;

import devonframe.util.NullUtil;

@Controller
@RequestMapping(value = "/card")
public class CardController {
	
	@Resource(name = "cardService")
	private CardServiceImpl cardService;
	
	@Resource(name = "noticeService")
	private NoticeServiceImpl noticeService;

	@Autowired
	private PageUtil pageUtil;
	
	/**
	 * Card 리스트 조회 화면
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardList.do")
	public String cardList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/card/cardList";
    }
	
	/**
	 * 카드 리스트 조회(Ajax)
	 * 
	 * @param request
	 * @param cardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCardList.do", method = RequestMethod.POST)
	public Map<String, Object> selectCardList(HttpServletRequest request, CardVO cardVO) throws Exception {
		if(String.valueOf(cardVO.getPageRowCount()) == null){
			cardVO.setPageRowCount(Constants.PAGING_CNT_TEN);			
		}
		Map<String, Object> resultMap = cardService.selectCardList(cardVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(cardVO.getPage(), pageUtil.getTotalPage(totalCount, cardVO.getPageRowCount()), cardVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);
		return resultMap;
	}
	
	/**
	 * 카드 오더 리스트 조회(Ajax)
	 * 
	 * @param request
	 * @param cardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCardOrderList.do", method=RequestMethod.POST)
	public Map<String, Object> selectCardOrderList(HttpServletRequest request, CardVO cardVO) throws Exception {
		
		Map<String, Object> resultMap = cardService.selectCardOrderList(cardVO);
		

		return resultMap;
	}
	
	/**
	 * 카드  삭제
	 * @param request
	 * @param response
	 * @param cardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteCard.do")
	public Map<String, Object> deleteCard(HttpServletRequest request, HttpServletResponse response, CardVO cardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = cardService.deleteCard(cardVO);
		return resultMap;
		
	}
	
	/**
	 * 카드  등록 화면
	 * 
	 * @param request
	 * @param response
	 * @param cardVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardInsertForm.do")
	public String cardInsertForm(HttpServletRequest request, HttpServletResponse response, CardVO cardVO, ModelMap model) throws Exception {
		return "/card/cardInsertForm";
	}
	
	/**
	 * 카드 정보 수정 화면
	 * 
	 * @param request
	 * @param response
	 * @param cardVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardEditForm.do")
	public String cardEditForm(HttpServletRequest request, HttpServletResponse response, CardVO cardVO, ModelMap model) throws Exception {
		cardVO = cardService.selectCardDetail(cardVO);
		model.addAttribute("cardVO", cardVO);
		return "/card/cardEditForm";
	}
	
	
	
	/**
	 * 신규 카드 정보 등록
	 * @param request
	 * @param response
	 * @param cardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertCard.do")
	public Map<String, Object> insertCard(HttpServletRequest request, HttpServletResponse response, CardVO cardVO) throws Exception {
		cardVO.setRegId(SessionUtil.getLoginId(request));
		cardVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = cardService.insertCard(cardVO);
		return resultMap;
	}
	
	/**
	 * 카드 상세 화면
	 * 
	 * @param request
	 * @param response
	 * @param cardVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardDetail.do")
	public String cardDetail(HttpServletRequest request, HttpServletResponse response, CardVO cardVO, ModelMap model) throws Exception {
		cardVO = cardService.selectCardDetail(cardVO);
		model.addAttribute("cardVO", cardVO);
		return "/card/cardDetail";
	}
	
	
	/**
	 * 카드 정보 정보 수정
	 * 
	 * @param request
	 * @param response
	 * @param cardVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/updateCard.do")
	public Map<String, Object> updateNotice(HttpServletRequest request, HttpServletResponse response, CardVO cardVO) throws Exception {
		cardVO.setUpdId(SessionUtil.getLoginId(request));
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = cardService.updateCard(cardVO);
		return resultMap;
	}
	
	
	
	//--------------------------------------------------------------------------------------------------//
	//-----------------------------------     Event Card             ------------------------------------//
	//--------------------------------------------------------------------------------------------------//
	//--------------------------------------------------------------------------------------------------//
	
	/**
	 * Event Card 리스트 조회 화면
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/eventCardList.do")
	public String eventCardList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/card/eventCardList";
    }
	
	/**
	 * 이벤트 카드 리스트 조회(Ajax)
	 * 
	 * @param request
	 * @param eventCardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectEventCardList.do", method = RequestMethod.POST)
	public Map<String, Object> selectEventCardList(HttpServletRequest request, EventCardVO eventCardVO) throws Exception {
		eventCardVO.setPageRowCount(Constants.PAGING_CNT_TEN);
		Map<String, Object> resultMap = cardService.selectEventCardList(eventCardVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(eventCardVO.getPage(), pageUtil.getTotalPage(totalCount, eventCardVO.getPageRowCount()), eventCardVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);
		return resultMap;
	}
	
	
	
	/**
	 * 이벤트 카드  삭제
	 * @param request
	 * @param response
	 * @param eventCardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteEventCard.do")
	public Map<String, Object> deleteEventCard(HttpServletRequest request, HttpServletResponse response, EventCardVO eventCardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = cardService.deleteEventCard(eventCardVO);
		return resultMap;
		
	}
	
	/**
	 * 이벤트 카드  등록 화면
	 * 
	 * @param request
	 * @param response
	 * @param eventCardVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/eventCardInsertForm.do")
	public String eventCardInsertForm(HttpServletRequest request, HttpServletResponse response, EventCardVO eventCardVO, ModelMap model) throws Exception {
		return "/card/eventCardInsertForm";
	}
	
	/**
	 * 이벤트 카드 정보 수정 화면
	 * 
	 * @param request
	 * @param response
	 * @param eventCardVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/eventCardEditForm.do")
	public String eventCardEditForm(HttpServletRequest request, HttpServletResponse response, EventCardVO eventCardVO, ModelMap model) throws Exception {
		eventCardVO = cardService.selectEventCardDetail(eventCardVO);
		model.addAttribute("eventCardVO", eventCardVO);
		return "/card/eventCardEditForm";
	}
	
	
	
	/**
	 * 신규 이벤트 카드 정보 등록
	 * @param request
	 * @param response
	 * @param eventCardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertEventCard.do")
	public Map<String, Object> insertEventCard(HttpServletRequest request, HttpServletResponse response, EventCardVO eventCardVO) throws Exception {
		eventCardVO.setRegId(SessionUtil.getLoginId(request));
		eventCardVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = cardService.insertEventCard(eventCardVO);
		return resultMap;
	}
	
	/**
	 * 이벤트 카드 상세 화면
	 * 
	 * @param request
	 * @param response
	 * @param eventCardVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/eventCardDetail.do")
	public String eventCardDetail(HttpServletRequest request, HttpServletResponse response, EventCardVO eventCardVO, ModelMap model) throws Exception {
		eventCardVO = cardService.selectEventCardDetail(eventCardVO);
		model.addAttribute("eventCardVO", eventCardVO);
		return "/card/eventCardDetail";
	}
	
	
	/**
	 * 이벤트 카드 정보 정보 수정
	 * 
	 * @param request
	 * @param response
	 * @param eventCardVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/updateEventCard.do")
	public Map<String, Object> updateEventCard(HttpServletRequest request, HttpServletResponse response, EventCardVO eventCardVO) throws Exception {
		eventCardVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = cardService.updateEventCard(eventCardVO);
		return resultMap;
	}
	
	/**
	 * 이벤트 카드 이미지 등록
	 * 
	 * @param request
	 * @param response
	 * @param eventCardVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/insertEventCardImg.do" ,produces = "application/json; charset=utf-8")
	public Map<String, Object> insertEventCardImg(HttpServletRequest request, HttpServletResponse response, EventCardVO eventCardVO) throws Exception {
		Map<String, Object> resultMap = cardService.insertEventCardImg(eventCardVO);
		return resultMap;
		
	}
	
	//--------------------------------------------------------------------------------------------------//
	//-----------------------------------     Card Order             -----------------------------------//
	//--------------------------------------------------------------------------------------------------//
	//--------------------------------------------------------------------------------------------------//
	
	/**
	 * Card Order 리스트 조회 화면
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardOrderManagementList.do")
	public String cardOrderManagementList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/card/cardOrderManagementList";
	}

	
	/**
	 * 카드 정보 순서 정보 수정
	 * 
	 * @param request
	 * @param response
	 * @param cardVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/updateCardOrder.do")
	public Map<String, Object> updateCardOrder(HttpServletRequest request, HttpServletResponse response, CardVO cardVO) throws Exception {
		cardVO.setUpdId(SessionUtil.getLoginId(request));
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = cardService.updateCardOrder(cardVO);
		return resultMap;
	}
	
	
	/**
	 * 카드 정보 순서 정보 수정
	 * 
	 * @param request
	 * @param response
	 * @param cardVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/selectLastModiInfo.do")
	public Map<String, Object> selectLastModiInfo(HttpServletRequest request, HttpServletResponse response, CardVO cardVO) throws Exception {
		cardVO.setUpdId(SessionUtil.getLoginId(request));
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, Object> resultMap = cardService.selectLastModiInfo(cardVO);
		return resultMap;
	}
	//--------------------------------------------------------------------------------------------------//
	//-----------------------------------     Card Notice             ------------------------------------//
	//--------------------------------------------------------------------------------------------------//
	//--------------------------------------------------------------------------------------------------//
	
	/**
	 * Card Notice 리스트 조회
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardNoticeList.do")
	public String noticeList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/card/cardNoticeList";
    }
	
	/**
	 * Card Notice 리스트 조회(Ajax)
	 * 
	 * @param request
	 * @param noticeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectCardNoticeList.do", method = RequestMethod.POST)
	public Map<String, Object> selectCardNoticeList(HttpServletRequest request, NoticeVO noticeVO) throws Exception {
		noticeVO.setPageRowCount(Constants.PAGING_CNT_TEN);
		
		noticeVO.setServiceExposure("D001");
		
		Map<String, Object> resultMap = noticeService.selectNoticeList(noticeVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(noticeVO.getPage(), pageUtil.getTotalPage(totalCount, noticeVO.getPageRowCount()), noticeVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);
		return resultMap;
	}
	
	/**
	 * Card Notice 삭제
	 * @param request
	 * @param response
	 * @param noticeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteCardNotice.do")
	public Map<String, Object> deleteNotice(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = noticeService.deleteNotice(noticeVO);
		return resultMap;
		
	}
	
	/**
	 * Card 공지사항 등록 화면
	 * 
	 * @param request
	 * @param response
	 * @param noticeVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardNoticeInsertForm.do")
	public String noticeInsertForm(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO, ModelMap model) throws Exception {
		return "/card/cardNoticeInsertForm";
	}
	
	/**
	 * Card 공지사항 정보 수정 화면
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardNoticeEditForm.do")
	public String cardNoticeEditForm(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO, ModelMap model) throws Exception {
		noticeVO = noticeService.selectNoticeDetail(noticeVO);
		model.addAttribute("noticeVO", noticeVO);
		return "/card/cardNoticeEditForm";
	}
	
	
	
	/**
	 * 신규 Card 공지사항 정보 등록
	 * @param request
	 * @param response
	 * @param noticeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertCardNotice.do")
	public Map<String, Object> insertCardNotice(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO) throws Exception {
		noticeVO.setRegId(SessionUtil.getLoginId(request));
		noticeVO.setUpdId(SessionUtil.getLoginId(request));
		
		Map<String, Object> resultMap = noticeService.insertNotice(noticeVO);
		return resultMap;
	}
	
	/**
	 * Card 공지사항 상세 화면
	 * 
	 * @param request
	 * @param response
	 * @param noticeVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardNoticeDetail.do")
	public String cardNoticeDetail(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO, ModelMap model) throws Exception {
		noticeVO = noticeService.selectNoticeDetail(noticeVO);
		model.addAttribute("noticeVO", noticeVO);
		return "/card/cardNoticeDetail";
	}
	
	
	/**
	 * Card 공지사항 정보 수정
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/updateCardNotice.do")
	public Map<String, Object> updateCardNotice(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO) throws Exception {
		noticeVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = noticeService.updateNotice(noticeVO);
		return resultMap;
	}
	
	
	
	/**
	 * 이벤트 카드 이미지 등록
	 * 
	 * @param request
	 * @param response
	 * @param eventCardVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/insertNoticeCardImg.do" ,produces = "application/json; charset=utf-8")
	public Map<String, Object> inserNoticeCardImg(HttpServletRequest request, HttpServletResponse response, EventCardVO eventCardVO) throws Exception {
		Map<String, Object> resultMap = cardService.insertNoticeCardImg(eventCardVO);
		return resultMap;
		
	}
}
