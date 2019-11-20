<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>

<!--  객체 생성 하기전에 session 검색한다. 동일한 id(key)와 객체가 있다면
		생성하지 않고 참조를 한다.   teamRead.jsp  line 18   :  session.setAttribute("bean", bean); -->
		
		<!-- 해당 방법이 DB를 한번 덜 거친다???  로직 파악하기 -->
<jsp:useBean id="bean" scope="session" class="ch07_beans.TeamBean" />
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team Mgr</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
<h1>Team Update</h1>
<form method="post" action="teamUpdateProc.jsp">
<table border="1">
<tr>
	<td width="50" align="center">번호</td>
	<td width="150">
		<input name="num" readonly value="<%=bean.getNum()%>">
	</td>
</tr>
<tr>
	<td  align="center">이름</td>
	<td>
		<input name="name" value="<%=bean.getName()%>">
	</td>
</tr>
<tr>
	<td align="center">사는곳</td>
	<td>
		<input name="city" value="<%=bean.getCity()%>">
	</td>
</tr>
<tr>
	<td align="center">나이</td>
	<td >
		<input name="age" value="<%=bean.getAge()%>">
	</td>
</tr>
<tr>
	<td align="center">팀명</td>
	<td>
		<input name="team" value="<%=bean.getTeam()%>">
	</td>
</tr>	
<tr>
	<td colspan="2" align="center">
		<input type="submit" value="UPDATE">
	</td>
</tr>
</table><p/>
</form>
<a href="teamRead.jsp?num=<%=bean.getNum()%>">READ</a>
</div>
</body>
</html>