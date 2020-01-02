<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		// scope 들의 공통 메소드 : set / get Attribute 등등
		pageContext.setAttribute("msg", "경자년 새해 복 많이 받으세요.");
		  //page scope의 클래스 : pageContext
%>
msg : ${pageScope.msg}<br/>
msg : ${msg}<br/>              <!-- 변수 (msg) 가 중복되지 않는 한 위 아래 같은 값 출력 -->


<!--  scope1.jsp 에서 request에 저장한 변수 sum -->
sum : <%= request.getAttribute("sum") %><br/>
sum : ${requestScope.sum }<br/>   <!-- 위 아래 같음 -->

