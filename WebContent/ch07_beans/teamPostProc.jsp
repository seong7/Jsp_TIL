<!-- teamPostProc.jsp : teamPost.html ���� �Է��� ����
���̺� ���� ����� ������. ���� �� teamList.jsp �� �Ѿ -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%@page import="ch07_beans.TeamMgr" %>
<%@page import="ch07_beans.TeamBean" %>
<%
		request.setCharacterEncoding("EUC-KR");
		TeamMgr mgr = new TeamMgr();
		TeamBean bean = new TeamBean();
		
		String name = request.getParameter("name");
		String city = request.getParameter("city");
		int age = Integer.parseInt(request.getParameter("age"));
		String team = request.getParameter("team");
		
		// ��û�� ������ ��� ����
		bean.setName(name);
		bean.setCity(city);
		bean.setAge(age);
		bean.setTeam(team);
		
		//���̺� ����
		boolean result = mgr.postTeam(bean);
		String msg = "���� ����";
		String url = "teamPost.jsp";
		if(result){
			msg = "���� ����";
			url = "teamList.jsp";
		}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>