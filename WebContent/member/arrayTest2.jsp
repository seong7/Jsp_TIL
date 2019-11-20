<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		//form에서 두개이상의 값이 동일한 name으로 request 되어 오는 값   (checkbox 등)   -->  array 로 처리
		String hobby[] = request.getParameterValues("hobby");   // 저장은 알아서 순서대로 함
		for(String hb : hobby){
			out.println(hb + "&nbsp;");
		}
		
		//MemberBean 에서 hobby를 배열로 선언한다.  :  <jsp: setProperty> 사용
		//bean.setHobby(request.getParameterValues("hobby"));
%>