<%@ page contentType="text/html; charset=EUC-KR"%>
<!--  Sun 의 정책은 JSP 내 java 코드를 0%화 하려함  -->

<%
		request.setCharacterEncoding("EUC-KR");
		String s = new String();
		int i = s.length();
%>
<jsp:declaration>
	public int m(int a, int b){
		return a>b?a:b;
	}
</jsp:declaration>
<jsp:scriptlet>
	int a = 22;
	int b = 33;
	
</jsp:scriptlet>
a=<jsp:expression>
	m(a,b)
</jsp:expression>