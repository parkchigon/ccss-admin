package com.lgu.ccss.common.utility;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
@Component
public class FileImageUtil {

	@Value("${common.domain}")
    private String serverDomain;
	@Value("${common.port}")
	private String serverPort;
	@Value("${common.profile.image.url}")
	private String profileUrl;
	@Value("${common.notice.image.url}")
	private String noticeUrl;
	@Value("${common.banner.image.url}")
	private String bannerUrl;
	@Value("${common.community.image.url}")
	private String communityUrl;
	@Value("${common.push.image.url}")
	private String pushUrl;
	@Value("${common.app.apk.url}")
	private String appUrl;
	@Value("${common.email.image.url}")
	private String emailUrl;
	@Value("${common.splash.image.url}")
	private String splashUrl;	
	@Value("${common.event.image.url}")
	private String eventUrl;
	@Value("${common.fnreqboard.image.url}")
	private String fnreqboardUrl;
	
	
	@Value("${common.category.image.url}")
	private String categoryIconUrl;
	
	
	
	//프로필 이미지 URL 만들기
	public String getProfileImageUrl(String userIdNum) {
		if(userIdNum.length() != 10) {
			//사용자 식별값 오류
			return "http://"+serverDomain+":"+serverPort+profileUrl+"default";
		} else if("SO".equals(userIdNum.substring(0, 2).toUpperCase())) {
			//군인 사용자
			return "http://"+serverDomain+":"+serverPort+profileUrl+userIdNum;
		} else if("AC".equals(userIdNum.substring(0,2).toUpperCase())) {
			//지인 사용자
			return "http://"+serverDomain+":"+serverPort+profileUrl+userIdNum;
		} else {
			//사용자 식별값 오류
			return "http://"+serverDomain+":"+serverPort+profileUrl+"default";
		}
	}
	
	//공지사항 이미지 URL 만들기
	public String getNoticeImageUrl(String fileName, String fileExtention) {
		return "http://"+serverDomain+":"+serverPort+noticeUrl+fileName+"?fileExt="+fileExtention;
	}
	//배너 이미지 URL 만들기
	public String getBannerImageUrl(String fileName, String fileExtention) {
		return "http://"+serverDomain+":"+serverPort+bannerUrl+fileName+"?fileExt="+fileExtention;
	}
	//커뮤니티 이미지 URL 만들기
	public String getCommunityImageUrl(String fileName, String fileExtention) {
		return "http://"+serverDomain+":"+serverPort+communityUrl+fileName+"?fileExt="+fileExtention;
	}
	//PUSH 이미지 URL 만들기
	public String getPushImageUrl(String fileName, String fileExtention) {
		return "http://"+serverDomain+":"+serverPort+pushUrl+fileName+"?fileExt="+fileExtention;
	}
	//앱 API 다운로드 URL 만들기
	public String getAppApkUrl(String fileName, String fileExtention) {
		return "http://"+serverDomain+":"+serverPort+appUrl+fileName+"?fileExt="+fileExtention;
	}
	//email 이미지 URL 만들기
	public String getEmailImageUrl(String fileName, String fileExtention) {
		return "http://"+serverDomain+":"+serverPort+emailUrl+fileName+"?fileExt="+fileExtention;
	}
	//스플래시 이미지 URL 만들기
	public String getSplashImageUrl(String fileName, String fileExtention) {
		return "http://"+serverDomain+":"+serverPort+splashUrl+fileName+"?fileExt="+fileExtention;
	}
	//이벤트 이미지 URL 만들기
	public String getEventImageUrl(String fileName, String fileExtention) {
		return "http://"+serverDomain+":"+serverPort+eventUrl+fileName+"?fileExt="+fileExtention;
	}
	//이벤트 move URL 만들기
	public String getEventMoveUrl(String eventSeq, String delivInfoTemplate, String winnerPostDtime) {
		return "http://"+serverDomain+":"+serverPort+"/web/mobileEvent/winnerForm?eventSeq=" + eventSeq + "&delivInfoTemplate=" + delivInfoTemplate + "&winner=false&winnerPostDtime=" + winnerPostDtime;
	}
	//기능요청게시판 이미지 URL 만들기
	public String getFnReqBoardImageUrl(String fileName, String fileExtention) {
		return "http://"+serverDomain+":"+serverPort+fnreqboardUrl+fileName+"?fileExt="+fileExtention;
	}
	//카테고리 아이콘 이미지 URL 만들기
	public String getCagegoryImageUrl(String fileName, String fileExtention) {
		return "http://"+serverDomain+":"+serverPort+categoryIconUrl+fileName+"?fileExt="+fileExtention;
	}
}
