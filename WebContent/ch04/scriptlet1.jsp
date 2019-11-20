<html>

<body>

<%
	int one = 1;
	int two;
//scriptlet 은 _jspService  메소드 영역에 선언이 되는 요소이다. 그래서 변수는 반드시 초기화되어야 함
// local 변수는 반드시 초기화 필요함  ::  자바의 기본 문법 (?)
	int three = one + two;
	String msg = "꿈은 이루어 진다. ";
%>

<%=one%>
<%=two%>
<%=three%>
<%=msg%>



</body>
</html>

<!--  tip  :  표현식(expression) 도 java 영역이지만,  ;  이 붙지 않음  -->