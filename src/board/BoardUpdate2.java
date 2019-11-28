package board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class BoardUpdate2
 */
@WebServlet("/board/boardUpdate2")
public class BoardUpdate2 extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("EUC-KR");
		response.setContentType("text/html; charset=EUC-KR");
		
		HttpSession session = request.getSession();
		BoardBean bean = (BoardBean)session.getAttribute("bean");
		
		MultipartRequest multi=
				new MultipartRequest(request, BoardMgr.SAVEFOLDER, BoardMgr.MAXSIZE, 
						BoardMgr.ENCTYPE, new DefaultFileRenamePolicy());
		
		String dbPass = bean.getPass();
		String inPass = multi.getParameter("pass");  // ���ǿ� ����� client �� �Է��� ��й�ȣ
		
		if(dbPass.equals(inPass)) {
			
			
			// ��й�ȣ ���� �� �Խñ� ������Ʈ ����
			BoardMgr mgr = new BoardMgr();
			mgr.updateBoard2(multi);
			
			
			String nowPage = multi.getParameter("nowPage");
			String num = multi.getParameter("num");
			response.sendRedirect("read.jsp?nowPage="+nowPage+"&num="+num);
			
		}else {
			// ��й�ȣ Ʋ���� �� ��� ���
			PrintWriter out = response.getWriter();
			out.println("<script>"
							+ "alert('�Է��Ͻ� ��й�ȣ�� ���� �ʽ��ϴ�.');"
							+ "history.back();"
						+"</script>");
		}
	}
}
