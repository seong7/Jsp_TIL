<%@page contentType="text/html;charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="guestBook_me.GuestBookMgr"/>
<jsp:useBean id="login" class="guestBook_me.JoinBean" scope="session"/>
<jsp:setProperty property="*" name="login"/>
<%
		String url="login.jsp";
		if(request.getParameter("url")!=null&&
				!request.getParameter("url").equals("null")){
			url=request.getParameter("url");
		}
		boolean flag = mgr.loginJoin(login.getId(), login.getPwd());
		String msg = "로그인 실패";
		if(flag){
			msg = "로그인 성공";
			login = mgr.getJoin(login.getId());
			session.setAttribute("idKey", login.getId());
			session.setAttribute("login", login);
		}
%>
<script>
	alert("<%=msg%>");	
	location.href="<%=url%>";
</script>





