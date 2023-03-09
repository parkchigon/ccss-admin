package com.lgu.ccss.admin.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.lgu.ccss.admin.board.domain.BoardMstVO;
import com.lgu.ccss.admin.board.domain.BoardVO;

public interface BoardService {

	public BoardMstVO selectBoardMstInfo(BoardMstVO boardMstVO) throws Exception ;
	
	public Map<String, Object> selectBoardList(BoardVO boardVO) throws Exception ;

	public List<BoardVO> selectBoardTopBannerList(BoardMstVO boardMstVO ) throws Exception;

	public String insertBoard(BoardVO boardVO) throws Exception ;
	
	public BoardVO selectBoardDetail(BoardVO boardVO) throws Exception ;
	
	public BoardVO selectPushUpdateTime() throws Exception ;
	
	public Map<String, Object> updatePushUpdateTime(BoardVO boardVO) throws Exception;

	public Map<String, Object> appversionValidationCheck(BoardVO boardVO) throws Exception ;

	public void updateBoard(BoardVO boardVO) throws Exception ;

	public Map<String, Object> updateBoardOrderNo(HttpServletRequest request,List<BoardVO> boardList) throws Exception ;

	public void deleteBoard(BoardVO boardVO) throws Exception ;

	public int selectBoardListCnt(BoardVO boardVO) throws Exception ;
	
	public int updateBoardTopBanner() throws Exception ;
}
