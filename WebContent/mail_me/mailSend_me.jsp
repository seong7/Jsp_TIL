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
					<input type="button" onclick="javascript:check()" value="제출 !">
			</form>
		</div>
	</body>
</html>
<script>
	function check(){
		if(emailFrm.id.value==""||emailFrm.email.value==""){
			alert('id와 email을 모두 입력해주세요');
		}else{
			document.emailFrm.submit();
		}
	}
</script>