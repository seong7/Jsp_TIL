<!-- list.jsp -->
<%@page import="board.UtilMgr"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="mgr" class="board.BoardMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int totalRecord =0;	  // �ѰԽù� ����  (mgr �޼ҵ� ����ؼ� ������ ����)
		int numPerPage=10;  // �������� ���ڵ� ���� (5, 10, 15, 30)  Ŭ���̾�Ʈ�� �������� ���� �����ϰ� ����
		int pagePerBlock = 15; // �ѹ��� ǥ�õǴ� ������ ����
		int totalPage = 0;		// �� ������ ����
		int totalBlock = 0; 		// �� �� ����
		int nowPage = 1;			// ���� ���ӽ� default page
		int nowBlock = 1;		// ���� ���ӽ� default block
		
		/** BoardMgr.getBoardList() �� �Ű����� �� sql �� LIMIT ���ǿ� �� �� ���� **/
				// LIMIT start, cnt     :    start ��° ����� cnt �� ���ڵ� ��� 
		int start = 0;
		int cnt = numPerPage;   // default = 10 ����
				
		/** �˻��� �ʿ��� ���� **/
		String keyField = "";   // �з�  (db table ������ column ��)
		String keyWord = "";   // �Էµ� �˻���
		
		
		totalRecord = mgr.getTotalCount(keyField, keyWord);
		//out.println(totalRecord);
		
		
		// nowPage �� ��û�� ���
		if(request.getParameter("nowPage")!=null){
			nowPage = UtilMgr.parseInt(request, "nowPage");
		}
		
		// ���̺��� ���� �� ��ȣ
		start = (nowPage*numPerPage) - numPerPage;
		
		// ��ü ������ �� (��ü���ڵ� �� / �������� ���ڵ� ��) �ø�
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		
		// ��ü �� �� (��ü������ �� / ���� ������ ��) �ø�
		totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		
		// ���� �� (���� ������ �� / ���� ������ ��) �ø�
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
		
%>
<html>
	<head>
		<title>JSP Board</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function check() {
			if(document.searchFrm.keyWord.value==""){
				alert("�˻�� �Է��ϼ���.");
				document.searchFrm.keyWord.focus();
				return;
			}
			document.searchFrm.submit();
		}
		
		function list() {
			document.listFrm.action = "list.jsp";
			document.listFrm.submit();
		}
		
		function numPerFn(numPerPage) {
			document.readFrm.numPerPage.value=numPerPage;
			document.readFrm.submit();
		}
		
		function read(num) {
			document.readFrm.num.value = num;
			document.readFrm.action = "read.jsp";
			document.readFrm.submit();
		}
	</script>
	</head>
	<body bgcolor="#FFFFCC" >
		<div align="center"><br/>
			<h2>JSP Board</h2><br/>
			<table>
				<tr>
					<td width = "600">
						Total : <%=totalRecord%>Articles(
						<font color = "red"><%=nowPage+"/"+totalPage%>Pages</font>
						)
					</td>
					<td align="right">
						<!-- page �� ����� record �� (numPerPage) ���� form -->
						<form name = "npFrm" method = "post">
							<select name = "numPerPage" size = "1" onchange="numPerFn(this.form.numPerPage.value)">
								<option value="5">5�� ����</option>
								<option value="10" selected>10�� ����</option>
								<option value="15">15�� ����</option>
								<option value="30">30�� ����</option>
							</select>
						</form>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td align="center" colspan="2">
						<%
							Vector<BoardBean>vlist = mgr.getBoardList(keyField, keyWord, start, cnt);  // ������ �����ϰ� ���缭 �����صξ���.
							int listSize=vlist.size(); 		// ������ ȭ�鿡 ǥ�õ� �Խù� ��ȣ ��
							
							if(vlist.isEmpty()){
								out.println("��ϵ� �Խù��� �����ϴ�.");
								out.println(listSize);
							} else{
						%>
							<table cellspacing="0">
								<tr align="center" bgcolor="#D0D0D0">
									<td width="100">��ȣ</td>
									<td width="250">����</td>
									<td width="100">�� ��</td>
									<td width="150">�� ¥</td>
									<td width="100">��ȸ��</td>
								</tr>
								<%
									for(int i=0; i<numPerPage;i++){  // �� �������� ���ڵ� ��� (default 10��)
										if(i==listSize) break;		// numPerPage �� �ȵǾ����� i �� ���ڵ��� ������ ���� �� break; (������ �������� ����)
										
										BoardBean bean = vlist.get(i);
										int num = bean.getNum();
										String subject = bean.getSubject();
										String name = bean.getName();
										String regdate = bean.getRegdate();
										int depth = bean.getDepth(); 		// �亯�� ����
										int count = bean.getCount();		// ��ȸ��
										String filename = bean.getFilename();		// ÷������
								%>		
								<tr align="center">
									<td><%=totalRecord-start-i %></td>  <!-- ��ü ���ڵ� �� - ���� ���� �� - i -->
									<td align="left">
										<%
											for(int j=0; j<depth; j++){   // depth : �亯 �ܰ� (�ܰ� 1���� ���� ��ĭ 2�� �־���)
												out.print("&nbsp;&nbsp;");
											}
										%>
										<a href="javascript:read('<%=num%>')">
											<%=subject %>
										</a>
										<% if(filename!=null&&filename.equals("")){ %>
											<img src = "img/icon_file.gif" align="middle">
										<% } %>
									</td>
									<td><%=name %></td>
									<td><%=regdate %></td>
									<td><%=count %></td>
								</tr>
								<%
									}//-- for
								%>
							</table>
						<%
							}//--else
						%>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
