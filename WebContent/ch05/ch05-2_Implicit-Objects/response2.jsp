<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("EUC-KR");

	//�ش� �������� ��Ű�� �������� �ʰ� �ݵ�� ������ ���ؼ��� ����Ǵ� �������� �����ϴ� ��
		//��Ű & ĳ��(cache) �� �������� �ʴ� �ڵ� : 
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
response2.jsp �������Դϴ�. 