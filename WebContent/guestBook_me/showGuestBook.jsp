<!-- showGuestBook.jsp -->
<%@page import="guestBook_me.CommentBean"%>
<%@page import="guestBook_me.JoinBean"%>
<%@page import="guestBook_me.GuestBookMgr"%>
<%@page import="guestBook_me.GuestBookBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<%request.setCharacterEncoding("EUC-KR");%>
<html>
<head>
<%@include file="getSession.jsp" %>
<title>GuestBook</title>
<script type="text/javascript">
	function updateFn(num) {    // 방명록 수정
		url = "updateGuestBook.jsp?num="+num;
		window.open(url, "Update GuestBook","width=520, height=300");
	}
	
	function commentPost(frm) {   // 빈내용 검사 후 submit  /  (this.form) 형태로 parameter 받음
		if(frm.comment.value==""){
			alert("내용을 입력해 주세요.");
			frm.comment.focus();
			return;
		}
		frm.submit();
	}
	
	function disFn(num){
		//alert(num);
		//var v = "cmt"+num; // 동적으로 부여된 div ID 값
		var v = "cmtT"+num; // 동적으로 부여된 div ID 값
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
<table width="520" cellspacing="0" cellpadding="3">
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
</table> <br/>
<!-- GuestBook List Start -->
<%
	GuestBookMgr mgr = new GuestBookMgr();
	Vector<GuestBookBean> vlist=
			//login 객체는 로그인 성공 시 loginProc.jsp 에서 세션 저장
			//postGuestBook.jsp 에서 useBean으로 가져옴.
			mgr.listGuestBook(login.getId(), login.getGrade());
			//out.print(vlist.size());
%>
<%if(vlist.isEmpty()) {%>
<table width="520" cellspacing="0" cellpadding="7">
	<tr>
		<td>등록된 글이 없습니다.</td>
	</tr>
</table>
<%
	} else{
		for(int i=0; i<vlist.size(); i++){
			//방명록의 글 내용
			GuestBookBean bean = vlist.get(i);
			//방명록 글쓴이
			JoinBean writer = mgr.getJoin(bean.getId());  // 해당 id 의 회원 정보 가져오기
%>
<table width="520" border="1" bordercolor="#000000" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table bgcolor="F5F5F5">
				<tr>
					<td width="225">NO : <%=vlist.size()-i %></td>
					<td width="225">
						<img src="img/face.bmp" border="0" alt="이름">
						<a href = "mailto : <%=writer.getEmail() %>">
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
							//로그인 id와 방명록 쓴 사람의 id가 동일하다면 수정 / 삭제 모두 활성화
							//관리자는 삭제 권한만 갖는다.
							boolean chk = login.getId().equals(writer.getId());
							if(chk||login.getGrade().equals("1")/*관리자*/){
								if(chk){
						%>
									<a href="javascript:updateFn('<%=bean.getNum()%>')">[수정]</a>
						<%}//-- if2 %>
								<a href="deleteGuestBook.jsp?num=<%=bean.getNum()%>">[삭제]</a>
						<%
								if(bean.getSecret().trim().equals("1")){
									out.println("비밀글");
								}
							}// -- if1
						%>
					</td>						
				</tr>
			</table>
		</td>
	</tr>
</table>


<!-- Comment List Start  /////////////////  댓글  /////////////-->

<div id="cmt<%=bean.getNum()%>">
	  <!-- div의 id 를 동적으로 주어 javascript disFn() function에서 호출 -->
	  
<%
		//방명록 글에 for 문 안에 있는 댓글 리스트
		// out.print(bean.getNum());
		Vector<CommentBean> cvlist= mgr.listComment(bean.getNum());
		if(!cvlist.isEmpty()){					// Comment Bean 이 비어 있지 않으면
%>
		<table width="500px" bgcolor="#F5F5F5" id="cmtT<%=bean.getNum()%>" style="display:none;">
		<%
			for(CommentBean cbean : cvlist){    // 댓글 bean에서 불러오기
		%>
			<tr>
				<td>
					<table width="500px">
						<tr>
							<td>
								<b><%=cbean.getCid()%></b>   <!--  Comment 작성자 ID  -->
							</td>
							<td align= "right" style="padding-right:10px;">
								<!-- 로그인 id 와 댓글 작성자 id 가 동일한 경우에만 삭제 기능 활성화 -->
								<%if(cbean.getCid().equals(login.getId())) { %>
									<a href="commentProc.jsp?flag=delete&cnum=<%=cbean.getCnum() %>">
										[삭제]
									</a>
								<%} %>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<%= cbean.getComment()%> <!--  Comment 내용  -->
							</td>
						</tr>
						<tr>
							<td>
								<%=cbean.getCip() %>       <!--  Comment 작성자 IP  -->
							</td>
							<td align="right" style="padding-right:10px;">
								<%=cbean.getCregDate() %>   <!--  Comment 작성 일  -->
							</td>
						</tr>
					</table>
					<hr/>
				</td>
			</tr>
			<%}// -- for _CommentBean   %>
		</table>	
<table width="500px">
	<tr>
		<td>
			<button onclick="javascript:disFn('<%=bean.getNum() %>')">댓글<%=cvlist.size()>0?"  "+cvlist.size():"" %></button>
		</td>
	</tr>
</table>  <!-- Comment List End -->
<% }//-- if%>
</div>


<!-- Comment Form start -->
<form name="cFrm" method="post" action="commentProc.jsp">
	<table>
		<tr>
			<td>
				<textarea name="comment" cols="65px" rows="1px" maxlength="1000"></textarea>
			</td>
			<td>
				<input type="button" value="댓글" onclick="javascript:commentPost(this.form)"> <!-- 빈값 검사 후 form submit -->
				<input type="hidden" name="flag" value="insert"> <!-- commentProc.jsp 에서 insert 와 delete 를 구분함 -->
				<input type="hidden" name="num" value="<%=bean.getNum()%>">
				<input type="hidden" name="cid" value="<%=login.getId() %>">
				<input type="hidden" name="cip" value="<%=request.getRemoteAddr()%>">
			</td>
		</tr>	
	</table>
</form>
<!-- Comment Form End  -->
<%
		}//--- for
	}//--- if
%>
<!-- GuestBook List End -->
</div>
</body>
<%}// include 된   getSession.jsp 의 else문 닫음.%>
</html>




