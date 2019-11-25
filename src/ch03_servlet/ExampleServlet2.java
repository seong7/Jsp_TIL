package ch03_servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


// 서블릿 라이프 싸이클  ( init / destroy / service )


@WebServlet("/ch03/ExampleServlet2")
public class ExampleServlet2 extends HttpServlet {
	
	@Override
	public void init() throws ServletException {
		System.out.println("init 호출");
		// 가장 먼저 호출됨
			// 해당 servlet class 의 객체 생성 시 최초에만 호출됨 
			// 변수 선언 및 세팅 시 주로 사용함 ( 사용 빈도는 낮음 ) 
	}
	
	@Override
	public void destroy() {
		System.out.println("destroy 호출");
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("service 호출");
		// init 다음 호출됨
			// 새로고침하면 게속 호출됨
			// html form 을 통해 일반적으로 호출되는 메소드임 ( 이 외에는 doGet , doPost 가 있음 )
				
	}
}
