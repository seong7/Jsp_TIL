<!-- empty.jsp -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("id");
		if(id!=null){
			
		}else{
			
		}
%>
name의 요청 여부 : ${empty param.id}<br/>
<a href="empty.jsp?id=aaa">id값이 요청</a><br/>
<a href="empty.jsp">id값이 요청 없음</a><br/>










