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
		out.print("���� ��¥�� �ð���? " + d.toLocaleString() + "<br/>");
		out.print("���� ID : " + session.getId()/*session ID ������*/);
%>

