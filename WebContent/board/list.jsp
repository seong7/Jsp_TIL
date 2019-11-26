<!-- list.jsp -->
<%@page import="board.UtilMgr"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<jsp:useBean id="mgr" class="board.BoardMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		int totalRecord =0;	  // 총게시물 개수  (mgr 메소드 사용해서 가져올 예정)
		int numPerPage=10;  // 페이지당 레코드 개수 (5, 10, 15, 30)  클라이언트가 동적으로 선택 가능하게 구현
		int pagePerBlock = 15; // 한번에 표시되는 페이지 개수
		int totalPage = 0;		// 총 페이지 개수
		int totalBlock = 0; 		// 총 블럭 개수
		int nowPage = 1;			// 최초 접속시 default page
		int nowBlock = 1;		// 최초 접속시 default block
		
		/** BoardMgr.getBoardList() 의 매개변수 중 sql 문 LIMIT 조건에 들어갈 값 지정 **/
				// LIMIT start, cnt     :    start 번째 행부터 cnt 개 레코드 출력 
		int start = 0;
		int cnt = numPerPage;   // default = 10 지정
				
		/** 검색에 필요한 변수 **/
		String keyField = "";   // 분류  (db table 에서는 column 명)
		String keyWord = "";   // 입력된 검색어
		
		
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
								<option value="10" selected>10개 보기</option>
								<option value="15">15개 보기</option>
								<option value="30">30개 보기</option>
							</select>
						</form>
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
								%>		
								<tr align="center">
									<td><%=totalRecord-start-i %></td>  <!-- 전체 레코드 수 - 현재 시작 행 - i -->
									<td align="left">
										<%
											for(int j=0; j<depth; j++){   // depth : 답변 단계 (단계 1마다 제목에 빈칸 2개 넣어줌)
												out.print("&nbsp;&nbsp;");
											}
										%>
										<a href="javascript:read('<%=num%>')">
											<%=subject %>
										</a>
										<% if(filename!=null&&filename.equals("")){ %>
											<img src = "img/icon_file.gif" align="middle">
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
			</table>
		</div>
	</body>
</html>
