<!-- processGuestBook.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR"); %>
<jsp:useBean id="mgr" class="guestBook_me.GuestBookMgr"/>
<jsp:useBean id="bean" class="guestBook_me.GuestBookBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
		//ip ���� postGuestBook.jsp ���� �������� �ʾ���
		bean.setIp(request.getRemoteAddr());  //request �� IP ���� bean�� ���� 
		//��б� üũ�� �� �� ���� :
		if(bean.getSecret()==null){
			bean.setSecret("0");
		}
		mgr.insertGuestBook(bean);
		response.sendRedirect("showGuestBook.jsp");
%>