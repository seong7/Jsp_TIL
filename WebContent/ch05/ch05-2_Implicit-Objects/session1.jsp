<%@ page contentType="text/html; charset=EUC-KR"
				 session="true"
%>
<%
		request.setCharacterEncoding("EUC-KR");
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		//DB ���� ��
		
		//session�̶�� ���� ���� - Ŭ���̾�Ʈ ������ (Ŭ���̾�Ʈ �ϳ��� �ϳ�����) ��ü�� �����ȴ�.
		session.setAttribute("idKey", id);  // session ���� ������ ID ���� (�ٸ� ���������� �ش� Ŭ���̾�Ʈ�� �α��� ������ Ȯ���ϱ� ����)
		
		//session �����ֱ� : �������� (default= 30��)
		session.setMaxInactiveInterval(60*3);  // �ֱ⸦ 3������ ����
%>
<h1>Session Example1</h1>
<Form Method=POST Action="session2.jsp">
	1. ���� �����ϴ� ������? <br/>
		<INPUT type="radio" Name="season" value="��">��
		<INPUT type="radio" Name="season" value="����">����
		<INPUT type="radio" Name="season" value="����">����
		<INPUT type="radio" Name="season" value="�ܿ�">�ܿ�
	<br/><br/>
	2. ���� �����ϴ� ������? <br/>
		<input type="radio" name="fruit" value ="watermelon">����
		<input type="radio" name="fruit" value ="melon">���
		<input type="radio" name="fruit" value ="apple">���
		<input type="radio" name="fruit" value ="orange">������<p>
		<input type="submit" value="�������">
</Form>

