package ch07_beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MySQLConnection {
	
	private DBConnectionMgr pool;
	
	public MySQLConnection() {
		pool = DBConnectionMgr.getInstance();
		Connection con =null;
		PreparedStatement pstmt =null;
		String sql = "select * from tblchat";
		ResultSet rs = null;
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				System.out.print(rs.getString("id"));
				System.out.print("\t");
				System.out.print(rs.getString("pwd") + "\n");
			}
			System.out.println("연결성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		new MySQLConnection();
	}
}
