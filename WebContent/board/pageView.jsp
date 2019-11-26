<%@ page import="board.UtilMgr" %>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	int totalRecord =UtilMgr.parseInt(request, "totalRecord");	  // 총게시물 개수  (mgr 메소드 사용해서 가져올 예정)
	out.print(totalRecord);
	int numPerPage=10;  // 페이지당 레코드 개수 (5, 10, 15, 30)  클라이언트가 동적으로 선택 가능하게 구현
	int pagePerBlock = 15; // 한번에 표시되는 페이지 개수
	int totalPage = 0;		// 총 페이지 개수
	int totalBlock = 0; 		// 총 블럭 개수
	int nowPage = 1;			// 최초 접속시 default page
	int nowBlock = 1;		// 최초 접속시 default block
	
	
		/** BoardMgr.getBoardList() 의 매개변수 중 sql 문 LIMIT 조건에 들어갈 값 지정 **/
		// LIMIT start, cnt     :    start 번째 행부터 cnt 개 레코드 출력 
	int start = 0;
		
	// nowPage 를 요청한 경우
	if(request.getParameter("nowPage")!=null){
	nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	
	// 테이블의 시작 행 번호
	start = (nowPage*numPerPage) - numPerPage;
	
	// 전체 페이지 수 (전체레코드 수 / 페이지당 레코드 수) 올림
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	
	// 전체 블럭 수 (전체페이지 수 / 블럭당 페이지 수) 올림
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	
	// 현재 블럭 (현재 페이지 수 / 블럭당 페이지 수) 올림
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>

<html>
	<head>
		<title>페이징 & 블럭 처리 테스트</title>
	</head>
	<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function block(block){
			document.readFrm.nowPage.value=
				<%=pagePerBlock%>*(block-1)+1;
				document.readFrm.submit();
		}
		function pageing(page){
			document.readFrm.nowPage.value=page;
			document.readFrm.submit();
		}
	</script>
	<body bgcolor="#FFFFCC">
		<div align="center"><br/>
		<h2>페이징 & 블럭 처리 테스트</h2>
		<table>
			<tr>
				<td  width="700" align="center">
				Total : <%=totalRecord%>Articles(
				<font color="red"><%=nowPage+"/"+totalPage%>Pages</font>
				)
				</td>
			</tr>
		</table>
		<table>
			<tr>
				<td>게시물 번호 : &nbsp;</td>
				<%
					int listSize=totalRecord-start;
					for(int i=0; i<numPerPage; i++){
						if(i==listSize) break;
				%>
				<td align="center">
					<%=totalRecord-start-i %>
				</td>
				<%	
					}//---for
				%>
			</tr>
		</table>
		
		<!----------------- 페이징 및 블럭 시작 -->
		<table>
			<tr>
				<td>
					<%
						if(totalPage>0){
					%>
							<!-- 이전 블럭 -->
							<%if(nowBlock>1){ %>
								<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
							<%} %>
							
							<!-- 페이징 -->
							<%
								int pageStart=(nowBlock-1)*pagePerBlock+1;
								int pageEnd = (pageStart+pagePerBlock)<totalPage?
													pageStart+pagePerBlock:totalPage+1;
								for(;pageStart<pageEnd;pageStart++){
									
							%>
								<a href="javascript:pageing('<%=pageStart%>')">
							<%
									if(pageStart ==nowPage){%><font color="red">	<%}%> 
										[<%=pageStart %>]
									<%if(pageStart==nowPage){ %></font><%} %>
								</a>
							<%} %>	
							
							<!-- 다음 블럭 -->
							<%if(totalBlock>nowBlock){ %>
								<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
							<%} %>
					
					<%}	%>
				</td>
			</tr>
		</table>
		<form name="readFrm">
			<input type="hidden"	name = "totalRecord" value="<%=totalRecord %>">
			<input type="hidden" name="nowPage" value="<%=nowPage %>">
		</form>
		
		<!------------------ 페이징 및 블럭 끝 -->
		
		<hr width="45%"/>
		<b>
			totalRecord : <%=totalRecord%>&nbsp;
			numPerPage : <%=numPerPage%>&nbsp;
			pagePerBlock : <%=pagePerBlock%>&nbsp;
			totalPage : <%=totalPage%>&nbsp;<br/>
			totalBlock : <%=totalBlock%>&nbsp;
			nowPage : <%=nowPage%>&nbsp;
			nowBlock : <%=nowBlock%>&nbsp;
			start : <%=start%>&nbsp;
		</b>
		<p/>
		<input type="button" value="TotalRecord 입력폼"
			 onClick="javascript:location.href='pageView.html'">
		</div>
	</body>
</html>