<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import = "java.io.BufferedOutputStream" %>
<%@ page import = "java.io.FileInputStream" %>
<%@ page import = "java.io.BufferedInputStream" %>
<%@ page import = "java.io.File" %>
<%@ page import = "board.BoardMgr" %>
<%
		request.setCharacterEncoding("EUC-KR");
		try {
			String filename = request.getParameter("filename");
			File file = new File(BoardMgr.SAVEFOLDER+File.separator+filename);
			byte b[] = new byte[(int)file.length()];
			
			response.setHeader("Accept-Ranges", "bytes");
			String strClient =request.
					//getHeader("User-Agent");
			if(strClient.indexOf("Trident")>0||strClient.indexOf("MSIE") >0)
			
		}catch(Exception e){
			e.printStackTrace();
		}
%>