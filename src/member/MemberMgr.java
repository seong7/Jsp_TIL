package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class MemberMgr {
	DBConnectionMgr pool;

	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	// zipcode insert
	public boolean insertZip() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ZipCodeReader reader = new ZipCodeReader();
		Vector<String> rSql = reader.sql; // zipcode.txt 읽어옴
		boolean flag = false;
		for (String sql : rSql) {
			try {
				con = pool.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate();
				// System.out.println("성공 !");
			} catch (Exception e) {
				System.out.println("실패 !");
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
		return flag;
	}

	// 전체 tblZipcode table 레코드 수 조회
	public int selectAllZip() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "select count(zipcode) from tblzipcode";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}

	// 로그인 : 성공 : true, 실패 : false
	public boolean loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id=? and pwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	// ID 중복확인 - true 중복
	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			flag = rs.next();// 결과값이 있으면 true 없으면 false
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}

	// 우편번호 검색
	// select * from tblZipcod where area3 like '%강남대로%'
	public Vector<ZipcodeBean> zipcodeRead(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + area3 + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	
	// 회원가입
	public boolean insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblMember(id,pwd,name,gender,birthday,email,zipcode,address,hobby,job) "
					+ "values(?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getGender());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getZipcode());
			pstmt.setString(8, bean.getAddress());
			
			//////////// hobby :  "010101" 형태로 삽입 ////////////
			String hobby[] = bean.getHobby();
			char hb[] = {'0','0', '0', '0', '0'};
			String lists[] = {"인터넷", "여행", "게임", "영화", "운동"};
			for(int i=0; i<hobby.length; i++) {
				for(int j=0; j<lists.length; j++) {
					if(hobby[i].contentEquals(lists[j])) {
						hb[j]='1';
						break;
					}//-- if
				}//-- for j
			}//-- for i
			pstmt.setString(9, new String(hb));   // char 의 배열을 매개변수로 String 객체 생성하면 자동으로 합쳐짐 !!
			/////////////////////////////////////////////////////
			
			pstmt.setString(10, bean.getJob());
			int cnt = pstmt.executeUpdate();
			if(cnt==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	
	//회원 정보 가져오기
		public MemberBean getMember(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MemberBean bean = new MemberBean();
			try {
				con = pool.getConnection();
				sql = "select * from tblMember where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setId(rs.getString("id"));
					bean.setPwd(rs.getString("pwd"));
					bean.setName(rs.getString("name"));
					bean.setGender(rs.getString("gender"));
					bean.setBirthday(rs.getString("birthday"));
					bean.setEmail(rs.getString("email"));
					bean.setZipcode(rs.getString("zipcode"));
					bean.setAddress(rs.getString("address"));
					////////////////////////////////////////
					String hobby = rs.getString("hobby");
					String hobbys[] = new String[hobby.length()];
					//hobby : 10101 => {"1","0","1","0","1"}
					for (int i = 0; i < hobbys.length; i++) {
						hobbys[i] = hobby.substring(i,i+1);
					}
					bean.setHobby(hobbys);
					////////////////////////////////////////
					bean.setJob(rs.getString("job"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}

		
	
	// 회원 정보 수정
	public boolean updateMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "UPDATE tblMember SET pwd=?, name=?, gender=?, birthday=?, email=?, zipcode=?, "
					+ "address=?, hobby=?, job=? WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getBirthday());
			pstmt.setString(5, bean.getEmail());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			////////////hobby :  "010101" 형태로 삽입 ////////////
			String hobby[] = bean.getHobby();
			char hb[] = {'0','0', '0', '0', '0'};
			String lists[] = {"인터넷", "여행", "게임", "영화", "운동"};
			for(int i=0; i<hobby.length; i++) {
				for(int j=0; j<lists.length; j++) {
					if(hobby[i].contentEquals(lists[j])) {
						hb[j]='1';
						break;
					}//-- if
				}//-- for j
			}//-- for i
			pstmt.setString(8, new String(hb));   // char 의 배열을 매개변수로 String 객체 생성하면 자동으로 합쳐짐 !!
			/////////////////////////////////////////////////////
			
			pstmt.setString(9, bean.getJob());
			pstmt.setString(10, bean.getId());
			int cnt = pstmt.executeUpdate();
			if(cnt==1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	


	public static void main(String[] args) {
		// System.out.println(new MemberMgr().selectAllZip());
	}
}