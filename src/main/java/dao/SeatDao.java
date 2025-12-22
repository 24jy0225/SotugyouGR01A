package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Seat;

public class SeatDao {
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
	
	public List<Seat> findAll() {
		List<Seat> list = new ArrayList<>();

		String sql = "SELECT seat_id , is_active , seat_number , store_number FROM 席 ";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				) {
			try(ResultSet rs = pstmt.executeQuery()){
				while (rs.next()) {
					Seat s = new Seat(
							rs.getInt("seat_id"),
							rs.getInt("store_number"),
							rs.getInt("is_active")
							);
					s.setSeatNumber(rs.getInt("seat_number"));
					
					list.add(s);
				}
				
				}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<Seat> findByStoreNumber(int storeNumber) {
		List<Seat> list = new ArrayList<>();

		String sql = "SELECT seat_id , is_active , store_number FROM 席 WHERE is_active = 1 and store_number = ?";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				) {
			pstmt.setInt(1, storeNumber);
			try(ResultSet rs = pstmt.executeQuery()){
				while (rs.next()) {
					Seat s = new Seat(
							rs.getInt("seat_id"),
							rs.getInt("store_number"),
							rs.getInt("is_active")
							);
					
					list.add(s);
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
