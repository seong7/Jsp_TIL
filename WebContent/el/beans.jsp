<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="bean" class="el.ELBean"/>
<jsp:setProperty property="siteName" name="bean"/>
빈즈액션태그 : <jsp:getProperty property="siteName" name="bean"/><br/>
표현식 : <%=bean.getSiteName()%><br/>
EL방식 : ${bean.siteName}