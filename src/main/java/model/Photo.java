package model;

public class Photo {
	private int photoId;
	private String photoCategory;
	private String photoFileName;

	public int getPhotoId() {
		return photoId;
	}

	public void setPhotoId(int photoId) {
		this.photoId = photoId;
	}

	public String getPhotoCategory() {
		return photoCategory;
	}

	public void setPhotoCategory(String photoCategory) {
		this.photoCategory = photoCategory;
	}

	public String getPhotoFileName() {
		return photoFileName;
	}

	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
	}

	public Photo(int photoId, String photoCategory, String photoFileName) {
		this.photoId = photoId;
		this.photoCategory = photoCategory;
		this.photoFileName = photoFileName;

	}
}
