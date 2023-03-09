package com.lgu.ccss.admin.file.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.file.domain.FileInfoVO;

import devonframe.dataaccess.CommonDao;

@Service("fileInfoService")
public class FileInfoServiceImpl implements FileInfoService{
	
	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;
    
	/**
	 * 파일정보 등록
	 * @param fileInfoVO
	 * @throws Exception
	 */
	public String insertFileInfo(FileInfoVO fileInfoVO) throws Exception {
		fileInfoVO.setFileSeq(UniqueKeyUtil.getUniKey());
		commonDao_oracle.insert("FileInfo.insertFileInfo",fileInfoVO);
		
		return fileInfoVO.getFileSeq();
	}
	
}
