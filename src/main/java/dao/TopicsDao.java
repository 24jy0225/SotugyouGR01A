package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Topics;

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
	public int insertPhoto(String fileName) {
		String sql = "INSERT INTO 写真 (photo_category, photo_file_name) VALUES ('topics', ?)";
		int generatedId = -1;

		try (Connection conn = createConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

			pstmt.setString(1, fileName);
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
		String sql = "INSERT INTO お知らせ (photo_id, topics_title , topics_content) VALUES (?, ?, ?)";
		try (Connection con = createConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, photoId);
			ps.setString(2, title);
			ps.setString(3, content);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	
	public int getPhotoIdByTopicsId(int topicsId) {
	    int photoId = -1;
	    String sql = "SELECT photo_id FROM お知らせ WHERE topics_id = ?";

	    try (Connection con = createConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {
	        
	        ps.setInt(1, topicsId);
	        
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                photoId = rs.getInt("photo_id");
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return photoId;
	}

	public List<Topics> findAll() {
		List<Topics> list = new ArrayList<>();
		String sql = "SELECT * FROM お知らせ ";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Topics topics = new Topics(
							rs.getInt("topics_id"),
							rs.getInt("photo_id"),
							rs.getString("topics_title"),
							rs.getString("topics_content"));

					list.add(topics);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean delete(int topicsId) {
		String sql = "DELETE FROM お知らせ WHERE topics_id = ?";
		try (Connection con = createConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, topicsId);
			ps.executeUpdate();
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	

}
