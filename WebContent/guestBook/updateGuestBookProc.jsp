<!-- updateGuestBookProc.jsp -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr"/>
<jsp:useBean id="bean" class="guestbook.GuestBookBean"/>
<jsp:setProperty property="*" name="bean"/>
<% 
		if(bean.getSecret()==null){
			bean.setSecret("0");
		}
		mgr.updateGuestBook(bean);
		//창은 닫치고 showGuestBook.jsp는 새로고침
%>
<script>
	opener.location.reload();//showGuestBook.jsp는 새로고침
	self.close();
</script>

