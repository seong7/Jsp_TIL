<%@ page contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
%>
<html>
	<body>
		<div style="height:150px;">
		</div>
		<div  align="right" style="width:50%; ">
			<form method="post" name="emailFrm" action="mailSendProc.jsp">
					id : <input type="text" name="id">
					<br/><br/>
					email : <input type="text" name="email">
					<br/><br/>
					<input type="button" onclick="javascript:check()" value="���� !">
			</form>
		</div>
	</body>
</html>
<script>
	function check(){
		if(emailFrm.id.value==""||emailFrm.email.value==""){
			alert('id�� email�� ��� �Է����ּ���');
		}else{
			document.emailFrm.submit();
		}
	}
</script>