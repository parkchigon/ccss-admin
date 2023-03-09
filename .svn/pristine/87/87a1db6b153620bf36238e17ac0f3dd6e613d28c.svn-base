package com.lgu.ccss.common.utility;

import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.web.multipart.MultipartFile;


/**
 * @version 1.0 2013. 5. 24.
 * @author lwjfa
 */
public class ExcelUtil {
    
    public static List<String> readExcelHeader(MultipartFile file, int headerCnt) throws Exception {

	    Workbook workbook = WorkbookFactory.create(file.getInputStream());
	
	    Sheet sheet = workbook.getSheetAt(0);
	    
	    int lastRowNum = sheet.getLastRowNum();
	    int lastCellNum = sheet.getRow(0).getLastCellNum();
	    
	    List<String> list = new ArrayList<String>();
	    Row row = null;
	    for (int i = headerCnt; i <= lastRowNum; i++) {
	        row = sheet.getRow(i);
	        if (row != null) {
	        	for(int j = 0; j < lastCellNum; j++){
	        		Cell cell = row.getCell(j);
		        	list.add(cell.toString());
	        	}
	        }
	    }
	    workbook = null;
	    return list;
    }
    
}
