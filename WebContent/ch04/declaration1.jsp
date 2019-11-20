<!--  declaration1.jsp  -->
<%@ page contentType="text/html; charset=EUC-KR"%>

<%	// servlet 에서 _jspService 메소드 영역에 사용됨
		// 메소드 안에는 메소드 선언 불가
		// 즉 이 영역에 메소드 선언 시 오류
	//public void m(){}
	String msg = team + " & " + team1 + "파이팅 !!";
	team = "Japan";
	//msg = team + " & " + team1 + "파이팅 !!";
%>

<%!
	String team = "Korea";
	String team1 = "Australia";
	// 필드를 및 메소드 선언
	// 이 영역 (declaration) 은  servlet 파일에서는 자동으로 class 가장 윗줄에 필드들이 선언되므로
	// JSP 상에서는 아래에 선언해도 위에서 호출 가능함
	// JSP 에서 선언한 필드 및 메소드는 해당 파일 (즉, 해당 페이지) 에서만 사용 가능하므로
		// 활용성이 떨어진다.   범용으로 사용하는 필드 및 메소드는  .java 파일로  생성해 호출하여 사용한다.
%>

출력되는 결과는 ?
<%=
	msg
%>