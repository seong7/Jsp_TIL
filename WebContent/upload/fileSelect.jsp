<!-- fileSlect.jsp -->
<%@ page contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>

<!-- file 업로드하기 위한 form 의 공식 :  post 방식 ,  enctype="multipart/form-data" -->

<form method="post" action="viewPage.jsp" enctype="multipart/form-data">
	user : <input name="user" value="홍길동"><br/>
	title : <input name="title" value="파일업로드"><br/>
	file : <input type="file" name="upload"><br/>
	<input type="submit" value="UPLOAD">
</form>