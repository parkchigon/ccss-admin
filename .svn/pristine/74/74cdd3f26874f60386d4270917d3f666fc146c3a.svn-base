package com.lgu.ccss.common.domain.ui;

import javax.servlet.http.HttpServletRequest;

import devonframe.paging.PagingConstants;
import devonframe.paging.model.PagingList;



/**
 * Paging 컴포넌트의 UI를 DevOn UI를 적용하여 그리기 위한 클래스<br>
 * 이 클래스를 이용하여 DevOn Paging 컴포넌트가 제공하는 여러 UI를 만들 수 있다.<br>
 * 샘플로도 PagingUI를 제공하고 있으니, 필요에 따라 수정한다.
 *
 *
 */
public class AjaxPagingUI extends SamplePagingUI {
    
    /**
     * 생성자.
     * 
     */
    public AjaxPagingUI() {
    }
    
    /**
     * 생성자.
     * 
     * @param pagingMultiData 화면 페이지 UI를 생성하기 위하여 필요한 페이지 속성이 담긴 데이터
     */
    public AjaxPagingUI(PagingList<?> PagingList) {
        this.pagingList = PagingList;
    }
    
    /**
     * 생성자
     * 
     * @param pagingMultiData 화면 페이지 UI를 생성하기 위하여 필요한 페이지 속성이 담긴 데이터
     * @param pagingUISpec 설정 정보에서 가져올 이미지 스펙
     */
    public AjaxPagingUI(PagingList<?> PagingList, String pagingUISpec) {
        this.pagingList = PagingList;
        setUIPolicy(pagingUISpec);
    }

    /**
     * 페이징에 필요한 자바스크립트를 표시한다.
     * 
     * @return 자바스크립트 문자열
     */
    public String showJavaScript() {
        StringBuffer strbuf =  new StringBuffer();
        strbuf.append("\n<!-- START OF LPAGE for AJAX JAVASCRIPT -->")
              .append("\n<script type=\"text/javascript\" language=\"javascript\">")
              .append("\n// <![CDATA[");
        strbuf.append("\n  function goPage(row) {")
              .append("\n    fnRetrieve(row);")
              .append("\n  }");
        strbuf.append("\n  function goOrderByPage(row, orderBy) {")
              .append("\n    jQuery(\"#").append(PagingConstants.ORDER_BY).append("\").val(orderBy);")
              .append("\n    fnRetrieve(row);")
              .append("\n  }");
        strbuf.append("\n  function changePage(sel) {")
              .append("\n    fnRetrieve(sel.value);")
              .append("\n  }");
        strbuf.append("\n  function changeRowSize(sel) {")
              .append("\n    jQuery(\"#").append(PagingConstants.ROW_SIZE).append("\").val(sel.value);")
              .append("\n    fnRetrieve(sel.value);")
              .append("\n  }");
        strbuf.append("\n// ]]>")
              .append("\n</script>")
              .append("\n<!-- END OF LPAGE for AJAX JAVASCRIPT -->").toString();
        return strbuf.toString();
    }

    /**
     * POST 방식의 페이징 사용 시에 필요한 파라미터(hidden)를 표시한다.
     *
     * @return 파라미터(hidden) 문자열
     */
    public String showHiddenParam(HttpServletRequest request) {
        StringBuffer hiddenParam = new StringBuffer("");
        String orderBy = (pagingList.getOrderBy() == null) ? "" : pagingList.getOrderBy();
        
        hiddenParam.append("\n<input type=\"hidden\" name=\"").append(PagingConstants.TARGET_ROW).append("\" id=\"").append(PagingConstants.TARGET_ROW).append("\" value=\"").append(pagingList.getTargetRow()).append("\" />");
        hiddenParam.append("\n<input type=\"hidden\" name=\"").append(PagingConstants.ORDER_BY).append("\" id=\"").append(PagingConstants.ORDER_BY).append("\" value=\"").append(orderBy).append("\" />");
        hiddenParam.append("\n<input type=\"hidden\" name=\"").append(PagingConstants.ROW_SIZE).append("\" id=\"").append(PagingConstants.ROW_SIZE).append("\" value=\"").append(pagingList.getRowSize()).append("\" />");
        return hiddenParam.toString();
    }
    
}