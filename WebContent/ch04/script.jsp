<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		response.setCharacterEncoding("EUC-KR");
		
%>
<!--  -->
<html>
<body>
<%! String test; %>

<%
	test = "11";
	String scriptlet = "스크립트릿";
	String comment = "주석";
%>
선언문의 출력 1 :  <%=comment%>
test  :    <%=test %>

</body>
</html>
