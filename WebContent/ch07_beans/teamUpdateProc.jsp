<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="ch07_beans.TeamBean" %>
<%@ page import="ch07_beans.TeamMgr" %>
<% request.setCharacterEncoding("EUC-KR");%>

<jsp:useBean id="bean" class="ch07_beans.TeamBean"/>
<jsp:useBean id="mgr" class="ch07_beans.TeamMgr" />
<jsp:setProperty property="*" name="bean"/>
<%
	String msg = "";
	String url = "";

	boolean result = mgr.updateTeam(bean);
	if (result) {
		msg = "���� ����";
		url = "teamRead.jsp?num=" + bean.getNum();
	} else {
		msg = "���� ����";
		url ="teamList.jsp";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>