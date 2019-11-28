<!-- read.jsp -->
<%@page import="java.util.Vector"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BCommentBean"%>
<%@page import="board.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="board.BoardMgr"/>
<jsp:useBean id="cmgr" class="board.BCommentMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int num = UtilMgr.parseInt(request, "num");
		//nowPage Ÿ���� ���������� ���⼭ ����� ���� �ʰ� 
		//�ٽ� list.jsp �ѱ�� ������ int ��ȯ �ʿ����.
		String nowPage = request.getParameter("nowPage");
		String keyField = request.getParameter("keyField");
		String keyWord = request.getParameter("keyWord");
		String numPerPage = request.getParameter("numPerPage");
		
		
		//��� �Է� �� ���� ó��
		String flag = request.getParameter("flag");
		if(flag!=null){
			if(flag.equals("insert")){
				BCommentBean cbean = new BCommentBean();
				//�Խù� ��ȣ
				cbean.setNum(num);
				
				cbean.setName(request.getParameter("cName"));
				cbean.setComment(request.getParameter("comment"));
				cmgr.insertBComment(cbean);
			}else if(flag.equals("del")){
				//��û�� ��� ����
				cmgr.deleteBComment(UtilMgr.parseInt(request, "cnum"));
			}
		}else{
			mgr.countUp(num);   //��ȸ�� ���� : list.jsp ��û
		}
		
		//��ȸ�� ����
		mgr.countUp(num);
		BoardBean bean = mgr.getBoard(num);
		String name = bean.getName();
		String subject = bean.getSubject();
		String regdate = bean.getRegdate();
		String content = bean.getContent();
		String filename = bean.getFilename();
		int filesize = bean.getFilesize();
		String ip = bean.getIp();
		int count = bean.getCount();
		//���ǿ� �о�� �Խù��� ���� : ����, ����, �亯
		session.setAttribute("bean", bean);
%>
<html>
	<head>
		<title>JSP Board</title>
		<link href="style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
			function down(filename){
				document.downFrm.filename.value = filename;
				document.downFrm.submit();
			}
			
			function list(){
				// ������ action ���� ������ �Ǿ� �־ ���� ����
				document.listFrm.action="list.jsp";
				document.listFrm.submit();
			}
			function cInsert() {
				if(document.cFrm.comment.value==""){
					alert("����� �Է��ϼ���.");
					document.cFrm.comment.focus();
					return;
				}
				document.cFrm.submit();
			}
			function cDel(cnum) {
				document.cFrm.cnum.value=cnum;
				document.cFrm.flag.value="del";
				document.cFrm.submit();
			}
		</script>
	</head>
	<body bgcolor="#FFFFCC">
	<br/><br/>
	<table align="center" width="600" cellspacing="3">
		<tr>
			<td bgcolor="#9CA2EE" height="25" align="center">���б�</td>
		</tr>
		<tr>
			<td colspan="2">
				<table cellpadding="3" cellspacing="0" width="100%">
					<tr>
						<td align="center" bgcolor="#DDDDDD" width="10%">�� ��</td>
						<td bgcolor="#FFFFE8"><%=name%></td>
						<td align="center" bgcolor="#DDDDDD" width="10%">��ϳ�¥</td>
						<td bgcolor="#FFFFE8"><%=regdate%></td>
					</tr>
					<tr>
						<td align="center" bgcolor="#DDDDDD">�� ��</td>
						<td bgcolor="#FFFFE8" colspan="3"><%=subject%></td>
					</tr>
					<tr>
						<td align="center" bgcolor="#DDDDDD">÷������</td>
						<td bgcolor="#FFFFE8" colspan="3">
							<%if(filename!=null&&!filename.equals("")){%> <a
							href="javascript:down('<%=filename %>')"> <%=filename %></a> <font
							color="blue">(<%=UtilMgr.getKBytes(filesize)%>bytes)
						</font> <%}else{out.println("��ϵ� ������ �����ϴ�.");} %>
						</td>
					</tr>
					<tr>
						<td colspan="4"><br />
						<pre><%=content%></pre><br /></td>
					</tr>
					<tr>
						<td colspan="4" align="right"><%=ip%>�� ���� ���� ����̽��ϴ�./ ��ȸ�� <%=count%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
			
			
				<!-- ��� �Է� form Start -->
					<form method="post" name="cFrm">
						<table>
							<tr align="center">
								<td width="50">
									�̸�
								</td>
								<td align="left">
									<input name= "cName" size="10" value="aaa">
								</td>
							</tr>
							<tr align="center">
								<td>
									����
								</td>
								<td>
									<input name="comment" size="50"> 
									<input type="button" value="���" onclick="cInsert()">
								</td>
							</tr>
						</table>
						<input type="hidden" name = "flag" value="insert">
						<input type="hidden" name = "num" value="<%=num%>">
						<input type="hidden" name = "cnum">
						<input type="hidden" name = "nowPage" value="<%=nowPage%>">
						<input type="hidden" name = "numPerPage" value="<%=numPerPage%>">
						<%if(!(keyWord==null||keyWord.equals(""))){ %>
							<input type="hidden" name="keyField" value="<%=keyField %>">
							<input type="hidden" name = "keyWord" value="<%=keyWord %>">
						<% } %>	
					</form>
				<!-- ��� �Է� form End -->
			
				
				<hr/>
			
				
				<!-- ��� List Start -->
				<%
					Vector<BCommentBean> cvlist = cmgr.getBComment(num);
					if(!cvlist.isEmpty()){
				%>	
						<table>
							<%
								for(BCommentBean cbean : cvlist){
									int cnum = cbean.getCnum();
									String cname = cbean.getName();
									String comment = cbean.getComment();
									String cregdate = cbean.getRegdate();
							%>
							<tr>
								<td colspan="3" width="600">
									<b><%=cname %></b>
								</td>
							</tr>
							<tr>
								<td>��� : <%=comment %></td>
								<td align="right"><%=cregdate%></td>
								<td align="center" valign="middle">
									<input type="button" value="����" onclick="cDel('<%=cnum %>')">
								</td>
							</tr>
							<tr>
								<td colspan="3"><br/></td>
							</tr>
							<%  }//---for %>	
						</table>
				<hr /> 
				<% } %>
				<!-- ��� List End -->
			
				[
				<a href="javascript:list()">����Ʈ</a> | 
				<a href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>">�� ��</a> | 
				<a href="update2.jsp?nowPage=<%=nowPage%>&num=<%=num%>" >�� ��2</a> |
				<a href="reply.jsp?nowPage=<%=nowPage%>">�� ��</a> |
				<a href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">�� ��</a> 
				]
				<br />
			</td>
		</tr>
	</table>
	<form name="downFrm" action="download.jsp" method="post">
		<input type="hidden" name="filename">
	</form>
	<form name = "listFrm">
		<input type="hidden" name = "nowPage" value="<%=nowPage%>">
		<input type="hidden" name = "numPerPage" value="<%=numPerPage%>">
		<%if(!(keyWord==null||keyWord.equals(""))){ %>
			<input type="hidden" name = "keyWord" value="<%=keyWord %>">
			<input type="hidden" name = "keyField" value="<%=keyField %>">
		<%} %>
	</form>
</body>
</html>






