<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String name = request.getParameter("name");
%>
include Action Tag 의 Top <p/>
<b><%=name%></b> 파이팅 !!
<hr/> 
