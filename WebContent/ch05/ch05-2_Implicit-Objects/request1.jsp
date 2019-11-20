<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		String name = request.getParameter("name");
		String studentNum = request.getParameter("studentNum");
		String gender = request.getParameter("gender");
		String major = request.getParameter("major");
		
		//hobby는 checkbox로 보내기 때문에 반드시 배열로 받아야 됨.
		String hobby[] = request.getParameterValues("hobby");
		String hobbys = "";
		for(int i = 0;i<hobby.length;i++){
			hobbys+=hobby[i]+"&nbsp;";
		}
		
		if(gender.equals("man")){
			gender = "남자";
		}else {
			gender = "여자";
		}
%>
<html>
<H1 align = "center">입력한 값 확인</H1>
<hr/>
<body>
이름 : <%=name%><br/>
학벅 : <%=studentNum%><br/>
성별 : <%=gender%><br/>
전공 : <%=major%><br/>
취미 : <%=hobbys%>
</body>
</html>
