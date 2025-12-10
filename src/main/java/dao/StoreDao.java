package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Store;

public class StoreDao {
	
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
	
	
	public List<Store> findAll() {
		List<Store> list = new ArrayList<>();

		String sql = "SELECT store_number , store_name , store_address , store_tel FROM 店舗 ;";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				) {
			try(ResultSet rs = pstmt.executeQuery()){
				while (rs.next()) {
					list.add(new Store(
							rs.getInt("store_number"),
							rs.getString("store_name"),
							rs.getString("store_address"),
							rs.getString("store_tel")
							));
				}
				
				}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
