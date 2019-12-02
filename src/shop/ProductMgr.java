package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ProductMgr {
	
	private DBConnectionMgr pool;
	private static final String UPLOAD = "C:/Jsp/myapp/WebContent/shop/data/";
	private static final String ENCTYPE = "EUC-KR";
	private static final int MAXSIZE = 10*1024*1024;

	
	// Product List
	//Product List
	public Vector<ProductBean> getProductList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ProductBean> vlist = new Vector<ProductBean>();
		try {
			con = pool.getConnection();
			sql = "select no, name, price, date, stock from tblProduct "
					+ "order by no desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductBean bean = new ProductBean();
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(3));
				bean.setDate(rs.getString(4));
				bean.setStock(rs.getInt(5));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	// Product Detail
	public ProductBean getProduct(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ProductBean bean = new ProductBean();
		try {
			con = pool.getConnection();
			sql = "select no, name, price, date, stock, image "
					+ "from tblProduct";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNo(rs.getInt(1));
				bean.setName(rs.getString(2));
				bean.setPrice(rs.getInt(3));
				bean.setDate(rs.getString(4));
				bean.setStock(rs.getInt(5));
				bean.setImage(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//Product Stock Reduce(���� -> ��� ����)
	public void reduceProduct(OrderBean order) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update tblProduct set stock = stock-? where no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, order.getQuantity());//�ֹ�����
			pstmt.setInt(2, order.getProductNo());//��ǰ��ȣ
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// admin mode /////////////////////////////////////////////////////
	
	// Product Insert
	
	// Product Update
	
	// Product Delete
}
