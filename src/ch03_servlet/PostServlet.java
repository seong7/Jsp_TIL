package ch03_servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PostServlet
 */
@WebServlet("/ch03_servlet/postServlet")
public class PostServlet extends HttpServlet {
	//private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=EUC-KR");
		
		request.setCharacterEncoding("EUC-KR");  // POST ������� ��û�� ��� ��û ���� ���� �ѱ� ���ڵ� ����
																   // GET ����� url �� �ڵ����� ���ڵ��� �ǹǷ� request �� ���ڵ� ���� ���ʿ�
		
		PrintWriter out = response.getWriter();
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String email = request.getParameter("email");
		
		out.println("<h3>id : " + id + "</h3>");
		out.println("<h3>pwd : " + pwd + "</h3>");
		out.println("<h3>email : " + email + "</h3>");
	}
}
