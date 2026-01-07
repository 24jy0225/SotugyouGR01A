package model;

public class CouponUsage {
	private String userId;
	private Coupon coupon;
	private boolean couponUsage;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Coupon getCoupon() {
		return coupon;
	}
	public void setCouponId(Coupon coupon) {
		this.coupon = coupon;
	}
	public boolean isCouponUsage() {
		return couponUsage;
	}
	public void setCouponUsage(boolean couponUsage) {
		this.couponUsage = couponUsage;
	}
	
	public CouponUsage(String userId, Coupon coupon, boolean couponUsage) {
		this.userId = userId;
		this.coupon = coupon;
		this.couponUsage = couponUsage;
	}
}
