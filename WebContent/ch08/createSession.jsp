<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = "aaa";
		String pwd = "1234";
		
		// id 와 pwd를 session에 저장
		session.setAttribute("logID", id);
		session.setAttribute("logPWD", pwd);
%>
세션에 id와 pwd를 저장하였습니다.<br/>
<a href = "viewSession.jsp">세션정보 확인</a>
