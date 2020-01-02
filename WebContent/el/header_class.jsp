<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
%>
호스트명 : ${header.host}<br/>
사용브라우저 : ${header["user-agent"]}<br/>
사용언어 : ${header["accept-language"]}<br/>