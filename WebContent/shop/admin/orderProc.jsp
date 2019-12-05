<!-- orderProc.jsp -->
<%@page import="shop.UtilMgr"%>
<%@page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="orderMgr" class="shop.OrderMgr"/>
<%
		//주문의 수정 삭제 처리
		request.setCharacterEncoding("EUC-KR");
		String flag = request.getParameter("flag");
		int no = UtilMgr.parseInt(request, "no");
		boolean result = false;
		String msg = "오류가 발생 하였습니다.";
		if(flag.equals("update")){
			String state = request.getParameter("state");
			result = orderMgr.updateOrder(no, state);
			if(result) msg = "수정하였습니다.";
		}else if(flag.equals("delete")){
			result = orderMgr.deleteOrder(no);
			if(result) msg = "삭제하였습니다.";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "orderMgr.jsp";
</script>







