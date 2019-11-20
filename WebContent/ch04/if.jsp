<%@ page contentType="text/html; charset=EUC-KR"%> <!-- jsp 파일( 해당 페이지) 에 대한 인코딩 -->
<%
		request.setCharacterEncoding("EUC-KR");  // if.html(client) 의 request 내 값을 EUC-KR로 인코딩
																  // POST 방식에서만 사용
		//if.html에서 name과 color 를 post 한다.
		//(매개변수 _prameter 의 변수명은 반드시 form 에서 보낸 값과 일치해야한다.)
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String msg = null;
		
		switch (color){
		case "blue" : msg = "파란색";
			break;
		case "red" : msg = "빨간색";
			break;
		case "orange": msg = "오렌지색";
			break; 
		default : msg = "기타색";
			color = "white";
		}
%>
<body bgcolor = "<%=color %>">
<%=name %>님이 좋아하는 색깔은 <%=msg %> 입니다.<br/>
<%=name + " : " + color%>
</body>

