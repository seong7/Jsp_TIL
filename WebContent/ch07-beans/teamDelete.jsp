<!-- teamDelete.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="ch07_beans.TeamMgr"%>
<% request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="mgr" class="ch07_beans.TeamMgr"/>
<%
		int num = Integer.parseInt(request.getParameter("num"));
		mgr.deleteTeam(num);
		response.sendRedirect("teamList.jsp");
%>