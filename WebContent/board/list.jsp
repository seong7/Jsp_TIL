<!-- list.jsp -->
<%@page import="board.UtilMgr"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="mgr" class="board.BoardMgr"/>
<jsp:useBean id="cmgr" class="board.BCommentMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int totalRecord =0;	  // 총게시물 개수  (mgr 메소드 사용해서 가져올 예정)
		int numPerPage=10;  // 페이지당 레코드 개수 (5, 10, 15, 30)  클라이언트가 동적으로 선택 가능하게 구현
		int pagePerBlock = 15; // 한번에 표시되는 페이지 개수
		int totalPage = 0;		// 총 페이지 개수
		int totalBlock = 0; 		// 총 블럭 개수
		int nowPage = 1;			// 최초 접속시 default page
		int nowBlock = 1;		// 최초 접속시 default block
		
		// page에 보여질 게시물 개수 값
		if(request.getParameter("numPerPage")!=null && !request.getParameter("numPerPage").equals("null")){
			numPerPage=UtilMgr.parseInt(request, "numPerPage");
		}
		
		/** BoardMgr.getBoardList() 의 매개변수 중 sql 문 LIMIT 조건에 들어갈 값 지정 **/
				// LIMIT start, cnt     :    start 번째 행부터 cnt 개 레코드 출력 
		int start = 0;
		int cnt = numPerPage;   // default = 10 지정
				
		/** 검색에 필요한 변수 **/
		String keyField = "";   // 분류  (db table 에서는 column 명)
		String keyWord = "";   // 입력된 검색어
		
		// 검색일 때
		if(request.getParameter("keyWord")!=null){
			keyField = request.getParameter("keyField");
			keyWord = request.getParameter("keyWord");
		}
		
		// 검색 후 다시 처음 화면으로
		if(request.getParameter("reload")!=null && request.getParameter("reload").equals("true")){
			keyField=""; keyWord="";
		}
		
		totalRecord = mgr.getTotalCount(keyField, keyWord);
		//out.println(totalRecord);
		
		
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
		<title>JSP Board</title>
	<link href="style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript">
		function check() {
			if(document.searchFrm.keyWord.value==""){
				alert("검색어를 입력하세요.");
				document.searchFrm.keyWord.focus();
				return;
			}
			document.searchFrm.submit();
		}
		
		function list() {
			document.listFrm.action = "list.jsp";
			document.listFrm.submit();
		}
		
		function numPerFn(numPerPage) {
			document.readFrm.numPerPage.value=numPerPage;
			document.readFrm.submit();
		}
		
		function read(num) {
			document.readFrm.num.value = num;
			document.readFrm.action = "read.jsp";
			//document.readFrm.action = "boardRead";
			document.readFrm.submit();
		}
		
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
	</head>
	<body bgcolor="#FFFFCC" >
		<div align="center"><br/>
			<h2>JSP Board</h2><br/>
			<table>
				<tr>
					<td width = "600">
						Total : <%=totalRecord%>Articles(
						<font color = "red"><%=nowPage+"/"+totalPage%>Pages</font>
						)
					</td>
					<td align="right">
						<!-- page 당 출력할 record 값 (numPerPage) 선택 form -->
						<form name = "npFrm" method = "post">
							<select name = "numPerPage" size = "1" onchange="numPerFn(this.form.numPerPage.value)">
								<option value="5">5개 보기</option>
								<option value="10">10개 보기</option>
								<option value="15">15개 보기</option>
								<option value="30">30개 보기</option>
							</select>
						</form>
						<script>
							document.npFrm.numPerPage.value="<%=numPerPage%>"
						</script>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td align="center" colspan="2">
						<%
							Vector<BoardBean>vlist = mgr.getBoardList(keyField, keyWord, start, cnt);  // 변수명 동일하게 맞춰서 선언해두었음.
							int listSize=vlist.size(); 		// 브라우저 화면에 표시될 게시물 번호 값
							
							if(vlist.isEmpty()){
								out.println("등록된 게시물이 없습니다.");
								out.println(listSize);
							} else{
						%>
							<table cellspacing="0">
								<tr align="center" bgcolor="#D0D0D0">
									<td width="100">번호</td>
									<td width="250">제목</td>
									<td width="100">이 름</td>
									<td width="150">날 짜</td>
									<td width="100">조회수</td>
								</tr>
								<%
									for(int i=0; i<numPerPage;i++){  // 한 페이지당 레코드 출력 (default 10개)
										if(i==listSize) break;		// numPerPage 값 안되었지만 i 가 레코드의 마지막 값일 때 break; (마지막 페이지에 쓰임)
										
										BoardBean bean = vlist.get(i);
										int num = bean.getNum();
										String subject = bean.getSubject();
										String name = bean.getName();
										String regdate = bean.getRegdate();
										int depth = bean.getDepth(); 		// 답변의 깊이
										int count = bean.getCount();		// 조회수
										String filename = bean.getFilename();		// 첨부파일
										int bcount = cmgr.getBCommentCount(num); // 댓글 count
								%>		
								<tr align="center">
									<td><%=totalRecord-start-i %></td>  <!-- : "전체 레코드 수-현재 시작 행-i" -->
									<td align="left">
										<%
											for(int j=0; j<depth; j++){   // depth : 답변 단계 (단계 1마다 제목에 빈칸 2개 넣어줌)
												out.print("&nbsp;&nbsp;");
											}
										%>
										<a href="javascript:read('<%=num%>')">
											<%=subject %>
										</a>
										<% if(filename!=null&&!filename.equals("")){ %>
											<img src = "img/icon_file.gif" align="middle">
										<% } %>
										<% if(bcount>0) {%>
													<font color="red">&nbsp;(<%=bcount %>)</font>
										<% } %>
									</td>
									<td><%=name %></td>
									<td><%=regdate %></td>
									<td><%=count %></td>
								</tr>
								<%
									}//-- for
								%>
							</table>
						<%
							}//--else
						%>
					</td>
				</tr>
				<tr>
					<td colspan = "2"><br/><br/></td>
				</tr>
				<tr >
					<td >
						<% if(totalPage>0){ %>
						
							<!-- 이전 블럭 -->
							<% if(nowBlock>1){ %>
								<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
							<% } %>
							
							<!-- 페이징 -->
							<%
								int pageStart=(nowBlock-1)*pagePerBlock+1;
								int pageEnd = (pageStart+pagePerBlock)<totalPage?
													pageStart+pagePerBlock:totalPage+1;
								for(;pageStart<pageEnd;pageStart++){
							%>
								<a href="javascript:pageing('<%=pageStart%>')">
									<%if(pageStart ==nowPage){%>
										<font color="red">	
									<%}%>
											
											[<%=pageStart %>]
											
									<%if(pageStart==nowPage){ %>
										</font>
									<%} %>
								</a>
							<%} %>	
							
							<!-- 다음 블럭 -->
							<% if(totalBlock>nowBlock){ %>
								<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
							<% } %>
						<% }	%>
					</td>
					<td align="right">
						<a href="post.jsp">[글쓰기]</a>
						<a href="javascript:list()">[처음으로]</a>
					</td>
				</tr>
			</table>
			
			<hr width="75%">
			
			<form name="listFrm" method="post">
				<input type="hidden" name="reload" value="true">
				<input type="hidden" name="nowPage" value="1">
			</form>

			<form  name="searchFrm">
				<table  width="600" cellpadding="4" cellspacing="0">
			 		<tr>
			  			<td align="center" valign="bottom">
			   				<select name="keyField" size="1" >
			    				<option value="name"> 이 름</option>
			    				<option value="subject"> 제 목</option>
			    				<option value="content"> 내 용</option>
			   				</select>
			   				<input size="16" name="keyWord">
			   				<input type="button"  value="찾기" onClick="javascript:check()">
			   				<input type="hidden" name="nowPage" value="1">
			  			</td>
			 		</tr>
				</table>
			</form>

			<form name="readFrm">
				<input type="hidden" name="num">
				<input type="hidden" name="nowPage" value="<%=nowPage %>">
				<input type="hidden" name="keyField" value="<%=keyField %>">
				<input type="hidden" name="keyWord" value="<%=keyWord %>">
				<input type="hidden" name="numPerPage" value="<%=numPerPage %>">
			</form>
		</div>
	</body>
</html>
