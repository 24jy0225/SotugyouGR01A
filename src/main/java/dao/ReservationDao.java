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

	public Reservation cancel(String reservationId) {

		Connection con = null;
		Reservation cancelledReservation = null;

		String selectSql = "SELECT * FROM 予約 WHERE reservation_number = ? ;";

		String copySql = "INSERT INTO キャンセル履歴 (reservation_number, reservation_people, reservation_date, member_id, member_name, seat_id, start_time, end_time, cancel_date) "
				+ "SELECT reservation_number, reservation_people, reservation_date, member_id, member_name, seat_id, start_time, end_time, NOW() "
				+ "FROM 予約 WHERE reservation_number = ? ;";

		String deleteSql = "DELETE FROM 予約 WHERE reservation_number = ? ;";

		try {
			con = createConnection();
			con.setAutoCommit(false); // トランザクション開始

			try (PreparedStatement selectPstmt = con.prepareStatement(selectSql)) {
				selectPstmt.setString(1, reservationId);
				try (ResultSet rs = selectPstmt.executeQuery()) {
					if (rs.next()) {
						LocalDate date = rs.getObject("reservation_date", LocalDate.class);
						LocalDateTime start = rs.getTimestamp("start_time").toLocalDateTime();
						LocalDateTime end = rs.getTimestamp("end_time").toLocalDateTime();

						cancelledReservation = new Reservation(
								rs.getString("reservation_number"),
								rs.getInt("reservation_people"),
								date,
								rs.getString("member_id"),
								rs.getInt("seat_id"),
								start,
								end,
								rs.getString("member_name"));
						cancelledReservation.setCancelDate(LocalDate.now());
					} else {
						con.rollback();
						return null;
					}
				}
			}

			try (PreparedStatement copyPstmt = con.prepareStatement(copySql)) {
				copyPstmt.setString(1, reservationId);
				copyPstmt.executeUpdate();
			}

			try (PreparedStatement deletePstmt = con.prepareStatement(deleteSql)) {
				deletePstmt.setString(1, reservationId);
				int result = deletePstmt.executeUpdate();

				if (result == 1) {
					con.commit();
					return cancelledReservation;
				} else {
					con.rollback();
					return null;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();

			if (con != null) {
				try {
					con.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			return null;
		} finally {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
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

		// UNIONを使って、予約テーブルとキャンセル履歴の両方から最大値を取得する
		String maxSql = "SELECT MAX(seq) FROM (" +
				"  SELECT CAST(RIGHT(reservation_number, 3) AS UNSIGNED) AS seq FROM 予約 WHERE reservation_date = ? " +
				"  UNION ALL " +
				"  SELECT CAST(RIGHT(reservation_number, 3) AS UNSIGNED) AS seq FROM キャンセル履歴 WHERE reservation_date = ?"
				+
				") AS combined";

		try (PreparedStatement maxStmt = con.prepareStatement(maxSql)) {
			maxStmt.setDate(1, Date.valueOf(date));
			maxStmt.setDate(2, Date.valueOf(date)); // 履歴側にも日付をセット

			try (ResultSet rs = maxStmt.executeQuery()) {
				int lastNumber = 0;
				if (rs.next()) {
					lastNumber = rs.getInt(1);
				}

				int nextNumber = lastNumber + 1;
				String seqStr = String.format("%03d", nextNumber);
				return "RES" + dateStr + seqStr;
			}
		}
	}

	public List<Reservation> ReservationHistoryByUser(String userId) {
		// UNION ALL を使って2つのテーブルを結合する
		// 予約テーブルには cancel_date がないので、NULLをダミー列として追加します
		String sql = "SELECT reservation_number, reservation_people, reservation_date, member_id, seat_id, start_time, end_time, member_name, NULL AS cancel_date "
				+
				"FROM 予約 WHERE member_id = ? " +
				"UNION ALL " +
				"SELECT reservation_number, reservation_people, reservation_date, member_id, seat_id, start_time, end_time, member_name, cancel_date "
				+
				"FROM キャンセル履歴 WHERE member_id = ? " +
				"ORDER BY reservation_date DESC, start_time DESC;"; // 日付の新しい順に並び替え

		List<Reservation> list = new ArrayList<>();

		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {

			// プレースホルダが2つ（予約用とキャンセル履歴用）あるので、両方にセット
			pstmt.setString(1, userId);
			pstmt.setString(2, userId);

			try (ResultSet rs = pstmt.executeQuery()) {
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

					// cancel_date列を取得し、存在すればセットする
					Date cancelSqlDate = rs.getDate("cancel_date");
					if (cancelSqlDate != null) {
						r.setCancelDate(cancelSqlDate.toLocalDate());
					}

					list.add(r);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		// リストが空でも null ではなく空のリストを返すほうが、呼び出し元で for文が回せるので一般的ですが、
		// 既存のコードの仕様に合わせて empty チェックを行っています。
		return list.isEmpty() ? null : list;
	}

	public List<Reservation> ReservationHistoryAll() {
		List<Reservation> list = new ArrayList<>();

		// 1. 予約テーブル（現在有効な予約）を取得。cancel_date は NULL として定義。
		// 2. キャンセル履歴テーブルを取得。
		// 3. 全体を日付順（降順）で結合。
		String sql = "SELECT r.reservation_number, r.reservation_people, r.reservation_date, " +
				"r.start_time, r.end_time, r.seat_id, r.member_id, r.member_name, NULL AS cancel_date " +
				"FROM 予約 r " +
				"UNION ALL " +
				"SELECT c.reservation_number, c.reservation_people, c.reservation_date, " +
				"c.start_time, c.end_time, c.seat_id, c.member_id, c.member_name, c.cancel_date " +
				"FROM キャンセル履歴 c " +
				"ORDER BY reservation_date DESC, start_time DESC;";

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

				// キャンセル日が入っている場合はセットする
				Date cancelSqlDate = rs.getDate("cancel_date");
				if (cancelSqlDate != null) {
					r.setCancelDate(cancelSqlDate.toLocalDate());
				}

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
	
	public boolean cancelDeleteAll(String userId) {
		String sql = "DELETE FROM キャンセル履歴 WHERE member_id = ? ;";
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

	public Reservation findByRid(String reserveId) {
		String sql = "SELECT * FROM 予約 WHERE reservation_number = ? ;";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, reserveId);
			try (ResultSet rs = pstmt.executeQuery()) {
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
					return r;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
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
