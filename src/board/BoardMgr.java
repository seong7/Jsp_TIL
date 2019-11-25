package board;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class BoardMgr {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER="C:/Jsp/myapp/WebContent/board/fileupload/";
	public static final String ENCTYPE="EUC-KR";
	public static int MAXSIZE=10*1024*1024;
	
	
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	//Board Insert : 파일 업로드 , ContentType, ref 의 상대적인 위치값
	public void insertBoard(HttpServletRequest req) {
		//multi part request 객체가 필요하므로 HttpServletRequest 를 매개변수로 받는다.
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			
			///////// 파일 업로드 //////
			
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()) {		//// 폴더가 없다면 새롭게 만들어라.
				dir.mkdirs();         // mkdir() : 상위 폴더가 없으면 생성불가
			}							  // mkdirs() : 상위 폴더가 없어도 생성가능
			
			MultipartRequest multi=
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
							ENCTYPE, new DefaultFileRenamePolicy());

			String filename = null;
			int filesize=0; 

			//사용자가 파일을 업로드 한 경우
			if(multi.getFilesystemName("filename")!=null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			//// 게시물 contentType : text, html   두 가지 있음  ////
			String content = multi.getParameter("content"); // 게시물 내용 return
			if(multi.getParameter("contentType").equals("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}	

			/////////////
			con = pool.getConnection();
			/////////////
			sql = "SELECT max(num) FROM tblBoard";  // 가장 높은 num 값
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int ref = 0;
			if(rs.next()) {
				ref = rs.getInt(1) + 1; // 가장 넢은 num 값에 1 을 더함
				/// ref 값 return;
			}
			pstmt.close();
			/////////////__ 파일 정상 업로드 완료
			sql = "insert tblBoard(name,content,subject,ref,pos,depth,";
			sql += "regdate,pass,count,ip,filename,filesize)";
			sql += "values(?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, content);
			pstmt.setString(3, multi.getParameter("subject"));
			pstmt.setInt(4, ref);
			pstmt.setString(5, multi.getParameter("pass"));
			pstmt.setString(6, multi.getParameter("ip"));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
	//Board Total Count (총 게시물 개수)
	
	
	//Board List(리스트) : 검색 포함  
		//( 페이지마다 10개씩만 가져오므로 DB limit 기능 사용 ) 
	
	
	// Board Get (한 개의 게시물)

	
	// Count Up(조회수 증가)
	public void countUp(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "UPDATE tblBoard SET count=count+1 WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeQuery();
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	// Board Delete : 게시물 삭제 (업로드한 파일도 함께 삭제)
	
	
	//Post 1000
	//페이징 및 블럭 테스트를 위한 게시물 저장 메소드 
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblBoard(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize)";
			sql+="values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1111',0, '127.0.0.1', null, 0);";
			pstmt = con.prepareStatement(sql);
			for (int i = 0; i < 1000; i++) {
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//main
	public static void main(String[] args) {
		BoardMgr mgr = new BoardMgr();
		mgr.post1000();
		System.out.println("성공~~");
	}
}
