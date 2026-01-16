package model;

public class Photo {
	private int photoId;
	private String photoCategory;
	private String photoFileName;
	private String prevPhotoFileName;
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
	public String getPrevPhotoFileName() {
		return prevPhotoFileName;
	}
	public void setPrevPhotoFileName(String prevPhotoFileName) {
		this.prevPhotoFileName = prevPhotoFileName;
	}
	public Photo(int photoId, String photoCategory, String photoFileName, String prevPhotoFileName) {
		this.photoId = photoId;
		this.photoCategory = photoCategory;
		this.photoFileName = photoFileName;
		this.prevPhotoFileName = prevPhotoFileName;
	}
}
