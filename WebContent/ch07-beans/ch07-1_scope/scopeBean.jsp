<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="pBean" scope="page" class="ch07_beans.ScopeBean"/>
<jsp:useBean id="sBean" scope="session" class="ch07_beans.ScopeBean"/>

<jsp:setProperty property="num" name="pBean" value="<%=pBean.getNum()+10%>"/>
<!-- scope="page"  : 새로고침해도 -->


<jsp:setProperty property="num" name="sBean" value="<%=sBean.getNum()+10%>"/>

<h2>Scope</h2>
pBean : <%=pBean.getNum() %>
<hr color="red"/>
sBean : <%=sBean.getNum() %>
