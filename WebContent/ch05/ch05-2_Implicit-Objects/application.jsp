<!-- application1.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		// servlet or Application 외부환경 정보 객체		
		String mimeType = application.getMimeType("request1.html");		//mimetype : 클라이언트에게 전송된 문서 타입
		String realPath = application.getRealPath("/");
		application.log("application 내부 객체 로그 테스트");  	// log 파일에 console에 출력되는 내용 저장 
		// server 객체 별 공간의 수용 범위 : application (세션과 달리 생명주기가 없음) > session > request > page
		application.setAttribute("aaa", "테스트");  // application에 데이터 저장 시 서버가 끝나도 유지가된다. (저장하는 경우 잘 없음)
%>
Servlet container 의 이름과 버전 : <%=application.getServerInfo()%><br/>
mimeType : <%=mimeType%><br/>
로컬 파일 시스템 경로 : <%=realPath%>