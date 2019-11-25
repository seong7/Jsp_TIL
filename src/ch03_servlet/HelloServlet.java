package ch03_servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/helloServlet")
public class HelloServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/html");  // 아래의 text 는 html 이라고 지정
		PrintWriter out = resp.getWriter();
		
        out.println("<html>");
        out.println("<head>");
        out.println("<title>My First Servlet</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<font color = red>");
        out.println("<h1>Fighting Korea!!!</h1>");
        out.println("</body>");
        out.println("</html>");
	}

}
