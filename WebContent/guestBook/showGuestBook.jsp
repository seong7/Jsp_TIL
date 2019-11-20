<!-- showGuestBook.jsp -->
<%@page import="guestbook.CommentBean"%>
<%@page import="guestbook.JoinBean"%>
<%@page import="guestbook.GuestBookMgr"%>
<%@page import="guestbook.GuestBookBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%request.setCharacterEncoding("EUC-KR");%>
<html>
<head>
<%@include file="getSession.jsp" %>
<title>GuestBook</title>
<script type="text/javascript">
	function updateFn(num) {
		url = "updateGuestBook.jsp?num=" + num;
		window.open(url, "Update GuestBook","width=520, height=300");
	}
	
	function commentPost(frm) { //this.form
		if(frm.comment.value==""){
			alert("내용을 입력해 주세요.");
			frm.comment.focus();
			return;
		}
		frm.submit();
	}
	
	function disFn(num) {
		//alert(num);
		var v = "cmt"+num;//동적으로 부여된 div id값
		var e = document.getElementById(v);
		if(e.style.display=='none')
			e.style.display='block';
		else
			e.style.display='none';
	}
</script>
<link href="css/style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#996600">
<div align="center">
<%@include file="postGuestBook.jsp" %>
<%
	
%>
<table width="520" cellspacing="0" cellpadding="3" >
	<tr bgcolor="#F5F5F5">
		<td>
			<font size="2">
			<b><%=login.getName()%></b>님 환영합니다.
			</font>
		</td>
		<td align="right">
			<a href="logout.jsp">로그아웃</a>
		</td>	
	</tr>
</table>
<!-- GuestBook List Start -->
<%
		GuestBookMgr mgr = new GuestBookMgr();
		Vector<GuestBookBean> vlist = 
				//login 객체는 로그인 성공시 loginProc.jsp에서 세션저장
				//postGuestBook.jsp에서 useBean으로 가져옴.
				mgr.listGuestBook(login.getId(), login.getGrade());
				//out.print(vlist.size());
%>
<%if(vlist.isEmpty()){%>
<table  width="520" cellspacing="0" cellpadding="7">
	<tr>
		<td>등록된 글이 없습니다.</td>
	</tr>
</table>
<% 
		}else{	
			for(int i=0;i<vlist.size();i++){
				//방명록 글
				GuestBookBean bean = vlist.get(i);
				//방명록 글쓴이
				JoinBean writer = mgr.getJoin(bean.getId());
%>
<table  width="520" border="1" bordercolor="#000000" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table bgcolor="#F5F5F5">
				<tr>
					<td width="225">NO : <%=vlist.size()-i%></td>					
					<td width="225">
						<img src="img/face.bmp" border="0" alt="이름">
						<a href="mailto:<%=writer.getEmail()%>">
						<%=writer.getName() %></a>
					</td>					
					<td width="150" align="center">
						<%if(writer.getHp()==null||writer.getHp().equals("")){
							out.print("홈페이지가 없네요.");
						}else{
						%>
						<a href="http://<%=writer.getHp()%>">
							<img alt="홈페이지 " src="img/hp.bmp" border="0">
						</a>
						<%}%>
					</td>					
				</tr>
				<tr>
					<td colspan="3"><%=bean.getContents() %></td>					
				</tr>
				<tr>
					<td>IP : <%=bean.getIp()%></td>					
					<td><%=bean.getRegdate()+" "+bean.getRegtime()%></td>					
					<td>
					<%
							//로그인 id와 방명록 쓴 사람의 id와 동일하다면 수정, 삭제 모두 활용화
							//관리자는 삭제 권한만 갇는다.
							boolean chk = login.getId().equals(writer.getId());
							if(chk||login.getGrade().equals("1")/*관리자*/){
								if(chk){
					%>
								<a href="javascript:updateFn('<%=bean.getNum()%>')">[수정]</a>
					<%}//--if2%>	
								<a href="deleteGuestBook.jsp?num=<%=bean.getNum()%>">[삭제]</a>
					<%			
								if(bean.getSecret().trim().equals("1")){
									out.println("비밀글");
								}
							}//---if1
					%>
					</td>						
				</tr>
			</table>
		</td>
	</tr>
</table>	
<!-- Comment List Start -->
<div id="cmt<%=bean.getNum()%>"  style="display:none;">
<%
		//방명록글에 for문 안에 있는 댓글 리스트
		//out.print(bean.getNum());
		Vector<CommentBean> cvlist = 
				mgr.listComment(bean.getNum());
		if(!cvlist.isEmpty()){
%>
		<table width="500" bgcolor="#F5F5F5">
		<%
				for(int j=0;j<cvlist.size();j++){
				CommentBean cbean = cvlist.get(j);			
		%>	
			<tr>
				<td>
					<table width="500">
						<tr>
							<td><b><%=cbean.getCid()%></b>	</td>
							<td align="right">
							<!-- 로그인 id랑 댓글쓴 id랑 동일인만 삭제 기능 활성화 -->
							<%if(cbean.getCid().equals(login.getId())){ %>
								<a href="commentProc.jsp?flag=delete&cnum=<%=cbean.getCnum()%>">
								[삭제]</a>
							<%} %>
							</td>
						</tr>
						<tr>
							<td colspan="2"><%=cbean.getComment() %></td>
						</tr>
						<tr>
							<td><%=cbean.getCip()%></td>
							<td align="right"><%=cbean.getCregDate()%></td>
						</tr>
					</table>
					<hr/>
				</td>
			</tr>
	   <%} %>		
		</table>
<%}//---if%>
</div>
<table width="500"> 
<tr><td><button onclick="disFn('<%=bean.getNum()%>')">
댓글<%=cvlist.size()>0?cvlist.size():""%></button></td></tr>
</table>
<!-- Comment List End -->
<!-- Comment Form Start -->
<form name="cFrm" method="post" action="commentProc.jsp">
	<table>
		<tr>
			<td><textarea name="comment" cols="65" rows="2"maxlength="1000"></textarea></td>
			<td><input type="button" value="댓글" onclick="javascript:commentPost(this.form)">
					<input type="hidden" name="flag" value="insert">
					<input type="hidden" name="num" value="<%=bean.getNum()%>">
					<input type="hidden" name="cid" value="<%=login.getId()%>">
					<input type="hidden" name="cip" value="<%=request.getRemoteAddr()%>">
			</td>
		</tr>
	</table>
</form>
<!-- Comment Form End -->
<%				
			}//---for
		}//---if
%>
<!-- GuestBook List End -->
</div>
</body>
<%}//getSession.jsp에 else를 닫는다.%>
</html>










