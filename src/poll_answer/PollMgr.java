package poll_answer;

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
	public Vector<PollListBean> getAllList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollListBean> vlist = new Vector<PollListBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblPollList order by num desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PollListBean plBean = new PollListBean();
				plBean.setNum(rs.getInt("num"));
				plBean.setQuestion(rs.getString("question"));
				plBean.setSdate(rs.getString("sdate"));
				plBean.setEdate(rs.getString("edate"));
				vlist.addElement(plBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Poll Read : 설문 한개 가져오기
	public PollListBean getPollRead(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		PollListBean plBean = new PollListBean();
		try {
			con = pool.getConnection();
			sql = "select num, question, type, active from tblPollList "
					+ "where num = ?";
			pstmt = con.prepareStatement(sql);
			//num 값이 0으로 리턴 -> 가장은 높은(최신)값이 num으로 리턴
			if(num==0)
				num = getMaxNum();
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				plBean.setNum(rs.getInt(1));
				plBean.setQuestion(rs.getString(2));
				plBean.setType(rs.getInt(3));
				plBean.setActive(rs.getInt(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return plBean;
	}
	
	//Poll Item List : 설문 하나에 연결된 아이템
	public Vector<String> getItem(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<String> vlist = new Vector<String>(); 
		try {
			con = pool.getConnection();
			sql = "select item from tblPollItem where listNum = ?";
			pstmt = con.prepareStatement(sql);
			if(num==0)
				num = getMaxNum();
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next())
				vlist.addElement(rs.getString(1));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	//Sum Count : 총 투표수
	public int sumCount(int listNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int sum = 0;
		try {
			con = pool.getConnection();
			sql = "select sum(count) from tblPollItem "
					+ "where listnum = ?";
			pstmt = con.prepareStatement(sql);
			if(listNum==0) 
				listNum = getMaxNum();
			pstmt.setInt(1, listNum);
			rs = pstmt.executeQuery();
			if(rs.next())
				sum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return sum;
	}
	
	//Poll Update : 투표실행
	//update tblPollItem set count = count +1 "
	// where listnum =? and itemnum = ?;
	//itemNum[] 정수변환 . for문
	public boolean updatePoll(int listNum, String itemNum[]) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblPollItem set count = count +1 "
					+ "where listnum=? and itemnum=?";
			pstmt = con.prepareStatement(sql);
			if(listNum==0)
				listNum = getMaxNum();
			for (int i = 0; i < itemNum.length; i++) {
				pstmt.setInt(1, listNum);
				pstmt.setInt(2, Integer.parseInt(itemNum[i]));
				if(pstmt.executeUpdate()==1)
					flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Poll View : 투표결과
	//select item, count from tblPollItem where listnum = ?
	public Vector<PollItemBean> getView(int listNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PollItemBean> vlist = new Vector<PollItemBean>();
		try {
			con = pool.getConnection();
			sql = "select item, count from tblPollItem where listnum = ?";
			pstmt = con.prepareStatement(sql);
			if(listNum==0)
				listNum = getMaxNum();
			pstmt.setInt(1, listNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				PollItemBean piBean = new PollItemBean();
				String item[] = new String[1];
				item[0] = rs.getString("item");
				piBean.setItem(item);
				piBean.setCount(rs.getInt("count"));
				vlist.addElement(piBean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Max Item Count : 아이템 중에 가장 높은 투표값
	//select max(count) from tblPollitem where listNum = ?
	public int getMaxCount(int listNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxCnt = 0;
		try {
			con = pool.getConnection();
			sql = "select max(count) from tblPollitem where listNum = ?";
			pstmt = con.prepareStatement(sql);
			if(listNum==0)
				listNum = getMaxNum();
			pstmt.setInt(1, listNum);
			rs = pstmt.executeQuery();
			if(rs.next())
				maxCnt = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxCnt;
	}
	
}






















