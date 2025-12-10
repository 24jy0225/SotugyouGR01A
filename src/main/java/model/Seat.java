package model;

public class Seat {
	private int seatId;
	private int seatNumber;
	private int storeNumber;
	private int isActive;
	
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
	
	public int getStoreNumber() {
		return storeNumber;
	}

	public void setStoreNumber(int storeNumber) {
		this.storeNumber = storeNumber;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}

	public Seat(int seatId , int storeNumber , int isActive) {
		this.seatId = seatId;
		this.storeNumber = storeNumber;
		this.isActive = isActive;
	}
}
