package model;

public class Topics {
	private int topicsId;
	private int photoId;
	private String topicsTitle;
	private String topicsContent;
	
	public int getTopicsId() {
		return topicsId;
	}
	public void setTopicsId(int topicsId) {
		this.topicsId = topicsId;
	}
	public int getPhotoId() {
		return photoId;
	}
	public void setPhotoId(int photoId) {
		this.photoId = photoId;
	}
	public String getTopicsTitle() {
		return topicsTitle;
	}
	public void setTopicsTitle(String topicsTitle) {
		this.topicsTitle = topicsTitle;
	}
	public String getTopicsContent() {
		return topicsContent;
	}
	public void setTopicsContent(String topicsContent) {
		this.topicsContent = topicsContent;
	}
	
	public Topics(int topicsId, int photoId, String topicsTitle, String topicsContent) {
		super();
		this.topicsId = topicsId;
		this.photoId = photoId;
		this.topicsTitle = topicsTitle;
		this.topicsContent = topicsContent;
	}
	
}
