package com.lgu.ccss.admin.term.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import com.feelingk.UniqueKeyUtil;
import com.lgu.ccss.admin.system.code.domain.CodeVO;
import com.lgu.ccss.admin.system.code.service.CodeServiceImpl;
import com.lgu.ccss.admin.term.domain.TermsVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.domain.Constants.ResultCode;

import devonframe.dataaccess.CommonDao;

@Service("termsService")
public class TermsServiceImpl implements TermsService {

	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;
	
	@Resource(name = "codeService")
	private CodeServiceImpl codeService;
	
	String[] Replace = { "&", "\"", "<", ">" ,"'"}; 
	String[] Orginal = { "&amp;", "&quot;", "&lt;", "&gt;","#039;" };
	/**
	 * 약관 조회
	 * 
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectTermsList(TermsVO termsVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Map<String, Object>> resultList = commonDao_oracle.selectList("Term.selectTermsList",termsVO);
		
		List<Map<String, Object>> currentList = commonDao_oracle.selectList("Term.selectCurrentTermsList",termsVO);
		
		
		int totalCount = commonDao_oracle.select("Term.selectTermsListCnt",termsVO);
		
		resultMap.put("resultList", resultList);
		resultMap.put("currentList", currentList);
		resultMap.put("totalCount", totalCount);
		
		return resultMap;
	}
	
	public Map<String, Object> deleteTermsAjax(TermsVO termsVO)  throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int deleteCnt = commonDao_oracle.delete("Term.deleteTermsAjax",termsVO);
		
		if(deleteCnt > 0){
			resultMap.put("resultCode", ResultCode.RESULT_CODE_0000.getCode());
		}else{
			resultMap.put("resultCode", ResultCode.RESULT_CODE_4000.getCode());
		}
		
		return resultMap;
	}

	
	/**
	 * 신규 약관 등록
	 * @param termsVO
	 * @return
	 */
	public Map<String, Object> insertNewTerms(TermsVO termsVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		termsVO.setTermsNo(UniqueKeyUtil.getUniKey());
		int checkCount = 0;
		
		//Check Name
		String grpCdId = codeService.selectGrpCdId("TERMS_DIV");
		CodeVO codeVO = new CodeVO();
		codeVO.setGrpCdId(grpCdId);
		codeVO.setCodeDesc((termsVO.getTermsTitle()));
		codeVO = codeService.selectDtlCodeDetail(codeVO);
		
		if(codeVO != null){
			
			//해당 termsDiv로 exposureYn 이 있는지 검색
			if(termsVO.getExposureYn().equals("Y")){
				checkCount =commonDao_oracle.select("Term.checkExistTerms",termsVO);
			}
			
			
			if(checkCount > 0) {
				resultMap.put(Constants.RESULT, Constants.EXIST);
			}else{
				int maxNum = commonDao_oracle.select("Term.selectMaxSortNum",termsVO);
				termsVO.setTermsSortNum(String.valueOf(maxNum));
				
				
				String termsCont = replaceWithCharacters( termsVO.getTermsCont(),Orginal, Replace)
						.replaceAll("&gt;", ">")
								.replaceAll("&lt;", "<")
								.replaceAll("&quot;", "\"")
								.replaceAll("&amp;", "&")
								.replaceAll("&#039;", "'");
						termsVO.setTermsCont(termsCont);
						
				commonDao_oracle.insert("Term.insertNewTerms",termsVO);
				resultMap.put(Constants.RESULT, Constants.YES);
			}
		}else{
			resultMap.put(Constants.RESULT, Constants.FAIL);
		}
		
		
		
		return resultMap;
	}
	
	
	/**
	 * 약관 상세
	 * 
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	public TermsVO selectTermsDetail(TermsVO termsVO) throws Exception {
		termsVO = commonDao_oracle.select("Term.selectTermsDetail",termsVO);
		
		String exposureStartDt = termsVO.getExposureStartDt();
		String exposureEndDt = 	termsVO.getExposureEndDt();
		
		termsVO.setSpostDate(exposureStartDt.substring(0,10));
		termsVO.setSpostHour(exposureStartDt.substring(11,13));
		termsVO.setSpostMinute(exposureStartDt.substring(14,16));
		
		termsVO.setEpostDate(exposureEndDt.substring(0,10));
		termsVO.setEpostHour(exposureEndDt.substring(11,13));
		termsVO.setEpostMinute(exposureEndDt.substring(14,16));
		
		/*System.out.println("##########################################");
		System.out.println("0termsCont:"+ termsVO.getTermsCont());
		System.out.println("##########################################");*/
		//String termsCont = replaceWithCharacters( termsVO.getTermsCont(),Orginal, Replace);
		String termsCont = replaceWithCharacters( termsVO.getTermsCont(),Orginal, Replace)
		.replaceAll("&gt;", ">")
				.replaceAll("&lt;", "<")
				.replaceAll("&quot;", "\"")
				.replaceAll("&amp;", "&")
				.replaceAll("&#039;", "'");
		/*System.out.println("##########################################");
		System.out.println("1termsCont:"+ termsCont);
		System.out.println("##########################################");*/
		
		termsVO.setTermsCont(termsCont);
		
		/*System.out.println("##########################################");
		System.out.println("2termsCont:"+ termsVO.getTermsCont());
		System.out.println("##########################################");*/
		
		return termsVO; 
	}

	public static String replaceWithCharacters(String alter, String[] org,
			String[] repl) {
		for (int i = 0; i < org.length; i++) {
			alter = alter.replaceAll(org[i], repl[i]);
		}
		return alter;
	}
	
	
	/**
	 * 약관 수정
	 * 
	 * @param termsVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> updateTerms(TermsVO termsVO) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int checkCount = 0;
		
		
		//Check Name
		String grpCdId = codeService.selectGrpCdId("TERMS_DIV");
		CodeVO codeVO = new CodeVO();
		codeVO.setGrpCdId(grpCdId);
		codeVO.setCodeDesc((termsVO.getTermsTitle()));
		codeVO = codeService.selectDtlCodeDetail(codeVO);
		
		if(codeVO != null){
			//해당 termsDiv로 exposureYn 이 있는지 검색
			if(termsVO.getExposureYn().equals("Y")){
				checkCount =commonDao_oracle.select("Term.checkExistTerms",termsVO);
			}
			
			if(checkCount > 0) {
				
				resultMap.put(Constants.RESULT, Constants.EXIST);
				
			}else{
				
				String termsCont = replaceWithCharacters( termsVO.getTermsCont(),Orginal, Replace)
						.replaceAll("&gt;", ">").replaceAll("&lt;", "<").replaceAll("&quot;", "\"")
						.replaceAll("&amp;", "&").replaceAll("&#039;", "'");
						
						if("N".equals(termsVO.getExposureYn())){
							termsVO.setTermsSortNum("0");
						}
						
						termsVO.setTermsCont(termsCont);
						
				if(termsVO.getExposureYn().equals("Y") && !termsVO.getTermsSortNum().equals("0")){
					
					int  dupleSortNum = commonDao_oracle.select("Term.checkExistTermsSortNum",termsVO);
					
					if(dupleSortNum > 0){
						
						resultMap.put(Constants.RESULT, Constants.DUPLICATE_TERMS_SORT_NUM);
					
					}else{
						
						if(commonDao_oracle.update("Term.updateTerms",termsVO) > 0){
							resultMap.put(Constants.RESULT, Constants.YES);
						}else{
							resultMap.put(Constants.RESULT, Constants.NO);
						}
						
					}
					
				}else if(termsVO.getExposureYn().equals("Y") && termsVO.getTermsSortNum().equals("0")){
					
					int maxNum = commonDao_oracle.select("Term.selectMaxSortNum",termsVO);
					termsVO.setTermsSortNum(String.valueOf(maxNum));
					
					if(commonDao_oracle.update("Term.updateTerms",termsVO) > 0){
						resultMap.put(Constants.RESULT, Constants.YES);
					}else{
						resultMap.put(Constants.RESULT, Constants.NO);
					}
					
				}else{
					
					if(commonDao_oracle.update("Term.updateTerms",termsVO) > 0){
						resultMap.put(Constants.RESULT, Constants.YES);
					}else{
						resultMap.put(Constants.RESULT, Constants.NO);
					}
				}

			}
		}else{
			resultMap.put(Constants.RESULT, Constants.FAIL);
		}
		return resultMap;
	}
}
