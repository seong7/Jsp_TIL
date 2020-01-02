<!-- elMethod.jsp -->
<%@ page import = "el.ElMethod" %>
<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="m" uri="/WEB-INF/tlds/Functions.tld" %>  <!-- directive (지시자)   taglib -->
<%
		int num = 123456789;
%>

JSP 방식 : <%=ElMethod.comma(num)%><br/>
TLD 방식 : ${m:comma(123456789)}    <!-- directive (지시자)  taglib 을 이용해 tld 파일을 불러와 접두사에 저장. -->