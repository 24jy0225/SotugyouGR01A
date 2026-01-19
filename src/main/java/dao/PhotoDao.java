package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PhotoDao {
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

	public String findCurrentFileName(String category) {
		String sql = "SELECT photo_file_name FROM 写真 WHERE photo_category = ? ;";
		try (Connection con = createConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, category);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				return rs.getString("photo_file_name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
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
