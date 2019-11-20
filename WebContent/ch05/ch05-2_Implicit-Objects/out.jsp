<%@ page contentType="text/html; charset=EUC-KR"
				 buffer="5kb"
%>
<%
		request.setCharacterEncoding("EUC-KR");
		int totalBuffer = out.getBufferSize();
		int remainBuffer = out.getRemaining();
		int usedBuffer = totalBuffer - remainBuffer;
		out.print("<b>하하1</b>");
		out.println("<b>하하2</b>");
		out.println("<b>하하3</b><br/>");
%>
출력 버퍼의 전체 크기 : <%=totalBuffer%><br/>
남은 버퍼의 전체 크기 : <%=remainBuffer%><br/>
현재 사용한 버퍼의 전체 크기 : <%=usedBuffer%><br/>