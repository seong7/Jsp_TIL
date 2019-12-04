<%@ page pageEncoding="EUC-KR"%>
<%
    String admin_id = (String)session.getAttribute("adminKey");

	if(admin_id == null) {
		response.sendRedirect("adminLogin.jsp");
	}
%>
<table width="75%" align="center" bgcolor="#FFFF99">
  <tr bgcolor="#FFCC00"> 
    <th><a href="../index.jsp">权</a></th>
    <th><a href="adminLogout.jsp">肺弊酒眶</a></th>
    <th><a href="memberMgr.jsp">雀盔包府</a></th>
    <th><a href="productMgr.jsp">惑前包府</a></th>
    <th><a href="orderMgr.jsp">林巩包府</a></th>
  </tr>
</table> 