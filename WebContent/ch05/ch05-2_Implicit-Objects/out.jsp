<%@ page contentType="text/html; charset=EUC-KR"
				 buffer="5kb"
%>
<%
		request.setCharacterEncoding("EUC-KR");
		int totalBuffer = out.getBufferSize();
		int remainBuffer = out.getRemaining();
		int usedBuffer = totalBuffer - remainBuffer;
		out.print("<b>����1</b>");
		out.println("<b>����2</b>");
		out.println("<b>����3</b><br/>");
%>
��� ������ ��ü ũ�� : <%=totalBuffer%><br/>
���� ������ ��ü ũ�� : <%=remainBuffer%><br/>
���� ����� ������ ��ü ũ�� : <%=usedBuffer%><br/>