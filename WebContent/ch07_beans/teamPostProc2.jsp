<!-- teamPostProc2.jsp :  ���� �׼� �±׸� ����Ͽ� ���̺� ���� ��� -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="ch07_beans.TeamMgr"/>
<jsp:useBean id="bean" class="ch07_beans.TeamBean"/>
<!-- ��û�� ���� �ް� �� ��� ������� �ϴ� ��� -->
<jsp:setProperty property="*" name="bean"/>
<% 
		
		boolean result = mgr.postTeam(bean);  //db�� ����
		String msg = "���Խ���";
		String url = "teamPost.jsp";
		if(result){
			msg = "���Լ���";
			url = "teamList.jsp";
		}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>

