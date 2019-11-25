<!-- teamList.jsp -->
<%@page import="ch07_beans.TeamBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="ch07_beans.TeamMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		Vector<TeamBean> vlist = mgr.listTeam();
		//out.println(vlist.size());
%>
<!DOCTYPE html>
<html>
<meta charset = "EUC-KR">
<title>Team Mgr</title>
<link href = "style.css" rel="stylesheet" type="text/css">
</head>
<body>
<div align="center">
<h1>TeamList</h1>
<table border="1">
	<tr>
		<th>��ȣ</th>
		<th>�̸�</th>
		<th>��°�</th>
		<th>����</th>
		<th>����</th>
	</tr>
	<%
		for(int i=0; i<vlist.size(); i++){
			//Vector�� ����� TeamBean ��ü�� ��ȯ.
			TeamBean bean = vlist.get(i);
			int num = bean.getNum();
	%>
	<tr>
		<td><a href="teamRead.jsp?num=<%=bean.getNum()%>"><%=i+1%></a></td>
		<td><%=bean.getName()%></td>
		<td><%=bean.getCity()%></td>
		<td><%=bean.getAge()%></td>
		<td><%=bean.getTeam()%></td>
	</tr>
	<%}//--for %>
</table>
<a href="teamPost.jsp">POST</a>
</div>
</body>
</html>