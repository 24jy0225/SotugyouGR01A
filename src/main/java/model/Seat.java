package model;

public class Seat {
	private int seatId;
	private int seatNumber;
	private Store store;
	private boolean isActive;
	
	public Seat(int seatId , Store store , boolean isActive) {
		this.seatId = seatId;
		this.store = store;
		this.isActive = isActive;
	}
	
	public int getSeatId() {
		return seatId;
	}

	public void setSeatId(int seatId) {
		this.seatId = seatId;
	}

	public int getSeatNumber() {
		return seatNumber;
	}

	public void setSeatNumber(int seatNumber) {
		this.seatNumber = seatNumber;
	}
	
	public Store getStore() {
		return store;
	}

	public void setStore(Store store) {
		this.store = store;
	}

	public boolean getIsActive() {
		return isActive;
	}

	public void setIsActive(boolean isActive) {
		this.isActive = isActive;
	}
}
