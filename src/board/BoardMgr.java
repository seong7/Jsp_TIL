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
	
	
	//Board Insert : ���� ���ε� , ContentType, ref �� ������� ��ġ��
	public void insertBoard(HttpServletRequest req) {
		//multi part request ��ü�� �ʿ��ϹǷ� HttpServletRequest �� �Ű������� �޴´�.
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			
			///////// ���� ���ε� //////
			
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()) {		//// ������ ���ٸ� ���Ӱ� ������.
				dir.mkdirs();         // mkdir() : ���� ������ ������ �����Ұ�
			}							  // mkdirs() : ���� ������ ��� ��������
			
			MultipartRequest multi=
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
							ENCTYPE, new DefaultFileRenamePolicy());

			String filename = null;
			int filesize=0; 

			//����ڰ� ������ ���ε� �� ���
			if(multi.getFilesystemName("filename")!=null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int)multi.getFile("filename").length();
			}
			//// �Խù� contentType : text, html   �� ���� ����  ////
			String content = multi.getParameter("content"); // �Խù� ���� return
			if(multi.getParameter("contentType").equals("TEXT")) {
				content = UtilMgr.replace(content, "<", "&lt;");
			}	

			/////////////
			con = pool.getConnection();
			/////////////
			sql = "SELECT max(num) FROM tblBoard";  // ���� ���� num ��
			pstmt=con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int ref = 0;
			if(rs.next()) {
				ref = rs.getInt(1) + 1; // ���� ���� num ���� 1 �� ����
				/// ref �� return;
			}
			pstmt.close();
			/////////////__ ���� ���� ���ε� �Ϸ�
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
	
	//Board Total Count (�� �Խù� ����)
	
	
	//Board List(����Ʈ) : �˻� ����  
		//( ���������� 10������ �������Ƿ� DB limit ��� ��� ) 
	
	
	// Board Get (�� ���� �Խù�)

	
	// Count Up(��ȸ�� ����)
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
	
	
	// Board Delete : �Խù� ���� (���ε��� ���ϵ� �Բ� ����)
	
	
	//Post 1000
	//����¡ �� �� �׽�Ʈ�� ���� �Խù� ���� �޼ҵ� 
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
		System.out.println("����~~");
	}
}
