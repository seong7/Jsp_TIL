<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		
%>
<!-- SimpleBean ��ü ���� -->
<jsp:useBean id = "bean" class= "ch07_beans.SimpleBean"/>
<!-- SimpleBean bean = new SimpleBean();  ���� ���� �ڵ� (use bean �̶�� action tag ��) -->




<!-- client request �� �� (msg) �� �޾� ��� �����ϴ� �ڵ� : -->
<jsp:setProperty property="msg" name = "bean"/>
<!-- (�� �Ʒ� ���� �ڵ�)

	  * String msg = request.getParameter("msg");
	  * bean.setMsg(msg); 
	  
	  * ��, setProperty �±� :: msg �� �޾ƿ��� setter ������� �ѹ��� �� �� �ְ� ��
	  
	  **** tip
	  - property = "*"   �� ǥ�����ָ� ������ ���� ��� ���� ���� ���μ����� bean�� ������.
	     **��, html form�� input �±� name �� bean �� field ���� �����ؾ߸� �� !!!!!!  -->
	  
	  
	  
msg2 : <jsp:getProperty property="msg" name="bean"/><br/>
<!-- (�� �Ʒ� ���� �ڵ�) 

	  * <%--bean.getMsg()--%> 
	  * ��, bean���� property�� ���� �޾ƿ� expression ���� �����Ŵ (���) -->



cnt2 : <jsp:getProperty property="cnt" name = "bean"/><br/>
msg2 : <%=bean.getMsg()%><br/>
cnt2 : <%=bean.getCnt()%><br/>
<!--  getPreperty �׼��±״�  "*" ����� �Ұ����� -->


