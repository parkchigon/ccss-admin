<%@page import="com.lgu.ccss.common.utility.JsonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/include/import.jsp" %>
<!--s: header -->
<script>
$.ajaxSetup({
	beforeSend : function(xhr, settings) {
		$(".loding_ajax").show();
	},
	complete : function(xhr, status) {
		$(".loding_ajax").hide();
	}
});
</script>


<%!
	public String getMenuUrl(HashMap menuMap, Object[] programList) {

		String programUrl = "";
		ArrayList subMenuList = (ArrayList) menuMap.get("subNodeList");
		HashMap subMenuMap = new HashMap();
		if(subMenuList != null) {
			if (subMenuList.size() > 0) {
				subMenuMap = (HashMap) subMenuList.get(0);
				String menuId = String.valueOf(subMenuMap.get("menuId"));
				for (int i = 0; i < programList.length; i++) {
					Map programMap = (Map) programList[i];
					String programMenuId = String.valueOf(programMap.get("menuId"));
					if (menuId.equals(programMenuId) && "Y".equals(String.valueOf(programMap.get("stProgramYn")))) {
						programUrl = String.valueOf(programMap.get("programUrl"));
						break;
					}
				}
			} else {
				programUrl = String.valueOf( menuMap.get("programUrl"));
			}
		}
		if (programUrl == null || "".equals(programUrl))
			programUrl = getMenuUrl(subMenuMap, programList);

		return programUrl;
	}

	public String getMenuNavi(HashMap menuMap, String menuId) {
		String menuNavi = "";
		
		ArrayList subNodeList = (ArrayList) menuMap.get("subNodeList");
		HashMap subMenuMap = new HashMap();
		
		for (int i = 0; i < subNodeList.size(); i++) {
			subMenuMap = (HashMap) subNodeList.get(i);
			if (menuId.equals(String.valueOf(subMenuMap.get("menuId")))) {
				menuNavi = String.valueOf(subMenuMap.get("menuNm"));
				break;
			}

			menuNavi = getMenuNavi(subMenuMap, menuId);
			if (!"".equals(menuNavi)) {
				menuNavi = subMenuMap.get("menuNm") + " &gt; " + menuNavi;
				break;
			}
		}

		return menuNavi;
	}

	public String getMenuPath(HashMap menuMap, String menuId) {
		String menuPath = "";
		ArrayList subNodeList = (ArrayList) menuMap.get("subNodeList");
		HashMap subMenuMap = new HashMap();
		
		for (int i = 0; i < subNodeList.size(); i++) {
			subMenuMap = (HashMap) subNodeList.get(i);
			if (menuId.equals(String.valueOf(subMenuMap.get("menuId")))) {
				menuPath = String.valueOf(subMenuMap.get("menuId"));
				break;
			}

			menuPath = getMenuPath(subMenuMap, menuId);
			if (!"".equals(menuPath)) {
				menuPath = subMenuMap.get("menuId") + "," + menuPath;
				break;
			}
		}

		return menuPath;
	}

%>

<div class="header_container">
	<div class="header_inner">
		<div class="header_top cboth">
			<div class="ltr">
				<h1 class="logo"><a href="#"><img src="/admin/resources/common/images/logo_end.png"></a></h1>
				<strong class="user_nm">${USER_INFO.mngrNm}</strong> 님 (${USER_INFO.mngrId}) 
			</div>
			<div class="rtl">
				<a href="javascript:excuteLogout();" class="btn_logout">로그아웃</a>
			</div>
		</div>
		
		<div class="gnb_wrap">
		
			<ul class="menu_wrap">
		
		<%
			/* System.out.println("1################################"); */
 	 	
			HashMap  _topMenuMap = (HashMap)request.getAttribute("MENU_MAP"); // 전체메뉴정보
 	 		/* System.out.println("2################################ _topMenuMap :"+_topMenuMap); */
 	 		
 	 		Iterator<String> mapIter = _topMenuMap.keySet().iterator();
 	        while(mapIter.hasNext()){
 	 
 	            String key = mapIter.next();
 	            String value = String.valueOf(_topMenuMap.get( key ));
 	 
 	          /*   System.out.println("2#####"+key+" : "+value); */
 	 
 	        }

 	 		ArrayList _menuList = (ArrayList)_topMenuMap.get("subNodeList"); // 메뉴리스트
 	 		/* System.out.println("3################################"); */
 	 		
 	 		
 	 		List _programList = (List)request.getAttribute( "MENU_LIST_MAP" ); // 프로그램리스트
 	 		/* System.out.println("4################################"); */
 	 		Object[] _objProgramList = _programList.toArray();
 	 		/* System.out.println("5################################"); */
 	 		String _requestUrl = String.valueOf(request.getAttribute("javax.servlet.forward.request_uri")); //요청URL
			
 	 		String _menuNavi = ""; // 네비게이션에 보여줄 현재 메뉴위치
			String _leftMenuTopTitle = "";
			String _menuId = "";	// 선택된 메뉴아이디
			String _menuPath = ""; // 선택된 메뉴의 상위메뉴코드 포함된 문자열
			HashMap _selectTopMenuMap = null; // 선택된 메뉴
			String _programCharge 	= "";
			String _programTel 		= "";
			String _programEmail 	= "";
			// 요청url 해당하는 menuId를 조회한다.
			for( int i = 0; i < _objProgramList.length; i++ ){
 				Map programMap = (Map)_objProgramList[i];
 				
				if( _requestUrl.equals( String.valueOf(programMap.get("programUrl"))))
				{
					_menuId = String.valueOf(programMap.get( "menuId" ));
					_programCharge = String.valueOf(programMap.get( "programCharge" ));
					_programTel = String.valueOf(programMap.get( "programTel" ));
					_programEmail = String.valueOf(programMap.get( "programEmail" ));
					
					break;
				}
			}
		/* 	System.out.println("6################################"); */
			// 메뉴수만큼 루프돌면서 탑메뉴를 구성한다.
			int _selectMenuIdx = 0;
			int menuIdx = 1;
			String _selectMenuCheck = "";
			
			for( int i = 0; i < _menuList.size(); i++ )
			{		
				HashMap _menuMap = (HashMap)_menuList.get( i );
				if( "".equals( _menuNavi ) ) _menuNavi = getMenuNavi( _menuMap, _menuId );
				if( "".equals( _menuPath ) ) _menuPath = getMenuPath( _menuMap, _menuId );
				
				_selectMenuCheck = "";//선택메뉴초기화
				if( !"".equals(_menuNavi) && _selectTopMenuMap == null )
				{
					_leftMenuTopTitle = String.valueOf(_menuMap.get("menuNm"));
					_menuNavi = _menuMap.get("menuNm") + " &gt; " + _menuNavi;
					_menuPath = _menuMap.get("menuId") + "," + _menuPath;
					_selectTopMenuMap = _menuMap;
					_selectMenuIdx = i + 1;
					_selectMenuCheck = "class=''";
				}
				 getMenuUrl( _menuMap, _objProgramList );
				if( "Y".equals( String.valueOf(_menuMap.get("useYn")))){
					out.println( "<li><a href=\"" + getMenuUrl( _menuMap, _objProgramList ) + "\" class=\"tit_gnb\" alt=\"" + _menuMap.get("menuNm") + "\">" + _menuMap.get("menuNm") + "</a></li>\n" );
					menuIdx++;
				}
			}
 	 	
		%>		
		
			</ul>
		</div>
	</div>
</div>
<!--e: header -->
<div class="loding_ajax" style="display: none;"></div>


