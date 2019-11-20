<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.util.Enumeration" %>
<%
		request.setCharacterEncoding("EUC-KR");
		//저장한 세션만 확인 위해서는 지정한 키값만 알면됨.
		
		String id = (String)session.getAttribute("logID");
		String pwd = (String)session.getAttribute("logPWD");
		out.println("id : " + id + ", pwd :" + pwd + "<p/>");
		
		Enumeration<String> en = session.getAttributeNames(); // session에 저장된 모든 객체의 key 값 return
		while(en.hasMoreElements()){
			String name=en.nextElement();
			Object obj = session.getAttribute(name);
			out.println("session name : " + name + "<br/>");
			out.println("session value : " + obj + "<p/>");
		}
%>