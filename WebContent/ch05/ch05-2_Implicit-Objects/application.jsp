<!-- application1.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		// servlet or Application �ܺ�ȯ�� ���� ��ü		
		String mimeType = application.getMimeType("request1.html");		//mimetype : Ŭ���̾�Ʈ���� ���۵� ���� Ÿ��
		String realPath = application.getRealPath("/");
		application.log("application ���� ��ü �α� �׽�Ʈ");  	// log ���Ͽ� console�� ��µǴ� ���� ���� 
		// server ��ü �� ������ ���� ���� : application (���ǰ� �޸� �����ֱⰡ ����) > session > request > page
		application.setAttribute("aaa", "�׽�Ʈ");  // application�� ������ ���� �� ������ ������ �������ȴ�. (�����ϴ� ��� �� ����)
%>
Servlet container �� �̸��� ���� : <%=application.getServerInfo()%><br/>
mimeType : <%=mimeType%><br/>
���� ���� �ý��� ��� : <%=realPath%>