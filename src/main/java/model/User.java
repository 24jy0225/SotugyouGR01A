package model;

import java.sql.Date;
import java.time.LocalDateTime;

public class User {
	private String name;
	private String userId;
	private String userTel;
	private String userEmail;
	private Date registDate;
	private String password;
	private int reserveCount;
	private int couponCount;
	private boolean authenticate;
	private String urlToken;
	private LocalDateTime tokenExpire;
	
	public User() {
		
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserTel() {
		return userTel;
	}

	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public Date getRegistDate() {
		return registDate;
	}

	public void setRegistDate(Date registDate) {
		this.registDate = registDate;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	public int getReserveCount() {
		return reserveCount;
	}


	public void setReserveCount(int reserveCount) {
		this.reserveCount = reserveCount;
	}


	public int getCouponCount() {
		return couponCount;
	}


	public void setCouponCount(int couponCount) {
		this.couponCount = couponCount;
	}


	public boolean isAuthenticate() {
		return authenticate;
	}


	public void setAuthenticate(boolean authenticate) {
		this.authenticate = authenticate;
	}


	public String getUrlToken() {
		return urlToken;
	}


	public void setUrlToken(String urlToken) {
		this.urlToken = urlToken;
	}


	public LocalDateTime getTokenExpire() {
		return tokenExpire;
	}


	public void setTokenExpire(LocalDateTime tokenExpire) {
		this.tokenExpire = tokenExpire;
	}

}
