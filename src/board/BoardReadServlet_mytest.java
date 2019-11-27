package board;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

/**
 * Servlet implementation class BoardRead
 */
@WebServlet("/board/boardRead")
public class BoardReadServlet_mytest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			int num = Integer.parseInt(request.getParameter("num"));
			
			BoardMgr mgr = new BoardMgr();
			BoardBean bean = mgr.getBoard(num);
			mgr.countUp(num);
			
			HttpSession session =  request.getSession();
			session.setAttribute("bean", bean);
			
			response.sendRedirect("read_mytest.jsp");
		}
}
