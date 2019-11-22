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
	
	
	// ���� ����Ʈ
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
	
	//���� ���ε�
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
	
	//���� ����
	public void deleteFile(int num[]) {              //  flist.jsp ���� üũ�� checkbox �� num ���� �޾Ƽ� ����
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
					continue;  							// rs �� ���� ������ ����  for �� num[i+1]�� �ٷ� ��. �Ʒ� �ڵ�� ���� �ȵ�.
				String upFile = rs.getString(1);
				File f  = new File(saveFolder+upFile);
				if(f.exists())  							 // �ش� ��ġ�� ������ ���� �����ϴ��� Ȯ��
					f.delete();  						 // �����ϸ� ����
				pstmt.close();  						// �ٸ� sql �� �� �����Ű�� ���� �ݾ��ش�.  (��� ���� �̹� rs�� ����)
				sql = "DELETE FROM tblFileload WHERE num=?";
				pstmt = con.prepareStatement(sql); 				 // ���� �����ϰ� ���� �ش� ���� ���� DB������ ����
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












