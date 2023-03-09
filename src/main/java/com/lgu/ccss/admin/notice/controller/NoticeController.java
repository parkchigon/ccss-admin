package com.lgu.ccss.admin.notice.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.lgu.ccss.admin.app.domain.AppVO;
import com.lgu.ccss.admin.notice.domain.NoticeVO;
import com.lgu.ccss.admin.notice.service.NoticeServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;

import devonframe.util.NullUtil;

@Controller
@RequestMapping(value = "/notice")
public class NoticeController {
	
    @Resource(name = "noticeService")
	private NoticeServiceImpl noticeService;

	@Autowired
	private PageUtil pageUtil;
	
	/**
	 * Notice 리스트 조회
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/noticeList.do")
	public String noticeList(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		return "/notice/noticeList";
    }
	
	/**
	 * Notice 리스트 조회(Ajax)
	 * 
	 * @param request
	 * @param noticeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectNoticeList.do", method = RequestMethod.POST)
	public Map<String, Object> selectNoticeList(HttpServletRequest request, NoticeVO noticeVO) throws Exception {
		noticeVO.setPageRowCount(Constants.PAGING_CNT_TEN);
		Map<String, Object> resultMap = noticeService.selectNoticeList(noticeVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(noticeVO.getPage(), pageUtil.getTotalPage(totalCount, noticeVO.getPageRowCount()), noticeVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);
		return resultMap;
	}
	
	/**
	 * Notice 삭제
	 * @param request
	 * @param response
	 * @param noticeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteNotice.do")
	public Map<String, Object> deleteNotice(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap   = noticeService.deleteNotice(noticeVO);
		return resultMap;
		
	}
	
	/**
	 * 공지사항 등록 화면
	 * 
	 * @param request
	 * @param response
	 * @param noticeVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/noticeInsertForm.do")
	public String noticeInsertForm(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO, ModelMap model) throws Exception {
		return "/notice/noticeInsertForm";
	}
	
	/**
	 * 공지사항 정보 수정 화면
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/noticeEditForm.do")
	public String noticeEditForm(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO, ModelMap model) throws Exception {
		noticeVO = noticeService.selectNoticeDetail(noticeVO);
		model.addAttribute("noticeVO", noticeVO);
		return "/notice/noticeEditForm";
	}
	
	
	
	/**
	 * 신규 공지사항 정보 등록
	 * @param request
	 * @param response
	 * @param noticeVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/insertNotice.do")
	public Map<String, Object> insertNotice(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO) throws Exception {
		noticeVO.setRegId(SessionUtil.getLoginId(request));
		noticeVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = noticeService.insertNotice(noticeVO);
		return resultMap;
	}
	
	/**
	 * 공지사항 상세 화면
	 * 
	 * @param request
	 * @param response
	 * @param noticeVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/noticeDetail.do")
	public String noticeDetail(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO, ModelMap model) throws Exception {
		noticeVO = noticeService.selectNoticeDetail(noticeVO);
		model.addAttribute("noticeVO", noticeVO);
		return "/notice/noticeDetail";
	}
	
	
	/**
	 * 공지사항 정보 수정
	 * 
	 * @param request
	 * @param response
	 * @param appVO
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/updateNotice.do")
	public Map<String, Object> updateNotice(HttpServletRequest request, HttpServletResponse response, NoticeVO noticeVO) throws Exception {
		noticeVO.setUpdId(SessionUtil.getLoginId(request));
		Map<String, Object> resultMap = noticeService.updateNotice(noticeVO);
		return resultMap;
	}
}
