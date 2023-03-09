package com.lgu.ccss.common.utility;

import java.io.IOException;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public abstract class XlsxDownRowHandler implements ResultHandler {

    private int rowNum;

    @SuppressWarnings("unused")
    private int sheetNum;

    private XSSFWorkbook workbook;

    @SuppressWarnings("unused")
    private XSSFSheet sheet;

    private LinkedHashMap<String, String> excelMap;

    @SuppressWarnings("unused")
    private int maxRowCountPerSheet;

    // 엑셀 파일 작성 객체.
    private SpreadsheetWriter shWriter;

    private Map<String, XSSFCellStyle> styles;

    public XlsxDownRowHandler(XSSFWorkbook workbook, Map<String, XSSFCellStyle> wbStyle, SpreadsheetWriter shWriter) {
        this.workbook = workbook;
        this.shWriter = shWriter;

        this.styles = wbStyle;

        init(0);
    }

    public XlsxDownRowHandler(XSSFWorkbook workbook, Map<String, XSSFCellStyle> wbStyle, SpreadsheetWriter shWriter, int maxRowCountPerSheet) {
        this.workbook = workbook;
        this.shWriter = shWriter;

        this.styles = wbStyle;

        init(maxRowCountPerSheet);
    }

    private void init(int maxRowCountPerSheet) {
        this.rowNum = 0;
        this.sheetNum = 1;
        this.excelMap = new LinkedHashMap<String, String>();
        this.excelMap = generateExcelMap();
        this.maxRowCountPerSheet = maxRowCountPerSheet;
    }

    @Override
    public void handleResult(ResultContext rs) {
    	Map dataMap = (Map) rs.getResultObject();
        if (this.rowNum == 0) {
            // 영문 header 생성.
        	createSheetTiles();
        } 
        addRow(dataMap, this.styles.get("data"));
        // System.out.println("#### "+ this.rowNum);
    }

    /**
     * title row 작성.
     * 
     * @param wb
     * @param excelMap
     * @return
     */
    @SuppressWarnings("rawtypes")
    private void createSheetTiles() {
    	
    	Set<String> mergeSet = new HashSet<String>();
    	
    	Iterator headerKeys = this.excelMap.keySet().iterator();
    	int maxRows = 0;
        while (headerKeys.hasNext()) {
            String headerKey = (String) headerKeys.next();
            String headerValue = (String) this.excelMap.get(headerKey);
            int countMatch = StringUtils.countMatches(headerValue, "|");
            
            if(countMatch > maxRows) {
            	maxRows = countMatch;
            }
        }
        
        maxRows++;
        
        for(int i=0; i<maxRows; i++) {		//i = rows 수
        	int cellCount = 0;
        	headerKeys = this.excelMap.keySet().iterator();
        	Map newHeaderMap = new HashMap<>();
        	String cellMergeValString = null;
        	String cellMergeStart = "";
        	String cellMergeEnd = "";
        	
	        while (headerKeys.hasNext()) {
	        	cellCount++;
	        	String headerKey = (String) headerKeys.next();
	        	String headerValue = (String) this.excelMap.get(headerKey);
	        	int countMatch = StringUtils.countMatches(headerValue, "|");
	        	if(countMatch >= 1) {
	        		//두 Cell 이상 병합되어야 하는 셀(ex - A1:C1)
	        		String[] headerValueArray = StringUtils.split(headerValue, "|");
	        		newHeaderMap.put(headerKey, headerValueArray[i]);
	        		
	        		if(StringUtils.isBlank(cellMergeValString)) {
	        			//신규 병합용 첫번째 Cell
	        			cellMergeValString = headerValueArray[i];
	        			
	        			String cellChar = getCharForNumber(cellCount);
	        			cellMergeStart = cellChar+(i+1);
	        			
	        		} else {
	        			//기존 병합용 Cell
	        			if(cellMergeValString.equals(headerValueArray[i])) {
	        				//이전 값과 현재 값이 동일하면 셀 카운트 증가만
	        			} else {
	        				//이전 값과 현재 값이 다르면 신규 cell 병합 시작. 
	        				//1. 이전 셀병합 정보 저장. 
	        				//2. 신규값 변경 + 셀카운트 초기화

	        				String cellChar = getCharForNumber(cellCount-1);
	        				cellMergeEnd = cellChar+(i+1);
	        				mergeSet.add(cellMergeStart+":"+cellMergeEnd);
	        				
	        				cellChar = getCharForNumber(cellCount);
	        				cellMergeStart = cellChar+(i+1);
	        				cellMergeValString = headerValueArray[i];
	        			}
	        			
	        		}
	        	} else {
	        		//row 병합 되어야 하는 셀(ex - A1:A3)
	        		newHeaderMap.put(headerKey, headerValue);
	        		String cellChar = getCharForNumber(cellCount);
	        		mergeSet.add(cellChar+"1:"+cellChar+maxRows);
	        	}
	        }
	        addRow(newHeaderMap, this.styles.get("header"));
        }

    	
        try {
			JsonUtil.marshallingJson(mergeSet);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
    	
        //addRowHeader(this.excelMap, this.styles.get("header"));
    }

	private String getCharForNumber(int i) {
	    return i > 0 && i < 27 ? String.valueOf((char)(i + 64)) : null;
	}	
    
    
    
    
    /*
     * @SuppressWarnings({ "rawtypes", "unused" }) private void addRow(Map
     * dataMap) throws RuntimeException { addRow(dataMap, null); }
     */
    @SuppressWarnings("rawtypes")
    private void addRow(Map dataMap, XSSFCellStyle cellStyle) throws RuntimeException {
        Iterator keyData = this.excelMap.keySet().iterator();
        int i = 0;
        try {
            this.shWriter.insertRow(this.rowNum);

            while (keyData.hasNext()) {
                String key = (String) keyData.next();
                String value = "";
                double valueDouble = 0l;
                if(dataMap.get(key) != null){
                    if(dataMap.get(key) instanceof String){
                        value = (String) dataMap.get(key);
                    }else{
                        if(dataMap.get(key) instanceof Integer){
                        	valueDouble = (Integer) dataMap.get(key);
                        }else if(dataMap.get(key) instanceof Long){
                        	valueDouble = (Long) dataMap.get(key);
                        }else if(dataMap.get(key) instanceof Double){
                        	valueDouble = (Double) dataMap.get(key);
                        }else if(dataMap.get(key) instanceof BigInteger){
                        	valueDouble =  Double.parseDouble(((BigInteger) dataMap.get(key)).toString());
                        }else {
                            value = (dataMap.get(key)).toString();
                        }
                    }                	
                }
                
                // ** 한글일 때 파일 깨짐.!!!
                // value = ComUtil.nvl(value, "");
                value = changeXmlStr(value);
                if (cellStyle != null) {
                	if(StringUtils.isNotBlank(value)) {
                		this.shWriter.createCell(i, value, cellStyle.getIndex());
                	} else {
                		this.shWriter.createCell(i, valueDouble, cellStyle.getIndex());
                	}
                } else {
                	if(StringUtils.isNotBlank(value)) {
                		this.shWriter.createCell(i, value);
                	} else {
                		this.shWriter.createCell(i, valueDouble);
                	}
                }

                i++;
            }
            this.shWriter.endRow();

        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }

        this.rowNum++;
    }
    
    
    @SuppressWarnings("rawtypes")
    private void addRowHeader(Map dataMap, XSSFCellStyle cellStyle) throws RuntimeException {
        Iterator keyData = this.excelMap.keySet().iterator();
        int i=0;
        try {
            this.shWriter.insertRow(this.rowNum);

            // 영문 Header
            while (keyData.hasNext()) {
                String key = (String) keyData.next();
                String value = "";
                if(dataMap.get(key) != null){
                	value = key;
                }
                
                if (cellStyle != null) {
                    this.shWriter.createCell(i, value, cellStyle.getIndex());
                } else {
                    this.shWriter.createCell(i, value);
                }
                i++;
            }
            this.shWriter.endRow();
            
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
        this.rowNum++;
        addRow(this.excelMap, this.styles.get("header"));
    }

    /**
     * @param param
     * @return
     */
    public static String changeXmlStr(String param) {
        if (param == null)
            param = "";
        else {
            param = param.replaceAll("<", "&lt;");
            param = param.replaceAll(">", "&gt;");
            param = param.replaceAll("&", "&amp;");
        }

        return param;
    }

    /**
     * 
     * @return
     */
    public abstract LinkedHashMap<String, String> generateExcelMap();

    public XSSFWorkbook getWorkbook() {
        return workbook;
    }

    protected LinkedHashMap<String, String> getExcelMap() {
        return excelMap;
    }

    protected void setExcelMap(LinkedHashMap<String, String> excelMap) {
        this.excelMap = excelMap;
    }
}
