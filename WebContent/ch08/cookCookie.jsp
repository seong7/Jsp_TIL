<!-- cookCookie.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String cookieName="myCookie";
		Cookie cookie = new Cookie(cookieName, "Apple");
		cookie.setMaxAge(60); // ��Ű�� �����ֱ� : 60�� ����
		cookie.setValue("Melone");
		response.addCookie(cookie);  // �����ϴ� response ��ü�� cooke �� �߰���
%>
��Ű�� ����ϴ�.<br/>
��Ű ������ <a href="tasteCookie.jsp">�����</a>