<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/taglib.jsp" %>
<%-- 메세지 출력후 이동하고자 하는 페이지가 있는 경우 --%>
<c:if test="${forwardUrl != null}">
  <%-- 출력메세지가 있는 경우 --%>
  <c:if test="${result != null}">
    <script>
    $(document).ready(function() {
      alert("${result}");
      location.replace("${forwardUrl}");
    });
    </script>
    <noscript>
      <p>해당페이지는 스크립트가 지원되지 않습니다. 게속하시려면 <a href="${root}/index.do">여기</a>를 클릭하세요</p>
    </noscript>
  </c:if>
  <%-- 출력메세지가 없는 경우 --%>
  <c:if test="${result == null}">
    <script type="text/javascript">
    $(document).ready(function() {
      location.replace("${forwardUrl}");
    });
    </script>
    <noscript>
      <p>해당페이지는 스크립트가 지원되지 않습니다. 게속하시려면 <a href="${root}/index.do">여기</a>를 클릭하세요</p>
    </noscript>
  </c:if>
</c:if>

<%-- 메세지 출력후 이동하고자 하는 페이지가 없는 경우 --%>
<c:if test="${forwardUrl == null}">
  <script type="text/javascript">
  $(document).ready(function() {
    <%-- 출력메세지가 있는 경우 --%>
    <c:if test="${result != null}">
      alert("${result}");
      history.back();
    </c:if>
    <%-- 출력메세지가 없는 경우 --%>
    <c:if test="${result == null}">
      history.back();
    </c:if>
  });
  </script>
  <noscript>
    <p>해당페이지는 스크립트가 지원되지 않습니다. 게속하시려면 <a href="${root}/index.do">여기</a>를 클릭하세요</p>
  </noscript>
</c:if>