package com.lgu.ccss.common.utility;

import java.io.File;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

public class FileUtils {
	private static Logger logger = LoggerFactory.getLogger(FileUtils.class);
	
	/**
	 * file save
	 * @param upLoadFile
	 * @param savePath
	 * @return
	 * @throws Exception
	 */
	public static boolean saveUpLoadFile(MultipartFile upLoadFile, String savePath, String orgFileName) throws Exception{
		boolean result = false;
		logger.debug("savePath : " + savePath);

		if(savePath != null && !savePath.equals("")){
			File dir = new File(savePath);
			if(!dir.exists()){
				dir.mkdirs();
			}		
			logger.debug("dir make check : " + dir.exists());
		
			// save
			File savefile = new File(savePath + orgFileName);
			try {
				upLoadFile.transferTo(savefile);
				
				result = true;
				logger.info("[" + savePath + orgFileName + "]File Save Success...........");
			} catch (Exception e) {
				// TODO: handle exception
				result = false;
				logger.info("[" + savePath + orgFileName + "]File Save Fail...........");
				logger.error("Exception : ", e);
				throw new Exception();
			}
		}
		return result;
	}
	
	/**
	 * file delete
	 * @param filePath
	 * @param fileName
	 * @return
	 * @throws Exception
	 */
	public static boolean deleteFile(String filePath, String fileName) throws Exception{
		boolean result = false;
		
		File fileDir = new File(filePath);
		File file = new File(filePath + fileName);
		
		// file Check
		if(file.exists()){
			file.delete();
			fileDir.delete();
			result = true;
		} else{
			logger.info("[" + filePath + fileName + "] File is Not Exist......");
			result = false;
		}
		
		return result;
	}
}
