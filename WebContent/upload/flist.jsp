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
				if(f.allCh.checked){   					// allCh �� üũ true ���
					for(i=0; i<f.fch.length; i++){
						f.fch[i].checked=true; 				 // checkbox ���õǰ� ��
					}
					f.btn.disabled=false; 					// ��ư Ȱ��ȭ ��	
				} else{										// allCh �� üũ false ���
					for(i=0; i<f.fch.length; i++){
						f.fch[i].checked=false;  			// ���� �ݴ�
					}
					f.btn.disabled=true; 						// ���� �ݴ�
				}
			}
			
			function chk(){   // checkbox �� check ��Ȳ�� ���� del ��ư Ȱ��ȭ ���� ���� function
				var f = document.frm;
				for (var i = 0; i < f.fch.length-1; i++) {     /* -1 ���ִ� ������ üũ���� Ȯ���Ҷ� hidden fch �� ���ܽ�Ű�� ����*/
					if(f.fch[i].checked){		    // fch (üũ�ڽ� �迭) �ϳ��� üũ�Ǹ�
						f.btn.disabled=false;  // DELETE ��ư Ȱ��ȭ
						return;				      // (�ϳ��� true �Ǹ� ) function �����Ŵ 
					}
				}
				f.allCh.checked=false;
				f.btn.disabled=true;
			}
			
			function downFn(upFile){  // ���� �� Ŭ�� �� downFrm  form  submit ��
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
						<td>��ȣ</td>
						<td>���ϸ�</td>
						<td>����ũ��</td>
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
					
					<!-- ���� (DELETE) ��ư -->
					<tr>
						<td colspan="4px">
							<input type="submit" name="btn" value="DELETE" disabled>
						</td>
					</tr>
				</table>
				
				<!-- �ϳ��� form ���� �ΰ� �̻��� ������ name ���� �־�� �迭�� �νĵȴ�. -->
				<!-- checkbox �迭�� fch �� �ϳ����� ���� �迭�� �ν����� ���ϹǷ� �Ʒ��� hidden fch �� �߰��Ͽ��ش�.-->
				<input type="hidden" name="fch" value="0">		
			</form><p>
			<a href="fupload.jsp">�Է���</a>
		</div>
		<form name="downFrm" method="post" action="fdownload.jsp">
			<input type="hidden" name="upFile">
			<!--  downFn(upFile) js function���� value �� ���� -->
		</form>
	</body>
</html>