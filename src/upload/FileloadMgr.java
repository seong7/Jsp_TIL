package upload;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class FileloadMgr {

	public static final String saveFolder = 
	"C:/Jsp/myapp/WebContent/upload/filestorage/"	;
	public static final String encType = "EUC-KR";
	public static final int maxSize = 10*1024*1024;//10MB
	
	private DBConnectionMgr pool;
	
	public FileloadMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	// 파일 리스트
	public Vector<FileloadBean> listFile(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FileloadBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from tblFileload";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FileloadBean bean = new FileloadBean();
				bean.setNum(rs.getInt(1));
				bean.setUpFile(rs.getString(2));
				bean.setSize(rs.getInt(3));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//파일 업로드
	public boolean uploadFile(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			
			MultipartRequest multi = new MultipartRequest(req, saveFolder, maxSize, 
					encType,	 new DefaultFileRenamePolicy());
					
			String upFile = multi.getFilesystemName("upFile");
			File f = multi.getFile("upFile");
			int size = (int)f.length();
			
			
			
			con = pool.getConnection();
			sql = "INSERT tblFileload(upFile, size) values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,  upFile);
			pstmt.setInt(2, size);
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//파일 삭제
	public void deleteFile(int num[]) {              //  flist.jsp 에서 체크된 checkbox 의 num 값들 받아서 실행
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = pool.getConnection();
			for(int numI : num) {
				sql="SELECT upFile FROM tblFileload WHERE num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,  numI);
				rs=pstmt.executeQuery();
				if(!rs.next())
					continue;  							// rs 에 값이 없으면 위의  for 문 num[i+1]로 바로 감. 아래 코드는 실행 안됨.
				String upFile = rs.getString(1);
				File f  = new File(saveFolder+upFile);
				if(f.exists())  							 // 해당 위치에 지명된 파일 존재하는지 확인
					f.delete();  						 // 존재하면 삭제
				pstmt.close();  						// 다른 sql 을 또 실행시키기 위해 닫아준다.  (결과 값은 이미 rs에 있음)
				sql = "DELETE FROM tblFileload WHERE num=?";
				pstmt = con.prepareStatement(sql); 				 // 파일 삭제하고 나면 해당 파일 정보 DB에서도 삭제
				pstmt.setInt(1, numI);
				pstmt.executeUpdate();
			}
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
}













