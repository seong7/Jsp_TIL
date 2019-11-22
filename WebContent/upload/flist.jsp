<!-- flist.jsp -->
<%@ page import="upload.UtilMgr" %>
<%@ page import="upload.FileloadBean" %>
<%@ page import="java.util.Vector" %>
<%@ page contentType="text/html; charset=EUC-KR"%>
<jsp:useBean id="mgr" class="upload.FileloadMgr"/>
<%
		request.setCharacterEncoding("EUC-KR");
		Vector<FileloadBean> vlist=mgr.listFile();
%>
<html>
	<head>
		<link href="style.css" rel="stylesheet" type="text/css">
		<script type="text/javascript">
			function allChk(){ 
				var f = document.frm;
				if(f.allCh.checked){   					// allCh 가 체크 true 라면
					for(i=0; i<f.fch.length; i++){
						f.fch[i].checked=true; 				 // checkbox 선택되게 함
					}
					f.btn.disabled=false; 					// 버튼 활성화 함	
				} else{										// allCh 가 체크 false 라면
					for(i=0; i<f.fch.length; i++){
						f.fch[i].checked=false;  			// 위와 반대
					}
					f.btn.disabled=true; 						// 위와 반대
				}
			}
			
			function chk(){   // checkbox 의 check 상황에 따라 del 버튼 활성화 여부 결정 function
				var f = document.frm;
				for (var i = 0; i < f.fch.length-1; i++) {     /* -1 해주는 이유는 체크여부 확인할때 hidden fch 를 제외시키기 위함*/
					if(f.fch[i].checked){		    // fch (체크박스 배열) 하나라도 체크되면
						f.btn.disabled=false;  // DELETE 버튼 활성화
						return;				      // (하나라도 true 되면 ) function 종료시킴 
					}
				}
				f.allCh.checked=false;
				f.btn.disabled=true;
			}
			
			function downFn(upFile){  // 파일 명 클릭 시 downFrm  form  submit 함
				df = document.downFrm;
				df.upFile.value=upFile;
				df.submit();
			}
		</script>	
	</head>
	<body>
		<div align="center">
			<h2>File List</h2>
			<form name="frm" action="fdeleteProc.jsp">
				<table border="1" width="300">
					<tr align="center">
						<td><input type="checkbox" name="allCh" onclick="allChk()"></td>
						<td>번호</td>
						<td>파일명</td>
						<td>파일크기</td>
					</tr>
					<%
						int i = 0;
						for(FileloadBean bean : vlist){
							int num = bean.getNum();
							String upFile=bean.getUpFile();
							int size=bean.getSize();
					%>
					<tr>
						<td><input type="checkbox" name="fch" value="<%=num%>" onclick="chk()"></td>
						<td><%=i+1 %></td>
						<td>
							<a href="javascript:downFn('<%=upFile %>')">
								<%=upFile %>
							</a>
						</td>
						<td><%=UtilMgr.monFormat(size) %>byte</td>			
					</tr>
					<%  i++; }//__for%>
					
					<!-- 삭제 (DELETE) 버튼 -->
					<tr>
						<td colspan="4px">
							<input type="submit" name="btn" value="DELETE" disabled>
						</td>
					</tr>
				</table>
				
				<!-- 하나의 form 에서 두개 이상의 동일한 name 값이 있어야 배열로 인식된다. -->
				<!-- checkbox 배열인 fch 가 하나뿐일 때는 배열로 인식하지 못하므로 아래의 hidden fch 를 추가하여준다.-->
				<input type="hidden" name="fch" value="0">		
			</form><p>
			<a href="fupload.jsp">입력폼</a>
		</div>
		<form name="downFrm" method="post" action="fdownload.jsp">
			<input type="hidden" name="upFile">
			<!--  downFn(upFile) js function으로 value 값 지정 -->
		</form>
	</body>
</html>