package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import model.Coupon;

public class CouponDao {
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

	public boolean createCoupon(Coupon coupon) {
		String todayPrefix = "COU" + LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

		String selectSql = "SELECT MAX(coupon_number) FROM クーポン WHERE coupon_number LIKE ?";
		String insertSql = "INSERT INTO クーポン (coupon_number, coupon_name, coupon_detail, coupon_start_date, coupon_end_date, valid_flag) VALUES (?, ?, ?, ?, ?, ?)";

		// 全員に配布するSQL（会員テーブルの全員分をクーポン利用テーブルに入れる）
		String distributeSql = "INSERT INTO クーポン利用 (member_id, coupon_number, coupon_usage) SELECT member_id, ?, 1 FROM 会員";

		try (Connection con = createConnection()) {
			// オートコミットをオフにする（トランザクション開始）
			con.setAutoCommit(false);

			try (PreparedStatement psSelect = con.prepareStatement(selectSql);
					PreparedStatement psInsert = con.prepareStatement(insertSql);
					PreparedStatement psDistribute = con.prepareStatement(distributeSql)) {

				// --- 1. IDの採番ロジック (変更なし) ---
				psSelect.setString(1, todayPrefix + "%");
				String newId;
				try (ResultSet rs = psSelect.executeQuery()) {
					int nextSeq = 1;
					if (rs.next()) {
						String maxId = rs.getString(1);
						if (maxId != null) {
							nextSeq = Integer.parseInt(maxId.substring(maxId.length() - 2)) + 1;
						}
					}
					newId = String.format("%s%02d", todayPrefix, nextSeq);
				}

				// --- 2. クーポン本体のINSERT実行 ---
				psInsert.setString(1, newId);
				psInsert.setString(2, coupon.getCouponName());
				psInsert.setString(3, coupon.getCouponDetail());
				psInsert.setDate(4, java.sql.Date.valueOf(coupon.getStartDate()));
				psInsert.setDate(5, java.sql.Date.valueOf(coupon.getEndDate()));
				psInsert.setBoolean(6, true);
				psInsert.executeUpdate();

				// 全員に配布実行 
				psDistribute.setString(1, newId);
				psDistribute.executeUpdate();

				// ここまですべて成功したら確定 ---
				con.commit();
				return true;

			} catch (SQLException e) {
				//途中でエラーが起きたらこのクーポン作成をなかったことにする
				con.rollback();
				e.printStackTrace();
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}
}
