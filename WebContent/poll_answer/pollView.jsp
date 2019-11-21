<!--  pollView.jsp -->
<%@page import="java.util.Random"%>
<%@page import="poll_answer.PollItemBean"%>
<%@page import="java.util.Vector"%>
<%@page import="poll_answer.PollListBean"%>
<%@page import="guestbook.MyUtil"%>
<%@page contentType="text/html; charset=EUC-KR"%>
jsp:useBean id="mgr" class="poll.PollMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int num = MyUtil.parseInt(request, "num");
		PollListBean plBean = mgr.getPollRead(num);
		String question = plBean.getQuestion();
		Vector<PollItemBean> vlist = mgr.getView(num);
		//현재 설문에 가장 높은 투표수
		int sumCnt = mgr.sumCount(num);
		Random r = new Random();
%>
<html>
<head>
<title>JSP Poll</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
<div align="center"><br/>
<h2>투표 결과</h2>
<table border="1" width="400">
	<tr>
		<td colspan="4">
		<b>Q : <%=question%></b>	
		</td>
	</tr>
	<tr>
		<td colspan="3">
		<b>총 투표자 : <%=sumCnt%></b>	
		</td>
		<td width="40"><b>count(%)</b></td>
	</tr>
	<%
			for(int i=0;i<vlist.size();i++){
				PollItemBean piBean = vlist.get(i);
				String item[] = piBean.getItem();
				int count = piBean.getCount();
				int ratio = new Double(Math.round((double)
						count/sumCnt*100)).intValue();
				String rgb = "#"+
					Integer.toHexString(r.nextInt(255*255*255));
	%>
	<tr>
		<td width="20" align="center"><%=i+1%></td>
		<td width="120"><%=item[0]%></td>
		<td>막대그래프</td>
		<td width="40" align="center"><%=count%>(<%=ratio%>)</td>
	</tr>	
	<%}//---for%>
</table><br/>
<a href="javascript:window.close()">닫기</a>
</div>
</body>







</html>

