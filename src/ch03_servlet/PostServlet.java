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
		
		request.setCharacterEncoding("EUC-KR");  // POST 방식으로 요청된 경우 요청 값에 대한 한글 인코딩 설정
																   // GET 방식은 url 에 자동으로 인코딩이 되므로 request 의 인코딩 설정 불필요
		
		PrintWriter out = response.getWriter();
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String email = request.getParameter("email");
		
		out.println("<h3>id : " + id + "</h3>");
		out.println("<h3>pwd : " + pwd + "</h3>");
		out.println("<h3>email : " + email + "</h3>");
	}
}
