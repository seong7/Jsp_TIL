<!--  flist.jsp => fdeleteProc.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="upload.FileloadMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		// flist.jsp ���� üũ�� fch ���� return  (String���� �����´�.)
		String snum[] = request.getParameterValues("fch");
		
		// String snum[] �� int num[] �� type��ȯ
		int num[] = new int[snum.length];
		for(int i=0; i<num.length; i++){
			num[i] = Integer.parseInt(snum[i]);
		}
		
		mgr.deleteFile(num);
		response.sendRedirect("flist.jsp");
%>