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
	function updateFn(num) {    // ���� ����
		url = "updateGuestBook.jsp?num="+num;
		window.open(url, "Update GuestBook","width=520, height=300");
	}
	
	function commentPost(frm) {   // �󳻿� �˻� �� submit  /  (this.form) ���·� parameter ����
		if(frm.comment.value==""){
			alert("������ �Է��� �ּ���.");
			frm.comment.focus();
			return;
		}
		frm.submit();
	}
	
	function disFn(num){
		//alert(num);
		//var v = "cmt"+num; // �������� �ο��� div ID ��
		var v = "cmtT"+num; // �������� �ο��� div ID ��
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
			<b><%=login.getName()%></b>�� ȯ���մϴ�.
			</font>
		</td>
		<td align="right">
			<a href="logout.jsp">�α׾ƿ�</a>
		</td>	
	</tr>
</table> <br/>
<!-- GuestBook List Start -->
<%
	GuestBookMgr mgr = new GuestBookMgr();
	Vector<GuestBookBean> vlist=
			//login ��ü�� �α��� ���� �� loginProc.jsp ���� ���� ����
			//postGuestBook.jsp ���� useBean���� ������.
			mgr.listGuestBook(login.getId(), login.getGrade());
			//out.print(vlist.size());
%>
<%if(vlist.isEmpty()) {%>
<table width="520" cellspacing="0" cellpadding="7">
	<tr>
		<td>��ϵ� ���� �����ϴ�.</td>
	</tr>
</table>
<%
	} else{
		for(int i=0; i<vlist.size(); i++){
			//������ �� ����
			GuestBookBean bean = vlist.get(i);
			//���� �۾���
			JoinBean writer = mgr.getJoin(bean.getId());  // �ش� id �� ȸ�� ���� ��������
%>
<table width="520" border="1" bordercolor="#000000" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table bgcolor="F5F5F5">
				<tr>
					<td width="225">NO : <%=vlist.size()-i %></td>
					<td width="225">
						<a href = "mailto:<%=writer.getEmail() %>">
						<img src="img/face.bmp" border="0" alt="�̸�">
						<%=writer.getName() %></a>
					</td>
					<td width="150" align="center">
						<%if(writer.getHp()==null||writer.getHp().equals("")){
							out.print("Ȩ�������� ���׿�.");
							}else{
						%>
						<a href="http://<%=writer.getHp()%>">
						<img alt="Ȩ������ " src="img/hp.bmp" border="0">
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
							//�α��� id�� ���� �� ����� id�� �����ϴٸ� ���� / ���� ��� Ȱ��ȭ
							//�����ڴ� ���� ���Ѹ� ���´�.
							boolean chk = login.getId().equals(writer.getId());
							if(chk||login.getGrade().equals("1")/*������*/){
								if(chk){
						%>
									<a href="javascript:updateFn('<%=bean.getNum()%>')">[����]</a>
						<%}//-- if2 %>
								<a href="deleteGuestBook.jsp?num=<%=bean.getNum()%>">[����]</a>
						<%
								if(bean.getSecret().trim().equals("1")){
									out.println("��б�");
								}
							}// -- if1
						%>
					</td>						
				</tr>
			</table>
		</td>
	</tr>
</table>


<!-- Comment List Start  /////////////////  ���  /////////////-->

<div id="cmt<%=bean.getNum()%>">
	  <!-- div�� id �� �������� �־� javascript disFn() function���� ȣ�� -->
	  
<%
		//���� �ۿ� for �� �ȿ� �ִ� ��� ����Ʈ
		// out.print(bean.getNum());
		Vector<CommentBean> cvlist= mgr.listComment(bean.getNum());
		if(!cvlist.isEmpty()){					// Comment Bean �� ��� ���� ������
%>
		<table width="500px" bgcolor="#F5F5F5" id="cmtT<%=bean.getNum()%>" style="display:none;">
		<%
			for(CommentBean cbean : cvlist){    // ��� bean���� �ҷ�����
		%>
			<tr>
				<td>
					<table width="500px">
						<tr>
							<td>
								<b><%=cbean.getCid()%></b>   <!--  Comment �ۼ��� ID  -->
							</td>
							<td align= "right" style="padding-right:10px;">
								<!-- �α��� id �� ��� �ۼ��� id �� ������ ��쿡�� ���� ��� Ȱ��ȭ -->
								<%if(cbean.getCid().equals(login.getId())) { %>
									<a href="commentProc.jsp?flag=delete&cnum=<%=cbean.getCnum() %>">
										[����]
									</a>
								<%} %>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<%= cbean.getComment()%> <!--  Comment ����  -->
							</td>
						</tr>
						<tr>
							<td>
								<%=cbean.getCip() %>       <!--  Comment �ۼ��� IP  -->
							</td>
							<td align="right" style="padding-right:10px;">
								<%=cbean.getCregDate() %>   <!--  Comment �ۼ� ��  -->
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
			<button onclick="javascript:disFn('<%=bean.getNum() %>')">���<%=cvlist.size()>0?"  "+cvlist.size():"" %></button>
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
				<input type="button" value="���" onclick="javascript:commentPost(this.form)"> <!-- �� �˻� �� form submit -->
				<input type="hidden" name="flag" value="insert"> <!-- commentProc.jsp ���� insert �� delete �� ������ -->
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
<%}// include ��   getSession.jsp �� else�� ����.%>
</html>




