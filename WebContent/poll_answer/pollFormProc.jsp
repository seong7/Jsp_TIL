<!-- pollFormProc.jsp -->
<%@page import="guestbook.MyUtil"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<!-- 요청되는 문자열 값에 대한 인코딩 EUC-KR 세팅. post 방식 -->
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="poll_answer.PollMgr"/>
<%
		int num = MyUtil.parseInt(request, "num");
		String itemnum[] = request.getParameterValues("itemnum");
		boolean result = mgr.updatePoll(num, itemnum);
		String msg = "투표가 등록되지 않았습니다.";
		if(result) msg = "투표하였습니다.";
%>
<script>
	alert("<%=msg%>");
	location.href = "pollList.jsp?num=<%=num%>";
</script>






