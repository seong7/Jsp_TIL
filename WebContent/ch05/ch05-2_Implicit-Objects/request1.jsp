<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String name = request.getParameter("name");
		String studentNum = request.getParameter("studentNum");
		String gender = request.getParameter("gender");
		String major = request.getParameter("major");
		
		//hobby�� checkbox�� ������ ������ �ݵ�� �迭�� �޾ƾ� ��.
		String hobby[] = request.getParameterValues("hobby");
		String hobbys = "";
		for(int i = 0;i<hobby.length;i++){
			hobbys+=hobby[i]+"&nbsp;";
		}
		
		if(gender.equals("man")){
			gender = "����";
		}else {
			gender = "����";
		}
%>
<html>
<H1 align = "center">�Է��� �� Ȯ��</H1>
<hr/>
<body>
�̸� : <%=name%><br/>
�й� : <%=studentNum%><br/>
���� : <%=gender%><br/>
���� : <%=major%><br/>
��� : <%=hobbys%>
</body>
</html>
