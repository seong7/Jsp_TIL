<!--  declaration1.jsp  -->
<%@ page contentType="text/html; charset=EUC-KR"%>

<%	// servlet ���� _jspService �޼ҵ� ������ ����
		// �޼ҵ� �ȿ��� �޼ҵ� ���� �Ұ�
		// �� �� ������ �޼ҵ� ���� �� ����
	//public void m(){}
	String msg = team + " & " + team1 + "������ !!";
	team = "Japan";
	//msg = team + " & " + team1 + "������ !!";
%>

<%!
	String team = "Korea";
	String team1 = "Australia";
	// �ʵ带 �� �޼ҵ� ����
	// �� ���� (declaration) ��  servlet ���Ͽ����� �ڵ����� class ���� ���ٿ� �ʵ���� ����ǹǷ�
	// JSP �󿡼��� �Ʒ��� �����ص� ������ ȣ�� ������
	// JSP ���� ������ �ʵ� �� �޼ҵ�� �ش� ���� (��, �ش� ������) ������ ��� �����ϹǷ�
		// Ȱ�뼺�� ��������.   �������� ����ϴ� �ʵ� �� �޼ҵ��  .java ���Ϸ�  ������ ȣ���Ͽ� ����Ѵ�.
%>

��µǴ� ����� ?
<%=
	msg
%>