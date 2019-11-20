<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		
%>
<!-- SimpleBean 객체 생성 -->
<jsp:useBean id = "bean" class= "ch07_beans.SimpleBean"/>
<!-- SimpleBean bean = new SimpleBean();  위와 같은 코드 (use bean 이라는 action tag 임) -->




<!-- client request 의 값 (msg) 을 받아 빈즈에 저장하는 코드 : -->
<jsp:setProperty property="msg" name = "bean"/>
<!-- (위 아래 같은 코드)

	  * String msg = request.getParameter("msg");
	  * bean.setMsg(msg); 
	  
	  * 즉, setProperty 태그 :: msg 값 받아오고 setter 실행까지 한번에 할 수 있게 함
	  
	  **** tip
	  - property = "*"   로 표시해주면 페이지 내의 모든 값을 위의 프로세스로 bean에 저장함.
	     **단, html form의 input 태그 name 과 bean 의 field 명이 동일해야만 함 !!!!!!  -->
	  
	  
	  
msg2 : <jsp:getProperty property="msg" name="bean"/><br/>
<!-- (위 아래 같은 코드) 

	  * <%--bean.getMsg()--%> 
	  * 즉, bean에서 property의 값을 받아와 expression 식을 실행시킴 (출력) -->



cnt2 : <jsp:getProperty property="cnt" name = "bean"/><br/>
msg2 : <%=bean.getMsg()%><br/>
cnt2 : <%=bean.getCnt()%><br/>
<!--  getPreperty 액션태그는  "*" 사용이 불가능함 -->


