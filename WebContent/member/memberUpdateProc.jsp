<!-- memberUpdateProc.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="Member.MemberMgr"/>
<jsp:useBean id="bean" class="Member.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	boolean result = mgr.updateMember(bean);
	if(result){
%>
<script>
	alert("ȸ���������� ����");
 	location.href="member.jsp";
</script>
<%} else{
%>
<script>
	alert("ȸ���������� ����")
	location.href="memberUpdate.jsp";
</script>
<%
}
%>