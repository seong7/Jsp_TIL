<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="mail_me.MailSend" %>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		
		MailSend ms = new MailSend();
		boolean flag = ms.getPwd(id, email);
		if(flag){
%>			
			<script type="text/javascript">
				alert("id�� pwd ������ �̸��Ϸ� �߼��߽��ϴ�.");
				location.href="mailSend.jsp";
			</script>
<%
			//response.sendRedirect("mailSend.jsp");
		}else{
%>
			<script type="text/javascript">
				alert("id�� pwd �� �����ʽ��ϴ�.");
				location.href="mailSend.jsp";
			</script>
<%			
			//response.sendRedirect("mailSend.jsp");
		}
%>
