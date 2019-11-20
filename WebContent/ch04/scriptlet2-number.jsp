<%@ page import = "java.util.Date" %>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		response.setCharacterEncoding("EUC-KR");
		float f = 2.3f;
		int i = Math.round(f);
		Date d = new Date();
%>
실수 f 반올림은? <%= i%><br/>
현재의 날짜와 시간은? <%=d.toString()%><br/>