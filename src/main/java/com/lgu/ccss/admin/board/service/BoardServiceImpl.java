package com.lgu.ccss.admin.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.board.domain.BoardMstVO;
import com.lgu.ccss.admin.board.domain.BoardVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.FileImageUtil;
import com.lgu.ccss.common.utility.FileUtil;
import com.lgu.ccss.common.utility.SessionUtil;

import devonframe.dataaccess.CommonDao;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;
    
	@Autowired
	private FileImageUtil fileImageUtil;
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 게시판 
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	/**
	 * 게시판 마스터 정보 조회 
	 * @param boardMstVO
	 * @return
	 * @throws Exception
	 */
	public BoardMstVO selectBoardMstInfo(BoardMstVO boardMstVO) throws Exception {
		return commonDao_oracle.select("Board.selectBoardMstInfo",boardMstVO);
	}

	
	/**
	 * 게시판 리스트 조회
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectBoardList(BoardVO boardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
	    
	    List<BoardVO> resultList = commonDao_oracle.select("Board.selectBoardList",boardVO);
	    
	    
	    for(BoardVO board : resultList){
    		if(board.getFileInfoVO() != null && StringUtils.isNotBlank(board.getFileInfoVO().getSaveFileName())){
    			board.getFileInfoVO().setFilePath(fileImageUtil.getPushImageUrl(board.getFileInfoVO().getSaveFileName().substring(0, board.getFileInfoVO().getSaveFileName().lastIndexOf(".")), FileUtil.getExtention(board.getFileInfoVO().getSaveFileName())));
    		}
    	}
	    
	    
	    int totalCount = commonDao_oracle.select("Board.selectBoardListCnt",boardVO);
	   
	    resultMap.put("resultList", resultList);
	    resultMap.put("totalCount", totalCount);
	    
		return resultMap;
	}
	/**
	 * 배너 상단 리스트
	 * @param boardMstVO
	 * @return
	 * @throws Exception
	 */
	public List<BoardVO> selectBoardTopBannerList(BoardMstVO boardMstVO ) throws Exception {
    	List<BoardVO> resultList2 = commonDao_oracle.select("Board.selectBoardTopBannerList");
    	for(BoardVO board : resultList2){
    		if(board.getFileInfoVO() != null && StringUtils.isNotBlank(board.getFileInfoVO().getSaveFileName())){
    			board.getFileInfoVO().setFilePath(fileImageUtil.getBannerImageUrl(board.getFileInfoVO().getSaveFileName().substring(0, board.getFileInfoVO().getSaveFileName().lastIndexOf(".")), FileUtil.getExtention(board.getFileInfoVO().getSaveFileName())));
    		}
    	}
    	return resultList2;
	}
	/**
	 * 게시판 등록
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public String insertBoard(BoardVO boardVO) throws Exception {
		if(StringUtils.isNotEmpty(boardVO.getPostDate())) {
			boardVO.setPostDate(boardVO.getPostDate() + boardVO.getPostHour() + boardVO.getPostMinute());
		}
		if(StringUtils.isNotEmpty(boardVO.getBannerEndDate())) {
			boardVO.setOpt6(boardVO.getBannerEndDate() + boardVO.getBannerEndHour() + boardVO.getBannerEndMinute());
		}
		boardVO.setBoardId(UniqueKeyUtil.getUniKey());
		commonDao_oracle.insert("Board.insertBoard",boardVO);
		
		return boardVO.getBoardId();
	}
	
	
	/**
	 * 게시판 상세 조회
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public BoardVO selectBoardDetail(BoardVO boardVO) throws Exception {
		BoardVO board = commonDao_oracle.select("Board.selectBoardDetail",boardVO);
		if(board.getFileInfoVO() != null && StringUtils.isNotBlank(board.getFileInfoVO().getSaveFileName())){
			if(Constants.BoardMstId.NOTICE.equals(boardVO.getBoardMstId())){
				board.getFileInfoVO().setFilePath(fileImageUtil.getNoticeImageUrl(board.getFileInfoVO().getSaveFileName().substring(0, board.getFileInfoVO().getSaveFileName().lastIndexOf(".")), FileUtil.getExtention(board.getFileInfoVO().getSaveFileName())));
			}else if(Constants.BoardMstId.BANNER.equals(boardVO.getBoardMstId())){
				board.getFileInfoVO().setFilePath(fileImageUtil.getBannerImageUrl(board.getFileInfoVO().getSaveFileName().substring(0, board.getFileInfoVO().getSaveFileName().lastIndexOf(".")), FileUtil.getExtention(board.getFileInfoVO().getSaveFileName())));
			}else if(Constants.BoardMstId.PUSH.equals(boardVO.getBoardMstId())){
				board.getFileInfoVO().setFilePath(fileImageUtil.getPushImageUrl(board.getFileInfoVO().getSaveFileName().substring(0, board.getFileInfoVO().getSaveFileName().lastIndexOf(".")), FileUtil.getExtention(board.getFileInfoVO().getSaveFileName())));
			}else if(Constants.BoardMstId.APPVERSION.equals(boardVO.getBoardMstId())){
				board.getFileInfoVO().setFilePath(fileImageUtil.getAppApkUrl(board.getFileInfoVO().getSaveFileName().substring(0, board.getFileInfoVO().getSaveFileName().lastIndexOf(".")), FileUtil.getExtention(board.getFileInfoVO().getSaveFileName())));
			}
		}
		return board;
	}
	
	/**
	 * PUSH 업데이트주기 정보조회
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public BoardVO selectPushUpdateTime() throws Exception {
		BoardVO board = commonDao_oracle.select("Board.selectPushUpdateTime");
		return board;
	}
	
	/**
	 * PUSH 업데이트주기 정보조회
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updatePushUpdateTime(BoardVO boardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(commonDao_oracle.update("Board.updatePushUpdateTime",boardVO) > 0) {
			resultMap.put(Constants.RESULT, Constants.YES);
		} else {
			resultMap.put(Constants.RESULT, Constants.NO);
		}
		return resultMap;
	}

	
	/**
	 * 앱 버전 체크
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> appversionValidationCheck(BoardVO boardVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		if(Integer.parseInt( (String) commonDao_oracle.select("Board.appversionValidationCheck",boardVO) ) > 0) {
			resultMap.put(Constants.RESULT, Constants.YES);
		} else {
			resultMap.put(Constants.RESULT, Constants.NO);
		}
		return resultMap;
	}

	/**
	 * 게시판 수정
	 * @param boardVO
	 * @throws Exception
	 */
	public void updateBoard(BoardVO boardVO) throws Exception {
		if(StringUtils.isNotEmpty(boardVO.getPostDate())) {
			boardVO.setPostDate(boardVO.getPostDate() + boardVO.getPostHour() + boardVO.getPostMinute());
		}
		if(StringUtils.isNotEmpty(boardVO.getBannerEndDate())) {
			boardVO.setOpt6(boardVO.getBannerEndDate() + boardVO.getBannerEndHour() + boardVO.getBannerEndMinute());
		}
		commonDao_oracle.update("Board.updateBoard",boardVO);
	}

	/**
	 * 게시판 정렬 순서변경
	 * @param boardVO
	 * @throws Exception
	 */
	@Transactional
	public Map<String, Object> updateBoardOrderNo(HttpServletRequest request,List<BoardVO> boardList) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		for(BoardVO boardVo : boardList){
			boardVo.setUpdateId(SessionUtil.getLoginId(request));
			commonDao_oracle.update("Board.updateBoardOrderNo",boardVo);
		}
		resultMap.put(Constants.RESULT, Constants.YES);
		return resultMap;
	}

	/**
	 * 게시판 삭제
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public void deleteBoard(BoardVO boardVO) throws Exception {
		commonDao_oracle.delete("Board.deleteBoard",boardVO);

	}
	
	/**
	 * 게시판 조회 개수 가져오기
	 * @param boardVO
	 * @return
	 * @throws Exception
	 */
	public int selectBoardListCnt(BoardVO boardVO) throws Exception {
		return commonDao_oracle.select("Board.selectBoardListCnt",boardVO);
	}
	
	
	public int updateBoardTopBanner() throws Exception {
		return commonDao_oracle.update("Board.updateBoardTopBanner");
	}
	
}
