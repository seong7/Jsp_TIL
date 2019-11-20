<%@ page contentType="text/html; charset=ISO-8859-1"
				 pageEncoding="EUC-KR"
				 trimDirectiveWhitespaces="true"
%>
<!-- 
		charset : Client 가 받아볼 source 의 인코딩 방식
		pageEncoding : 현재 JSP source 의 인코딩 방식
 -->
 trimDirectiveWhitespaces="false" 테스트<br/>
<%
		request.setCharacterEncoding("EUC-KR");
		String s = "한글";
%>
<%=s%>