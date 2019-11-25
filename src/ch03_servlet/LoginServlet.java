package ch03_servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/ch03_servlet/loginServlet")
public class LoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// id pwd 는 보통 한글이 아니므로 굳이  request 의 인코딩을 설정해주지 않는다.
		response.setContentType("text/html; charset=EUC-KR");
		
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		if(id.equals("aaa") && pwd.contentEquals("1234")) {
			// 로그인 성공시  : 세션에 idKey 값 저장
			HttpSession session = request.getSession(); // session return 받아옴 
			session.setAttribute("idKey", id);
			response.sendRedirect("login.jsp");
			
		}else {
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('입력하신 계정이 아닙니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}
