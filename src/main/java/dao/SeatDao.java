package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Seat;
import model.Store;

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
	
	public boolean insert(int seatCount) {
		String sql = "INSERT INTO 席 (seat_number, store_number , is_active ) VALUES (?, 1, 0)";
		try (Connection con = createConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, seatCount);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public List<Seat> findAll() {
		List<Seat> list = new ArrayList<>();

		String sql = "SELECT s.seat_id, s.is_active, s.seat_number, s.store_number, " +
				"t.store_name, t.store_address, t.store_tel " + // 店舗テーブルのカラム
				"FROM 席 s " +
				"JOIN 店舗 t ON s.store_number = t.store_number";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);) {
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Store store = new Store(rs.getInt("store_number"), rs.getString("store_name"),
							rs.getString("store_address"), rs.getString("store_tel"));
					Seat s = new Seat(
							rs.getInt("seat_id"),
							store,
							rs.getBoolean("is_active"));
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

		// こちらも JOIN を使って店舗詳細を取得
		String sql = "SELECT s.seat_id, s.is_active, s.seat_number, s.store_number, " +
				"t.store_name, t.store_address, t.store_tel " +
				"FROM 席 s " +
				"JOIN 店舗 t ON s.store_number = t.store_number " +
				"WHERE s.is_active = 1 AND s.store_number = ?";

		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, storeNumber);

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					Store store = new Store(
							rs.getInt("store_number"),
							rs.getString("store_name"),
							rs.getString("store_address"),
							rs.getString("store_tel"));

					Seat s = new Seat(
							rs.getInt("seat_id"),
							store,
							rs.getBoolean("is_active"));
					s.setSeatNumber(rs.getInt("seat_number"));

					list.add(s);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean editCoupon(int seatId, boolean seatActive) {
		String sql = "";
		if (seatActive) {
			sql = "UPDATE 席 SET is_active = 0 WHERE seat_id = ? ;";
		} else {
			sql = "UPDATE 席 SET is_active = 1 WHERE seat_id = ? ;";
		}
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setInt(1, seatId);

			return pstmt.executeUpdate() > 0; // 更新できたら true
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean delete(int seatId) {
		String sql = "DELETE FROM 席 WHERE coupon_number = ?;";

		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				) {
			pstmt.setInt(1, seatId);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

}
