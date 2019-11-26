package board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// post.jsp 에 입력한 게시물을 저장 처리하기 위한 기능의 메소드
@WebServlet("/board/boardPost")
public class BoardPostServlet extends HttpServlet {
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");   // post 방식이므로 encoding 설정
		
		BoardMgr mgr = new BoardMgr();
		mgr.insertBoard(request);
		response.sendRedirect("list.jsp");
	}
}
