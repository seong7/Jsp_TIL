<!-- scope3.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		session.setAttribute("id", "DJJUng");
		application.setAttribute("siteName", "google.com");

%>
id : ${sessionScope.id} <br/>
siteName : ${applicationScope.siteName} <br/>