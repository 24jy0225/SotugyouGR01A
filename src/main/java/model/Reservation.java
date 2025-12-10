package model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Reservation {
	private String reserveId;
	private int reservePeople;
	private LocalDate reserveDate;
	private String userId;
	private int seatId;
	private LocalDateTime startDateTime;
	private LocalDateTime endDateTime;
	

	public String getReserveId() {
		return reserveId;
	}

	public void setReserveId(String reserveId) {
		this.reserveId = reserveId;
	}

	public int getReservePeople() {
		return reservePeople;
	}

	public void setReservePeople(int reservePeople) {
		this.reservePeople = reservePeople;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public LocalDate getReserveDate() {
		return reserveDate;
	}

	public void setReserveDate(LocalDate reserveDate) {
		this.reserveDate = reserveDate;
	}

	public int getSeatId() {
		return seatId;
	}

	public void setSeatId(int seatId) {
		this.seatId = seatId;
	}

	public LocalDateTime getStartDateTime() {
		return startDateTime;
	}

	public void setStartDateTime(LocalDateTime startDateTime) {
		this.startDateTime = startDateTime;
	}

	public LocalDateTime getEndDateTime() {
		return endDateTime;
	}

	public void setEndDateTime(LocalDateTime endDateTime) {
		this.endDateTime = endDateTime;
	}

	public Reservation(int reservePeople, LocalDate reserveDate, String userId, int seatId, LocalDateTime startDateTime, LocalDateTime endDateTime ) {
		this.reservePeople = reservePeople;
		this.reserveDate = reserveDate;
		this.userId = userId;
		this.seatId = seatId;
		this.startDateTime = startDateTime;
		this.endDateTime = endDateTime;
	}
	public Reservation(String reserveId, int reservePeople, LocalDate reserveDate, String userId, int seatId, LocalDateTime startDateTime, LocalDateTime endDateTime ) {
		this.reserveId = reserveId;
		this.reservePeople = reservePeople;
		this.reserveDate = reserveDate;
		this.userId = userId;
		this.seatId = seatId;
		this.startDateTime = startDateTime;
		this.endDateTime = endDateTime;
	}

}
