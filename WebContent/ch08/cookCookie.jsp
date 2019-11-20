<!-- cookCookie.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String cookieName="myCookie";
		Cookie cookie = new Cookie(cookieName, "Apple");
		cookie.setMaxAge(60); // 쿠키의 생명주기 : 60초 설정
		cookie.setValue("Melone");
		response.addCookie(cookie);  // 응답하는 response 객체에 cooke 를 추가함
%>
쿠키를 만듭니다.<br/>
쿠키 내용은 <a href="tasteCookie.jsp">여기로</a>