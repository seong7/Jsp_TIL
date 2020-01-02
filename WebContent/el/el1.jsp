<!-- el1.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		// 저장소 : page, request, session, application
		
		request.setAttribute("siteName", "JSPStudy.co.kr");
%>

사이트명 : <%=request.getAttribute("siteName")%><br/>
사이트명: ${siteName}<br/>