package ch07_beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

//JSP DB������ �ʿ��� �޼ҵ带 ����� Ŭ����
public class TeamMgr {
	
	//Ǯ����� : Connection ��ü�� �̸� 10�� ����� ���´�.
	private DBConnectionMgr pool;
	
	public TeamMgr() {
		//DBConnectionMgr�� �̱��� ������ ���� Ŭ����
		//�̱��� ������ ��ü�� �Ѱ��� ����� �ֵ��� ������ Ŭ����
		pool = DBConnectionMgr.getInstance();
	}

	//����
	//public boolean postTeam(String name,String city,int age,String team)
	public boolean postTeam(TeamBean bean) {
		//java.sql ��Ű�� ���
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			//DBConnectionMgr���� Connection ������.
			con = pool.getConnection();
			sql = "insert tblTeam(name,city,age,team)values(?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			//?�� �������� ���� ����
			pstmt.setString(1, bean.getName());
			pstmt.setString(2, bean.getCity());
			pstmt.setInt(3, bean.getAge());
			pstmt.setString(4, bean.getTeam());
			//�ϼ��� sql ���� : cnt�� �����̸� 1, ���� 0
			int cnt = pstmt.executeUpdate();//insert, update, delete
			if(cnt==1) flag =true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//Connection �ݳ��ϰ�, pstmt�� close
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//����Ʈ : ���ڵ� ���ٸ� ��� ��ü�� �����. 
	//�̷��� ������ ��� ��� ��ü Vector
	public Vector<TeamBean> listTeam(){
		Connection con = null;
		PreparedStatement pstmt = null;
		//select �϶� ���̺� ��Ű��(����), ���ڵ� ����)
		ResultSet rs = null;
		String sql = null;
		Vector<TeamBean> vlist = new Vector<TeamBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblTeam";
			pstmt = con.prepareStatement(sql);
			//���� sql���� ? �� ����. �ٷ� ����
			rs = pstmt.executeQuery();//select ����
			while(rs.next()) {
				//���̺��� ������ ������ ��� ����
				TeamBean bean = new TeamBean();
				bean.setNum(rs.getInt("num"));
				bean.setName(rs.getString("name"));
				bean.setCity(rs.getString("city"));
				bean.setAge(rs.getInt("age"));
				bean.setTeam(rs.getString("team"));
				//��� Vector ����
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			//con �ݳ�, pstmt, rs�� close
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	//���ڵ� �Ѱ� ��������
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
	
	
	//����
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
	
	//����
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
	
	//teamPost.jsp �� ���� ��  select �ɼ� �� ��������
	
	String [] teamN;  // �ʱ�ȭ ���� �ʱ� ���� ���������� ����
	
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
			//System.out.println("�迭�� ũ�� : "+i);
			teamN= new String[i];
			i = 0;
			rs.beforeFirst();  // rs  cursor ù�� ������ �ٽ� �̵�
			while(rs.next()) {
				teamN[i] = rs.getString(1);
				//System.out.println(i +" �ڸ� �Է°�  : " + rs.getString(1));
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




