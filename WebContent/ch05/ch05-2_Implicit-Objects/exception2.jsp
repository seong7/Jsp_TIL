<%@ page contentType="text/html; charset=EUC-KR"
				isErrorPage="true"
%>
<%
		request.setCharacterEncoding("EUC-KR");
		String msg = exception.getMessage();
		String obj = exception.toString();
%>
에러메세지 : <%=msg%><br/>
에러메세지와 클래스 : <%=msg%><br/>