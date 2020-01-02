<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
%>

name : ${param.name}<br/>
hobby1 : ${paramValues.hobby[0]}<br/>
hobby2 : ${paramValues.hobby[1]}<br/>
hobby3 : ${paramValues.hobby[2]}<br/>
hobby4 : ${paramValues.hobby[3]}<br/>
hobby5 : ${paramValues.hobby[4]}<br/>

<!-- checkbox 값을 배열로 받는 클래스 : paramValues -->