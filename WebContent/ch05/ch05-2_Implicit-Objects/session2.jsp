<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String season = request.getParameter("season");
		String fruit = request.getParameter("fruit");
		//id 는 세션에서 가져온다.
		String id = (String)session.getAttribute("idKey");
		String sessionId = session.getId();
		int intervalTime = session.getMaxInactiveInterval();
		if(id!=null){
%>
<%=id%> 님이 좋아하는 계절과 과일은
<%=season%>과 <%=fruit %>입니다. <br/><br/>
세션 id = <%=sessionId%><br/><br/>
세션 유지시간 = <%=intervalTime %><br/>
<%	
		//세션에 저장한 ID 값을 제거
		session.removeAttribute("idKey");   // 주로 특정 값을 session에서 제거할 때 사용한다.
		//세션 자체를 종료 및 제거
		session.invalidate(); // 보통 로그아웃 시에 사용됨
		}else{
			out.println("세션의 시간이 경과되었거나 다른 이유로 연결을 할 수 없습니다.");
		}
 %>