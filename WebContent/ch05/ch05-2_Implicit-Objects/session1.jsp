<%@ page contentType="text/html; charset=EUC-KR"
				 session="true"
%>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		//DB 연동 시
		
		//session이라는 저장 공간 - 클라이언트 단위로 (클라이언트 하나당 하나씩의) 객체가 생성된다.
		session.setAttribute("idKey", id);  // session 내에 접속한 ID 저장 (다른 페이지에서 해당 클라이언트의 로그인 정보를 확인하기 위함)
		
		//session 생명주기 : 조절가능 (default= 30분)
		session.setMaxInactiveInterval(60*3);  // 주기를 3분으로 변경
%>
<h1>Session Example1</h1>
<Form Method=POST Action="session2.jsp">
	1. 가장 좋아하는 계절은? <br/>
		<INPUT type="radio" Name="season" value="봄">봄
		<INPUT type="radio" Name="season" value="여름">여름
		<INPUT type="radio" Name="season" value="가을">가을
		<INPUT type="radio" Name="season" value="겨울">겨울
	<br/><br/>
	2. 가장 좋아하는 과일은? <br/>
		<input type="radio" name="fruit" value ="watermelon">수박
		<input type="radio" name="fruit" value ="melon">멜론
		<input type="radio" name="fruit" value ="apple">사과
		<input type="radio" name="fruit" value ="orange">오렌지<p>
		<input type="submit" value="결과보기">
</Form>

