package ch07_beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

//JSP DB연동에 필요한 메소드를 만드는 클래스
public class TeamMgr {
	
	//풀링기법 : Connection 객체를 미리 10개 만들어 놓는다.
	private DBConnectionMgr pool;
	
	public TeamMgr() {
		//DBConnectionMgr은 싱글톤 패턴을 구현 클래스
		//싱글톤 패턴은 객체를 한개만 만들수 있도록 구현한 클래스
		pool = DBConnectionMgr.getInstance();
	}

	//저장
	//public boolean postTeam(String name,String city,int age,String team)
	public boolean postTeam(TeamBean bean) {
		//java.sql 패키지 사용
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			//DBConnectionMgr에서 Connection 빌려옴.
			con = pool.getConnection();
			sql = "insert tblTeam(name,city,age,team)values(?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			//?에 실질적인 값을 세팅
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getCity());
			pstmt.setInt(3, bean.getAge());
			pstmt.setString(4, bean.getTeam());
			//완성된 sql 실행 : cnt는 성공이면 1, 실패 0
			int cnt = pstmt.executeUpdate();//insert, update, delete
			if(cnt==1) flag =true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//Connection 반납하고, pstmt는 close
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//리스트 : 레코드 한줄를 담는 객체는 빈즈다. 
	//이런한 여러개 빈즈를 담는 객체 Vector
	public Vector<TeamBean> listTeam(){
		Connection con = null;
		PreparedStatement pstmt = null;
		//select 일때 테이블 스키마(구조), 레코드 단위)
		ResultSet rs = null;
		String sql = null;
		Vector<TeamBean> vlist = new Vector<TeamBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblTeam";
			pstmt = con.prepareStatement(sql);
			//현재 sql문은 ? 가 없다. 바로 실행
			rs = pstmt.executeQuery();//select 실행
			while(rs.next()) {
				//테이블에서 가져온 값들을 빈즈에 저장
				TeamBean bean = new TeamBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setCity(rs.getString("city"));
				bean.setAge(rs.getInt("age"));
				bean.setTeam(rs.getString("team"));
				//빈즈를 Vector 저장
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//con 반납, pstmt, rs는 close
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	//레코드 한개 가져오기
	public TeamBean readTeam(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql =null;
		TeamBean bean = new TeamBean();
		try {
			con = pool.getConnection();
			sql = "SELECT * FROM tblTeam WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setCity(rs.getString(3));
				bean.setAge(rs.getInt(4));
				bean.setTeam(rs.getString(5));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	
	//수정
	public boolean updateTeam(TeamBean bean) {
		Connection con =null;
		PreparedStatement pstmt =null;
		String sql = null;
		boolean flag =false;
		try {
			con = pool.getConnection();
			sql = "UPDATE tblteam SET NAME=?, city=?, age=?, team=? WHERE (num = ?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getCity());
			pstmt.setInt(3, bean.getAge());
			pstmt.setString(4, bean.getTeam());
			pstmt.setInt(5, bean.getNum());
			int cnt = pstmt.executeUpdate();
			if(cnt ==1) {
				flag =true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//삭제
	public void deleteTeam(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "DELETE FROM tblteam WHERE num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//teamPost.jsp 의 직업 란  select 옵션 값 가져오기
	
	String [] teamN;  // 초기화 하지 않기 위해 전역변수로 선언
	
	public String[] readTeamName() {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs =null;
		int i = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT DISTINCT team FROM tblteam ORDER BY team";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				i++;
			}
			//System.out.println("배열의 크기 : "+i);
			teamN= new String[i];
			i = 0;
			rs.beforeFirst();  // rs  cursor 첫행 앞으로 다시 이동
			while(rs.next()) {
				teamN[i] = rs.getString(1);
				//System.out.println(i +" 자리 입력값  : " + rs.getString(1));
				i++;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return teamN;
	}
}




