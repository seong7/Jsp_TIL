<%@ page contentType="text/html; charset=EUC-KR"%>
<!--  Sun �� ��å�� JSP �� java �ڵ带 0%ȭ �Ϸ���  -->

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