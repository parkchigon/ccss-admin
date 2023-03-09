package com.lgu.ccss.common.domain.ui;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import devonframe.paging.PagingConstants;
import devonframe.paging.PagingHelper;
import devonframe.paging.model.PagingList;
import devonframe.paging.policy.DefaultPagingUIPolicy;
import devonframe.paging.ui.PagingUI;
import devonframe.util.NullUtil;


/**
 * Paging 컴포넌트의 UI를 DevOn UI를 적용하여 그리기 위한 클래스<br>
 * 이 클래스를 이용하여 DevOn Paging 컴포넌트가 제공하는 여러 UI를 만들 수 있다.<br>
 * 샘플로도 PagingUI를 제공하고 있으니, 필요에 따라 수정한다.
 *
 *
 */
public class SamplePagingUI implements PagingUI{

    /**
     * 설정 정보에서 불러올 이미지 Policy
     */
    protected String pagingUIPolicy = "";
    
    protected DefaultPagingUIPolicy pagingUIConfig = new DefaultPagingUIPolicy();

    protected PagingList<?> pagingList;
    
    /**
     * 생성자.
     * 
     */
    public SamplePagingUI() {
    }
    
    /**
     * 생성자.
     * 
     * @param pagingMultiData 화면 페이지 UI를 생성하기 위하여 필요한 페이지 속성이 담긴 데이터
     */
    public SamplePagingUI(PagingList<?> PagingList) {
        this.pagingList = PagingList;
    }
    
    /**
     * 생성자
     * 
     * @param pagingMultiData 화면 페이지 UI를 생성하기 위하여 필요한 페이지 속성이 담긴 데이터
     * @param pagingUISpec 설정 정보에서 가져올 이미지 스펙
     */
    public SamplePagingUI(PagingList<?> PagingList, String pagingUISpec) {
        this.pagingList = PagingList;
        setUIPolicy(pagingUISpec);
    }
    
    /**
     * Get the pagingUIConfig
     * 
     * @return pagingUIConfig
     * @see devonframe.pagination.ui.PagingUI#getPagingUIConfig()
     */
    public DefaultPagingUIPolicy getPagingUIPolicy() {
        return pagingUIConfig;
    }

    /**
     * Set the pagingUIConfig
     * 
     * @param pagingUIConfig
     * @see devonframe.pagination.ui.PagingUI#setPagingUIConfig(devonframe.pagination.policy.PagingUIConfig)
     */
    public void setPagingUIPolicy(DefaultPagingUIPolicy pagingUIConfig) {
        this.pagingUIConfig = pagingUIConfig;
    }

    /**
     * 화면 페이지 UI를 생성하기 위하여 필요한 페이지 속성이 담긴
     * 데이터를 세팅한다.
     */
    public void setPagedList(PagingList<?> PagingList){
        this.pagingList = PagingList;
    }
    
    /**
     * 화면 페이지 UI를 생성하기 위하여 필요한 페이지 속성이 담긴
     * 데이터를 가져온다.
     */
    public PagingList<?> getPagedList() {
        return this.pagingList;
    } 

    /**
     * 페이징에 필요한 자바스크립트를 표시한다.
     * 
     * @return 자바스크립트 문자열
     */
    public String showJavaScript() {
        StringBuffer strbuf =  new StringBuffer();
        strbuf.append("\n<!-- START OF LPAGE JAVASCRIPT -->")
              .append("\n<script type=\"text/javascript\" language=\"javascript\">")
              .append("\n// <![CDATA[")
              .append("\n  function goPage(row) {")
              .append("\n    var pageForm = document.getElementById(\"").append(PagingConstants.TARGET_ROW).append("\").form;")
              .append("\n    pageForm.").append(PagingConstants.TARGET_ROW).append(".value = row;");
        strbuf.append("\n    pageForm.submit();")
              .append("\n  }")
              .append("\n  function goOrderByPage(row, orderBy) {")
              .append("\n    var pageForm = document.getElementById(\"").append(PagingConstants.TARGET_ROW).append("\").form;")
              .append("\n    pageForm.").append(PagingConstants.TARGET_ROW).append(".value = row;")
              .append("\n    pageForm.").append(PagingConstants.ORDER_BY).append(".value = orderBy;");
        strbuf.append("\n    pageForm.submit();").append("\n  }")
              .append("\n  function changePage(sel) {")
             .append("\n    var pageForm = document.getElementById(\"").append(PagingConstants.TARGET_ROW).append("\").form;")
              .append("\n    pageForm.").append(PagingConstants.TARGET_ROW).append(".value = sel.value;");
        strbuf.append("\n    pageForm.submit();").append("\n  }")
              .append("\n  function changeRowSize(sel) {")
             .append("\n    var pageForm = document.getElementById(\"").append(PagingConstants.TARGET_ROW).append("\").form;")
              .append("\n    pageForm.").append(PagingConstants.ROW_SIZE).append(".value = sel.value;");
        strbuf.append("\n    pageForm.submit();").append("\n  }").append("\n// ]]>")
              .append("\n</script>")
              .append("\n<!-- END OF LPAGE JAVASCRIPT -->").toString();
        return strbuf.toString();
    }

    /**
     * POST 방식의 페이징 사용 시에 필요한 파라미터(hidden)를 표시한다.
     *
     * @return 파라미터(hidden) 문자열
     */
    public String showHiddenParam(HttpServletRequest request) {
        StringBuilder hiddenParam = new StringBuilder("");
        hiddenParam.append("\n<input type=\"hidden\" name=\"").append(PagingConstants.TARGET_ROW).append("\" id=\"").append(PagingConstants.TARGET_ROW).append("\" value=\"").append(this.pagingList.getTargetRow()).append("\" />");
        hiddenParam.append("\n<input type=\"hidden\" name=\"").append(PagingConstants.ORDER_BY).append("\" id=\"").append(PagingConstants.ORDER_BY).append("\" value=\"").append(this.pagingList.getOrderBy()).append("\" />");
        hiddenParam.append("\n<input type=\"hidden\" name=\"").append(PagingConstants.ROW_SIZE).append("\" id=\"").append(PagingConstants.ROW_SIZE).append("\" value=\"").append(this.pagingList.getRowSize()).append("\" />");
        return hiddenParam.toString();
    }
    
    /**
     * SELECT 태그를 이용하여 페이지 인덱스를 표시해주는 메서드이다.<br>
     * 리턴되는 문자열에 대한 스타일을 조작하기 위해서는 CSS 파일에 page_select_index 클래스를 편집해야 한다.
     * 
     * @return 페이지 인덱스를 표시하기 위한 select 태그 문자열
     */
    public String showSelectIndex() {
        StringBuffer rtnStr = new StringBuffer();

        rtnStr.append("<select onchange=\"changePage(this)\">");
        int currentPage = pagingList.getCurrentPage();
        int startPageIndex = currentPage - pagingList.getPageSize() + 1;
        if(startPageIndex <= 0)
            startPageIndex = 1;
        int endPageIndex = currentPage + pagingList.getPageSize();
        if (endPageIndex > getPages()) {
            endPageIndex = getPages() + 1;
        }
        
        for (int targetPage = startPageIndex; targetPage < endPageIndex; targetPage++) {
            int targetRow = PagingHelper.getFirstRowIndex(targetPage, pagingList.getRowSize());
            
            rtnStr.append("<option value=\"").append(targetRow).append("\"");
            if (targetPage == currentPage) {
                rtnStr.append(" selected");
            }
            rtnStr.append(">").append(targetPage).append("</option>");
        }
        rtnStr.append("</select>");

        return rtnStr.toString();
    }
    
    /**
     * SELECT 태그를 이용하여 Custom Row 사이즈를 표시해주는 메서드이다. <br>
     * 
     * @return Row Size 인덱스를 표시하기 위한 select 태그 문자열
     */
    public String showCustomRowSize() {
        StringBuffer rtnStr = new StringBuffer();

        rtnStr.append("<select onchange=\"changeRowSize(this)\">");
        int currentRowSize = pagingList.getRowSize();
        int defaultRowSize = pagingList.getDefaultRowSize();
        int [] customRowSize = pagingList.getCustomRowSize();
        
        rtnStr.append("<option value=\"").append(defaultRowSize).append("\"");
        rtnStr.append(" selected");
        rtnStr.append(">").append("--").append("</option>");
        for(int inx = 0; inx < customRowSize.length ; inx++) {
            rtnStr.append("<option value=\"").append(customRowSize[inx]).append("\"");
            if (customRowSize[inx] == currentRowSize) {
                rtnStr.append(" selected");
            }
            rtnStr.append(">").append(customRowSize[inx]).append("</option>");
        }
        
        rtnStr.append("</select>");

        return rtnStr.toString();
    }

    /**
     * 기존에 총 데이터 건수와 페이지 index 선택했던 UI를 한번에 뿌려준다.<br><br>
     * JSP 코드 상에는 아래의 코드가 추가되며 <br>
     *  &nbsp;&nbsp; 총 &lt;LTag:pagingOut value='getRows' /&gt; 건 (&lt;LTag:pagingOut value='showSelectIndex' /&gt; / &lt;LTag:pagingOut value='getPages' /&gt; 페이지)<br>
     * 화면 상에는 아래와 같이 출력된다.<br>
     *  &nbsp;&nbsp; 총 2000030 건 (2345678910 / 400006 페이지)
     * 
     * @return 기존에 총 데이터 건수와 페이지 index 선택했던 UI
     */
    public String showCountFrame() {
        StringBuffer rtnStr = new StringBuffer();
        if(getIndexes() > 0){
            rtnStr.append("총 ");
            rtnStr.append(getRows());
            rtnStr.append("건");
        }
        return rtnStr.toString();
    }

    /**
     * 기존에 페이지 index 및 이전/ 다음 인덱스, 처음/끝 인덱스로 이동하는 
     * 버튼 UI를 만들어 주는 HTML을 생성한다.<br>
     * 예) [첫 페이지][이전 페이지] 6 | 7 | 8 | 9 | 10 [다음 페이지][끝 페이지]
     * 
     * @return 기존에 페이지 index 및 이전/ 다음 인덱스, 처음/끝 인덱스로 이동하는 버튼 UI
     */
    public String showIndexFrame() {
        StringBuffer rtnStr = new StringBuffer();
        if(getIndexes() > 0){
            rtnStr.append(showMoveFirstPage());
            rtnStr.append(showMoveBeforePage());
            rtnStr.append(" "+showIndex()+" ");
            rtnStr.append(showMoveNextPage());
            rtnStr.append(showMoveEndPage());
        }
        return rtnStr.toString();
    }
    
    /**
     * 정렬 기능을 제공하는 필드를 구성하기 위한 메서드이다.<br>
     * 리턴되는 문자열에 대한 스타일을 조작하기 위해서는 CSS 파일에 page_sort_field 클래스를 편집해야 한다.
     * 
     * @param orderByFieldTitle 정렬 링크가 걸려 있는 필드의 타이틀 문자열
     * @param orderByColumnName 정렬을 원하는 컬럼의 이름
     * @return 정렬 링크가 포함된 문자열
     */
    public String showSortField(String orderByFieldTitle, String orderByColumnName) {
        StringBuffer rtnStr = new StringBuffer();
        String orderBy = (pagingList.getOrderBy() == null) ? "" : pagingList.getOrderBy();
        if (("order by " + orderByColumnName + " desc").equals(orderBy)) {
            rtnStr.append(getImageTag(pagingUIConfig.getOrderByDesc(), "내림차순으로 정렬", "▼&nbsp;"));
            rtnStr.append("<a href=\"#\" onclick=\"goOrderByPage(1,''); return false;\" title=\"정렬하지 않음\">");
            rtnStr.append(orderByFieldTitle).append("</a>");
        } else if (("order by " + orderByColumnName + " asc").equals(orderBy)) {
            rtnStr.append(getImageTag(pagingUIConfig.getOrderByAsc(), "오름차순으로 정렬", "▲&nbsp;"));
            rtnStr.append("<a href=\"#\" onclick=\"goOrderByPage(1,'order by ").append(orderByColumnName).append(" desc'); return false;\" title=\"내림차순으로 정렬\">");
            rtnStr.append(orderByFieldTitle).append("</a>");
        } else {
            rtnStr.append(getImageTag(pagingUIConfig.getOrderByNone(), "정렬하지 않음", ""));
            rtnStr.append("<a href=\"#\" onclick=\"goOrderByPage(1,'order by ").append(orderByColumnName).append(" asc'); return false;\" title=\"오름차순으로 정렬\">");
            rtnStr.append(orderByFieldTitle).append("</a>");
        }
        return rtnStr.toString();
    }

    /**
     * 첫 페이지로 이동하기 위한 링크 문자열을 표시한다. <br>
     * 첫 페이지로 이동을 표시하는 이미지를 변경하기 위해서는 설정 파일에서 move-first-page 항목의 값을 수정한다. 만약, 이
     * 항목에 값이 설정되어 있지 않다면 "[첫 페이지]" 값이 기본으로 표시된다. <br>
     * 리턴되는 문자열에 대한 스타일을 조작하기 위해서는 CSS 파일에 page_move_first_page 클래스를 편집해야 한다.
     * 
     * @return 첫 페이지로 이동하기 위한 링크 문자열.
     */
    public String showMoveFirstPage() {
        if (getIndexes() > 0 && pagingList.getCurrentPage() > 1) {
            String titleAttr = "첫 페이지로 이동";
            StringBuffer sb = new StringBuffer();
            sb.append("<li class=\"Lbegin\"><span>")
               .append("<a href=\"#\" onclick=\"goPage('")
              .append(1)
              .append("'); return false;\" title=\"")
              .append(titleAttr).append("\">")
              .append(getImageTag(pagingUIConfig.getMoveFirstPage(), titleAttr, "1page"))
              .append("</a></span></li>");
            return sb.toString();
        }
        return "";
    }

    /**
     * 끝 페이지로 이동하기 위한 링크 문자열을 표시한다. <br>
     * 끝 페이지로 이동을 표시하는 이미지를 변경하기 위해서는 설정 파일에서 move-end-page 항목의 값을 수정한다. 만약, 이
     * 항목에 값이 설정되어 있지 않다면 "[끝 페이지]" 값이 기본으로 표시된다. <br>
     * 리턴되는 문자열에 대한 스타일을 조작하기 위해서는 CSS 파일에 page_move_end_page 클래스를 편집해야 한다.
     * 
     * @return 끝 페이지로 이동하기 위한 링크 문자열.
     */
    public String showMoveEndPage() {
        int targetPage = getPages();
        if (getIndexes() > 0 && pagingList.getCurrentPage() < targetPage) {
            String titleAttr = "끝 페이지로 이동";
            StringBuffer sb = new StringBuffer();
            
            sb.append("<li class=\"Lend\"><span>")
               .append("<a href=\"#\" onclick=\"goPage('")
              .append(getTargetRow(targetPage))
              .append("'); return false;\" title=\"")
              .append(titleAttr).append("\">")
              .append(getImageTag(pagingUIConfig.getMoveEndPage(), titleAttr, targetPage +"page"))
              .append("</a></span></li>");
            return sb.toString();
        }
        return "";
    }

    /**
     * 이전 인덱스로 이동하기 위한 링크 문자열을 표시한다. <br>
     * 이전 인덱스로 이동을 표시하는 이미지를 변경하기 위해서는 설정 파일에서 move-before-index 항목의 값을 수정한다.
     * 만약, 이 항목에 값이 설정되어 있지 않다면 "[이전 인덱스]" 값이 기본으로 표시된다. <br>
     * 리턴되는 문자열에 대한 스타일을 조작하기 위해서는 CSS 파일에 page_move_before_index 클래스를 편집해야 한다.
     * 
     * @return 이전 인덱스로 이동하기 위한 링크 문자열.
     */
    public String showMoveBeforeIndex() {
        int targetIndex = getCurrentIndex() - 1;
        if (getIndexes() > 0 && targetIndex > 0) {
            StringBuffer sb = new StringBuffer();
            sb.append("<li class=\"Lprevious\"><span>");
            sb.append(getPagingTag(getTargetRow(getTargetPage(targetIndex)), "이전 인덱스로 이동", pagingUIConfig.getMoveBeforeIndex(), "[이전 인덱스]"));
            sb.append("</span></li>");
            return sb.toString();
        }
        return "";
    }

    /**
     * 다음 인덱스로 이동하기 위한 링크 문자열을 표시한다. <br>
     * 다음 인덱스로 이동을 표시하는 이미지를 변경하기 위해서는 설정 파일에서 move-next-image 항목의 값을 수정한다. 만약,
     * 이 항목에 값이 설정되어 있지 않다면 "[다음 인덱스]" 값이 기본으로 표시된다. <br>
     * 리턴되는 문자열에 대한 스타일을 조작하기 위해서는 CSS 파일에 page_move_next_index 클래스를 편집해야 한다.
     * 
     * @return 다음 인덱스로 이동하기 위한 링크 문자열.
     */
    public String showMoveNextIndex() {
        int targetIndex = getCurrentIndex() + 1;
        int indexSize = getIndexes();
        if (indexSize > 0 && targetIndex <= indexSize) {
            StringBuffer sb = new StringBuffer();
            sb.append("<li class=\"Lnext\"><span>");
            sb.append(getPagingTag(getTargetRow(getTargetPage(targetIndex)), "다음 인덱스로 이동", pagingUIConfig.getMoveNextIndex(), "[다음 인덱스]"));
            sb.append("</span></li>");
            return sb.toString();
        }
        return "";
    }

    /**
     * 이전 페이지로 이동하기 위한 링크 문자열을 표시한다. <br>
     * 이전 페이지로 이동을 표시하는 이미지를 변경하기 위해서는 설정 파일에서 move-before-page 항목의 값을 수정한다. 만약,
     * 이 항목에 값이 설정되어 있지 않다면 "[이전 페이지]" 값이 기본으로 표시된다. <br>
     * 리턴되는 문자열에 대한 스타일을 조작하기 위해서는 CSS 파일에 page_move_before_page 클래스를 편집해야 한다.
     * 
     * @return 이전 페이지로 이동하기 위한 링크 문자열.
     */
    public String showMoveBeforePage() {
        int targetPage = pagingList.getCurrentPage() - 1;
        if (getIndexes() > 0 && targetPage > 0) {
            StringBuffer sb = new StringBuffer();
            sb.append("<li class=\"Lnext\"><span>");
            sb.append(getPagingTag(getTargetRow(targetPage), "이전 페이지로 이동", pagingUIConfig.getMoveBeforePage(), "[이전 페이지]"));
            sb.append("</span></li>");            
            return sb.toString();            
        }
        return "";
    }

    /**
     * 다음 페이지로 이동하기 위한 링크 문자열을 표시한다. <br>
     * 다음 페이지로 이동을 표시하는 이미지를 변경하기 위해서는 설정 파일에서 move-next-page 항목의 값을 수정한다. 만약, 이
     * 항목에 값이 설정되어 있지 않다면 "[다음 페이지]" 값이 기본으로 표시된다. <br>
     * 리턴되는 문자열에 대한 스타일을 조작하기 위해서는 CSS 파일에 page_move_next_page 클래스를 편집해야 한다.
     * 
     * @return 다음 페이지로 이동하기 위한 링크 문자열.
     */
    public String showMoveNextPage() {
        int targetPage = pagingList.getCurrentPage() + 1;
        if (getIndexes() > 0 && targetPage <= getPages()) {
            StringBuffer sb = new StringBuffer();
            sb.append("<li class=\"Lnext\"><span>");
            sb.append(getPagingTag(getTargetRow(targetPage), "다음 페이지로 이동", pagingUIConfig.getMoveNextPage(), "[다음 페이지]"));
            sb.append("</span></li>");            
            return sb.toString();
        }
        return "";
    }

    /**
     * 페이지 스펙에 정의한 내용을 바탕으로 인덱스 이동을 위한 링크 문자열을 표시한다. <br>
     * 인덱스 간의 구분자 이미지를 변경하기 위해서는 설정 파일에서 index-separator 항목의 값을 수정한다. 만약, 이 항목에
     * 값이 설정되어 있지 않다면 " | " 값이 기본으로 표시된다. <br>
     * 리턴되는 문자열에 대한 스타일을 조작하기 위해서는 CSS 파일에 page_pagenum_active와
     * page_pagenum_inactive 클래스를 편집해야 한다. 이들은 각각 현재 페이지에 대한 인덱스와 그렇지 않은 것에 대한
     * 스타일 클래스를 의미한다. <br>
     * 
     * @return 인덱스 이동을 위한 링크 문자열.
     */
    public String showIndex() {
        StringBuffer retStr = new StringBuffer();

        final String separator = getImageTag(pagingUIConfig.getIndexSeperator(), "index-separator", " | ");
        
        int currentPage = pagingList.getCurrentPage();
        int startPageIndex = getTargetPage(getCurrentIndex());
        int endPageIndex = getTargetPage(getCurrentIndex() + 1);
        if (endPageIndex > getPages()) {
            endPageIndex = getPages() + 1;
        }

        for (int targetPage = startPageIndex; targetPage < endPageIndex; targetPage++) {
            if (targetPage != startPageIndex) {
                retStr.append(separator);
            }
            
            String showIndexStr = "";
            if (targetPage == currentPage) {
                showIndexStr = targetPage + "";
            } else {
                StringBuffer sb = new StringBuffer();
                sb.append("<a href=\"#\" onclick=\"goPage('")
                  .append(getTargetRow(targetPage))
                  .append("'); return false;\" title=\"")
                  .append(targetPage)
                  .append(" 페이지로 이동\">")
                  .append(targetPage)
                  .append("</a>");
                showIndexStr = sb.toString();
            }
            
            if (targetPage == endPageIndex - 1) {
                retStr.append("<li class=\"Llast\"><span>")
                      .append(showIndexStr)
                      .append("</span></li>");
            } else if (targetPage == startPageIndex) {
                retStr.append("<li class=\"Lfirst\"><span>")
                      .append(showIndexStr)
                      .append("</span></li>")
                      .append("\n");
            } else {
                //만약 선택된 글자의 스타일을 주고 싶다면 다음의 li 태그에 class를 삽입하세요.
                retStr.append("<li><span>")
                  .append(showIndexStr)
                  .append("</span></li>")
                  .append("\n");
            }
        }
        return retStr.toString();
    }
    
    /**
     * 설정값에서 가져온 Font 설정이 있는 경우, Font를 그려준다.
     * 
     * @param retStr 리턴 스트링
     * @param fontList font 리스트
     * @param targetPage target 되는 페이지 index
     */
    protected void getFontTag(StringBuffer retStr, String fontList, int targetPage){
        if(fontList != null && fontList.length() > 0){
            retStr.append("<span style=\"")
                  .append(fontList)
                  .append("\">")
                  .append(targetPage)
                  .append("</span>");
        }else{
            retStr.append(targetPage);
        }
    }

    /**
     * 페이징을 위한 링크(A) 태그를 만들어 준다.
     * 
     * @param targetRow 페이징할 로우.
     * @param titleAttr A 태그의 TITLE 속성에 넣을 값.
     * @param imageOrPath A 태그 사이에 넣을 이미지.
     * @param defaultImage 설정 파일에 이미지 경로 값이 없는 경우 사용할 이미지.
     * @return 페이징을 위한 링크 태그 문자열.
     */
    protected String getPagingTag(int targetRow, String titleAttr, String imageOrPath, String defaultImage) {
        StringBuffer rtnStr = new StringBuffer("<a href=\"#\" onclick=\"goPage('").append(targetRow).append("'); return false;\" title=\"").append(titleAttr).append("\">");
        rtnStr.append(getImageTag(imageOrPath, titleAttr, defaultImage)).append("</a>").toString();
        return rtnStr.toString();

    }

    /**
     * 설정 파일에서 이미지 파일의 경로를 가져와 IMG 태그로 만들어준다.
     * 
     * @param imageOrPath 가져올 이미지 또는 경로.
     * @param altAttr IMG 태그의 ALT 속성에 넣을 문자열.
     * @param defaultImage 설정 파일에 값이 없는 경우 사용할 이미지.
     * @return IMG 태그 문자열. 설정 파일에 값이 없는 경우에는 defaultImage.
     */
    protected String getImageTag(String imageOrPath, String altAttr, String defaultImage) {
        try {
            
            if(PagingHelper.isImagePath(imageOrPath)){
                
                String contextPath = 
                        ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
                        .getRequest().getContextPath();
                
                if(NullUtil.notNone(contextPath) && !"/".equals(contextPath)) {
                    imageOrPath = contextPath + imageOrPath;
                }
                
                return new StringBuffer("<img src=\"").append(imageOrPath).append("\" alt=\"").append(altAttr).append("\" />").toString();
            }else{
                return imageOrPath; 
            }
        } catch (Exception e) {
            return defaultImage;
        }
    }

    /**
     * 사용할 spec을 설정한다. 기본적으로 spec은 사용중인 pageSpec을 따르며, 필요 시 이 메서드를 호출하여 사용할
     * spec을 변경할 수 있다.
     * 
     * @param pagingUIPolicy 설정할 spec 문자열.
     */
    public void setUIPolicy(String pagingUIPolicy) {
        this.pagingUIPolicy = pagingUIPolicy;
    }

    /**
     * 현재 사용 중인 spec 문자열을 반환한다.
     * 
     * @return 사용 중인 spec 문자열.
     */
    public String getUIPolicy() {
        return pagingUIPolicy;
    }

    /**
     * 모든 페이지 Row의 갯수를 가져온다.
     * 
     * @return 모든 페이지 Row의 갯수
     */
    public int getRows(){
        return pagingList.getRows();
    }
    
    /**
     * 모든 페이지 인덱스 갯수를 가져온다.
     * 
     * @return 모든 페이지 인덱스 갯수
     */
    public int getPages() {
        return pagingList.getPages();
    }

    /**
     * 하나의 JSP 페이지에서 보여지는 페이지 인덱스 갯수를 가져온다.
     */
    public int getIndexes() {
        return PagingHelper.getIndexOfPage( getPages(), pagingList.getPageSize());
    }

    /**
     * 타겟 인덱스로 해당 인덱스에 대한 타겟 페이지를 가져온다.
     * 
     * @param  타겟 페이지
     * @return 타겟 인덱스에 대한 타겟 페이지.
     */
    protected int getTargetPage(int pageIndex) {
        return PagingHelper.getFirstPageOfIndex(pageIndex, pagingList.getPageSize());
    }
    
    /**
     * 한 화면에 보이는 여러 페이지 인덱스의 단위를 하나의 Index라고 한다.
     * 현재 보고 있는 Index 번호를 리턴한다.
     */
    public int getCurrentIndex(){
        return PagingHelper.getIndexOfPage(pagingList.getCurrentPage(), pagingList.getPageSize());
    }
    
    /**
     * 타겟 페이지로 해당 페이지에 대한 타겟 로우를 가져온다.
     * 
     * @param targetPage 타겟 페이지.
     * @return 타겟 페이지에 대한 타겟 로우.
     */
    protected int getTargetRow(int targetPage) {
        return PagingHelper.getFirstRowIndex(targetPage, pagingList.getRowSize());
    }
}