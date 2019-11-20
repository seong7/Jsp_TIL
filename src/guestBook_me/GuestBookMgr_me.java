package guestBook_me;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

public class GuestBookMgr_me {

	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private final SimpleDateFormat SDF_DATE =
			new SimpleDateFormat("yyyy'³â'  M'¿ù' d'ÀÏ' (E)");
	private final SimpleDateFormat SDF_TIME =
			new SimpleDateFormat("H:mm:ss");
	
	
	public GuestBookMgr_me() {
		try {
			String dbUrl = "jdbc:mysql://localhost:3306/mydb";
			String dbId = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbUrl, dbId, dbPassword);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void select() {
		String sql = "select * from tblJoin";
		try {
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				System.out.print(rs.getString(1) + "\t");
				System.out.print(rs.getString(2) + "\t");
				System.out.print(rs.getString(3) + "\t");
				System.out.print(rs.getString(4) + "\t");
				System.out.print(rs.getString(5) + "\t");
				System.out.print(rs.getString(6) + "\n");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				pstmt.close();
				rs.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public static void main(String[]args) {
		new GuestBookMgr_me().select();
	}
}
