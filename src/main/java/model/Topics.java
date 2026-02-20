package model;

public class Topics {
	private int topicsId;
	private Photo photo;
	private String topicsTitle;
	private String topicsContent;

	public Topics(int topicsId, Photo photo, String topicsTitle, String topicsContent) {
		this.topicsId = topicsId;
		this.photo = photo;
		this.topicsTitle = topicsTitle;
		this.topicsContent = topicsContent;
	}
	
	public int getTopicsId() {
		return topicsId;
	}

	public void setTopicsId(int topicsId) {
		this.topicsId = topicsId;
	}

	public Photo getPhotoId() {
		return photo;
	}

	public void setPhotoId(Photo photo) {
		this.photo = photo;
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
}
