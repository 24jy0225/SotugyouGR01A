package model;

public class Store {
	private int storeNumber;
	private String storeName;
	private String storeAddress;
	private String storeTel;
	
	public int getStoreNumber() {
		return storeNumber;
	}
	public void setStoreNumber(int storeNumber) {
		this.storeNumber = storeNumber;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getStoreAddress() {
		return storeAddress;
	}
	public void setStoreAddress(String storeAddress) {
		this.storeAddress = storeAddress;
	}
	public String getStoreTel() {
		return storeTel;
	}
	public void setStoreTel(String storeTel) {
		this.storeTel = storeTel;
	}
	
	public Store(int storeNumber, String storeName, String storeAddress, String storeTel) {
		this.storeNumber = storeNumber;
		this.storeName = storeName;
		this.storeAddress = storeAddress;
		this.storeTel = storeTel;
	}
	
}
