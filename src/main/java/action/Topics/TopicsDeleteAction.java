package action.Topics;

import java.io.File;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.PhotoDao;
import dao.TopicsDao;

public class TopicsDeleteAction {

	public boolean execute(HttpServletRequest req) {
		HttpSession session = req.getSession(false);

		if (session == null || session.getAttribute("topicsId") == null) {
			return false;
		}

		int topicsId = (int) session.getAttribute("topicsId");
		TopicsDao dao = new TopicsDao();

		int photoId = dao.getPhotoIdByTopicsId(topicsId);
		PhotoDao pDao = new PhotoDao();

		if (photoId > 0) {
			String dbPath = pDao.getFileNameById(photoId);

			if (dbPath != null && !dbPath.isEmpty()) {

				String fileName = dbPath.substring(dbPath.lastIndexOf("/") + 1);
				String serverSaveDir = req.getServletContext().getRealPath("/image/photo");
				File serverFile = new File(serverSaveDir + File.separator + fileName);
				if (serverFile.exists()) {
					serverFile.delete();
				}

				String localSaveDir = "Z:\\卒業制作2\\SotugyouGR01A\\src\\main\\webapp\\image\\photo";
				File localFile = new File(localSaveDir + File.separator + fileName);
				if (localFile.exists()) {
					localFile.delete();
				}
			}
		}

		boolean tSuccess = dao.delete(topicsId);

		if (photoId > 0) {
			pDao.delete(photoId);
		}

		return tSuccess;
	}
}