package dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import model.Reservation;

public class ReservationDao {
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

	public boolean insert(Reservation r) {
		String sql = "INSERT INTO 予約(reservation_number , reservation_people , reservation_date , member_id , member_name , seat_id , start_time , end_time) VALUES(?,?,?,?,?,?,?,?) ;";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {

			if (r.getReserveId() == null || r.getReserveId().isEmpty()) {
				String reservationNumber = generateReservationNumber(r.getReserveDate(), con);
				r.setReserveId(reservationNumber);
			}

			pstmt.setString(1, r.getReserveId());
			pstmt.setInt(2, r.getReservePeople());
			pstmt.setDate(3, Date.valueOf(r.getReserveDate()));
			pstmt.setString(4, r.getUserId());
			pstmt.setString(5, r.getUserName());
			pstmt.setInt(6, r.getSeatId());
			pstmt.setTimestamp(7, Timestamp.valueOf(r.getStartDateTime())); // start_time
			pstmt.setTimestamp(8, Timestamp.valueOf(r.getEndDateTime())); // end_time

			return pstmt.executeUpdate() == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	//----------------------------
	//予約番号の作成(RESyyyymmddxxx)
	//----------------------------

	public String generateReservationNumber(LocalDate date, Connection con) throws SQLException {
	    String dateStr = date.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
	    
	    // COUNTではなく、その日の予約番号の末尾3桁の「最大値」を取得する
	    // RIGHT(reservation_number, 3) で末尾3文字を取り出し、数値に変換して最大を探す
	    String maxSql = "SELECT MAX(CAST(RIGHT(reservation_number, 3) AS UNSIGNED)) FROM 予約 WHERE reservation_date = ? ;";
	    
	    try (PreparedStatement maxStmt = con.prepareStatement(maxSql)) {
	        maxStmt.setDate(1, Date.valueOf(date));
	        try (ResultSet rs = maxStmt.executeQuery()) {
	            int lastNumber = 0;
	            if (rs.next()) {
	                lastNumber = rs.getInt(1); // 最大値（例：31）を取得
	            }
	            
	            int nextNumber = lastNumber + 1; // 最大値に+1する（例：32）
	            String seqStr = String.format("%03d", nextNumber);
	            return "RES" + dateStr + seqStr;
	        }
	    }
	}

	public List<Reservation> ReservationHistoryByUser(String userId) {
		String sql = "SELECT * FROM 予約 WHERE member_id = ? ;";
		List<Reservation> list = new ArrayList<>();
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, userId);
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					LocalDate date = rs.getObject("reservation_date", LocalDate.class);
					LocalDateTime start = rs.getObject("start_time", LocalDateTime.class);
					LocalDateTime end = rs.getObject("end_time", LocalDateTime.class);
					Reservation r = new Reservation(
							rs.getString("reservation_number"),
							rs.getInt("reservation_people"),
							date,
							rs.getString("member_id"),
							rs.getInt("seat_id"),
							start,
							end,
							rs.getString("member_name"));

					list.add(r);

				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (list.isEmpty()) {
			return null;
		}
		return list;
	}

	public List<Reservation> ReservationHistoryAll() {
		List<Reservation> list = new ArrayList<>();

		String sql = "SELECT r.reservation_number, r.reservation_people, r.reservation_date, " +
				"r.start_time, r.end_time, r.seat_id, " +
				"m.member_id, m.member_name " +
				"FROM 予約 r " +
				"JOIN 会員 m ON r.member_id = m.member_id " +
				"ORDER BY r.reservation_date, r.start_time ;";

		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				LocalDate date = rs.getObject("reservation_date", LocalDate.class);
				LocalDateTime start = rs.getTimestamp("start_time").toLocalDateTime();

				LocalDateTime end = rs.getTimestamp("end_time").toLocalDateTime();

				Reservation r = new Reservation(
						rs.getString("reservation_number"),
						rs.getInt("reservation_people"),
						date,
						rs.getString("member_id"),
						rs.getInt("seat_id"),
						start,
						end,
						rs.getString("member_name"));
				list.add(r);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean delete(String reservationId) {
		String sql = "DELETE FROM 予約 WHERE reservation_number = ? ;";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, reservationId);
			return pstmt.executeUpdate() == 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean deleteAll(String userId) {
		String sql = "DELETE FROM 予約 WHERE member_id = ? ;";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, userId);
			pstmt.executeUpdate();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public java.util.Map<String, String> getMonthlyStatus(LocalDate startMonth, LocalDate endMonth) {
		java.util.Map<String, String> statusMap = new java.util.HashMap<>();

		String sql = "SELECT " +
				"  reservation_date, " +
				"  SUM(TIMESTAMPDIFF(MINUTE, start_time, end_time)) as daily_total, " +
				"  (SELECT COUNT(*) FROM 席 WHERE is_active = 1) * 480 as total_capacity " +
				"FROM 予約 " +
				"WHERE reservation_date BETWEEN ? AND ? " +
				"GROUP BY reservation_date";

		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {

			pstmt.setDate(1, Date.valueOf(startMonth));
			pstmt.setDate(2, Date.valueOf(endMonth));

			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {
					// 文字列ではなくDateとして取得し、フォーマットを yyyy-MM-dd に固定
					LocalDate localDate = rs.getDate("reservation_date").toLocalDate();
					String date = localDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

					int reservedMinutes = rs.getInt("daily_total");
					int totalCapacity = rs.getInt("total_capacity");

					double occupancyRate = (double) reservedMinutes / totalCapacity;

					if (occupancyRate >= 0.95) {
						statusMap.put(date, "is-full");
					} else if (occupancyRate >= 0.75) {
						statusMap.put(date, "is-warning");
					} else {
						statusMap.put(date, "is-available");
					}

				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statusMap;
	}

}
