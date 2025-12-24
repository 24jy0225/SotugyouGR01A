package model;

public class CouponUsage {
	private String userId;
	private String couponId;
	private boolean couponUsage;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCouponId() {
		return couponId;
	}
	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}
	public boolean isCouponUsage() {
		return couponUsage;
	}
	public void setCouponUsage(boolean couponUsage) {
		this.couponUsage = couponUsage;
	}
}
