<%@ page contentType="text/html; charset=EUC-KR"%>
<html>
<head>
<title>my first 备备窜.jsp</title>
<style>
	body { background :#E85A58 }
	h1 { color : #FFBF66;
		   font-weight : bolder;
		   }
	
	td:hover { background : black; }
	th:hover { background : black; }
	
	thead{ 
			   background : #43373a;
			}
	
	th { height : 60px;
		  test-align : center; 
		  font-weight : bolder;
		  font-size : x-large;
		  /*border-radius : 10px;*/
		  }
	.th-top_left-radius {
								 border-top-left-radius : 10px;
	}
	
	.th-top_right-radius {
								 border-top-right-radius : 10px;
	}
	
	.td-bot_left-radius-dark {
							     border-bottom-left-radius : 10px;
							     background : #ea6462;
	}
	
	.td-bot_right-radius-dark {
								 border-bottom-right-radius : 10px;
								 background : #ea6462;
	}
	
	.td-light {
				  background : #fc7a78;
	}
	
	.td-dark {
				  background : #ea6462;
	}
	
	tr, td { align : center;
			  text-align : center; 
			  font-weight : normal;
			  /*border-radius : 10px;*/
			  }
	
	.bodywrap { border-radius : 10px;
					  /*border : 2px solid black;*/
	}
	
	.table { border : 1px;
				border-collapse : collapse;
				table-layout : auto;
				width : 900px;
				height : 600px;
				text-align : center;
				align : center;
				}
	

</style>
</head>
<body>
	<br/>
		<h1 align="center">
			备 备 窜
		</h1>
		<br />

		<%! 
				int i;
				int j;
			%>

	<div class="bodywrap">
		<table class="table" align="center">
			<thead>
				<tr>
					<%
							for(i=1; i<10; i++){
								out.println("<th");
								if(i==1){
									out.println(" class = \"th-top_left-radius\"");
								}else if(i==9){
									out.println(" class = \"th-top_right-radius\"");
								}
								out.println("><font color = \"#FFBF66\">" +  i + " 窜</font></th>");
							} 
						%>
				
			</thead>
			<tbody>
				</tr>
				<%
							for(i=1; i<10; i++){
								out.println("<tr>");
								
								for(j=1; j<10; j++){
									out.println("<td");
									if(i%2 ==1){
										if(j%2 ==1){
											if(i == 9 && j == 1){
												out.println(" class = \"td-bot_left-radius-dark\"");
												//continue;
											} else if(i == 9 && j == 9){
												out.println(" class = \"td-bot_right-radius-dark\"");
												//continue;
											}	else
											out.println(" class = \"td-dark\"");
										}
										else if(j%2==0)
											out.println(" class = \"td-light\"");
									}else if(i%2 ==0){
										if(j%2 ==0)
											out.println(" class = \"td-dark\"");
										else if(j%2==1)
											out.println(" class = \"td-light\"");
									}
															
									out.println("><font color = \"#FFFF35\">" + j + " x " + i + " = " + i*j + "</font></td>");
								}
								out.println("</tr>");
							}
						%>
			</tbody>
		</table>
	</div>
</body>
</html>

