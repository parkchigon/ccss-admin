package com.lgu.ccss.common.utility;

import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class DefaultXlsxDownRowHandler extends XlsxDownRowHandler {

	public DefaultXlsxDownRowHandler(XSSFWorkbook workbook, Map<String, XSSFCellStyle> wbStyle,
			SpreadsheetWriter shWriter, LinkedHashMap<String, String> sheetMap) {
		super(workbook, wbStyle, shWriter);
		setExcelMap(sheetMap);
	}

	@Override
	public LinkedHashMap<String, String> generateExcelMap() {
		return null;
	}

}
