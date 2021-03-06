package board;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

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
				dir.mkdirs();         // mkdir() : 상위 폴더가 없으면 저장불가
			}							  // mkdirs() : 상위 폴더가 없어도 폴더 생성 후 저장 가능
			
			MultipartRequest multi=
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, 
							ENCTYPE, new DefaultFileRenamePolicy());

			String filename = null;
			int filesize=0; 

			//사용자가 파일을 업로드 하는 경우
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
	
	//Board Total Count ( 총 게시물 개수 _ 화면에 출력 )
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.equals("")||keyWord==null) { 			                 // 검색이 아닌경우
				sql="SELECT count(*) FROM tblBoard";
				pstmt = con.prepareStatement(sql);
			} else {																			     				 // 검색인 경우
				sql="SELECT count(*) FROM tblBoard WHERE " + keyField +" LIKE ?"; 	 	// keyField column 이  %keyWord% 값인 행 검색
																														// sql 문 띄어쓰기 주의 
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" +keyWord + "%");                   					     // &검색어&  : 검색어가 포함된 모든 값
			}
			rs=pstmt.executeQuery();
			if(rs.next())
				totalCount = rs.getInt(1);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	
	//Board List(리스트) : 검색 기능도 포함  ( keyField / keyWord 사용 )
		//( 페이지마다 10개씩만 가져오므로 DB limit 기능 사용 )
	public Vector<BoardBean> getBoardList(String keyField, String keyWord, int start, int cnt){
		Connection con =null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		Vector <BoardBean> vlist = new Vector <BoardBean> ();
		try {
			con = pool.getConnection();
			if(keyWord.trim().contentEquals("")||keyWord==null) { 						 // 검색이 아닌 경우
				sql = "SELECT * FROM tblBoard ORDER BY ref DESC, pos ASC LIMIT ?, ?";  	// LIMIT x, y   :  x번째 행부터 y개 select
																													// ref descending 정렬  + pos ascending 정렬
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start); 		// 게시물 시작 행 번호
				pstmt.setInt(2, cnt);			// 가져올 게시물 개수
			} else {      															            		  // 검색인 경우
				sql = "SELECT * FROM tblBoard WHERE " + keyField + " LIKE ? "		   // keyField column 이  %keyWord% 값인 행 검색
						+ "ORDER BY ref DESC, pos ASC LIMIT ?, ?";	    							   // sql 문 띄어쓰기 주의 
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" +keyWord + "%");
				pstmt.setInt(2, start); 		// 게시물 시작 행 번호
				pstmt.setInt(3, cnt);			// 가져올 게시물 개수
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardBean bean = new BoardBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setSubject(rs.getString("subject"));
				bean.setPos(rs.getInt("pos"));
				bean.setRef(rs.getInt("ref"));
				bean.setDepth(rs.getInt("depth"));
				//regdate DB에서 DATE타입이지만 모든 타입은 getString 가능
				bean.setRegdate(rs.getString("regdate"));
				bean.setCount(rs.getInt("count"));
				bean.setFilename(rs.getString("filename"));
				vlist.addElement(bean);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	
	// Board Get (한 개의 게시물)
	public BoardBean getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		BoardBean bean = new BoardBean();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM tblBoard WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setSubject(rs.getString(3));
				bean.setContent(rs.getString(4));
				bean.setPos(rs.getInt(5));
				bean.setRef(rs.getInt(6));
				bean.setDepth(rs.getInt(7));
				bean.setRegdate(rs.getString(8));
				bean.setPass(rs.getString(9));
				bean.setIp(rs.getString(10));
				bean.setCount(rs.getInt(11));
				bean.setFilename(rs.getString(12));
				bean.setFilesize(rs.getInt(13));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	
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
			pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	// Board Delete : 게시물 삭제 (업로드한 파일도 함께 삭제)
	public void deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "SELECT filename FROM tblBoard WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next() && rs.getString(1)!=null) {
				if(!rs.getString(1).equals("")) {
					File f = new File(SAVEFOLDER+rs.getString(1));
					if(f.exists()) {
						//파일 삭제 기능
						UtilMgr.delete(SAVEFOLDER+rs.getString(1));
					}
				}
			}
			pstmt.close();
			sql = "DELETE FROM tblBoard WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
				
	}
	
	
	
	// Board Update(name, subject, content 3개만 수정)
	public void updateBoard(BoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblBoard set name=?, subject=?, content=? "
					+ "where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getSubject());
			pstmt.setString(3, bean.getContent());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	// Board Update 2 (name, subject, content, file 모두 수정)
		public void updateBoard2(MultipartRequest multi) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			try {
				con = pool.getConnection();

				if(multi.getFilesystemName("filename")!=null) {
					// 파일이 새로 업로드 되었을 때
				/// 파일 삭제
				sql = "SELECT filename FROM tblBoard WHERE num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("num"));
				rs = pstmt.executeQuery();
				if(rs.next() && rs.getString(1)!=null) {
					if(!rs.getString(1).equals("")) {
						File f = new File(SAVEFOLDER+rs.getString(1));
						if(f.exists()) {
							//파일 삭제 기능
							UtilMgr.delete(SAVEFOLDER+rs.getString(1));
						}
					}
				}
				pstmt.close();
				rs.close();
				//// -- 파일 삭제 완료
				}
				
				
				/////////////   파일 업로드    /////////////////
				File dir = new File(SAVEFOLDER);
				if(!dir.exists()) {		//// 폴더가 없다면 새롭게 만들어라.
					dir.mkdirs();         // mkdir() : 상위 폴더가 없으면 저장불가
				}							  // mkdirs() : 상위 폴더가 없어도 폴더 생성 후 저장 가능
				
				String filename = null;
				int filesize=0; 

				//사용자가 파일을 업로드 하는 경우
				if(multi.getFilesystemName("filename")!=null) {
					filename = multi.getFilesystemName("filename");
					filesize = (int)multi.getFile("filename").length();
				}
				
				////////////////////////////////////////
				sql = "update tblBoard set name=?, subject=?, content=?, filename=?, filesize=? "
						+ "where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("name"));
				pstmt.setString(2, multi.getParameter("subject"));
				pstmt.setString(3, multi.getParameter("content"));
				// 파일명 / 파일 사이즈
				if(multi.getFilesystemName("filename")==null) {  // filename 이 입력되지 않았을 때는  sql : filename=filename, filesize = filesize  동일값 입력되도록 함.
					pstmt.setString(4, "filename");
					pstmt.setString(5, "filesize");
				} else {															// 새 filename 입력되었을 때 : 새 name 및 size 로 입력시킴
					pstmt.setString(4, filename);
					pstmt.setInt(5, filesize);
				}
				//////////
				pstmt.setInt(6, Integer.parseInt(multi.getParameter("num")));
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	
	
	
	// Board Reply : 답변
	public void replyBoard(BoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "INSERT tblBoard(name, content, subject, ref, pos, depth, regdate,"
					+" pass, count, ip) VALUES(?,?,?,?,?,?, now(), ?,0,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getContent());
			pstmt.setString(3, bean.getSubject());
			///////////////////////////////////////////////
			pstmt.setInt(4, bean.getRef());		   // 원글과 동일한 ref  (ref : 원글 그룹 번호)
			pstmt.setInt(5, bean.getPos()+1);   // 원글의 Pos +1  (pos : 원글 그룹 내(ref) 답글 순서)
			pstmt.setInt(6, bean.getDepth()+1);   // 원글의 depth+1  (
			///////////////////////////////////////////////
			pstmt.setString(7,  bean.getPass());
			pstmt.setString(8,  bean.getIp());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	// Board Reply Up : 답변 위치값 (pos) 수정(+1 증가)
	public void replyUpBoard(int ref, int pos) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "UPDATE tblBoard SET pos = pos+1 WHERE ref=? AND pos>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, pos);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	//Post 1000
	//페이징 및 블럭 테스트를 위한 게시물 1000개 삽입하는 메소드 
	public void post1000(){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert tblBoard(name,content,subject,ref,pos,depth,regdate,pass,count,ip,filename,filesize)";
			sql+=" values('aaa', 'bbb', 'ccc', 0, 0, 0, now(), '1111',0, '127.0.0.1', null, 0);";
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
	
	//main method
	public static void main(String[] args) {
		BoardMgr mgr = new BoardMgr();
		mgr.post1000();
		System.out.println("성공~~");
	}
}
