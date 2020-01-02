<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		
%>
id: ${param.id}<br/>
pwd: ${param["pwd"]}<br/>  <!-- 위 아래 모두 같음 -->