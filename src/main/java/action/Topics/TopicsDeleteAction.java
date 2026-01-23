package action.Topics;

import java.io.File;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import dao.PhotoDao;
import dao.TopicsDao;

/**
 * Servlet implementation class TopicsDeleteAction
 */
@WebServlet("/TopicsDeleteAction")
public class TopicsDeleteAction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TopicsDeleteAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public boolean execute(HttpServletRequest req) {
		HttpSession session = req.getSession(false);

		int topicsId = (int) session.getAttribute("topicsId");
		TopicsDao dao = new TopicsDao();
		int photoId = dao.getPhotoIdByTopicsId(topicsId);

		PhotoDao pDao = new PhotoDao();
		//String fileName = pDao.getFileNameById(photoId);

		if (photoId > 0) {
			String fileName = pDao.getFileNameById(photoId);
			if (fileName != null && !fileName.isEmpty()) {

				String workspacePath = "Z:\\卒業制作\\SotugyouGR01A\\src\\main\\webapp\\image\\photo";
				File workspaceFile = new File(workspacePath, fileName);
				
				if (workspaceFile.exists()) {
					workspaceFile.delete();
					System.out.println("★画像を削除しました");
				} else {
					// ファイルが見つからない場合、念のため別のパス構成も試す
					System.out.println("★警告: ファイルが見つかりません。ファイル名が正しいか、エクスプローラーで上記パスを直接確認してください。");
				}
			}
		}
		boolean tSuccess = dao.delete(topicsId);

		// 写真テーブルからも消す（photoIdが有効な場合のみ）
		if (photoId > 0) {
			pDao.delete(photoId);
		}

		return tSuccess;
	}
}
