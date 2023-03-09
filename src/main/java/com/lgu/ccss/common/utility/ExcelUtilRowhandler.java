package com.lgu.ccss.common.utility;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 대량의 엑셀리스트를 다운 받기 위해 mybatis Rowhandler 사용하여 엑셀 생성을 구현한다. (개발 예정) Rowhandler
 * 사용시 mybatis 는 List Object 를 생성하지 않고 건건히 처리 하기 때문에 Out Of Memory Excetion 발생하지
 * 않는다.
 * @author skyikho
 *
 */
@Service
public class ExcelUtilRowhandler {
	
	private Logger log = LoggerFactory.getLogger("common");

	private final String tempName = "temp.xlsx";
	

	public void createXlsxDown(String mapperStatmentId, Object param, LinkedHashMap<String, String> headerMap,
			HttpServletResponse response, String fileName, SqlSession sqlSessions) throws Exception {
		createXlsxDown(mapperStatmentId, param, headerMap, response, fileName, sqlSessions, new ArrayList<String>());
		
	}
	public void createXlsxDown(String mapperStatmentId, Object param, LinkedHashMap<String, String> headerMap,
			HttpServletResponse response, String fileName, SqlSession sqlSessions, List<String> cellMergeList) throws Exception {
		
		String DIR_UPLOAD = "/data/excel/oem";
		
		String filePath = DIR_UPLOAD + "/down" + File.separator;
		String extensionNm = ".xlsx";

		File dir = new File(filePath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMddHHmmss", Locale.KOREA );
		Date currentTime = new Date ( );
		String mTime = mSimpleDateFormat.format ( currentTime );
		
		File targetFile = new File(filePath + fileName +"_"+mTime + extensionNm);
		File tempFile = new File(filePath + tempName);
		
		try {

			XSSFWorkbook wb = new XSSFWorkbook();
			XSSFSheet sheet = wb.createSheet("Sheet");

			Map<String, XSSFCellStyle> styles = createStyles(wb);
			String sheetRef = sheet.getPackagePart().getPartName().getName();

			/** 1. save the template **/
			FileOutputStream os = null;
			try {
				os = new FileOutputStream(tempFile);
				wb.write(os);
			} catch (Exception ex) {
				throw new RuntimeException(ex);
			} finally {
				os.close();
			}

			log.info("STEP1 >>>>>>>>>> SUCC");
			// -----------------------------------------------
			/** 2. Generate XML file. **/
			File tmp = File.createTempFile("sheet", ".xml");
			Writer fw = null;
			try {
				fw = new OutputStreamWriter(new FileOutputStream(tmp), "UTF-8");

				SpreadsheetWriter sw = new SpreadsheetWriter(fw);
				sw.beginSheet();

				// ++++ db query 영역 ++++
				DefaultXlsxDownRowHandler rowHandler = new DefaultXlsxDownRowHandler(wb, styles, sw, headerMap);
				sqlSessions.select(mapperStatmentId, param, rowHandler);
				// ++++ db query 영역 종료 ++++

				sw.endSheet(cellMergeList);
			} catch (Exception ex) {
				throw new RuntimeException(ex);
			} finally {
				fw.close();
			}

			/** 3. Substitute the template entry with the generated data */
			FileOutputStream out = null;
			try {
				out = new FileOutputStream(targetFile);
				substitute(tempFile, tmp, sheetRef.substring(1), out);
				tmp.delete();
				tempFile.delete();

			} catch (Exception ex) {
				throw new RuntimeException(ex);
			} finally {
				out.close();
				
				/** 4.다운로드 파일 생성 */
				response.setContentType("application/x-msdownload");
				response.setHeader("Content-Disposition","attachment;filename=" + URLEncoder.encode(targetFile.getName(), "UTF-8"));
				
				FileInputStream inStream = new FileInputStream(targetFile);
				
		        OutputStream outStream = response.getOutputStream();
		         
		        byte[] buffer = new byte[4096];
		        int bytesRead = -1;
		         
		        while ((bytesRead = inStream.read(buffer)) != -1) {
		            outStream.write(buffer, 0, bytesRead);
		        }
		         
		        inStream.close();
		        outStream.close(); 

			}
		} catch (Exception ex) {
			throw new RuntimeException(ex);
		}

	}

	/**
	 * Create a library of cell styles.
	 */
	private static Map<String, XSSFCellStyle> createStyles(XSSFWorkbook wb) {

		Map<String, XSSFCellStyle> styles = new HashMap<String, XSSFCellStyle>();
		XSSFDataFormat fmt = wb.createDataFormat();

		XSSFCellStyle style1 = wb.createCellStyle();
		style1.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
		style1.setDataFormat(fmt.getFormat("0.0%"));
		styles.put("percent", style1);

		XSSFCellStyle style2 = wb.createCellStyle();
		style2.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		style2.setDataFormat(fmt.getFormat("0.0X"));
		styles.put("coeff", style2);

		XSSFCellStyle style3 = wb.createCellStyle();
		style3.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
		style3.setDataFormat(fmt.getFormat("$#,##0.00"));
		styles.put("currency", style3);

		XSSFCellStyle style4 = wb.createCellStyle();
		style4.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
		style4.setDataFormat(fmt.getFormat("mmm dd"));
		styles.put("date", style4);

		XSSFCellStyle style5 = wb.createCellStyle();
		XSSFFont headerFont = wb.createFont();
		headerFont.setBold(true);
		style5.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		style5.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		style5.setBorderRight(XSSFCellStyle.BORDER_THIN);
		style5.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style5.setAlignment(XSSFCellStyle.ALIGN_CENTER);
        style5.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);		
		
        style5.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		style5.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		style5.setFont(headerFont);
		styles.put("header", style5);

		return styles;
	}

	/**
	 *
	 * @param zipfile
	 *            the template file
	 * @param tmpfile
	 *            the XML file with the sheet data
	 * @param entry
	 *            the name of the sheet entry to substitute, e.g.
	 *            xl/worksheets/sheet1.xml
	 * @param out
	 *            the stream to write the result to
	 */
	private static void substitute(File zipfile, File tmpfile, String entry, OutputStream out) throws IOException {
		ZipFile zip = new ZipFile(zipfile);

		ZipOutputStream zos = new ZipOutputStream(out);

		@SuppressWarnings("unchecked")
		Enumeration<ZipEntry> en = (Enumeration<ZipEntry>) zip.entries();
		while (en.hasMoreElements()) {
			ZipEntry ze = en.nextElement();
			if (!ze.getName().equals(entry)) {
				zos.putNextEntry(new ZipEntry(ze.getName()));
				InputStream is = zip.getInputStream(ze);
				copyStream(is, zos);
				is.close();
			}
		}
		zos.putNextEntry(new ZipEntry(entry));
		InputStream is = new FileInputStream(tmpfile);
		copyStream(is, zos);
		is.close();

		zos.close();
	}

	private static void copyStream(InputStream in, OutputStream out) throws IOException {
		byte[] chunk = new byte[1024];
		int count;
		while ((count = in.read(chunk)) >= 0) {
			out.write(chunk, 0, count);
		}
	}
}
