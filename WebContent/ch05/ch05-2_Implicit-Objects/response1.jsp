<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		//응답 페이지는 form 의 action 값
		response.sendRedirect("response2.jsp");    // 처리만을 목적으로 함
		// 중요 !!
%>
