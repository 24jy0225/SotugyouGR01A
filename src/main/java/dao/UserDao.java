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

	public boolean createUser(User user, String token) {
		Timestamp ts = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMdd");
		String registTime = sdf.format(ts);
		int random = (int) (Math.random() * 1000);
		String randomNo = String.format("%03d", random);
		String sql = "INSERT INTO 会員(member_id,member_name,member_tel,registration_time,member_email_address,member_password , url_token , token_expire , authentication) VALUES (?,?,?,?,?,?,?,DATE_ADD(NOW(),INTERVAL 1 DAY),0) ";

		try (Connection con = createConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, "MEM" + registTime + randomNo);
			pstmt.setString(2, user.getName());
			pstmt.setString(3, user.getUserTel());
			pstmt.setDate(4, new Date(System.currentTimeMillis()));
			pstmt.setString(5, user.getUserEmail());
			pstmt.setString(6, user.getPassword());
			pstmt.setString(7, token);
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
		String sql = "SELECT * FROM 会員 WHERE member_email_address = ? AND member_password = ? AND authentication = 1";
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
				user.setUserTel(rs.getString("member_tel"));
				user.setRegistDate(rs.getDate("registration_time"));

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

	public List<User> findAll() {
		String sql = """
				   SELECT *,
				     (SELECT COUNT(*) FROM 予約 WHERE 予約.member_id = 会員.member_id AND 予約.reservation_date >= CURDATE()) AS res_count,
				     (SELECT COUNT(*) FROM クーポン利用 WHERE クーポン利用.member_id = 会員.member_id) AS coup_count
				   FROM 会員
				""";
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
				user.setUserTel(rs.getString("member_tel"));
				user.setRegistDate(rs.getDate("registration_time"));
				user.setReserveCount(rs.getInt("res_count"));
				user.setCouponCount(rs.getInt("coup_count"));
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

	public User findById(String userId) {
		String sql = """
				   SELECT *,
				     (SELECT COUNT(*) FROM 予約 WHERE 予約.member_id = 会員.member_id AND 予約.reservation_date >= CURDATE()) AS res_count,
				     (SELECT COUNT(*) FROM クーポン利用 WHERE クーポン利用.member_id = 会員.member_id) AS coup_count
				   FROM 会員 WHERE member_id = ?
				""";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, userId);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getString("member_id"));
				user.setUserEmail(rs.getString("member_email_address"));
				user.setPassword(rs.getString("member_password"));
				user.setName(rs.getString("member_name"));
				user.setUserTel(rs.getString("member_tel"));
				user.setRegistDate(rs.getDate("registration_time"));
				user.setReserveCount(rs.getInt("res_count"));
				user.setCouponCount(rs.getInt("coup_count"));
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

	public boolean delete(String userId) {
		String sql = "DELETE FROM 会員 WHERE member_id = ? ;";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, userId);
			return pstmt.executeUpdate() == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean authenticate(String token) {
		String sql = "UPDATE 会員 SET authentication = 1, url_token = NULL "
				+ "WHERE url_token = ? AND token_expire > NOW() AND authentication = 0";

		try (Connection con = createConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, token);

			int count = pstmt.executeUpdate();
			// 1件更新できれば認証成功
			return count == 1;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public boolean reissueToken(String email , String newToken) {
		String sql = "UPDATE 会員 SET url_token = ?, token_expire = DATE_ADD(NOW(), INTERVAL 1 DAY) "
	               + "WHERE member_email_address = ? AND authenticate = 0";

	    try (Connection con = createConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, newToken);
			pstmt.setString(2, email);
	        
	        int count = pstmt.executeUpdate();
	        // 1件更新できれば成功（メアドが存在し、かつ仮登録だった）
	        return count == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public boolean setPasswordResetToken(String email, String token) {
	    String sql = "UPDATE 会員 SET url_token = ?, token_expire = DATE_ADD(NOW(), INTERVAL 30 MINUTE) "
	               + "WHERE member_email_address = ?";
	    // パスワード再設定はセキュリティ上、期限を短め（30分など）にするのが一般的です。

	    try (Connection con = createConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
	        pstmt.setString(1, token);
	        pstmt.setString(2, email);
	        return pstmt.executeUpdate() == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
	public boolean updatePassword(String token, String newPassword) {
	    String sql = "UPDATE 会員 SET member_password = ?, url_token = NULL "
	               + "WHERE url_token = ? AND token_expire > NOW()";

	    try (Connection con = createConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
	        pstmt.setString(1, newPassword);
	        pstmt.setString(2, token);
	        return pstmt.executeUpdate() == 1;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

}
