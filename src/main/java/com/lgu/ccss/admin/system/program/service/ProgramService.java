package com.lgu.ccss.admin.system.program.service;

import java.util.List;

import com.lgu.ccss.admin.system.program.domain.ProgramVO;


public interface ProgramService {

	public List<ProgramVO> selectProgramList(ProgramVO programVO) throws Exception;

	public void insertProgram(ProgramVO programVO) throws Exception;
	
	public void updateProgram(ProgramVO programVO) throws Exception;

	public void deleteProgramMenu(ProgramVO programVO) throws Exception;

}
