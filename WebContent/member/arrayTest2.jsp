<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		//form���� �ΰ��̻��� ���� ������ name���� request �Ǿ� ���� ��   (checkbox ��)   -->  array �� ó��
		String hobby[] = request.getParameterValues("hobby");   // ������ �˾Ƽ� ������� ��
		for(String hb : hobby){
			out.println(hb + "&nbsp;");
		}
		
		//MemberBean ���� hobby�� �迭�� �����Ѵ�.  :  <jsp: setProperty> ���
		//bean.setHobby(request.getParameterValues("hobby"));
%>