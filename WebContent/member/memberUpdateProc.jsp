<!-- memberUpdateProc.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="member.MemberMgr"/>
<jsp:useBean id="bean" class="member.MemberBean"/>
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