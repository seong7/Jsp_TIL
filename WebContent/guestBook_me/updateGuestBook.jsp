<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="guestBook_me.GuestBookBean" %>
<%@ page import="guestBook_me.MyUtil" %>
<%request.setCharacterEncoding("EUC-KR");%>
<jsp:useBean id="mgr" class="guestBook_me.GuestBookMgr"/>
<jsp:useBean id="login" scope="session" class="guestBook_me.JoinBean"/>
<%
	int num=MyUtil.parseInt(request, "num");
	GuestBookBean bean = mgr.getGuestBook(num);
%>

<html>
	<head>
		<title>Guest Book</title>
		<link href="css/style.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div align="center">
			<table width="500px" cellspacing="0" cellpadding="3">
				<tr>
					<td bgcolor="#F5F5F5">
						<font size="4">
							<b>�����ϱ�</b>
						</font>
					</td>
				</tr>
			</table>
			<form method="post" action="updateGuestBookProc.jsp?num=6"> <!-- jsp �ֱ� -->
				<table width="500px" border="1" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table>
								<tr>
									<td height="40px" align="center">
										<img src="img/face.bmp" border="0" alt="����"> 
										<input name="name" size="9" value="<%=login.getName()%>" readonly> 
										<img src="img/email.bmp" border="0" alt="����"> 
										<input name="email" size="20" value="<%=login.getEmail()%>"> 
										<img src="img/hp.bmp" border="0" alt="Ȩ������"> 
										<input title="Ȩ�������� ������ �˷��ֽþ��" name="hp" size="20" value="<%=login.getHp()%>">
									</td>
								</tr>
								<tr>
									<td align="center">
										<textarea name="contents" cols="60" rows="6"> <%=bean.getContents().trim()%></textarea>
									</td>
								</tr>
								<tr>
									<td width="500" height="30" colspan="3" align="center">
										<input type="hidden" name="id" value="<%=login.getId().trim()%>">
										<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
										<input type="submit" value="�ۼ���"> 
										<input type="reset" value="��ġ��"> 
										<input type="checkbox" name="secret" value="1" 
											<%if (bean.getSecret().trim().equals("1"))
												out.println("checked");%>>��б�
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
