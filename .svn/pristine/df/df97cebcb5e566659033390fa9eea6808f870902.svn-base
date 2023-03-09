package com.lgu.ccss.common.utility;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

@Component("pageUtil")
public class PageUtil {
  protected static final Log log = LogFactory.getLog(PageUtil.class);
  
  /**
   * 페이징 코드 반환
   * forwardUrl 뒤에 자동으로 &page=1 형식으로 링크를 만들어 반환
   * 리스트 두개가 상/하위 관계이고, 하위 리스트를 조회 하면서 상위 리스트의 페이지 정보를 가지고 있어야 할 때 사용
   * 
   * @param currentPage
   * @param currentPage2
   * @param totalPage
   * @param pageRowCount
   * @param forwardUrl
   * @return
   */
  public String getPagingString(int currentPage, int currentPage2, int totalPage, int pageRowCount, String forwardUrl) {
    StringBuffer page = new StringBuffer();

    int startPage = 0;
    int endPage = 0;
    int iTemp = 0;
    
    /**
     * url에 파라미터가 하나도 없으면 "?page=" 추가.
     * 파라미터가 하나라도 있으면 "&page=" 추가.
     */
    if(forwardUrl.indexOf("?") < 0) {
      forwardUrl += "?page=";
    }
    else {
      forwardUrl += "&page=";
    }
    
    forwardUrl += currentPage + "&cPage=";
    
    page.append("                <div class=\"panel-body text-center\">\n");
    page.append("                  <div class=\"pad-btm text-right\">\n");
    page.append("                    <ul class=\"pagination pagination-sm\">\n");

    if(totalPage > 0) {
      if(currentPage2 % pageRowCount == 0) {
        startPage = currentPage2 - pageRowCount + 1; 
      } else {
        startPage = currentPage2 - (currentPage2 % pageRowCount) + 1;
      }
      endPage = (startPage + pageRowCount) - 1;

      /**
       * 마지막 페이지가 총 페이지보다 크면
       * 마지막 페이지는 총 페이지가 된다.
       */
      if(endPage > totalPage) {
        endPage = totalPage;
      }
      
      // 이전 페이지로 이동
      if(startPage > pageRowCount) {
        // 첫 페이지로 이동
        page.append("                      <li>\n");
        page.append("                        <a class=\"fa fa-angle-double-left\" href=\"" + forwardUrl + "1\"></a>\n");
        page.append("                      </li>\n");
        // 이전 페이지로 이동
        page.append("                      <li class=\"prev\">\n");
        page.append("                        <a class=\"fa fa-angle-left\" href=\"" + forwardUrl + (currentPage - 1) + "\"></a>");
        page.append("                      </li>\n");
      } else {
        page.append("                      <li class=\"disabled\">\n");
        page.append("                        <a class=\"fa fa-angle-double-left disabled\"></a>\n");
        page.append("                      </li>\n");
        page.append("                      <li class=\"disabled\">\n");
        page.append("                        <a class=\"fa fa-angle-left\" \"></a>");
        page.append("                      </li>\n");
      }

      // 실제 페이지들
      // 여기서 반복돌며 페이지 세팅
      for(int i = startPage; i <= endPage; i++) {
        if(currentPage2 == i) {
          // 현재 페이지 기본값
          page.append("                      <li class=\"active\">\n");
          page.append("                        <a style=\"position: static;\">").append(i).append("</a>\n");
        } else {
          page.append("                      <li>\n");
          page.append("                        <a href=\"").append(forwardUrl + i).append("\">").append(i).append("</a>\n");
        }
        page.append("                      </li>");
      }

      // 다음 페이지로 이동(다음 10페이지가 아니라 +1 페이지)
      if(endPage < totalPage) {
        iTemp = startPage + pageRowCount;
        
        // 총 페이지가 현재 페이지보다 클때만 다음 페이지로 이동할 수 있다.
        page.append("                     <li>");
        page.append("                       <a class=\"fa fa-angle-double-right\" href=\"").append(forwardUrl + iTemp).append("\"></a>\n");
        page.append("                     </li>\n");
        page.append("                     <li>");
        page.append("                       <a class=\"fa fa-angle-double-right\" href=\"").append(forwardUrl + totalPage).append("\"></a>\n");
        page.append("                     </li>\n");
      } else {
        // 총 페이지가 현재 페이지보다 크지 않으면 링크 제거
        page.append("                      <li class=\"disabled\">");
        page.append("                        <a class=\"fa fa-angle-right\"></a>\n");
        page.append("                      </li>\n");
        // 마지막 페이지로 이동
        page.append("                      <li class=\"disabled\">");
        page.append("                        <a class=\"fa fa-angle-double-right\"></a>\n");
        page.append("                      </li>\n");
      }
    }
    
    page.append("                    </ul>");
    page.append("                  </div>");
    page.append("                </div>");

    //log.info("paging : " + page.toString());
    
    return page.toString();
  }
  
  /**
   * 페이징 코드 반환
   * 
   * @param currentPage
   * @param totalPage
   * @param pageRowCount
   * @param forwardUrl
   * @return
   */
  public String getPagingString(int currentPage, int totalPage, int pageRowCount, String forwardUrl) {
    StringBuffer page = new StringBuffer();

    int startPage = 0;
    int endPage = 0;
    int iTemp = 0;
    
    // 20개씩보기보다 클 경우 > 한 페이지에 무조건 20페이지씩
    pageRowCount = 10;
    
    /**
     * url에 파라미터가 하나도 없으면 "?page=" 추가.
     * 파라미터가 하나라도 있으면 "&page=" 추가.
     */
    /*if(forwardUrl.indexOf("?") < 0) {
      forwardUrl += "?page=";
    }
    else {
      forwardUrl += "&page=";
    }*/
    
    forwardUrl += "(";
    
    /*page.append("               <div class=\"col-md-4 col-sm-6 ui-sortable\">\n");
    page.append("                 <div class=\"dataTables_info\" id=\"data-table_info\" role=\"status\" aria-live=\"polite\">총 ");
    page.append(totalPage).append("페이지중 ").append(currentPage).append("페이지 보는중</div>\n");
    page.append("               </div>");*/
    
/*    page.append("                <div class=\"panel-body text-center\">\n");
    page.append("                  <div class=\"pad-btm text-right\">\n");
    page.append("                    <ul class=\"pagination pagination-sm\">\n");*/

    //page.append("                  <div class=\"paging\">\n");
    
    if(totalPage > 0) {
      if(currentPage % pageRowCount == 0) {
        startPage = currentPage - pageRowCount + 1; 
      } else {
        startPage = currentPage - (currentPage % pageRowCount) + 1;
      }
      endPage = (startPage + pageRowCount) - 1;

      /**
       * 마지막 페이지가 총 페이지보다 크면
       * 마지막 페이지는 총 페이지가 된다.
       */
      if(endPage > totalPage) {
        endPage = totalPage;
      }
      
      // 이전 페이지로 이동
      if(startPage > pageRowCount) {
        // 이전 페이지로 이동
        page.append("                        <a class=\"prev\" href=\"javascript:" + forwardUrl + (currentPage - 1) + ");\") >Previous</a>");
      } else {
        page.append("                        <a class=\"prev\" disabled >Previous</a>\n");
      }
      
      page.append("                  <div class=\"list\">");

      // 실제 페이지들
      // 여기서 반복돌며 페이지 세팅
      for(int i = startPage; i <= endPage; i++) {
        if(currentPage == i) {
          // 현재 페이지 기본값
          page.append("                        <a class=\"page active\" style=\"position: static;\">").append(i).append("</a>\n");
        } else {
          page.append("                        <a class=\"page\" href=\"javascript:").append(forwardUrl + i).append(");\" >").append(i).append("</a>\n");
        }
      }
      
      page.append("                  </div>");

      // 다음 페이지로 이동(다음 10페이지가 아니라 +1 페이지)
      if(endPage < totalPage) {
        iTemp = startPage + pageRowCount;
        
        // 총 페이지가 현재 페이지보다 클때만 다음 페이지로 이동할 수 있다.
        page.append("                       <a class=\"next\" href=\"javascript:").append(forwardUrl + iTemp).append(");\" >Next</a>\n");
      } else {
        // 총 페이지가 현재 페이지보다 크지 않으면 링크 제거
        page.append("                        <a class=\"next\" disabled >Next</a>\n");
      }
    }
    
    //page.append("                  </div>");

    //log.info("paging : " + page.toString());
    
    return page.toString();
  }
  
  /**
   * 데이터의 총 개수를 받아 총 페이지수를 계산해 반환.
   * @param totalCount   데이터의 총 개수
   * @param pageRowCount     한 페이지에 보여줄 데이터의 개수
   * @return
   */
  public int getTotalPage(int totalCount, int pageRowCount) {
    int page = 1;

    if(totalCount == 0) {
      page = 1;
    }
    else {
      // 페이지 = 총개수 / 한페이지에보여줄 개수
      page = totalCount / pageRowCount;

      /**
       *  총개수와 한페이지에보여줄 개수를 나눠서 나머지가
       *  있다면 페이지수를 1증가 시킨다.
       */
      if(totalCount % pageRowCount > 0) {
        page++;
      }
    }

    return page;
  }
}