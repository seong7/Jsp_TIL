<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Core Tags4</h2>
<hr/>

<c:import url="http://localhost:11207/myapp/jstl/coreTags2.jsp">
	<c:param name="id" value="aaa"/>
	<c:param name="color" value="orange"/>
</c:import>

<hr/>

<c:url var="url1" value="https://www.google.com">
	<c:param name="q" value="jsp"/>
	<c:param name="safe" value="off"/>
</c:url>
<a href="${url1 }">구글에서 jsp 검색</a>