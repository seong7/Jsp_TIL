<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String season = request.getParameter("season");
		String fruit = request.getParameter("fruit");
		//id �� ���ǿ��� �����´�.
		String id = (String)session.getAttribute("idKey");
		String sessionId = session.getId();
		int intervalTime = session.getMaxInactiveInterval();
		if(id!=null){
%>
<%=id%> ���� �����ϴ� ������ ������
<%=season%>�� <%=fruit %>�Դϴ�. <br/><br/>
���� id = <%=sessionId%><br/><br/>
���� �����ð� = <%=intervalTime %><br/>
<%	
		//���ǿ� ������ ID ���� ����
		session.removeAttribute("idKey");   // �ַ� Ư�� ���� session���� ������ �� ����Ѵ�.
		//���� ��ü�� ���� �� ����
		session.invalidate(); // ���� �α׾ƿ� �ÿ� ����
		}else{
			out.println("������ �ð��� ����Ǿ��ų� �ٸ� ������ ������ �� �� �����ϴ�.");
		}
 %>