<%@ page import = "ch03_servlet.MyUtil" %>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String msg = request.getParameter("msg");
		int number = Integer.parseInt(request.getParameter("number"));
		// ��ſ��� ��� ���� String���� ������
		int count = 0;
		
		while (number>count){
%>
	<font color= "<%=MyUtil.randomColor()%>">
	<b><%=msg%></b></font><br/>

<% 
			count++;
	} // -- while
%>