<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.util.Enumeration" %>
<%
		request.setCharacterEncoding("EUC-KR");
		//������ ���Ǹ� Ȯ�� ���ؼ��� ������ Ű���� �˸��.
		
		String id = (String)session.getAttribute("logID");
		String pwd = (String)session.getAttribute("logPWD");
		out.println("id : " + id + ", pwd :" + pwd + "<p/>");
		
		Enumeration<String> en = session.getAttributeNames(); // session�� ����� ��� ��ü�� key �� return
		while(en.hasMoreElements()){
			String name=en.nextElement();
			Object obj = session.getAttribute(name);
			out.println("session name : " + name + "<br/>");
			out.println("session value : " + obj + "<p/>");
		}
%>