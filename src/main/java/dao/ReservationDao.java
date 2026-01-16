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
		String sql = "INSERT INTO 予約(reservation_number , reservation_people , reservation_date , member_id , member_name , seat_id , start_time , end_time) VALUES(?,?,?,?,?,?,?,?)";
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

		String countSql = "SELECT COUNT(*) FROM 予約 WHERE reservation_date = ?";
		try (PreparedStatement countStmt = con.prepareStatement(countSql)) {
			countStmt.setDate(1, Date.valueOf(date));
			try (ResultSet rs = countStmt.executeQuery()) {
				int count = 0;
				if (rs.next()) {
					count = rs.getInt(1);
				}
				int sequence = count + 1;
				String seqStr = String.format("%03d", sequence);
				return "RES" + dateStr + seqStr;
			}
		}
	}

	public List<Reservation> ReservationHistoryByUser(String userId) {
		String sql = "SELECT * FROM 予約 WHERE member_id = ?";
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

	public  List<Reservation> ReservationHistoryAll() {
		List<Reservation> list = new ArrayList<>();

		String sql = "SELECT r.reservation_number, r.reservation_people, r.reservation_date, " +
				"r.start_time, r.end_time, r.seat_id, " +
				"m.member_id, m.member_name " +
				"FROM 予約 r " +
				"JOIN 会員 m ON r.member_id = m.member_id " +
				"ORDER BY r.reservation_date, r.start_time";

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
		String sql = "DELETE FROM 予約 WHERE reservation_number = ?";
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

}
