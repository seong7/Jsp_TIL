<%@ page contentType="text/html; charset=ISO-8859-1"
				 pageEncoding="EUC-KR"
				 trimDirectiveWhitespaces="true"
%>
<!-- 
		charset : Client �� �޾ƺ� source �� ���ڵ� ���
		pageEncoding : ���� JSP source �� ���ڵ� ���
 -->
 trimDirectiveWhitespaces="false" �׽�Ʈ<br/>
<%
		request.setCharacterEncoding("EUC-KR");
		String s = "�ѱ�";
%>
<%=s%>