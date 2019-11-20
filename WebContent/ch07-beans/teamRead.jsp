<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="ch07_beans.TeamBean" %>
<%request.setCharacterEncoding("EUC-KR");%>

<jsp:useBean id="mgr" class="ch07_beans.TeamMgr"/>
<%
		int num=0;
		if(request.getParameter("num")==null){
			//���������� num�� ��û���� ������ (�������� ������ �ƴϸ�_url ���� ?num=4 ���� ��� ��� )
			//������ �������� ���� (���� ���� �������� ������)
			response.sendRedirect("teamList.jsp");
		}else{
			num=Integer.parseInt(request.getParameter("num"));
		}
		TeamBean bean = mgr.readTeam(num);
		
		// ���ǿ� "bean" Ű������ bean ��ü�� ���� (teamUpdate2.jsp ���� ���)
		session.setAttribute("bean", bean);
%>
<!DOCTYPE html>
<html>
<meta charset="EUC-KR">
<title>Team Mgr</title>
<link href="style.css" rel="stylesheet" type="text/css">
<body>
	<div align="center">
		<h1>Team Select</h1>
		<table border="1">
			<tr>
				<td>��ȣ</td>
				<td><%=bean.getNum()%></td>
			</tr>
			<tr>
				<td>�̸�</td>
				<td><%=bean.getName()%></td>
			</tr>
			<tr>
				<td>��°�</td>
				<td><%=bean.getCity()%></td>
			</tr>
			<tr>
				<td>����</td>
				<td><%=bean.getAge()%></td>
			</tr>
			<tr>
				<td>����</td>
				<td><%=bean.getTeam()%></td>
			</tr>
		</table>
		<p />
		<a href="teamList.jsp">LIST</a>&nbsp;&nbsp;
		<a href="teamPost.jsp">POST</a>&nbsp;&nbsp;
		<a href="teamUpdate.jsp?num=<%=num%>">UPDATE</a>&nbsp;&nbsp;
		<a href="teamDelete.jsp?num=<%=num%>">DELETE</a>&nbsp;&nbsp;
		<a href="teamUpdate2.jsp">UPDATE2</a>&nbsp;&nbsp;
	</div>
</body>
</html>