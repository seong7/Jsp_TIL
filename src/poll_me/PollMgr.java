package poll_me;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class PollMgr {

	private DBConnectionMgr pool;
	
	public PollMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Max Num(�ڵ�����) : JSP ���������� num���� ��û�� �ȵ� ��� ���� �ֽ��� ������ ��
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblPollList";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next())
				maxNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}
	
	//Poll Insert : �����ۼ�
	public boolean insertPoll(PollListBean plBean, PollItemBean piBean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblPollList(question,sdate,edate,wdate,type)"
					+ "values(?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, plBean.getQuestion());
			pstmt.setString(2, plBean.getSdate());
			pstmt.setString(3, plBean.getEdate());
			pstmt.setInt(4, plBean.getType());//1:��������, 0:���ϼ���
			int cnt = pstmt.executeUpdate();
			pstmt.close();
			if(cnt==1) { //���������� ��������Ʈ�� ���� -> ���������� ����
				sql = "insert tblPollItem values (?,?,?,0)";
				pstmt = con.prepareStatement(sql);
				int listNum = getMaxNum();//��� ����� listNum�� ����
				String item[] = piBean.getItem();
				int j = 0;
				for (int i = 0; i < item.length; i++) {
					if(item[i]==null||item[i].trim().equals("")) {
						break;
					}
					pstmt.setInt(1, listNum);
					pstmt.setInt(2, i);
					pstmt.setString(3, item[i]);
					j = pstmt.executeUpdate();
				}//---for
				if(j==1) flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Poll List : ���� ����Ʈ
	
	//Sum Count : �� ��ǥ��
	
	//Poll Read : ���� �Ѱ� ��������
	
	//Poll Item List : ���� �ϳ��� ����� ������
	
	//Poll Update : ��ǥ����
	
	//Poll View : ��ǥ���
	
	//Max Item Count : ������ �߿� ���� ���� ��ǥ��
	
}






















