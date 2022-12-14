package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.User;

public class UserDAO {
	private String driver = "oracle.jdbc.OracleDriver";
	private String url = "jdbc:oracle:thin:@//localhost:1521/xe";
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//회원 가입 
	public boolean insertUser(User user) {
		String insert = "insert into mab_users values(?,?,?,?,?, sysdate)";
		boolean result = false;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(insert);
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPwd());
			pstmt.setString(3, user.getNickname());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getBirthday());
			pstmt.executeUpdate();
			con.commit();
			result = true;
			System.out.println("insertUser() insert done.");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		System.out.println("insertUser() end.");
		return result;
	}
	
	//입력된 id로 id 검색 (id 중복검사용)
	public String getId(String id) {
		String select = "select id from mab_users where id = ?";
		String selectedId = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) selectedId = rs.getString(1);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e){}
		}
		return selectedId;
	}
	
	//id로 암호 검색
	public String getPwd(String id) {
		String select = "select pwd from mab_users where id = ?";
		String pwd = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pwd = rs.getString(1);
			}
			System.out.println("getPwd() select done");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		System.out.println("getPwd() end");
		return pwd;
	}
}
