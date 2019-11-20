<%@ page contentType="text/html; charset=EUC-KR"
				 errorPage="error.jsp"
%>
<%
		request.setCharacterEncoding("EUC-KR");
		
%>
<%
	int one = 1;
	int zero = 0;
%>
one과 zero의 사칙연산<p>
one+zero=<%=one + zero%><p>
one-zero=<%=one - zero%><p>
one*zero=<%=one * zero%><p>
one/zero=<%=one / zero%><p>