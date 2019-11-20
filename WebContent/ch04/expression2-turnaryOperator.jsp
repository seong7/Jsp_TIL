<%@ page import = "java.util.Date"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%!
	public int operation(int i, int j){
		return i>j?i:j;
	}
%>
<%
		response.setCharacterEncoding("EUC-KR");
		Date d = new Date();
		int h = d.getHours();
		int i = 10;
		int j = 20;
		out.print("zz");
%>
지금은 오전일까요? 오후일까요? <%=(h<12)? "오전":"오후"%><br/>
i와 j중에 큰 숫자는? <%= operation(i,j)%><br/>
<% // 삼항 연산자 사용 %> 