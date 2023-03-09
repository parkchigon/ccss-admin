package com.lgu.ccss.common.utility;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import com.lgu.ccss.admin.file.domain.FileInfoVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.UploadFileSDO;

public class FileUtil {

    /** The logger. */
    private static Logger logger = LoggerFactory.getLogger(FileUtil.class);

    /**
     * 업로드 파일 저장
     * 
     * @param multipartFile
     * @param filePath
     * @return saveMultipartFile(multipartFile, filePath, "Y")
     * @throws Exception
     */
    public static UploadFileSDO saveMultipartFile(MultipartFile multipartFile, String filePath) throws Exception {

        return saveMultipartFile(multipartFile, filePath, "Y");
    }

    /**
     * 업로드 파일 저장 <br/>
     * 
     * <pre></pre>
     * 
     * @param multipartFile
     *            업로드 파일 객체
     * @param filePath
     *            파일 저장 경로
     * @param uniqueYN
     *            유일한 파일명 생성 여부
     * @return
     * @throws Exception
     */
    public static UploadFileSDO saveMultipartFile(MultipartFile multipartFile, String filePath, String uniqueYN) throws Exception {

        UploadFileSDO uploadFileSDO = null;

        if (multipartFile == null || multipartFile.isEmpty()) {

            return null;
        }

        try {

            // 파일명
            String fileName = multipartFile.getOriginalFilename().substring(0, multipartFile.getOriginalFilename().lastIndexOf("."));

            // 파일 확장자
            String exe = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".") + 1, multipartFile.getOriginalFilename().length());

            logger.debug("file name : " + fileName);
            logger.debug("file exe : " + exe);

            // 유일한 파일명 생성을 원할 경우
            Date date = Calendar.getInstance().getTime();
            if (uniqueYN.equals("Y")) {
                String currentTime = StringUtil.getToDay("MS");
                // fileName = fileName+"_"+currentTime;

                Random rn = new Random();
                // 중복발생 방지용
                // rn.setSeed(System.currentTimeMillis());

                fileName = currentTime + "_" + rn.nextInt(10);

                logger.debug("unique file name : " + fileName);
            }

            // 디렉토리 확인
            File dir = new File(filePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            // 파일 생성
            dir = new File(filePath + fileName + "." + exe);

            multipartFile.transferTo(dir);

            // 파일정보 설정
            uploadFileSDO = new UploadFileSDO();
            uploadFileSDO.setOrgFileName(multipartFile.getOriginalFilename());
            uploadFileSDO.setStoreFileName(fileName);
            uploadFileSDO.setStoreFileExtention(exe);
            uploadFileSDO.setFilePath(filePath);
            uploadFileSDO.setFileSize((int) multipartFile.getSize() / Constants.BYTE_DIVISION);
            uploadFileSDO.setSaveFile(dir);
            uploadFileSDO.setUploadDate(date);

        } catch (Exception e) {
            throw e;
        }

        return uploadFileSDO;
    }

    /**
     * 파일 삭제 <br/>
     * 
     * <pre></pre>
     * 
     * @param filePath
     *            파일 저장 경로
     * @param fileName
     *            저장 파일명
     * @param fileExtention
     *            파일 확장자명
     * @return
     * @throws Exception
     */
    public static void deleteFile(String filePath, String fileName, String fileExtention) throws Exception {

        // 디렉토리 확인
        File dir = new File(filePath + fileName + "." + fileExtention);
        if (dir.exists()) {
            dir.delete();
        }
    }

    public static Boolean downloadFile(HttpServletRequest request, HttpServletResponse response) {
        // get absolute path of the application
        ServletContext context = request.getServletContext();
        String appPath = context.getRealPath("/");
        String fileName = (String) request.getParameter("fileName");
        String orgFileName = (String) request.getParameter("orgFileName");
        System.out.println("appPath = " + appPath);

        // construct the complete absolute path of the file
        String exe = orgFileName.substring(orgFileName.lastIndexOf(".") + 1, orgFileName.length());
        String fullPath = appPath + "\\files\\" + fileName + "." + exe;
        File downloadFile = new File(fullPath);
        FileInputStream inputStream = null;
        OutputStream outStream = null;

        try {
            inputStream = new FileInputStream(downloadFile);
            // get MIME type of the file
            String mimeType = context.getMimeType(fullPath);
            if (mimeType == null) {
                // set to binary type if MIME mapping not found
                mimeType = "application/octet-stream";
            }
            System.out.println("MIME type: " + mimeType);

            // set content attributes for the response
            response.setContentType(mimeType);
            response.setContentLength((int) downloadFile.length());

            // set headers for the response
            String headerKey = "Content-Disposition";
            String headerValue = String.format("attachment; filename=\"%s\"", orgFileName);
            response.setHeader(headerKey, headerValue);

            // get output stream of the response

            outStream = response.getOutputStream();

            byte[] buffer = new byte[4096];
            int bytesRead = -1;

            // write bytes read from the input stream into the output stream
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                // outStream.write(buffer, 0, bytesRead);
                outStream.write(buffer, 0, bytesRead);
            }
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
            	if(inputStream != null) {
            		inputStream.close();
            	}
            	if(outStream != null) {
            		outStream.close();
            	}
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * @param checkExt
     *            (유효한 파일 확장자명)
     * @param multipartFile
     *            (체크할 파일)
     * @return 성공시 true, 실패시 false
     */
    public static boolean checkFileExtension(String[] checkExt, MultipartFile multipartFile) {

        boolean flag = false;

        if (multipartFile != null && !multipartFile.isEmpty()) {
            String fileName = multipartFile.getOriginalFilename();
            String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
            for (int i = 0; i < checkExt.length; i++) {
                if (checkExt[i].toUpperCase().equals(fileExt.toUpperCase())) {
                    flag = true;
                    break;
                }
            }
        }

        return flag;
    }
    
    public static FileInfoVO uploadMultipartFile(MultipartFile multipartFile, String filePath, String uniqueYN, String bizClassifyCode) throws Exception {
    	FileInfoVO fileInfoVO = null;
		
    	// 파일명
        String fileName = multipartFile.getOriginalFilename().substring(0, multipartFile.getOriginalFilename().lastIndexOf("."));
        // 파일 확장자
        String exe = multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".") + 1, multipartFile.getOriginalFilename().length());

		logger.debug("file name : " + fileName);
        logger.debug("file exe : " + exe);
	
        // 유일한 파일명 생성을 원할 경우
        if (StringUtils.equals(uniqueYN, Constants.YES)) {
            String currentTime = StringUtil.getToDay("MS");
            fileName = fileName+"_"+currentTime;

            Random rn = new Random();
            // 중복발생 방지용
            rn.setSeed(System.currentTimeMillis());

            fileName = currentTime + "_" + rn.nextInt(10);

            logger.debug("unique file name : " + fileName);
        }
        
        // 디렉토리 확인
        File dir = new File(filePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        // 파일 생성
        dir = new File(filePath + fileName + "." + exe);

        multipartFile.transferTo(dir);
        
        BufferedImage bi = ImageIO.read(dir);

    	
        fileInfoVO = new FileInfoVO();
        fileInfoVO.setOriginFileName(multipartFile.getOriginalFilename());
        fileInfoVO.setSaveFileName(fileName + "." + exe);
        fileInfoVO.setBizClassifyCode(bizClassifyCode);
        
        if(!exe.equals("apk") && !exe.equals("APK") && !exe.equals("xls") && !exe.equals("xlsx") && !exe.equals("XLS") && !exe.equals("XLSX")){
	        fileInfoVO.setWidth(String.valueOf(bi.getWidth()));
	        fileInfoVO.setHeight(String.valueOf(bi.getHeight()));
        }
        fileInfoVO.setFileSize(String.valueOf(multipartFile.getSize()));
        
    	return fileInfoVO;
    }
    
    /**
	 * 파일경로에서 확장명 get
	 * 
	 * @param filePath
	 * @return
	 */
	public static String getExtention(String filePath) {

		if (filePath == null)
			return null;

		int index = filePath.lastIndexOf('.');
		if (index < 0)
			return null;

		return filePath.substring(index + 1);

	}

}
