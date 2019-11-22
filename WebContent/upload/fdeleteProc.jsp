<!--  flist.jsp => fdeleteProc.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="upload.FileloadMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		// flist.jsp 에서 체크된 fch 값을 return  (String으로 가져온다.)
		String snum[] = request.getParameterValues("fch");
		
		// String snum[] 을 int num[] 로 type변환
		int num[] = new int[snum.length];
		for(int i=0; i<num.length; i++){
			num[i] = Integer.parseInt(snum[i]);
		}
		
		mgr.deleteFile(num);
		response.sendRedirect("flist.jsp");
%>