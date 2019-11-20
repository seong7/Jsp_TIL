<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="java.util.*, java.text.*"
				 import ="ch03.MyUtil"
				 session="true"
				 buffer="16kb"
				 autoFlush="true"
				 isThreadSafe="true"			 
%>
<%
		request.setCharacterEncoding("EUC-KR");
		Date d = new Date();
		out.print("현재 날짜와 시간은? " + d.toLocaleString() + "<br/>");
		out.print("세션 ID : " + session.getId()/*session ID 가져옴*/);
%>

