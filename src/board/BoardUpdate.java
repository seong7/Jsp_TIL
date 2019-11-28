// 게시글 수정 - 비밀번호 확인
package board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/board/boardUpdate")
public class BoardUpdate extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//요청된 값들에 대한 한글 인코딩
		request.setCharacterEncoding("EUC-KR");
		
		// 게시글 수정 시 비밀번호가 틀렸을 때 응답의 한글 인코딩
		response.setContentType("text/html; charset=EUC-KR");
	
		// 세션에서 read.jsp (약 51라인) 에서 저장한 해당 게시글의 db bean 객체 return
		HttpSession session = request.getSession();
		BoardBean bean = (BoardBean) session.getAttribute("bean");
		
		String dbPass = bean.getPass();
		String inPass = request.getParameter("pass");  // 세션에 저장된 client 가 입력한 비밀번호
	
		if(dbPass.contentEquals(inPass)) {
			
			// 비밀번호 맞을 때 게시글 업데이트 실행
			BoardMgr mgr = new BoardMgr();
			BoardBean upBean = new BoardBean();
			upBean.setNum(Integer.parseInt(request.getParameter("num")));
			upBean.setName(request.getParameter("name"));
			upBean.setSubject(request.getParameter("subject"));
			upBean.setContent(request.getParameter("content"));
			mgr.updateBoard(upBean);
			
			String nowPage = request.getParameter("nowPage");
			response.sendRedirect("read.jsp?nowPage="+nowPage+"&num="+upBean.getNum());
			
		}else {
			// 비밀번호 틀렸을 때 경고 띄움
			PrintWriter out = response.getWriter();
			out.println("<script>"
							+ "alert('입력하신 비밀번호가 맞지 않습니다.');"
							+ "history.back();"
						+"</script>");
		}
	}
}
