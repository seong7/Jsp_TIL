<%@ page import = "java.util.Random" %>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%!
	// 랜덤한 색상을 리턴하는 메소드 선언
	public String randomColor(){
		Random r = new Random();
		String rgb = Integer.toHexString(r.nextInt(256));
		rgb += Integer.toHexString(r.nextInt(256));
		rgb += Integer.toHexString(r.nextInt(256));
		return "#" + rgb;
}
%>
<font color = "<%=randomColor()%>"> 무궁화 꽃이 피었습니다. </font><br/>
<font color = "<%=randomColor()%>"> 무궁화 꽃이 피었습니다. </font><br/>
<font color = "<%=randomColor()%>"> 무궁화 꽃이 피었습니다. </font><br/>
<font color = "<%=randomColor()%>"> 무궁화 꽃이 피었습니다. </font><br/>
<font color = "<%=randomColor()%>"> 무궁화 꽃이 피었습니다. </font><br/>
<font color = "<%=randomColor()%>"> 무궁화 꽃이 피었습니다. </font><br/>