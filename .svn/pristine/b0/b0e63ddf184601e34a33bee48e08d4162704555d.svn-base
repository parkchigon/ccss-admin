package com.lgu.ccss.admin.system.program.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.system.menu.service.MenuServiceImpl;
import com.lgu.ccss.admin.system.program.domain.ProgramVO;

import devonframe.dataaccess.CommonDao;

@Service("programService")
public class ProgramServiceImpl implements ProgramService{

	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;
	
	@Autowired
	private MenuServiceImpl menuService;
	
	public List<ProgramVO> selectProgramList(ProgramVO programVO) throws Exception{
		return commonDao_oracle.selectList("Program.selectProgramList",programVO);
	}

	public void insertProgram(ProgramVO programVO) throws Exception{
		
		programVO.setProgramId(UniqueKeyUtil.getUniKey());
		commonDao_oracle.insert("Program.insertProgram",programVO);
		menuService.menuMapSetting();
		
	}
	
	public void updateProgram(ProgramVO programVO) throws Exception {
	
		commonDao_oracle.update("Program.updateProgram",programVO);

		menuService.menuMapSetting();
		
	}

	public void deleteProgramMenu(ProgramVO programVO) throws Exception {
		
		commonDao_oracle.delete("Program.deleteProgramMenu",programVO);
		
		menuService.menuMapSetting();
		
	}

}
