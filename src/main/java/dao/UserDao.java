package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import model.User;

public class UserDao {
	private Connection createConnection() throws Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://10.64.144.5:3306/24jy0225";
			String user = "24jy0225";
			String password = "24jy0225";
			Connection con = DriverManager.getConnection(url, user, password);
			return con;
		} catch (SQLException e) {
			e.printStackTrace();
			throw new Exception("DB接続処理に失敗しました");
		}
	}

	public boolean createUser(User user) {
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMdd");
		String registTime = sdf.format(ts);
		int random = (int) (Math.random() * 1000);
		String randomNo = String.format("%03d", random);
		String sql = "INSERT INTO 会員(member_id,member_name,member_tel,registration_time,member_email_address,member_password) VALUES (?,?,?,?,?,?) ";

		try (Connection con = createConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, "MEM" + registTime + randomNo);
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getUserTel());
			pstmt.setDate(4, new Date(System.currentTimeMillis()));
			pstmt.setString(5, user.getUserEmail());
			pstmt.setString(6, user.getPassword());
			int result = pstmt.executeUpdate();
			return result == 1;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public User Login(String email, String password) {
		String sql = "SELECT member_id , member_email_address , member_password , member_name FROM 会員 WHERE member_email_address = ? AND member_password = ? ";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setString(1, email);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getString("member_id"));
				user.setUserEmail(rs.getString("member_email_address"));
				user.setPassword(rs.getString("member_password"));
				user.setName(rs.getString("member_name"));
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}
	public User adminLogin(String adminId, String adminPassword) {
		String sql = "SELECT member_id , member_email_address , member_password , member_name FROM 会員 WHERE member_id = ? AND member_password = ? ";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, adminId);
			pstmt.setString(2, adminPassword);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getString("member_id"));
				user.setUserEmail(rs.getString("member_email_address"));
				user.setPassword(rs.getString("member_password"));
				user.setName(rs.getString("member_name"));
				return user;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return null;
	}
	
	public List<User> getUser(){
		String sql = "SELECT member_id , member_email_address , member_password , member_name FROM 会員 ";
		List<User> list = new ArrayList<>();
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getString("member_id"));
				user.setUserEmail(rs.getString("member_email_address"));
				user.setPassword(rs.getString("member_password"));
				user.setName(rs.getString("member_name"));
				list.add(user);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	} 

	
	

}
