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

				String rootPath = req.getServletContext().getRealPath("/");
                File serverFile = new File(rootPath, dbPath); 

                if (serverFile.exists()) {
                    if (serverFile.delete()) {
                        System.out.println("ファイルを削除しました: " + serverFile.getPath());
                    }
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