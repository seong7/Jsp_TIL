<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="board.BoardBean" %>
<% 
	request.setCharacterEncoding("EUC-KR");
	BoardBean bean = (BoardBean)session.getAttribute("bean");
%>
<html>
<head>
<title>JSP Board</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
<div align="center">
<br/><br/>
<table width="600" cellpadding="3">
	<tr>
		<td bgcolor="84F399" height="25" align="center">�� �б�</td>
	</tr>
</table>
<br/>
<form name="postFrm" method="post" enctype="multipart/form-data">
<table width="600" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			<tr>
				<td width="10%">�� ��</td>
				<td width="90%">
				<input name="name" size="10" maxlength="8" readonly></td>
			</tr>
			<tr>
				<td>�� ��</td>
				<td>
				<input name="subject" size="50" maxlength="30" value="<%=bean.getSubject()%>" readonly></td>
			</tr>
			<tr>
				<td>�� ��</td>
				<td><textarea name="content" rows="10" cols="50"  readonly><%=bean.getContent()%></textarea></td>
			</tr>
			<tr>
			 <tr>
     			<td>����ã��</td> 
     			<td><input type="file" name="filename" size="50" maxlength="50"></td>
    		</tr>
 			<tr>
 				<td>����Ÿ��</td>
 				<td> HTML<input type=radio name="contentType" value="HTTP" >&nbsp;&nbsp;&nbsp;
  			 	TEXT<input type=radio name="contentType" value="TEXT" checked>
  			 	</td>
 			</tr>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2">
					 <input type="submit" value="���">
					 <input type="reset" value="�ٽþ���">
					 <input type="button" value="����Ʈ" onClick="javascript:location.href='list.jsp'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
</form>
</div>
</body>
</html>
<script>
	document.postFrm.name.value = "xx"
	
	
</script>