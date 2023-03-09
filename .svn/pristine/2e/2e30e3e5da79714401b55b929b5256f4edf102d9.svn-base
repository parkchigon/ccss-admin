package com.lgu.ccss.admin.stat.serviceStat.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.lgu.ccss.admin.product.domain.ProductVO;
import com.lgu.ccss.admin.stat.api.domain.ApiStatVO;
import com.lgu.ccss.admin.stat.serviceStat.domain.ServiceStatVO;
import com.lgu.ccss.admin.system.code.domain.CodeVO;
import com.lgu.ccss.admin.system.code.domain.ServiceStatCodeVO;
import com.lgu.ccss.admin.system.code.service.CodeServiceImpl;
import com.lgu.ccss.admin.user.domain.UserVO;
import com.lgu.ccss.common.domain.Constants;
import com.lgu.ccss.common.utility.DateUtil;
import com.lgu.ccss.common.utility.JsonUtil;

import devonframe.dataaccess.CommonDao;


@Service("serviceStatService")
public class ServiceStatServiceImpl implements ServiceStatService {
	
	private static final Logger logger = LoggerFactory.getLogger(ServiceStatServiceImpl.class);

	@Resource(name = "commonDao_oracle")
	private CommonDao commonDao_oracle;

	@Resource(name = "commonDao_altibase")
	private CommonDao commonDao_altibase;

	@Resource(name = "codeService")
	private CodeServiceImpl codeService;

	private final String SERVICE_STAT_APP_TYPE = "SERVICE_STAT_APP_TYPE";
	
	private static final String DOUBLE_COLON =":";
	
	public static Map<String, Object> serviceCodeMap = new HashMap<String, Object>();
	public static Map<String, Object> reversKeyValueServiceCodeMap = new HashMap<String, Object>();
	
	@Value("#{config['use.logStat.Yn']}")
	private String useLogStatYn;

	
	//@Scheduled(cron ="0 */5 * * * *")
	@Scheduled(cron = "${ReInit.serviceStatCode.cron}")
	public void reInitServiceStatCode() {
		try {
			
			if(useLogStatYn !=null && useLogStatYn.equals("Y")){
				logger.debug("#Re Init Service Stat Code Map !!");
				this.selectServiceStatCodeList();
			}
			
		} catch (Exception e) {
			logger.error("### [" + DateUtil.getDate( "yyyy-MM-dd HH:mm:ss:SSS" ) + "] An error has occurred while initializing service stat code.");
		}
	}

	/**
	 * 서비스 통계 이력 리스트 카운트
	 * 
	 * @param apiStatVO
	 * @return
	 */
	public int selectServiceStatListCnt(ServiceStatVO serviceStatVO) throws Exception{
		return commonDao_oracle.select("ServiceStat.selectServiceStatListCnt",serviceStatVO);
	}


	/**
	 * 서비스 통계 사용 이력 리스트 조회
	 * @param apiStatVO
	 * @return
	 */
	public Map<String, Object> selectServiceStatList(ServiceStatVO serviceStatVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String[] statItemArray =  serviceStatVO.getStatItemArray();
		List<ServiceStatVO> serviceStatVOList = new ArrayList<ServiceStatVO>();
		
		Map<String,Object> paramMap =new HashMap<String,Object>();
		for(int idx=0; idx < statItemArray.length; idx++){
			ServiceStatVO tempVO = (ServiceStatVO) serviceStatVO.clone();
			
			String[] tempItemArry = statItemArray[idx].split(DOUBLE_COLON);
			tempVO.setStatApp(tempItemArry[0]);
			tempVO.setStatCat1(tempItemArry[1]);
			tempVO.setStatItem(tempItemArry[2]);
			serviceStatVOList.add(tempVO);
		}
		
		paramMap.put("serviceStatVOList",serviceStatVOList);
		paramMap.put("serviceStatVO",serviceStatVO);
		
		//System.out.println("###paramMap "+ JsonUtil.marshallingJson(paramMap));

		List<ServiceStatVO> resultList = commonDao_oracle.selectList("ServiceStat.selectServiceStatList",paramMap);
		int totalCount = commonDao_oracle.select("ServiceStat.selectServiceStatListCnt",paramMap);
		
		//System.out.println("###resultList "+ JsonUtil.marshallingJson(resultList));
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		return resultMap;
	}
	
	
	
	/**
	 * 서비스 통계 조회 Excel
	 * @param apiStatVO
	 * @return
	 */
	public Map<String, Object> selectServiceStatListExcel(ServiceStatVO serviceStatVO) throws Exception{
		Map<String, Object> resultMap = new HashMap<String, Object>();

		//Map<String, String> statAppMap = (Map<String, String>) reversKeyValueServiceCodeMap.get("statAppMap");
		Map<String, String> statCat1Map = (Map<String, String>) reversKeyValueServiceCodeMap.get("statCat1Map");
		Map<String, String> statItemMap = (Map<String, String>) reversKeyValueServiceCodeMap.get("statItemMap");
		
		String[] statItemArray =  serviceStatVO.getStatItemArray();
		List<ServiceStatVO> serviceStatVOList = new ArrayList<ServiceStatVO>();
		
		Map<String,Object> paramMap =new HashMap<String,Object>();
		for(int idx=0; idx < statItemArray.length; idx++){
			ServiceStatVO tempVO = (ServiceStatVO) serviceStatVO.clone();
			String[] tempItemArry = statItemArray[idx].split(DOUBLE_COLON);
			tempVO.setStatApp(tempItemArry[0]);
			tempVO.setStatCat1(tempItemArry[1]);
			tempVO.setStatItem(tempItemArry[2]);
			serviceStatVOList.add(tempVO);
		}
		
		paramMap.put("serviceStatVOList",serviceStatVOList);
		paramMap.put("serviceStatVO",serviceStatVO);
		
		logger.debug("###paramMap "+ JsonUtil.marshallingJson(paramMap));
		
		List<ServiceStatVO> resultList = commonDao_oracle.selectList("ServiceStat.selectServiceStatListExcel",paramMap);
		
		HashMap<String,String> statCat1HashMap = new HashMap<String,String>();
		
		if(resultList !=null && resultList.size() > 0){
			for(int idx = 0;  idx < resultList.size(); idx ++){
				ServiceStatVO convertVO = resultList.get(idx);
				String convertStatCat1Val = statCat1Map.get(convertVO.getStatApp() + DOUBLE_COLON + convertVO.getStatCat1());
				String convertStatItemVal = statItemMap.get(convertVO.getStatApp() + DOUBLE_COLON + convertVO.getStatCat1() + DOUBLE_COLON + convertVO.getStatItem());
				convertVO.setStatCat1(convertStatCat1Val);
				convertVO.setStatItem(convertStatItemVal);
				
				statCat1HashMap.put(convertStatCat1Val, convertStatCat1Val);
			}
		}
		
		List<String> statCat1List = new ArrayList<String>(statCat1HashMap.values());
		serviceStatVO.setStatCat1List(statCat1List);
		
		int totalCount = resultList.size();
		
		resultMap.put("resultList", resultList);
		resultMap.put("totalCount", totalCount);
		resultMap.put("serviceStatVO", serviceStatVO);
		
		return resultMap;
	}
	
	
	public void selectServiceStatCodeList() throws Exception{
		
		Map<String, Object> statAppCodeMap = new HashMap<String, Object>();
		Map<String, Object> statStatCat1Map = new HashMap<String, Object>();
		Map<String, Object> statStatItemMap = null;
		
	
		ServiceStatCodeVO codeVO = new ServiceStatCodeVO();
		codeVO.setGrpCdNm(SERVICE_STAT_APP_TYPE);
		
		//StatApp
		if(String.valueOf(codeVO.getGrpCdId()).equals("null")){
			String grpCdId = codeService.selectGrpCdId(codeVO.getGrpCdNm());
			codeVO.setGrpCdId(grpCdId);
		}
		List<ServiceStatCodeVO> statAppResultList = (List<ServiceStatCodeVO>) codeService.selectServiceStatDtlCodeList(codeVO).get("resultList");
		
		System.out.println("######statAppResultList.size####"+statAppResultList.size());
		
		for(int idx =0 ; idx < statAppResultList.size(); idx++){
			ServiceStatCodeVO searchStatAppVO = new  ServiceStatCodeVO();
			String dtlCdNm = statAppResultList.get(idx).getDtlCdNm();
			searchStatAppVO.setGrpCdNm(dtlCdNm);
			
			if(String.valueOf(searchStatAppVO.getGrpCdId()).equals("null")){
				String grpCdId = codeService.selectGrpCdId(searchStatAppVO.getGrpCdNm());
				if(grpCdId == null || grpCdId.length()  == 0){
					logger.error("Fail Select grpCdId - grpCdNm : " + searchStatAppVO.getGrpCdNm());
					break;
				}
				searchStatAppVO.setGrpCdId(grpCdId);
			}
			
			List<ServiceStatCodeVO> statCat1ResultList = (List<ServiceStatCodeVO>) codeService.selectServiceStatDtlCodeList(searchStatAppVO).get("resultList");

			for(int idy =0 ; idy < statCat1ResultList.size(); idy++){
				ServiceStatCodeVO searchStatCat1VO = new  ServiceStatCodeVO();
				searchStatCat1VO.setGrpCdNm(statCat1ResultList.get(idy).getDtlCdNm());
				
				if(String.valueOf(searchStatCat1VO.getGrpCdId()).equals("null")){
					String grpCdId = codeService.selectGrpCdId(searchStatCat1VO.getGrpCdNm());
					if(grpCdId == null || grpCdId.length()  == 0){
						logger.error("Fail Select grpCdId - grpCdNm : " + searchStatCat1VO.getGrpCdNm());
						break;
					}
					searchStatCat1VO.setGrpCdId(grpCdId);
				}
				
				List<ServiceStatCodeVO> statItemResultList = (List<ServiceStatCodeVO>) codeService.selectServiceStatDtlCodeList(searchStatCat1VO).get("resultList");
				//List<Map<String,Object>> itemMapList = new LinkedList<Map<String,Object>>();
				statStatItemMap = new HashMap<String, Object>();
				
				for(int k =0 ; k < statItemResultList.size(); k++){
					statStatItemMap.put(statItemResultList.get(k).getCodeDesc().replaceAll("^\\s+","").replaceAll("\\s+$",""),statItemResultList.get(k).getCdVal());
				}
				//itemMapList.add(statStatItemMap);
				statStatCat1Map.put(statCat1ResultList.get(idy).getDtlCdNm().replaceAll("^\\s+","").replaceAll("\\s+$","")+ DOUBLE_COLON + statCat1ResultList.get(idy).getCdVal() ,statStatItemMap);
			}
			statAppCodeMap.put(statAppResultList.get(idx).getCodeDesc().replaceAll("^\\s+","").replaceAll("\\s+$","")+DOUBLE_COLON+statAppResultList.get(idx).getDtlCdNm().replaceAll("^\\s+","").replaceAll("\\s+$",""),statStatCat1Map);
			statStatCat1Map = new HashMap<String, Object>();
		}
		System.out.println("## statAppCodeMap:" + JsonUtil.marshallingJson(statAppCodeMap));
		
		serviceCodeMap = statAppCodeMap;
		
		//reversServiceCodeMap Make
		Map<String, String> statAppMap = new HashMap<String, String>();
		Map<String, String> statCat1Map = new HashMap<String, String>();
		Map<String, String> statItemMap = new HashMap<String, String>();
		
		List<String> serviceStatAppKeyList = new LinkedList<>();
		
		try{
			Iterator<String> iter = (Iterator<String>) serviceCodeMap.keySet().iterator();
			while(iter.hasNext()){
				String key =iter.next();
				serviceStatAppKeyList.add(key);
			}
			for(int idx = 0 ; idx < serviceStatAppKeyList.size(); idx++){
				String[] splitValue = serviceStatAppKeyList.get(idx).split(DOUBLE_COLON);
				statAppMap.put(splitValue[1], splitValue[1]);
				
				List<String> serviceStatCat1KeyList = new LinkedList<>();
				Map<String,Object> tmpStatCat1Map = (Map<String, Object>) serviceCodeMap.get(serviceStatAppKeyList.get(idx));
				
				logger.debug("### tmpStatCat1Map:" + JsonUtil.marshallingJson(tmpStatCat1Map));
				Iterator<String> iterStatCat1 = (Iterator<String>) tmpStatCat1Map.keySet().iterator();
				while(iterStatCat1.hasNext()){
					String key =iterStatCat1.next();
					serviceStatCat1KeyList.add(key);
				}
				for(int idk = 0 ; idk < serviceStatCat1KeyList.size(); idk++){
					String[] stat1SplitValue = serviceStatCat1KeyList.get(idk).split(DOUBLE_COLON);
					statCat1Map.put(splitValue[1]+DOUBLE_COLON+stat1SplitValue[1],stat1SplitValue[0]);
					
					Map<String,Object> tmpStatItemMap = (Map<String, Object>) tmpStatCat1Map.get(serviceStatCat1KeyList.get(idk));
					
					logger.debug("### tmpStatItemMap:" + JsonUtil.marshallingJson(tmpStatItemMap));
					
					Iterator<String> iterStatItem = (Iterator<String>) tmpStatItemMap.keySet().iterator();
					while(iterStatItem.hasNext()){
						String key =iterStatItem.next();
						statItemMap.put(splitValue[1]+DOUBLE_COLON+stat1SplitValue[1]+DOUBLE_COLON +tmpStatItemMap.get(key) ,key);
					}
				}
			}
			
			//System.out.println("#####################################");
			//System.out.println("statAppMap:" + JsonUtil.marshallingJson(statAppMap));
			//System.out.println("statCat1Map:" + JsonUtil.marshallingJson(statCat1Map));
			//System.out.println("statItemMap:" + JsonUtil.marshallingJson(statItemMap));
			//System.out.println("#####################################");
			
			reversKeyValueServiceCodeMap.put("statAppMap", statAppMap);
			reversKeyValueServiceCodeMap.put("statCat1Map", statCat1Map);
			reversKeyValueServiceCodeMap.put("statItemMap", statItemMap);
			
		}catch(Exception e){
			logger.error("make fail serviceStatCodeReversMap",e);
		}
		
		
	}
}
