<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String siteName = request.getParameter("siteName");
%>
요청한 사이트 명 : <%=siteName%><br/>
<jsp:include page="includeTagTop2.jsp">
	<jsp:param value="aaa" name = "id"/>
	<jsp:param value="1234" name="pwd"/>
</jsp:include>
