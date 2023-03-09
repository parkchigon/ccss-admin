package com.lgu.ccss.common.utility;

import java.io.IOException;
import java.io.Writer;
import java.util.Calendar;
import java.util.List;

import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.util.CellReference;

/**
 * Writes spreadsheet data in a Writer. (YK: in future it may evolve in a
 * full-featured API for streaming data in Excel)
 */
public class SpreadsheetWriter {

    private final Writer _out;

    private int _rownum;

    public SpreadsheetWriter(Writer out) {
        _out = out;
    }

    public void beginSheet() throws IOException {
        _out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>" + "<worksheet xmlns=\"http://schemas.openxmlformats.org/spreadsheetml/2006/main\">");
        _out.write("<sheetData>\n");
        
    }

    public void endSheet(List<String> cellMergeList) throws IOException {
        _out.write("</sheetData>");
        
        
        if(cellMergeList.size() > 0) {
        	_out.write("<mergeCells>");
        	for(String merge : cellMergeList) {
        		_out.write("<mergeCell ref=\""+merge+"\"/>");
        	}
        	_out.write("</mergeCells>");
        }
        
        _out.write("</worksheet>");
    }

    /**
     * Insert a new row
     * 
     * @param rownum
     *            0-based row number
     */
    public void insertRow(int rownum) throws IOException {
        _out.write("<row r=\"" + (rownum + 1) + "\">\n");
        this._rownum = rownum;
    }

    /**
     * Insert row end marker
     */
    public void endRow() throws IOException {
        _out.write("</row>\n");
    }

    public void createCell(int columnIndex, String value, int styleIndex) throws IOException {
        String ref = new CellReference(_rownum, columnIndex).formatAsString();
        _out.write("<c r=\"" + ref + "\" t=\"inlineStr\"");
        if (styleIndex != -1)
            _out.write(" s=\"" + styleIndex + "\"");
        _out.write(">");
        _out.write("<is><t>" + value + "</t></is>");
        _out.write("</c>");

    }

    public void createCell(int columnIndex, String value) throws IOException {
        createCell(columnIndex, value, -1);
    }

    public void createCell(int columnIndex, double value, int styleIndex) throws IOException {
        String ref = new CellReference(_rownum, columnIndex).formatAsString();
        _out.write("<c r=\"" + ref + "\" t=\"n\"");
        if (styleIndex != -1)
            _out.write(" s=\"" + styleIndex + "\"");
        _out.write(">");
        _out.write("<v>" + value + "</v>");
        _out.write("</c>");

    }

    public void createCell(int columnIndex, double value) throws IOException {
        createCell(columnIndex, value, -1);
    }

    public void createCell(int columnIndex, Calendar value, int styleIndex) throws IOException {
        createCell(columnIndex, DateUtil.getExcelDate(value, false), styleIndex);
    }
}
