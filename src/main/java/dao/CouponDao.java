package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import model.Coupon;
import model.CouponUsage;

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
	
	public List<Coupon> findAll() {
		List<Coupon> list = new ArrayList<>();
		String sql = "SELECT * FROM クーポン " ;
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				) {
			try(ResultSet rs = pstmt.executeQuery()){
				while (rs.next()) {
					Coupon coupon = new Coupon();
	                coupon.setCouponId(rs.getString("coupon_number"));
	                coupon.setCouponName(rs.getString("coupon_name"));
	                coupon.setCouponDetail(rs.getString("coupon_detail"));
	                coupon.setEndDate(rs.getDate("coupon_end_date").toLocalDate());
	                coupon.setStartDate(rs.getDate("coupon_start_date").toLocalDate());	
	                coupon.setIsActive(rs.getBoolean("valid_flag"));
	                list.add(coupon);
				}
				
				}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
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
	
	public List<CouponUsage> findById(String userId) {
		List<CouponUsage> list = new ArrayList<>();
		String sql = "SELECT * FROM クーポン利用 " +
                "JOIN クーポン ON クーポン利用.coupon_number = クーポン.coupon_number " +
                "WHERE クーポン利用.member_id = ? AND クーポン利用.coupon_usage = 1";
		try (Connection con = createConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				) {
			pstmt.setString(1,userId);
			try(ResultSet rs = pstmt.executeQuery()){
				while (rs.next()) {
					Coupon coupon = new Coupon();
	                coupon.setCouponId(rs.getString("coupon_number"));
	                coupon.setCouponName(rs.getString("coupon_name"));
	                coupon.setCouponDetail(rs.getString("coupon_detail"));
	                coupon.setEndDate(rs.getDate("coupon_end_date").toLocalDate());
	                coupon.setStartDate(rs.getDate("coupon_start_date").toLocalDate());
	                coupon.setIsActive(rs.getBoolean("valid_flag"));
	                CouponUsage usage = new CouponUsage(
	                        rs.getString("member_id"),
	                        coupon, // ここで合体！
	                        rs.getBoolean("coupon_usage")
	                    );
	                    
	                    list.add(usage);
				}
				
				}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public boolean useCoupon(String userId , String couponId) {
		String sql = "UPDATE クーポン利用 SET coupon_usage = 0 WHERE member_id = ? AND coupon_number = ?";
		try (Connection con = createConnection();
		         PreparedStatement pstmt = con.prepareStatement(sql)) {
		        
		        pstmt.setString(1, userId);
		        pstmt.setString(2, couponId);
		        
		        return pstmt.executeUpdate() > 0; // 更新できたら true
		    } catch (Exception e) {
		        e.printStackTrace();
		        return false;
		    }
	}
	
	public boolean editCoupon(String couponNumber , boolean couponActive) {
		String sql = "";
		if(couponActive) {
			sql = "UPDATE クーポン SET valid_flag = 0 WHERE coupon_number = ?";			
		}else {
			sql = "UPDATE クーポン SET valid_flag = 1 WHERE coupon_number = ?";
		}
		try (Connection con = createConnection();
		         PreparedStatement pstmt = con.prepareStatement(sql)) {
		        
		        pstmt.setString(1, couponNumber);
		        
		        return pstmt.executeUpdate() > 0; // 更新できたら true
		    } catch (Exception e) {
		        e.printStackTrace();
		        return false;
		    }
	}
}
