package member;

//zipcode 의 주소 모두 sql 문으로 작성하여  MemberMgr.java  insertZip() 통해 삽입


import java.io.FileReader;
import java.util.Vector;

public class ZipCodeReader {
	String cc ="";
	Vector <String> sql = new Vector <String>();
	
	public ZipCodeReader() {
		FileReader fin = null;
		try {
			fin = new FileReader("C:\\Jsp\\myapp\\WebContent\\member\\zipcode.txt");
			int c;
			while((c=fin.read()) !=-1) {
				cc = cc+(char)c;
				if((char)c==';') {
					sql.add(cc);
					cc = "";
					//System.out.println(sql.lastElement());
				}
			}
			fin.close();
			System.out.println("sql size : " + sql.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new ZipCodeReader();
	}

}
