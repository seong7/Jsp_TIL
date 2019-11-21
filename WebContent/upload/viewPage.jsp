<!--  viewPage.jsp -->
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String saveFolder="C:/Jsp/myapp/WebContent/upload/filestorage";
		final String encoding="EUC-KR";
		final int maxSize=10*1024*1024;// 10mb
		//���� ���ε� : �⺻�� ��Ʈ��ũ or I()
		try{
			//������ ������ ���ε� �Ǵ� ����
			MultipartRequest multi =  /*www.servlets.com �� cos-.zip library �κ��� ���� Ŭ����*/ 
			new MultipartRequest(request, saveFolder, maxSize, encoding, 
					new DefaultFileRenamePolicy()/*�ߺ����� ������ 1  2 �� �ڵ����� �ٿ� ����  / ������ �������*/);
			
			//��û�� form�� file type�� name ��
			String fileName = multi.getFilesystemName("upload");
			//�ߺ��� ���ϸ��� ����Ǳ� ���� ���ε� ���ϸ�
			String original = multi.getOriginalFileName("upload"	);
			String type = multi.getContentType("upload");
			File f = multi.getFile("upload");
			long len = 0;
			if(f!=null){
				len=f.length();
			}
			String user=multi.getParameter("user");
			String title = multi.getParameter("title");
%>
����� ���ϸ� : <%=fileName%><br/>
���� ���ϸ� : <%=original%><br/>
���� Ÿ�� : <%=type%><br/>
���� ũ�� : <%=len	%><br/>
user : <%=user%><br/>
title : <%=title%><br/> 			


<%
		}catch(Exception e){
			e.printStackTrace();
		}
				
%>