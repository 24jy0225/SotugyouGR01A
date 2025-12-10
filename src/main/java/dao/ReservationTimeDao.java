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
import java.util.ArrayList;
import java.util.List;

public class ReservationTimeDao {
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
	
	public List<LocalDateTime> findAvailableSlots (LocalDate date , int seatId , int course ){
		List<LocalDateTime> list = new ArrayList<>();
		String sql = """
				WITH RECURSIVE candi AS (
					SELECT TIMESTAMP(? , '20:00:00') AS start_at
					UNION ALL
					SELECT DATE_ADD(start_at,INTERVAL 30 MINUTE)
					FROM candi
					WHERE start_at < TIMESTAMP(? , '04:00:00')
					)
				SELECT start_at
				FROM candi
				WHERE NOT EXISTS(
					SELECT 1
					FROM 予約 r
					WHERE r.seat_id = ?
						AND
							r.start_time < DATE_ADD(start_at, INTERVAL ? MINUTE)
						AND r.end_time > start_at
					)
					AND DATE_ADD(start_at,INTERVAL ? MINUTE) <= TIMESTAMP(?,'04:00:00');
				""";
		try (Connection con = createConnection();
			 PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setDate(1, Date.valueOf(date));
			pstmt.setDate(2, Date.valueOf(date.plusDays(1)));
			pstmt.setInt(3, seatId);
			pstmt.setInt(4, course);
			pstmt.setInt(5, course);
			pstmt.setDate(6, Date.valueOf(date.plusDays(1)));
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					Timestamp ts = rs.getTimestamp("start_at");
					list.add(ts.toLocalDateTime());
				}
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}catch(Exception e) {
			e.printStackTrace();
		}return list;
		
	}
	
}
