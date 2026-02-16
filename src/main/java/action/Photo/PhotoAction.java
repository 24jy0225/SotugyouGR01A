package action.Photo;

import java.util.List;

import dao.PhotoDao;
import model.Photo;

public class PhotoAction {

	public List<Photo> execute() {
		PhotoDao dao = new PhotoDao();
		return dao.findAll();
	}

}
