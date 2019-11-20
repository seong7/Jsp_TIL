<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		Cookie[] cookies=request.getCookies();  	// 요청하는 request 객체에 포함된 cookie 를 가져옴
		if(cookies!=null){
			for(Cookie co : cookies){
			%>
				Cookie Name : <%=co.getName()%><br/>
				Cookie Value : <%=co.getValue()%><p/>
			<%	
			}
		}//---if
%>