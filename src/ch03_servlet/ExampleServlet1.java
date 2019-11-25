package ch03_servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ExampleServlet1
 */
@WebServlet("/ch03/exampleServlet1")
public class ExampleServlet1 extends HttpServlet {
	//private static final long serialVersionUID = 1L;
	//serialVersionUID : 객체 직렬화 -> 객체 자체를 네트워크로 전송할 시에만 사용

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=EUC-KR"); 
		PrintWriter out = response.getWriter();
		// print writer : 출력 스트림
		
		/////////  html code  ///////
		out.println("<html>");
		out.println("<body>");
		out.println("<h1> 이클립스로 서블릿 만들기</h1>");
		out.println("</body>");
		out.println("</html>");
	}
}
