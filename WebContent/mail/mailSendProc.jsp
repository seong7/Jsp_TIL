<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="mail.MailSend"/>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		boolean result = mgr.sendPwd(id, email);
		String msg = "메일전송 실패";
		if(result)
			msg = "메일전송 성공";
%>
<script>
	alert("<%=msg%>");
	location.href = "mailSend.jsp";
</script>