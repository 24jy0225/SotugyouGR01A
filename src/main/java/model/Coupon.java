package model;

import java.time.LocalDate;

public class Coupon {
	private String couponId;
	private String couponName;
	private String couponDetail;
	private LocalDate startDate;
	private LocalDate endDate;
	private boolean isActive;

	public Coupon(String couponId, String couponName, String couponDetail, LocalDate startDate, LocalDate endDate, boolean isActive) {
		this.couponId = couponId;
		this.couponName = couponName;
		this.couponDetail = couponDetail;
		this.startDate = startDate;
		this.endDate = endDate;
		this.isActive = isActive;
	}
	public Coupon() {}

	public String getCouponId() {
		return couponId;
	}

	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}

	public String getCouponName() {
		return couponName;
	}

	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}

	public String getCouponDetail() {
		return couponDetail;
	}

	public void setCouponDetail(String couponDetail) {
		this.couponDetail = couponDetail;
	}

	public LocalDate getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}

	public LocalDate getEndDate() {
		return endDate;
	}

	public void setEndDate(LocalDate endDate) {
		this.endDate = endDate;
	}
	
	public boolean getIsActive() {
		return isActive;
	}
	
	public void setIsActive(boolean isActive) {
		this.isActive = isActive;
	}
}
