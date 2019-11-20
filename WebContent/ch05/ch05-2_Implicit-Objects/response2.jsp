<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("EUC-KR");

	//해당 페이지를 쿠키에 저장하지 않고 반드시 서버를 통해서만 응답되는 페이지로 설정하는 법
		//쿠키 & 캐쉬(cache) 에 저장하지 않는 코드 : 
	response.setHeader("Pragma", "no-cache");
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
response2.jsp 페이지입니다. 