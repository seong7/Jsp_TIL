<%@ page contentType="text/html; charset=EUC-KR"%> <!-- jsp ����( �ش� ������) �� ���� ���ڵ� -->
<%
		request.setCharacterEncoding("EUC-KR");  // if.html(client) �� request �� ���� EUC-KR�� ���ڵ�
																  // POST ��Ŀ����� ���
		//if.html���� name�� color �� post �Ѵ�.
		//(�Ű����� _prameter �� �������� �ݵ�� form ���� ���� ���� ��ġ�ؾ��Ѵ�.)
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String msg = null;
		
		switch (color){
		case "blue" : msg = "�Ķ���";
			break;
		case "red" : msg = "������";
			break;
		case "orange": msg = "��������";
			break; 
		default : msg = "��Ÿ��";
			color = "white";
		}
%>
<body bgcolor = "<%=color %>">
<%=name %>���� �����ϴ� ������ <%=msg %> �Դϴ�.<br/>
<%=name + " : " + color%>
</body>

