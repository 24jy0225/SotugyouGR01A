package action.Design;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.PhotoDao;

/**
 * Servlet implementation class DesignUpdateAction
 */
@WebServlet("/DesignUpdateAction")
public class DesignUpdateAction {

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DesignUpdateAction() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void execute(HttpServletRequest req, HttpServletResponse resp) throws IOException {

		HttpSession session = req.getSession();
		String category = (String) session.getAttribute("category");
		String webPath = (String) session.getAttribute("webPath");
		System.out.println("カテゴリ: " + category);

		PhotoDao dao = new PhotoDao();
		String dbPath = dao.findCurrentFileName(category);
		System.out.println("DBから取得したパス: " + dbPath);
		if (dbPath != null && !dbPath.isEmpty()) {

			String rootPath = req.getServletContext().getRealPath("/");
			File oldFile = new File(rootPath, dbPath);
			if (oldFile.exists()) {
	            if (oldFile.delete()) {
	                System.out.println("古いファイルを削除しました: " + oldFile.getPath());
	            } else {
	                System.out.println("ファイルの削除に失敗しました。");
	            }
	        }

		}
		dao.update(category, webPath);

		resp.sendRedirect("DesignCustom.jsp");

	}

}
