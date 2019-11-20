package poll;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class PollMgr {

	private DBConnectionMgr pool;
	
	public PollMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Max Num(자동증가) : JSP 페이지에서 num값이 요청이 안될 경우 가장 최신의 설문지 값
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
	
	//Poll Insert : 설문작성
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
			pstmt.setInt(4, plBean.getType());//1:복수설문, 0:단일설문
			int cnt = pstmt.executeUpdate();
			pstmt.close();
			if(cnt==1) { //정상적으로 설문리스트가 저장 -> 설문아이템 저장
				sql = "insert tblPollItem values (?,?,?,0)";
				pstmt = con.prepareStatement(sql);
				int listNum = getMaxNum();//방금 저장된 listNum값 리턴
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
	
	//Poll List : 설문 리스트
	
	//Sum Count : 총 투표수
	
	//Poll Read : 설문 한개 가져오기
	
	//Poll Item List : 설문 하나에 연결된 아이템
	
	//Poll Update : 투표실행
	
	//Poll View : 투표결과
	
	//Max Item Count : 아이템 중에 가장 높은 투표값
	
}






















