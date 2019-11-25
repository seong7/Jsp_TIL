<!-- login.jsp 서블릿 형식으로 구현 -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	String id = (String)session.getAttribute("idKey");
					// session 의 값은 object type 이므로 casting 해줌
%>
<html>
	<body>
		<h3>로그인 Servlet 방식</h3>
		<%
			if(id!=null){
		%>
			<%=id%>님 반갑습니다.<p/>
			<a href="logout.jsp"> 로그아웃 </a>
		<%		
			}else{
		%>
			<!-- id : aaa , pwd = 1234 -->
			<form method="post" action="loginServlet">
				id : <input name="id"><br/>
				pwd : <input type="password" name="pwd"><br/>
				<input type="submit" value="로그인">
			</form>
		<%	
			}
		%>
	</body>
</html>