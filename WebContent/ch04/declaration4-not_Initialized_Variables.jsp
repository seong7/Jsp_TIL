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

one 과 two의 합은 ? <%=plusMethod()%><br/>
String msg 값은 ? <%=msg %><br/>
int three 는 ? <%= three%><br/>

</body>
</html>