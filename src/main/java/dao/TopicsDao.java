package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TopicsDao {
	private Connection createConnection() throws Exception {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://10.64.144.5:3306/24jy0225";
			String user = "24jy0225";
			String password = "24jy0225";
			return DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new Exception("DB接続処理に失敗しました");
		}
	}

	// 写真テーブルへインサートし、自動採番されたIDを返す
	public int insertPhoto(String category, String fileName) {
		// カラム名は update メソッドに合わせました。適宜DBに合わせてください
		String sql = "INSERT INTO 写真 (photo_category, photo_file_name) VALUES (?, ?)";
		int generatedId = -1;

		try (Connection conn = createConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			pstmt.setString(1, category);
			pstmt.setString(2, fileName);
			pstmt.executeUpdate();

			// 生成された写真IDを取得
			try (ResultSet rs = pstmt.getGeneratedKeys()) {
				if (rs.next()) {
					generatedId = rs.getInt(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return generatedId;
	}
	
	public void insertTopic(int photoId, String title, String content) {
	    String sql = "INSERT INTO お知らせ (写真ID, タイトル, 内容) VALUES (?, ?, ?)";
	    try (Connection con = createConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        ps.setInt(1, photoId);
	        ps.setString(2, title);
	        ps.setString(3, content);
	        ps.executeUpdate();
	    } catch (Exception e) { e.printStackTrace(); }
	}
	

	public void update(String category, String fileName) {

		String sql = """
				    UPDATE 写真
				    SET photo_file_name = ?
				    WHERE photo_category = ?
				""";

		try (Connection con = createConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, fileName);
			ps.setString(2, category);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
