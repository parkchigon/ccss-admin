package com.lgu.ccss.admin.board.controller;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.lgu.ccss.admin.board.domain.BoardMstVO;
import com.lgu.ccss.admin.board.domain.BoardVO;
import com.lgu.ccss.admin.board.service.BoardServiceImpl;
import com.lgu.ccss.admin.file.domain.FileInfoVO;
import com.lgu.ccss.admin.file.service.FileInfoServiceImpl;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.ExcelUtilRowhandler;
import com.lgu.ccss.common.utility.FileImageUtil;
import com.lgu.ccss.common.utility.FileUtil;
import com.lgu.ccss.common.utility.PageUtil;
import com.lgu.ccss.common.utility.SessionUtil;
import com.lgu.ccss.common.utility.StringUtil;

import devonframe.util.NullUtil;


@Controller
@RequestMapping(value = "/board")
public class BoardController {
	
    @Resource(name = "boardService")
	private BoardServiceImpl boardService;
	
    @Resource(name = "fileInfoService")
	private FileInfoServiceImpl fileService;
	
	@Autowired
	private PageUtil pageUtil;
	
	@Value("${upload.filePath}")
    private String filePath;
	
	@Value("${upload.uploadFilePath}")
    private String uploadFilePath;
	
	@Autowired
	private FileImageUtil fileImageUtil;
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 게시판 
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	
	/**
	 * 게시판 리스트 화면
	 * 
	 * @param request
	 * @param boardVO
	 * @param bdType
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{bdType}List.do")
    public String boardList(HttpServletRequest request, @ModelAttribute("boardVO") BoardVO boardVO, @PathVariable("bdType") String bdType
    		, ModelMap model) throws Exception {
		
		// 게시판 마스터 코드 설정
		BoardMstVO boardMstVO = selectBoardMstInfo(bdType);

		// 게시판 마스터 코드 미등록된 경우 처리
		if (boardMstVO == null) {
			return "forward:/HistoryBack.do";
		}
		
		if(Constants.BoardMstId.BANNER.equals(boardMstVO.getBoardMstId())){
			List<BoardVO>  boardList = boardService.selectBoardTopBannerList(boardMstVO);
			model.addAttribute("bannerImgList", boardList);
		}
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("boardMstVO", boardMstVO);
				
        return boardMstVO.getListUrl();
    }
	
	
	/**
	 * 게시판 리스트 조회
	 * 
	 * @param request
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{bdType}ListAjax.do")
    public Map<String, Object> selectBoardList(HttpServletRequest request, BoardVO boardVO) throws Exception {
		Map<String, Object> resultMap = boardService.selectBoardList(boardVO);
		int totalCount = (int)resultMap.get(Constants.TOTAL_COUNT);
		String paging = pageUtil.getPagingString(boardVO.getPage(), pageUtil.getTotalPage(totalCount, boardVO.getPageRowCount()), boardVO.getPageRowCount(), Constants.GO_SEARCH);
		
		resultMap.put(Constants.PAGING, paging);
        
        return resultMap;
	}
	
	
	/**
	 * 게시판 등록/수정 화면
	 * 
	 * @param request
	 * @param boardVO
	 * @param bdType
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{bdType}EditForm.do")
    public String boardEditForm(HttpServletRequest request, @ModelAttribute("boardVO") BoardVO boardVO, @PathVariable("bdType") String bdType
    		, ModelMap model) throws Exception {
		
		// 게시판 마스터 코드 설정
		BoardMstVO boardMstVO = selectBoardMstInfo(bdType);
		
		// 게시판 마스터 코드 미등록된 경우 처리
		if (boardMstVO == null) {
			return "forward:/HistoryBack.do";
		}
		
		if(!NullUtil.isNone(boardVO.getBoardId())) { // 수정 화면
			boardVO.setBoardMstId(bdType);
			boardVO = boardService.selectBoardDetail(boardVO);
			
//			if(boardVO.getFileInfoVO() != null) {
//				FileInfoVO fileInfoVO = new FileInfoVO();
//				fileInfoVO.setFilePath(fileImageUtil.getNoticeImageUrl(boardVO.getFileInfoVO().getSaveFileName().substring(0, boardVO.getFileInfoVO().getSaveFileName().lastIndexOf(".")), FileUtil.getExtention(boardVO.getFileInfoVO().getSaveFileName())));
//				fileInfoVO.setOriginFileName(boardVO.getFileInfoVO().getOriginFileName());
//				fileInfoVO.setSaveFileName(boardVO.getFileInfoVO().getSaveFileName());
//				boardVO.setFileInfoVO(fileInfoVO);
//			}
		}
		
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("boardMstVO", boardMstVO);
		if(Constants.BoardMstId.NOTICE.equals(bdType)){
			BoardVO boardVO2 = new BoardVO();
			boardVO2.setFixYn("Y");
			boardVO2.setUseYn("Y");
			boardVO2.setBoardMstId(bdType);
			model.addAttribute("fixCount",boardService.selectBoardListCnt(boardVO2));
		}else if(Constants.BoardMstId.BANNER.equals(bdType)){
			BoardVO boardVO2 = new BoardVO();
			boardVO2.setUseYn("Y");
			boardVO2.setBoardMstId(bdType);
			boardVO2.setSearchDateDiv("REALPOSTBANNER");
			model.addAttribute("bannerCount",boardService.selectBoardListCnt(boardVO2));
		}
		return boardMstVO.getRegUrl();
	}

	
	/**
	 * 게시판 등록/수정
	 * 
	 * @param request
	 * @param boardVO
	 * @param bdType
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{bdType}Edit.do")
    public String editBoard(HttpServletRequest request, @ModelAttribute("boardVO") BoardVO boardVO, @PathVariable("bdType") String bdType
    		, ModelMap model) throws Exception {
		
		
		
		// 게시판 마스터 코드 설정
		BoardMstVO boardMstVO = selectBoardMstInfo(bdType);
		
		// 게시판 마스터 코드 미등록된 경우 처리
		if (boardMstVO == null) {
			return "forward:/HistoryBack.do";
		}
		
		//String filePath = request.getSession().getServletContext().getRealPath("/") + "images/";
		//String filePath = "C://images/";
		String fileSeq = "";
		// 파일이 존재할경우
		if(!boardVO.getUploadfile().isEmpty() && !StringUtil.isEmpty(boardVO.getOriginFileName())) {
			String filePathName = filePath + bdType+"/";
			
			FileInfoVO fileInfoVO = new FileInfoVO();
			if (bdType.equals("appversion")) { 
				fileInfoVO = FileUtil.uploadMultipartFile(boardVO.getUploadfile(), filePathName, Constants.NO, Constants.Table.TB_BOARD);
			}else {
				fileInfoVO = FileUtil.uploadMultipartFile(boardVO.getUploadfile(), filePathName, Constants.YES, Constants.Table.TB_BOARD);
			}
			fileInfoVO.setUploadId(SessionUtil.getLoginId(request));
			
			fileSeq = fileService.insertFileInfo(fileInfoVO);
			boardVO.setOpt1(fileSeq);
		}else if(boardVO.getUploadfile().isEmpty() && StringUtil.isEmpty(boardVO.getOriginFileName())){
			boardVO.setOpt1(fileSeq);
		}
		
		if (NullUtil.isNone(boardVO.getBoardId())) { // 등록
			boardVO.setInsertId(SessionUtil.getLoginId(request));
			boardService.insertBoard(boardVO);
		} else { // 수정
			boardVO.setUpdateId(SessionUtil.getLoginId(request));
			boardService.updateBoard(boardVO);
		}
		
		return "redirect:"+boardMstVO.getListUrl()+".do";
	}
	
	/**
	 * 게시판 삭제
	 * @param request
	 * @param response
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteBoardAjax.do")
	public Map<String, Object> deleteBoard(HttpServletRequest request, HttpServletResponse response, BoardVO boardVO) throws Exception {
		
		boardService.deleteBoard(boardVO);
		Map<String, Object> result = new HashMap<>();
		return result;
	}
	
	/**
	 * 게시판 정렬 정보 수정
	 * @param request
	 * @param boardList
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{bdType}OrderNoEditAjax.do")
    public Map<String, Object> orderNoEditBoard(HttpServletRequest request,@RequestBody List<BoardVO> boardList) throws Exception {	
		Map<String, Object> resultMap = boardService.updateBoardOrderNo(request,boardList);
	    return resultMap;
	}
	
	/**
	 * 게시판 상세 화면
	 * 
	 * @param request
	 * @param boardVO
	 * @param bdType
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{bdType}Detail.do")
    public String boardDetail(HttpServletRequest request, @ModelAttribute("boardVO") BoardVO boardVO, @PathVariable("bdType") String bdType
    		, ModelMap model) throws Exception {
		
		// 게시판 마스터 코드 설정
		BoardMstVO boardMstVO = selectBoardMstInfo(bdType);
		
		// 게시판 마스터 코드 미등록된 경우 처리
		if (boardMstVO == null) {
			return "forward:/HistoryBack.do";
		}
		boardVO.setBoardMstId(bdType);
		boardVO = boardService.selectBoardDetail(boardVO);
		
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("boardMstVO", boardMstVO);
		
		return boardMstVO.getViewUrl();
	}
	/**
	 * 디테일 정보  가져오기(Ajax)
	 * @param request
	 * @param boardVO
	 * @param bdType
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/{bdType}DetailAjax.do")
    public BoardVO boardDetailAjax(HttpServletRequest request,BoardVO boardVO, @PathVariable("bdType") String bdType) throws Exception {
//		Map<String, Object> resultMap = null;
		boardVO.setBoardMstId(bdType);
		boardVO = boardService.selectBoardDetail(boardVO);
		return boardVO;
	}

	
	/**
	 * 게시판 마스터 정보 조회
	 * 
	 * @param bdType
	 * @return
	 * @throws Exception
	 */
	public BoardMstVO selectBoardMstInfo(String bdType) throws Exception {
		BoardMstVO boardMstVO = new BoardMstVO();

		boardMstVO.setBoardMstId(bdType);
		boardMstVO = boardService.selectBoardMstInfo(boardMstVO);

		return boardMstVO;
	}
	
	
	/**
	 * 게시판 엑셀 다운로드
	 *  
	 * @param request
	 * @param response
	 * @param boardVO
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping(value = "/boardListExcel.do")
	public void boardListExcel(HttpServletRequest request, HttpServletResponse response, @ModelAttribute("boardVO") BoardVO boardVO,
			ModelMap model) throws Exception {
		
		boardVO.setExcelDownYn(Constants.YES);
		
		ExcelUtilRowhandler excelUtilRowhandler = new ExcelUtilRowhandler();
		
		LinkedHashMap<String, String> headerMap = new LinkedHashMap<String, String>();
		headerMap.put("boardId", "게시판ID");
		headerMap.put("boardMstId", "게시판마스터ID");
		headerMap.put("title", "제목");
		headerMap.put("content", "내용");
		headerMap.put("useYn", "사용여부");
		headerMap.put("insertId", "등록자");
		headerMap.put("insertDate", "등록일자");
		
		//excelUtilRowhandler.createXlsxDown("com.lgu.ccss.admin.board.mapper.BoardMapper.selectBoardList", boardVO, headerMap, response, "게시판리스트" , sqlSession);
	
	}
	/**
	 * 공지사항 리스트 팝업
	 * @param request
	 * @param bdType
	 * @param model
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "/{bdType}ListPopup.do")
    public String noticeListPopup(HttpServletRequest request,@PathVariable("bdType") String bdType,  ModelMap model) throws Exception {
		// 게시판 마스터 코드 설정
		BoardMstVO boardMstVO = selectBoardMstInfo(bdType);

		// 게시판 마스터 코드 미등록된 경우 처리
		if (boardMstVO == null) {
			return "forward:/HistoryBack.do";
		}
		model.addAttribute("boardMstVO", boardMstVO);
				
		// [Fortify] Cross-Site Scripting: Reflected
        if(bdType.equals("notice")) {
        	return "/board/noticeListPopup.exclude";
        }else if(bdType.equals("manualBatchDetail")) {
        	return "/board/manualBatchDetailListPopup.exclude";
        }else if(bdType.equals("userServiceUse")) {
        	return "/board/userServiceUseListPopup.exclude";
        }else {
        	return "/board/noticeListPopup.exclude";
        }
    }
	
	
	
	/**
	 * PUSH 업데이트 주기 팝업
	 * 
	 * @param request
	 * @param model
	 * @param newsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pushUpdateTimePopup.do")
    public String pushUpdateTime(HttpServletRequest request, ModelMap model) throws Exception {
		//Map<String, Object> resultMap = boardService.selectNewsDetail(newsVO);
		//model.addAllAttributes(resultMap);
		return "/board/pushUpdateTimePopup.exclude";
    }
	
	/**
	 * PUSH 업데이트 주기 조회
	 * 
	 * @param request
	 * @param model
	 * @param newsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectPushUpdateTime.do")
	public BoardVO selectPushUpdateTime(HttpServletRequest request, @ModelAttribute("boardVO") BoardVO boardVO, ModelMap model) throws Exception {
		boardVO = boardService.selectPushUpdateTime();
		model.addAttribute("boardVO", boardVO);
		return boardVO;
	}
	
	
	/**
	 * PUSH 업데이트 주기 수정
	 * 
	 * @param request
	 * @param model
	 * @param newsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePushUpdateTime.do")
	public Map<String, Object>  updatePushUpdateTime(HttpServletRequest request, @RequestBody BoardVO boardVO) throws Exception {
		Map<String, Object> resultMap = boardService.updatePushUpdateTime(boardVO);
		return resultMap;
	}

	/**
	 * 앱 버전 체크
	 * 
	 * @param request
	 * @param model
	 * @param newsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/appversionValidationCheck.do")
	public Map<String, Object>  appversionValidationCheck(HttpServletRequest request, @RequestBody BoardVO boardVO) throws Exception {
		Map<String, Object> resultMap = boardService.appversionValidationCheck(boardVO);
		return resultMap;
	}

}
