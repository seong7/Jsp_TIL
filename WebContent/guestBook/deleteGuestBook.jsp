<%@page import="guestbook.MyUtil"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int num = 0;
		if(request.getParameter("num")!=null){
			num = Integer.parseInt(request.getParameter("num"));
			num = MyUtil.parseInt(request, "num");
			mgr.deleteGuestBook(num);
			mgr.deleteAllComment(num);
		}
		response.sendRedirect("showGuestBook.jsp");
%>