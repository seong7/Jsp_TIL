<!-- processGuestBook.jsp -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr"/>
<jsp:useBean id="bean" class="guestbook.GuestBookBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
		//ip값은 postGuestBook.jsp에서 설정을 하지 않음.
		bean.setIp(request.getRemoteAddr()); //첫번째 방법
		//비밀글 체크를 안 한 상태
		if(bean.getSecret()==null){
			bean.setSecret("0");
		}
		mgr.insertGuestBook(bean);
		response.sendRedirect("showGuestBook.jsp");
%>





