<!-- processGuestBook.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="mgr" class="guestBook_me.GuestBookMgr"/>
<jsp:useBean id="bean" class="guestBook_me.GuestBookBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
		//ip 값은 postGuestBook.jsp 에서 설정하지 않았음
		bean.setIp(request.getRemoteAddr());  //request 의 IP 값을 bean에 저장 
		//비밀글 체크를 안 한 상태 :
		if(bean.getSecret()==null){
			bean.setSecret("0");
		}
		mgr.insertGuestBook(bean);
		response.sendRedirect("showGuestBook.jsp");
%>