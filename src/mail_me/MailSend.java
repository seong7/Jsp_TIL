package mail_me;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MailSend {
	
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public MailSend() {
		try {
			String dbUrl = "jdbc:mysql://localhost:3306/mydb";
			String dbId = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection(dbUrl, dbId, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
//	public class WrongInfoException extends RuntimeException {
//	}
	
	public boolean getPwd(String id, String email) {
		String pwd ="";
		String sql = "SELECT pwd FROM tblmember WHERE id=? AND email=?";
		boolean flag = false;
		boolean flag2 = false;
		boolean flag3 = false;
		try{
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, email);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				pwd = rs.getString(1);
				flag = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				con.close();
				pstmt.close();
				rs.close();
			}catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		//System.out.println(pwd);
		if(flag) {
			flag2 = sendPwd(id, pwd, email);
		}
		if(flag2) {
			flag3 = true;
		}
		return flag3;
	}

	boolean sendPwd(String id, String pwd, String email) {
		boolean flag = false;
		
		flag = GmailSend.send("아이디 및 비밀번호 정보", "id: "+ id+" pwd : "+pwd, "sjkim1123@naver.com");
		
		return flag;
	}
	
//	public static void main(String[] args) {
//		MailSend x = new MailSend();
//		x.getPwd("aaa", "sjkim1123@naver.com");
//	}
}
