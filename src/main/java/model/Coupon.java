package model;

import java.util.Date;

public class Coupon {
	private int couponId;
	private String couponName;
	private String couponDetail;
	private Date startDate;
	private Date endDate;
	private int isActive;

	public Coupon(int couponId, String couponName, String couponDetail, Date startDate, Date endDate, int isActive) {
		this.couponId = couponId;
		this.couponName = couponName;
		this.couponDetail = couponDetail;
		this.startDate = startDate;
		this.endDate = endDate;
		this.isActive = isActive;
	}

	public int getCouponId() {
		return couponId;
	}

	public void setCouponId(int couponId) {
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

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	public int getIsActive() {
		return isActive;
	}
	
	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
}
