<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String name = request.getParameter("name");
%>
include Action Tag �� Top <p/>
<b><%=name%></b> ������ !!
<hr/> 
