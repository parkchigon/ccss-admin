package com.lgu.ccss.admin.card.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
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
public class CardImageFileController {
	
	@Value("#{config['upload.eventCardImg.path']}")
	private String uploadEventCardImgPath;
	
    @Resource(name = "cardService")
	private CardServiceImpl cardService;
    
    
	@Autowired
	private PageUtil pageUtil;
	
	/**
	    * 이벤트 카드 이미지 조회
	    * @param request
	    * @param response
	    * @param bannerImgFileName
	    * @param file
	    * @throws IOException
	    */
	@RequestMapping(value = "/eventCardFileDown/{cardImgFileName:.+}*", method = RequestMethod.GET)
	public void eventCardFileDown(@PathVariable String cardImgFileName,HttpServletRequest request, HttpServletResponse response) throws IOException {

		String fileExtension = cardImgFileName.substring(cardImgFileName.lastIndexOf(".")+1,cardImgFileName.length());
	    File file = new File(uploadEventCardImgPath + cardImgFileName);
			
		response.setContentType("image/"+fileExtension);
		FileUtils.copyFile(file, response.getOutputStream());
	}
}
