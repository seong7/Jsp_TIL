<!-- commentProc.jsp : 댓그 저장 및 삭제 처리 페이지 -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr"/>
<jsp:useBean id="cbean" class="guestbook.CommentBean"/>
<jsp:setProperty property="*" name="cbean"/>
<%
		//insert, delete
		String flag = request.getParameter("flag");
		if(flag.equals("insert")){
			mgr.insertComment(cbean);
		}else if(flag.equals("delete")){
			mgr.deleteComment(cbean.getCnum());
		}
		response.sendRedirect("showGuestBook.jsp");
%>





