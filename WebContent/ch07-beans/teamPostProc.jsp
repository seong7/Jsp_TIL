<!-- teamPostProc.jsp : teamPost.html 에서 입력한 값을
테이블에 저장 기능의 페이지. 저장 후 teamList.jsp 로 넘어감 -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%@page import="ch07_beans.TeamMgr" %>
<%@page import="ch07_beans.TeamBean" %>
<%
		request.setCharacterEncoding("EUC-KR");
		TeamMgr mgr = new TeamMgr();
		TeamBean bean = new TeamBean();
		
		String name = request.getParameter("name");
		String city = request.getParameter("city");
		int age = Integer.parseInt(request.getParameter("age"));
		String team = request.getParameter("team");
		
		// 요청한 값들을 빈즈에 저장
		bean.setName(name);
		bean.setCity(city);
		bean.setAge(age);
		bean.setTeam(team);
		
		//테이블에 저장
		boolean result = mgr.postTeam(bean);
		String msg = "가입 실패";
		String url = "teamPost.jsp";
		if(result){
			msg = "가입 성공";
			url = "teamList.jsp";
		}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>