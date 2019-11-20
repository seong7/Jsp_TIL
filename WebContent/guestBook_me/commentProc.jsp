<!--  showGuestBook.jsp  (댓글 등록 및 삭제)   =>   commentProc.jsp  -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr"/>
<jsp:useBean id="CmtBean" class="guestbook.CommentBean"/>
<jsp:setProperty property="*" name="CmtBean"/>

<%
		String flag = request.getParameter("flag");
		if(flag.equals("insert")){
			mgr.insertComment(CmtBean);
		} else if(flag.equals("delete")){
			mgr.deleteComment(CmtBean.getCnum());
		}
		
		response.sendRedirect("showGuestBook.jsp");
%>