<%@ page import = "ch03.MyUtil" %>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String msg = request.getParameter("msg");
		int number = Integer.parseInt(request.getParameter("number"));
		// 통신에서 모든 값은 String으로 변형됨
		int count = 0;
		
		while (number>count){
%>
	<font color= "<%=MyUtil.randomColor()%>">
	<b><%=msg%></b></font><br/>

<% 
			count++;
	} // -- while
%>