<html>

<body>

<%@ page contentType="text/html; charset=EUC-KR" %>
<%!
	int one;
	int two = 1;
	public int plusMethod(){
		return one + two;
	}
	String msg;
	int three;
	
%>

one �� two�� ���� ? <%=plusMethod()%><br/>
String msg ���� ? <%=msg %><br/>
int three �� ? <%= three%><br/>

</body>
</html>