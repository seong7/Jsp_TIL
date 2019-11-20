<%@page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		//세션에 지정한 키값만 삭제
		session.removeAttribute("idKey");
		//세션 객체 자체를 무효화
		session.invalidate();
%>
<script>
	alert("로그아웃 하였습니다.");
	location.href = "login.jsp";
</script>