<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		Cookie[] cookies=request.getCookies();  	// ��û�ϴ� request ��ü�� ���Ե� cookie �� ������
		if(cookies!=null){
			for(Cookie co : cookies){
			%>
				Cookie Name : <%=co.getName()%><br/>
				Cookie Value : <%=co.getValue()%><p/>
			<%	
			}
		}//---if
%>