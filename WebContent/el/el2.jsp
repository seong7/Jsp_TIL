<!-- el2.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"
			isELIgnored="true" %>
		<!--  EL 문법 인식 ignore 하도록 지시-->

<%
		request.setCharacterEncoding("EUC-KR");
		// 저장소 : page, request, session, application
		
		request.setAttribute("siteName", "JSPStudy.co.kr");
%>

사이트명: ${siteName}<br/>