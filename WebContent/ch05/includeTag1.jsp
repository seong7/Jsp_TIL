<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		//includeTag1.html 에서 입력한 이름의 값을 받는다. (request)
		//String name = request.getParameter("name");
%>
<!-- include tag 사용   :  directive include 는 file 속성 / tag include 는 page 속성 -->
		<!--  request 의 정보도 같이 넘어간다.  -->
<jsp:include page="includeTagTop1.jsp"/>


include Action Tag 의 Body