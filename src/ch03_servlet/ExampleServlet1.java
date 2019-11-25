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
	//serialVersionUID : ��ü ����ȭ -> ��ü ��ü�� ��Ʈ��ũ�� ������ �ÿ��� ���

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=EUC-KR"); 
		PrintWriter out = response.getWriter();
		// print writer : ��� ��Ʈ��
		
		/////////  html code  ///////
		out.println("<html>");
		out.println("<body>");
		out.println("<h1> ��Ŭ������ ���� �����</h1>");
		out.println("</body>");
		out.println("</html>");
	}
}
