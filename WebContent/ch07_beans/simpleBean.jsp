<%@ page import="ch07_beans.SimpleBean"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String msg = request.getParameter("msg");
		int cnt = Integer.parseInt(request.getParameter("cnt"));
		SimpleBean bean = new SimpleBean();
		bean.setMsg(msg);
		bean.setCnt(cnt);
%>

msg : <%=bean.getMsg()%>
cnt : <%=bean.getCnt()%>

